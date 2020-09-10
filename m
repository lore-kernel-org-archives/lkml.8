Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B905C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F09F207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vS5/9Bhu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ISjEgglO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgIJJd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:33:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38842 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbgIJJXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:23:32 -0400
Date:   Thu, 10 Sep 2020 09:22:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5KBuFXDCkBTIRdXk+IROBfUg9GpeVlMxwgcRTooDJU=;
        b=vS5/9BhuyPEczSCITA6snKFOJwTXVLm5Yo60kF5aHLgEDNLysIQWKSJjQJTp4yKmJqPpUr
        qh/1TaVv5dv5kmAqiO3KmyR4iZw2Q8e7DLQAJDfO0eUkzMrQGpoNUE9ONZxR32YRH864Q7
        nqr9rBZmJVqUCicz96VviT38E4dnmLtrKKAVX8zt+PI+05WAl6dFbNnMicdcVW5VSVgBi6
        85A2AyBWaC8XEyQtlNAh6BSkY5n9axfV7P6Yh9gjClncQ9LCy9mveFazgTORtwfXrSs/zP
        z1eibAQRMR2nOstmX/XPyF3ar1FXfzCuzaS1hO0P26gAtOYVa20CIY461Uii/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5KBuFXDCkBTIRdXk+IROBfUg9GpeVlMxwgcRTooDJU=;
        b=ISjEgglOhVXtnSTiKFhEEJCLOJuX9mQ+bzKbQzJdLQtP19I7gRoLvhsUPFvafuaYC7h1EJ
        jkwtEVwMEW/J9sAg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/insn: Add insn_get_modrm_reg_off()
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-11-joro@8bytes.org>
References: <20200907131613.12703-11-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974863.20229.6794223447626019613.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     7af1bd822dd45a669fc178a35cc8183922333d56
Gitweb:        https://git.kernel.org/tip/7af1bd822dd45a669fc178a35cc8183922333d56
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:11 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:24 +02:00

x86/insn: Add insn_get_modrm_reg_off()

Add a function to the instruction decoder which returns the pt_regs
offset of the register specified in the reg field of the modrm byte.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-11-joro@8bytes.org
---
 arch/x86/include/asm/insn-eval.h |  1 +
 arch/x86/lib/insn-eval.c         | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 392b4fe..f748f57 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -17,6 +17,7 @@
 
 void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs);
+int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs);
 unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
 int insn_get_code_seg_params(struct pt_regs *regs);
 int insn_fetch_from_user(struct pt_regs *regs,
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 2323c85..f20942c 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -20,6 +20,7 @@
 
 enum reg_type {
 	REG_TYPE_RM = 0,
+	REG_TYPE_REG,
 	REG_TYPE_INDEX,
 	REG_TYPE_BASE,
 };
@@ -439,6 +440,13 @@ static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
 			regno += 8;
 		break;
 
+	case REG_TYPE_REG:
+		regno = X86_MODRM_REG(insn->modrm.value);
+
+		if (X86_REX_R(insn->rex_prefix.value))
+			regno += 8;
+		break;
+
 	case REG_TYPE_INDEX:
 		regno = X86_SIB_INDEX(insn->sib.value);
 		if (X86_REX_X(insn->rex_prefix.value))
@@ -808,6 +816,21 @@ int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs)
 }
 
 /**
+ * insn_get_modrm_reg_off() - Obtain register in reg part of the ModRM byte
+ * @insn:	Instruction containing the ModRM byte
+ * @regs:	Register values as seen when entering kernel mode
+ *
+ * Returns:
+ *
+ * The register indicated by the reg part of the ModRM byte. The
+ * register is obtained as an offset from the base of pt_regs.
+ */
+int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs)
+{
+	return get_reg_offset(insn, regs, REG_TYPE_REG);
+}
+
+/**
  * get_seg_base_limit() - obtain base address and limit of a segment
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
