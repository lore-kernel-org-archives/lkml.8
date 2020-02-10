Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A1CC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F37620714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341561;
	bh=1XafbSwsaOm7WMrwjLaRqhStQQ0xFhsk1hiOt1Q+6Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n4ymdnH5bLi02zFvFU/x5TvHuG9jgvgBYG64mlIRdVKMN6lrua02wFUBXQ9NOXeJO
	 BKElyb4Q0o0NOEm5mEiqKypVIplPDEoPoxJPnSqZ0i3mAOxnrLhraim1ku6+tyrCQ3
	 FicxtBYSbbhHLD9YFbs8yqqeSUYvkAzqHBgB34pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgBJNck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:32:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgBJMfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:43 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 122AB2465D;
        Mon, 10 Feb 2020 12:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338143;
        bh=1XafbSwsaOm7WMrwjLaRqhStQQ0xFhsk1hiOt1Q+6Ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gx5kZ+HaqW+DxAppv1x9GUB8fOhDEyqKKgss/twSiJZvrw7enFqqZZQvQ0obm9Yfj
         bkY451hksEqV0dnDOaAlAbeMYQrnHiL7t6HjXHDvLw6jTxpobxpTqIw6sBrYs0FooH
         vhyh6kjSD67KNPe6BBbBD+xipSH+pKjL6+wKtejU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 100/195] crypto: api - Fix race condition in crypto_spawn_alg
Date:   Mon, 10 Feb 2020 04:32:38 -0800
Message-Id: <20200210122314.957291864@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 73669cc556462f4e50376538d77ee312142e8a8a upstream.

The function crypto_spawn_alg is racy because it drops the lock
before shooting the dying algorithm.  The algorithm could disappear
altogether before we shoot it.

This patch fixes it by moving the shooting into the locked section.

Fixes: 6bfd48096ff8 ("[CRYPTO] api: Added spawns")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/algapi.c   |   16 +++++-----------
 crypto/api.c      |    3 +--
 crypto/internal.h |    1 -
 3 files changed, 6 insertions(+), 14 deletions(-)

--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -659,22 +659,16 @@ EXPORT_SYMBOL_GPL(crypto_drop_spawn);
 static struct crypto_alg *crypto_spawn_alg(struct crypto_spawn *spawn)
 {
 	struct crypto_alg *alg;
-	struct crypto_alg *alg2;
 
 	down_read(&crypto_alg_sem);
 	alg = spawn->alg;
-	alg2 = alg;
-	if (alg2)
-		alg2 = crypto_mod_get(alg2);
-	up_read(&crypto_alg_sem);
-
-	if (!alg2) {
-		if (alg)
-			crypto_shoot_alg(alg);
-		return ERR_PTR(-EAGAIN);
+	if (alg && !crypto_mod_get(alg)) {
+		alg->cra_flags |= CRYPTO_ALG_DYING;
+		alg = NULL;
 	}
+	up_read(&crypto_alg_sem);
 
-	return alg;
+	return alg ?: ERR_PTR(-EAGAIN);
 }
 
 struct crypto_tfm *crypto_spawn_tfm(struct crypto_spawn *spawn, u32 type,
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -349,13 +349,12 @@ static unsigned int crypto_ctxsize(struc
 	return len;
 }
 
-void crypto_shoot_alg(struct crypto_alg *alg)
+static void crypto_shoot_alg(struct crypto_alg *alg)
 {
 	down_write(&crypto_alg_sem);
 	alg->cra_flags |= CRYPTO_ALG_DYING;
 	up_write(&crypto_alg_sem);
 }
-EXPORT_SYMBOL_GPL(crypto_shoot_alg);
 
 struct crypto_tfm *__crypto_alloc_tfm(struct crypto_alg *alg, u32 type,
 				      u32 mask)
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -79,7 +79,6 @@ void crypto_alg_tested(const char *name,
 void crypto_remove_spawns(struct crypto_alg *alg, struct list_head *list,
 			  struct crypto_alg *nalg);
 void crypto_remove_final(struct list_head *list);
-void crypto_shoot_alg(struct crypto_alg *alg);
 struct crypto_tfm *__crypto_alloc_tfm(struct crypto_alg *alg, u32 type,
 				      u32 mask);
 void *crypto_create_tfm(struct crypto_alg *alg,


