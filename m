Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E605C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E518207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824212;
	bh=m45JaHwCAEG1YWYob+PENkUlEKbfP0kHp+PbPhsBbHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fmYukskZ98Rzysa4Fxo0gZ8aMo6t+Ke5jx63oGi4noWwraq2T77OetYiNPcyCI60i
	 YNlh88WiofVNIL9NT9BK5OSUXZ6xN76cR2F7SrFKiZv11BbjplXLV1F24Oly4iHMcR
	 bHF6m3t1wbfnS8097OOvtGmDqIMAQV5mh9aZ3s08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgERRuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbgERRuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:50:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13FD9207C4;
        Mon, 18 May 2020 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824207;
        bh=m45JaHwCAEG1YWYob+PENkUlEKbfP0kHp+PbPhsBbHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5KWhhGMdt0dEC2tfk4meyK2KMMAyNCzb4ysFcK+D0hXe7Mrwujum5sF5Qt9rvJoG
         58owWG9ST/iNCuqfLjMtksUAHg5TtjtgyqbbWZCYQbLE3pHlJzrHLAEwuh0wiN8URD
         Zx2WpaW2Gvv8tPUth8YnBv/dC/dbClsvh06bNJ20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 078/114] gcc-10: avoid shadowing standard library free() in crypto
Date:   Mon, 18 May 2020 19:36:50 +0200
Message-Id: <20200518173516.758791300@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
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
@@ -531,7 +531,7 @@ static void exit_tfm(struct crypto_skcip
 	crypto_free_skcipher(ctx->child);
 }
 
-static void free(struct skcipher_instance *inst)
+static void free_inst(struct skcipher_instance *inst)
 {
 	crypto_drop_skcipher(skcipher_instance_ctx(inst));
 	kfree(inst);
@@ -642,7 +642,7 @@ static int create(struct crypto_template
 	inst->alg.encrypt = encrypt;
 	inst->alg.decrypt = decrypt;
 
-	inst->free = free;
+	inst->free = free_inst;
 
 	err = skcipher_register_instance(tmpl, inst);
 	if (err)
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -469,7 +469,7 @@ static void exit_tfm(struct crypto_skcip
 	crypto_free_cipher(ctx->tweak);
 }
 
-static void free(struct skcipher_instance *inst)
+static void free_inst(struct skcipher_instance *inst)
 {
 	crypto_drop_skcipher(skcipher_instance_ctx(inst));
 	kfree(inst);
@@ -580,7 +580,7 @@ static int create(struct crypto_template
 	inst->alg.encrypt = encrypt;
 	inst->alg.decrypt = decrypt;
 
-	inst->free = free;
+	inst->free = free_inst;
 
 	err = skcipher_register_instance(tmpl, inst);
 	if (err)


