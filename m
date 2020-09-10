Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF13AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB7120C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GlX4dzjx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7iesgdja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbgIJJdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:33:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38826 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbgIJJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:23:44 -0400
Date:   Thu, 10 Sep 2020 09:22:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=leeCEjaB7aJ1Cvey5jbaTdNXiMKqJcyaELi4cIzDVrw=;
        b=GlX4dzjxjlLxicG3rdbuDP1hqbwknYBYM1aIVK/1q7gf/dnggnfErUhY1IFdv40a8kEbzZ
        4Q27Pf9vMSwsKbrp43qmBPR7OHGoP3Ox3QiAT/QBSUlhAuGAi3czzj5H/jTeazP3bNw3uV
        6tP5FNHD92Bh9a3pqQs/j4kGEv8HQIy6dRMRGjD4R5rKmF2vcb13iwENIejU7tMs0ra4WK
        HguG0lEnWqBKncmOgSpZA/5sPFIyYAS3OyFLbU4MBf0AdPHn9FdneLiMdnINGz+uycmTHi
        EXJ8uUr+0+89YXqHkv6qn4W/v7I2twsXhLdh14pgBFx/8EPi7FfDFfu46fvtJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=leeCEjaB7aJ1Cvey5jbaTdNXiMKqJcyaELi4cIzDVrw=;
        b=7iesgdjaiwlDBoDKrGRlu5pboKvumPvH9OCgsiardQVMDl17nQ1ze/Q+q1hVq4u9v1xikU
        BicSaejPomBnfeCQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/umip: Factor out instruction fetch
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-9-joro@8bytes.org>
References: <20200907131613.12703-9-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974945.20229.15602712338870098983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     172b75e56b08846e6fb07a88e5685ce4e24f4620
Gitweb:        https://git.kernel.org/tip/172b75e56b08846e6fb07a88e5685ce4e24f4620
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:09 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:24 +02:00

x86/umip: Factor out instruction fetch

Factor out the code to fetch the instruction from user-space to a helper
function.

No functional changes.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-9-joro@8bytes.org
---
 arch/x86/include/asm/insn-eval.h |  2 ++-
 arch/x86/kernel/umip.c           | 26 ++++-----------------
 arch/x86/lib/insn-eval.c         | 38 +++++++++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 2b6ccf2..b8b9ef1 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -19,5 +19,7 @@ void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs);
 unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
 int insn_get_code_seg_params(struct pt_regs *regs);
+int insn_fetch_from_user(struct pt_regs *regs,
+			 unsigned char buf[MAX_INSN_SIZE]);
 
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 2c304fd..ad135be 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -335,11 +335,11 @@ static void force_sig_info_umip_fault(void __user *addr, struct pt_regs *regs)
  */
 bool fixup_umip_exception(struct pt_regs *regs)
 {
-	int not_copied, nr_copied, reg_offset, dummy_data_size, umip_inst;
-	unsigned long seg_base = 0, *reg_addr;
+	int nr_copied, reg_offset, dummy_data_size, umip_inst;
 	/* 10 bytes is the maximum size of the result of UMIP instructions */
 	unsigned char dummy_data[10] = { 0 };
 	unsigned char buf[MAX_INSN_SIZE];
+	unsigned long *reg_addr;
 	void __user *uaddr;
 	struct insn insn;
 	int seg_defs;
@@ -347,26 +347,12 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	if (!regs)
 		return false;
 
-	/*
-	 * If not in user-space long mode, a custom code segment could be in
-	 * use. This is true in protected mode (if the process defined a local
-	 * descriptor table), or virtual-8086 mode. In most of the cases
-	 * seg_base will be zero as in USER_CS.
-	 */
-	if (!user_64bit_mode(regs))
-		seg_base = insn_get_seg_base(regs, INAT_SEG_REG_CS);
-
-	if (seg_base == -1L)
-		return false;
-
-	not_copied = copy_from_user(buf, (void __user *)(seg_base + regs->ip),
-				    sizeof(buf));
-	nr_copied = sizeof(buf) - not_copied;
+	nr_copied = insn_fetch_from_user(regs, buf);
 
 	/*
-	 * The copy_from_user above could have failed if user code is protected
-	 * by a memory protection key. Give up on emulation in such a case.
-	 * Should we issue a page fault?
+	 * The insn_fetch_from_user above could have failed if user code
+	 * is protected by a memory protection key. Give up on emulation
+	 * in such a case.  Should we issue a page fault?
 	 */
 	if (!nr_copied)
 		return false;
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 5e69603..947b7f1 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1367,3 +1367,41 @@ void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs)
 		return (void __user *)-1L;
 	}
 }
+
+/**
+ * insn_fetch_from_user() - Copy instruction bytes from user-space memory
+ * @regs:	Structure with register values as seen when entering kernel mode
+ * @buf:	Array to store the fetched instruction
+ *
+ * Gets the linear address of the instruction and copies the instruction bytes
+ * to the buf.
+ *
+ * Returns:
+ *
+ * Number of instruction bytes copied.
+ *
+ * 0 if nothing was copied.
+ */
+int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
+{
+	unsigned long seg_base = 0;
+	int not_copied;
+
+	/*
+	 * If not in user-space long mode, a custom code segment could be in
+	 * use. This is true in protected mode (if the process defined a local
+	 * descriptor table), or virtual-8086 mode. In most of the cases
+	 * seg_base will be zero as in USER_CS.
+	 */
+	if (!user_64bit_mode(regs)) {
+		seg_base = insn_get_seg_base(regs, INAT_SEG_REG_CS);
+		if (seg_base == -1L)
+			return 0;
+	}
+
+
+	not_copied = copy_from_user(buf, (void __user *)(seg_base + regs->ip),
+				    MAX_INSN_SIZE);
+
+	return MAX_INSN_SIZE - not_copied;
+}
