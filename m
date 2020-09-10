Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F96C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642AE20758
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="31sXwdLm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fPiTbZdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIJTBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:01:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41784 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgIJSyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:54:47 -0400
Date:   Thu, 10 Sep 2020 18:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L3SZZFRPUnHcIHVodRamdf0L5LfD+h08IWUNNnV6fF4=;
        b=31sXwdLmjes405/3vEOkXQyPs9RjzZ383TQby9neFl9B7VGxb0S8VXVN8JYV56830zf96l
        FoH4iEczP4pZOXQXhuwike+PJ1b93iCtBWMImREpHZBT90Pngl3D5qS3ona/fD+9i/naNc
        NvP1+AtJNysJGJcXV4kvINJsdMWlMLxk/V4ToM9imaJt94ek7N3f7qEtP5R0yWdtiXIji0
        +wtxRYF40RXKiPZjvQv82hlIjTO5FFcmNMWiMECueuuM3mtRng77fq9eQFgaVGgavfWTZu
        tjdmsDNde5QWszNMXcEF2G93qpB9EnT9zas9ewoY6LqYEHhrkX/pV9COcQKvxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L3SZZFRPUnHcIHVodRamdf0L5LfD+h08IWUNNnV6fF4=;
        b=fPiTbZdo9J6Ch1hjtIlrHfNGSaVZt8Zp4HX3IAaXWpN77kknEDt4IqoLe/nSeIzjU+GsDQ
        cYRkFKLL+fn/AVCw==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Decode unwind hint register depending on
 architecture
Cc:     Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976407436.20229.15130486625259199732.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     edea9e6bcbeaa41718b022a8b99ffddef2330bbc
Gitweb:        https://git.kernel.org/tip/edea9e6bcbeaa41718b022a8b99ffddef2330bbc
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 04 Sep 2020 16:30:28 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 10 Sep 2020 10:43:13 -05:00

objtool: Decode unwind hint register depending on architecture

The set of registers that can be included in an unwind hint and their
encoding will depend on the architecture. Have arch specific code to
decode that register.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/arch.h            |  2 ++-
 tools/objtool/arch/x86/decode.c | 37 ++++++++++++++++++++++++++++++++-
 tools/objtool/check.c           | 27 +-----------------------
 3 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index b18c5f6..4a84c30 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -88,4 +88,6 @@ unsigned long arch_dest_reloc_offset(int addend);
 
 const char *arch_nop_insn(int len);
 
+int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 1967370..cde9c36 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -15,6 +15,7 @@
 #include "../../elf.h"
 #include "../../arch.h"
 #include "../../warn.h"
+#include <asm/orc_types.h>
 
 static unsigned char op_to_cfi_reg[][2] = {
 	{CFI_AX, CFI_R8},
@@ -583,3 +584,39 @@ const char *arch_nop_insn(int len)
 
 	return nops[len-1];
 }
+
+int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
+{
+	struct cfi_reg *cfa = &insn->cfi.cfa;
+
+	switch (sp_reg) {
+	case ORC_REG_UNDEFINED:
+		cfa->base = CFI_UNDEFINED;
+		break;
+	case ORC_REG_SP:
+		cfa->base = CFI_SP;
+		break;
+	case ORC_REG_BP:
+		cfa->base = CFI_BP;
+		break;
+	case ORC_REG_SP_INDIRECT:
+		cfa->base = CFI_SP_INDIRECT;
+		break;
+	case ORC_REG_R10:
+		cfa->base = CFI_R10;
+		break;
+	case ORC_REG_R13:
+		cfa->base = CFI_R13;
+		break;
+	case ORC_REG_DI:
+		cfa->base = CFI_DI;
+		break;
+	case ORC_REG_DX:
+		cfa->base = CFI_DX;
+		break;
+	default:
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 95c6e0d..4e2f703 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1367,32 +1367,7 @@ static int read_unwind_hints(struct objtool_file *file)
 
 		insn->hint = true;
 
-		switch (hint->sp_reg) {
-		case ORC_REG_UNDEFINED:
-			cfa->base = CFI_UNDEFINED;
-			break;
-		case ORC_REG_SP:
-			cfa->base = CFI_SP;
-			break;
-		case ORC_REG_BP:
-			cfa->base = CFI_BP;
-			break;
-		case ORC_REG_SP_INDIRECT:
-			cfa->base = CFI_SP_INDIRECT;
-			break;
-		case ORC_REG_R10:
-			cfa->base = CFI_R10;
-			break;
-		case ORC_REG_R13:
-			cfa->base = CFI_R13;
-			break;
-		case ORC_REG_DI:
-			cfa->base = CFI_DI;
-			break;
-		case ORC_REG_DX:
-			cfa->base = CFI_DX;
-			break;
-		default:
+		if (arch_decode_hint_reg(insn, hint->sp_reg)) {
 			WARN_FUNC("unsupported unwind_hint sp base reg %d",
 				  insn->sec, insn->offset, hint->sp_reg);
 			return -1;
