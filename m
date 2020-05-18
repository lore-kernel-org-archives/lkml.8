Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178F6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B1E20674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824345;
	bh=1FTqzyxEzcIrc6VF13xjCbQNw1co+uH7AVWcJBusJ/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cLU0TeODXgHdxHW3p4m9NmJ0WPYyUd4ZehfcNlNM8ofuLDsqKEKYBi2/9dDYsWtKO
	 1Jp98ID2RH5cVRezGLc9m6mOOOnIhE8LfNWJ18Pz5CIFID9fSjF/QSv7hmF4x+GzpK
	 EGc/d/ZL7f1t/xoJbS5UyTzoWwdSKt868QIkmwm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbgERRwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730962AbgERRwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:52:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987BB20674;
        Mon, 18 May 2020 17:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824339;
        bh=1FTqzyxEzcIrc6VF13xjCbQNw1co+uH7AVWcJBusJ/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPyES5UUtQXu4TdKJjsVINkk1wM8ml6IRWrnwc1jfCKowPe7NXiubYBzXMZVtkjEA
         SjsJe7r1Ht6ZclRLHfevs7YBCXwDk40Tv8JsrXuIj9C3T61ZPBcd7Dn3xHwH9oUyjx
         nJpnCKcr9SfIDZArIFB+1oSV8I6kndBQsiQZQ0vw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 52/80] gcc-10: avoid shadowing standard library free() in crypto
Date:   Mon, 18 May 2020 19:37:10 +0200
Message-Id: <20200518173500.936440392@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.097837707@linuxfoundation.org>
References: <20200518173450.097837707@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 1a263ae60b04de959d9ce9caea4889385eefcc7b upstream.

gcc-10 has started warning about conflicting types for a few new
built-in functions, particularly 'free()'.

This results in warnings like:

   crypto/xts.c:325:13: warning: conflicting types for built-in function ‘free’; expected ‘void(void *)’ [-Wbuiltin-declaration-mismatch]

because the crypto layer had its local freeing functions called
'free()'.

Gcc-10 is in the wrong here, since that function is marked 'static', and
thus there is no chance of confusion with any standard library function
namespace.

But the simplest thing to do is to just use a different name here, and
avoid this gcc mis-feature.

[ Side note: gcc knowing about 'free()' is in itself not the
  mis-feature: the semantics of 'free()' are special enough that a
  compiler can validly do special things when seeing it.

  So the mis-feature here is that gcc thinks that 'free()' is some
  restricted name, and you can't shadow it as a local static function.

  Making the special 'free()' semantics be a function attribute rather
  than tied to the name would be the much better model ]

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/lrw.c |    4 ++--
 crypto/xts.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -453,7 +453,7 @@ static void exit_tfm(struct crypto_skcip
 	crypto_free_skcipher(ctx->child);
 }
 
-static void free(struct skcipher_instance *inst)
+static void free_inst(struct skcipher_instance *inst)
 {
 	crypto_drop_skcipher(skcipher_instance_ctx(inst));
 	kfree(inst);
@@ -565,7 +565,7 @@ static int create(struct crypto_template
 	inst->alg.encrypt = encrypt;
 	inst->alg.decrypt = decrypt;
 
-	inst->free = free;
+	inst->free = free_inst;
 
 	err = skcipher_register_instance(tmpl, inst);
 	if (err)
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -393,7 +393,7 @@ static void exit_tfm(struct crypto_skcip
 	crypto_free_cipher(ctx->tweak);
 }
 
-static void free(struct skcipher_instance *inst)
+static void free_inst(struct skcipher_instance *inst)
 {
 	crypto_drop_skcipher(skcipher_instance_ctx(inst));
 	kfree(inst);
@@ -504,7 +504,7 @@ static int create(struct crypto_template
 	inst->alg.encrypt = encrypt;
 	inst->alg.decrypt = decrypt;
 
-	inst->free = free;
+	inst->free = free_inst;
 
 	err = skcipher_register_instance(tmpl, inst);
 	if (err)


