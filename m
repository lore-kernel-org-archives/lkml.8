Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AB1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550132078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926507;
	bh=xGSghv4vVlkYjoXq27P/5hyIj+LHqAvkUJ1zVGjpX84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J3rhODWdoBE0E7ER1JqE2dllg4kT3HSXcDopdbIySCkJ6l3e1A+bhSZ+kkyFQV8js
	 oa1BQZp2FGJk6Sni6xMjkLflPJKOLbXb2sRdETkIfQoP6MgNptBZ5kNA46ntzLlpPM
	 Di//y2WaY50pJj2OyuCgDF6juZktNLWBL+2R8iqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbgHTM2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:32932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729857AbgHTJvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:51:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73F022078D;
        Thu, 20 Aug 2020 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917112;
        bh=xGSghv4vVlkYjoXq27P/5hyIj+LHqAvkUJ1zVGjpX84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E59BJqb0U0YZaONaEMUr4IJnRmZdsnh+PSBmMuOQiq30Zmd+JMF6d585t6Q8DEirj
         iaW/N9p7Iqdbjk2D++mKfl/TpcPLdu7blGKfxx4LhzX4mpPj4eJRVGoYfXnlQjhhWT
         RNO3mCjt+uzFQ1JJWwIX+d2oz3X8xvZiDexQFqEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 139/152] crypto: algif_aead - fix uninitialized ctx->init
Date:   Thu, 20 Aug 2020 11:21:46 +0200
Message-Id: <20200820091600.925682270@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit 21dfbcd1f5cbff9cf2f9e7e43475aed8d072b0dd ]

In skcipher_accept_parent_nokey() the whole af_alg_ctx structure is
cleared by memset() after allocation, so add such memset() also to
aead_accept_parent_nokey() so that the new "init" field is also
initialized to zero. Without that the initial ctx->init checks might
randomly return true and cause errors.

While there, also remove the redundant zero assignments in both
functions.

Found via libkcapi testsuite.

Cc: Stephan Mueller <smueller@chronox.de>
Fixes: f3c802a1f300 ("crypto: algif_aead - Only wake up when ctx->more is zero")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/algif_aead.c     | 6 ------
 crypto/algif_skcipher.c | 7 +------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index d48d2156e6210..43c6aa784858b 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -558,12 +558,6 @@ static int aead_accept_parent_nokey(void *private, struct sock *sk)
 
 	INIT_LIST_HEAD(&ctx->tsgl_list);
 	ctx->len = len;
-	ctx->used = 0;
-	atomic_set(&ctx->rcvused, 0);
-	ctx->more = 0;
-	ctx->merge = 0;
-	ctx->enc = 0;
-	ctx->aead_assoclen = 0;
 	crypto_init_wait(&ctx->wait);
 
 	ask->private = ctx;
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index a51ba22fef58f..81c4022285a7c 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -333,6 +333,7 @@ static int skcipher_accept_parent_nokey(void *private, struct sock *sk)
 	ctx = sock_kmalloc(sk, len, GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
+	memset(ctx, 0, len);
 
 	ctx->iv = sock_kmalloc(sk, crypto_skcipher_ivsize(tfm),
 			       GFP_KERNEL);
@@ -340,16 +341,10 @@ static int skcipher_accept_parent_nokey(void *private, struct sock *sk)
 		sock_kfree_s(sk, ctx, len);
 		return -ENOMEM;
 	}
-
 	memset(ctx->iv, 0, crypto_skcipher_ivsize(tfm));
 
 	INIT_LIST_HEAD(&ctx->tsgl_list);
 	ctx->len = len;
-	ctx->used = 0;
-	atomic_set(&ctx->rcvused, 0);
-	ctx->more = 0;
-	ctx->merge = 0;
-	ctx->enc = 0;
 	crypto_init_wait(&ctx->wait);
 
 	ask->private = ctx;
-- 
2.25.1



