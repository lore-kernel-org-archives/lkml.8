Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF13FC07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82316214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oe8OKIMm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Z1xsiH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgIJS7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgIJSzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:55:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D93AC06179A;
        Thu, 10 Sep 2020 11:54:41 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:54:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wuJUFUYBEkGFoF3enHhsHwS0Z324yctQHDOsU3eHsBo=;
        b=oe8OKIMmQdaZP2Mcc1Jvrlw3pZqcAeWhxuv2wJboeAVl7ZNan34rLFoCaTdTZCyguJC0kE
        RskN+myM16Rv1UEXcDTr2a5exrbgRPf9vjqFye3dKAwwgq8I/pNx2PFfbCrqJ59WuBNUnD
        qPDP6D4N94Noiga/VOpHmb9A0Lb9WzEguHd7MFLkAcMKOMPOl/9tClh6HftYWEhlG6Vtng
        laRduHxA/UzooybdLXC0S9mJ5x4LAHdP1g7RVIEvVshzhDZT+l71u4fRM0CSX+ZO+CrJjd
        lk0XVfrtxhSEKfmV8M0EMmiaew2RpCGqNYmpoO+KoJN5F82MrFwHJWzq1FqJgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wuJUFUYBEkGFoF3enHhsHwS0Z324yctQHDOsU3eHsBo=;
        b=6Z1xsiH5/aR7U+Na48qVEDyqM/iNEsc++4TtONItRq0yM/vGmMwE2lYQlkBdWmwhDMIUUJ
        ORMfDPeoFUcdPCCA==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Define 'struct orc_entry' only when needed
Cc:     Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976407922.20229.16311373293182663804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     66734e32463bd1346466f92662feeaccef26e94f
Gitweb:        https://git.kernel.org/tip/66734e32463bd1346466f92662feeaccef26e94f
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Tue, 25 Aug 2020 13:47:42 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 01 Sep 2020 17:19:12 -05:00

objtool: Define 'struct orc_entry' only when needed

Implementation of ORC requires some definitions that are currently
provided by the target architecture headers. Do not depend on these
definitions when the orc subcommand is not implemented.

This avoid requiring arches with no orc implementation to provide dummy
orc definitions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/Makefile | 4 ++++
 tools/objtool/arch.h   | 2 ++
 tools/objtool/check.h  | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 7770edc..33d1e3c 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -55,6 +55,10 @@ ifeq ($(SRCARCH),x86)
 	SUBCMD_ORC := y
 endif
 
+ifeq ($(SUBCMD_ORC),y)
+	CFLAGS += -DINSN_USE_ORC
+endif
+
 export SUBCMD_CHECK SUBCMD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 2e2ce08..b18c5f6 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -11,7 +11,9 @@
 #include "objtool.h"
 #include "cfi.h"
 
+#ifdef INSN_USE_ORC
 #include <asm/orc_types.h>
+#endif
 
 enum insn_type {
 	INSN_JUMP_CONDITIONAL,
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 36d38b9..6cac345 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -43,7 +43,9 @@ struct instruction {
 	struct symbol *func;
 	struct list_head stack_ops;
 	struct cfi_state cfi;
+#ifdef INSN_USE_ORC
 	struct orc_entry orc;
+#endif
 };
 
 struct instruction *find_insn(struct objtool_file *file,
