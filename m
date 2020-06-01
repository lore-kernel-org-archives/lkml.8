Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957F7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71710206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591036906;
	bh=Wyu+GuCOolBnDea1UArZiULxzXCqnF1YkMDWXkCrWuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r54sdnxZPuUlYdj1cdC5Rd3sbJswE1BKNuafAx2GhCMRSUhozio4iZNiPDLuMVFOd
	 ztP9qgpYgTh4x6WRQZLcIMMlTe8Tq4z7S7hjj9Qa4x1nxqV/vpZnTFV2SlchSN1Dao
	 2Qngi4h8dhIZ6i1Z0Oomt/YRPcI/mPvjN3SN6eNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgFASlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbgFASMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:12:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E45B520776;
        Mon,  1 Jun 2020 18:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035143;
        bh=Wyu+GuCOolBnDea1UArZiULxzXCqnF1YkMDWXkCrWuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v8GHjvIFOmhYsREFa4gn4+XoJyRfZVIY1X4/c95Cqxf6/9rdvSiPR+X7JGzru0+eq
         MxFjIQXr8ZhXuxav4NT0bvOykLPHN68nzTkG9UWHh/VRKN7jRTbilzCZ60e5dfAI5f
         kvHN4xTxKSKVlTttvgZNL8kXovmP9HdtizO7mcPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Dunwoodie <ncon@noconroy.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 028/177] wireguard: noise: read preshared key while taking lock
Date:   Mon,  1 Jun 2020 19:52:46 +0200
Message-Id: <20200601174051.189930197@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

[ Upstream commit bc67d371256f5c47d824e2eec51e46c8d62d022e ]

Prior we read the preshared key after dropping the handshake lock, which
isn't an actual crypto issue if it races, but it's still not quite
correct. So copy that part of the state into a temporary like we do with
the rest of the handshake state variables. Then we can release the lock,
operate on the temporary, and zero it out at the end of the function. In
performance tests, the impact of this was entirely unnoticable, probably
because those bytes are coming from the same cacheline as other things
that are being copied out in the same manner.

Reported-by: Matt Dunwoodie <ncon@noconroy.net>
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireguard/noise.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/wireguard/noise.c
+++ b/drivers/net/wireguard/noise.c
@@ -715,6 +715,7 @@ wg_noise_handshake_consume_response(stru
 	u8 e[NOISE_PUBLIC_KEY_LEN];
 	u8 ephemeral_private[NOISE_PUBLIC_KEY_LEN];
 	u8 static_private[NOISE_PUBLIC_KEY_LEN];
+	u8 preshared_key[NOISE_SYMMETRIC_KEY_LEN];
 
 	down_read(&wg->static_identity.lock);
 
@@ -733,6 +734,8 @@ wg_noise_handshake_consume_response(stru
 	memcpy(chaining_key, handshake->chaining_key, NOISE_HASH_LEN);
 	memcpy(ephemeral_private, handshake->ephemeral_private,
 	       NOISE_PUBLIC_KEY_LEN);
+	memcpy(preshared_key, handshake->preshared_key,
+	       NOISE_SYMMETRIC_KEY_LEN);
 	up_read(&handshake->lock);
 
 	if (state != HANDSHAKE_CREATED_INITIATION)
@@ -750,7 +753,7 @@ wg_noise_handshake_consume_response(stru
 		goto fail;
 
 	/* psk */
-	mix_psk(chaining_key, hash, key, handshake->preshared_key);
+	mix_psk(chaining_key, hash, key, preshared_key);
 
 	/* {} */
 	if (!message_decrypt(NULL, src->encrypted_nothing,
@@ -783,6 +786,7 @@ out:
 	memzero_explicit(chaining_key, NOISE_HASH_LEN);
 	memzero_explicit(ephemeral_private, NOISE_PUBLIC_KEY_LEN);
 	memzero_explicit(static_private, NOISE_PUBLIC_KEY_LEN);
+	memzero_explicit(preshared_key, NOISE_SYMMETRIC_KEY_LEN);
 	up_read(&wg->static_identity.lock);
 	return ret_peer;
 }


