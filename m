Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CBFC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D40205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409690;
	bh=rTnGPWhJtUxx8YM07eUp4YSPeRUUXMPbXzznbDOrHcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BQAeNYxpmO9S0InRwxXlAudlYaXcQrYSf0Hyre2/5omwyc/i/lmYB2+k3IYYyfBpz
	 AI7Gwt4YwsieHZ/M3nqzlN7etNNrqGF6Zyczpwfih4bxojcs76dDVRaASsXaTOKew7
	 duE+6mHfRzti91fqC1LGECBBdN1DMB63IrtD+osM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgA3Sla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:41:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730162AbgA3Sl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:41:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02AA520702;
        Thu, 30 Jan 2020 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409685;
        bh=rTnGPWhJtUxx8YM07eUp4YSPeRUUXMPbXzznbDOrHcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9M6JzOKkbCG6nYWkuges/BAvtwakxyjUB5MsmmYYtpZ4h1Kaec820wqn49EJ7M9y
         lzZX0jwudJqLaz0VKqNo+1kvQgQahbbHBt2fzm3HQO+OcceC1PTE1gGkPrY+uBkAGE
         gdiyy1yZ+awL600gF5vCE5PKFbbiiQy5daFuG7hU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c2f1558d49e25cc36e5e@syzkaller.appspotmail.com,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.5 50/56] crypto: af_alg - Use bh_lock_sock in sk_destruct
Date:   Thu, 30 Jan 2020 19:39:07 +0100
Message-Id: <20200130183617.938243880@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
References: <20200130183608.849023566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 37f96694cf73ba116993a9d2d99ad6a75fa7fdb0 upstream.

As af_alg_release_parent may be called from BH context (most notably
due to an async request that only completes after socket closure,
or as reported here because of an RCU-delayed sk_destruct call), we
must use bh_lock_sock instead of lock_sock.

Reported-by: syzbot+c2f1558d49e25cc36e5e@syzkaller.appspotmail.com
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Fixes: c840ac6af3f8 ("crypto: af_alg - Disallow bind/setkey/...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/af_alg.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -134,11 +134,13 @@ void af_alg_release_parent(struct sock *
 	sk = ask->parent;
 	ask = alg_sk(sk);
 
-	lock_sock(sk);
+	local_bh_disable();
+	bh_lock_sock(sk);
 	ask->nokey_refcnt -= nokey;
 	if (!last)
 		last = !--ask->refcnt;
-	release_sock(sk);
+	bh_unlock_sock(sk);
+	local_bh_enable();
 
 	if (last)
 		sock_put(sk);


