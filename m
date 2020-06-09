Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC795C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E0C2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hb9fxq.ch header.i=@hb9fxq.ch header.b="lJq+I/Ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbgFIPa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgFIPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:30:58 -0400
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Jun 2020 08:30:57 PDT
Received: from sw.superlogical.ch (sw.superlogical.ch [IPv6:2a03:4000:9:189::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12971C05BD1E;
        Tue,  9 Jun 2020 08:30:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F17F8C28BF;
        Tue,  9 Jun 2020 17:21:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hb9fxq.ch; s=default;
        t=1591716067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8+Nt7ROQbqai3uPLzcGnzXulo/FR7FIpsmMrw9Q5mCQ=;
        b=lJq+I/Uggqk8XVZXt7sJ29wlB6RYBBwtBT3t5FbUTSQnwz7E+ydTJiqhYZxCNeNVfWLU69
        +UeQN6UxZzoJNrqalKMB8tDyzK1gN1VipBrd2Yb+5ZTXiH2q1T3V2dT5r0gmyXfsKpcFDB
        2USr9tk1D4ftm1y+diZ7PIADPwLAJ8yq8KZLgo4mSpIv+8LWSiPkQnmBin1Xewb2wcIh6N
        HLDjBHQSDr6BZBUAZVfQSqMYc38acKGJrZXQo9x85stX7QRtJ+IJaFzkchaLI0x7LsjOqz
        9T0tMYfp2KV5QxbOiBtvitbibGvvPTZKWZPYGavpvJT1chaTlRzJ5EpiJ48dyA==
From:   Frank Werner-Krippendorf <mail@hb9fxq.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wireguard@lists.zx2c4.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Werner-Krippendorf <mail@hb9fxq.ch>
Subject: [PATCH] Do not assign in if condition wg_noise_handshake_consume_initiation()
Date:   Tue,  9 Jun 2020 17:21:00 +0200
Message-Id: <20200609152100.29612-1-mail@hb9fxq.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an error condition reported by checkpatch.pl which caused by
assigning a variable in an if condition in
wg_noise_handshake_consume_initiation().

Signed-off-by: Frank Werner-Krippendorf <mail@hb9fxq.ch>
---
 drivers/net/wireguard/noise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
index 626433690abb..9524a15a62a6 100644
--- a/drivers/net/wireguard/noise.c
+++ b/drivers/net/wireguard/noise.c
@@ -617,8 +617,9 @@ wg_noise_handshake_consume_initiation(struct message_handshake_initiation *src,
 	memcpy(handshake->hash, hash, NOISE_HASH_LEN);
 	memcpy(handshake->chaining_key, chaining_key, NOISE_HASH_LEN);
 	handshake->remote_index = src->sender_index;
+	initiation_consumption = ktime_get_coarse_boottime_ns();
 	if ((s64)(handshake->last_initiation_consumption -
-	    (initiation_consumption = ktime_get_coarse_boottime_ns())) < 0)
+	    initiation_consumption) < 0)
 		handshake->last_initiation_consumption = initiation_consumption;
 	handshake->state = HANDSHAKE_CONSUMED_INITIATION;
 	up_write(&handshake->lock);
-- 
2.20.1

