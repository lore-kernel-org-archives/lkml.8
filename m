Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9630CC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4D820C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NRdvBZU0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Pl8Y0rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbgIJJdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:33:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38852 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbgIJJXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:23:32 -0400
Date:   Thu, 10 Sep 2020 09:22:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tHh1cdoYAeJWYIOhscbGpid/9poC7OrbNQmZPjDHjg=;
        b=NRdvBZU0saNW4z4JE/rKomPDQd0ODOO3Lvv11WQahLrbvR8qCjlVvHaWJkSmfrZyvVWeZ4
        +T5t3AyngBlTnASRMRyhvXRlIwqatXAwSP7asGwTBMqgrI/+1cQZXlMjYVVxWSwrvvR3HM
        lAsYaTyL+dyo3gO7ZAVdGl3CYVA7obWrFvkAFGxTmgIhyiMzz19nbqHAX0hwFCxQ7nyBj3
        GC8vCePQesAlK8Epy6hcB7Q7LiKdJZfQKUai+El/0Nj+UcH5fEE91aOS8T9ln8RzzrqPRs
        4oojJdiI/+bYNpOjU2rUEd7g1wHKrFGB+4wkoAFouiIblxIpDb4ACgBJHfq1vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tHh1cdoYAeJWYIOhscbGpid/9poC7OrbNQmZPjDHjg=;
        b=6Pl8Y0rbR5XBjFPIEQL/p8Y9yhUtIHjeo4pKG2g6qtj/ogRS0K7l6/KFh+7H5gWOOL30Iz
        IHIx8AujEajtX/Aw==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/insn: Add insn_has_rep_prefix() helper
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-12-joro@8bytes.org>
References: <20200907131613.12703-12-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974814.20229.4181697015714949858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     5901781a11175a5e5ee91746ec8627f18d47eebd
Gitweb:        https://git.kernel.org/tip/5901781a11175a5e5ee91746ec8627f18d47eebd
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:12 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:25 +02:00

x86/insn: Add insn_has_rep_prefix() helper

Add a function to check whether an instruction has a REP prefix.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-12-joro@8bytes.org
---
 arch/x86/include/asm/insn-eval.h |  1 +
 arch/x86/lib/insn-eval.c         | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index f748f57..a0f839a 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -15,6 +15,7 @@
 #define INSN_CODE_SEG_OPND_SZ(params) (params & 0xf)
 #define INSN_CODE_SEG_PARAMS(oper_sz, addr_sz) (oper_sz | (addr_sz << 4))
 
+bool insn_has_rep_prefix(struct insn *insn);
 void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs);
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index f20942c..58f7fb9 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -54,6 +54,30 @@ static bool is_string_insn(struct insn *insn)
 }
 
 /**
+ * insn_has_rep_prefix() - Determine if instruction has a REP prefix
+ * @insn:	Instruction containing the prefix to inspect
+ *
+ * Returns:
+ *
+ * true if the instruction has a REP prefix, false if not.
+ */
+bool insn_has_rep_prefix(struct insn *insn)
+{
+	int i;
+
+	insn_get_prefixes(insn);
+
+	for (i = 0; i < insn->prefixes.nbytes; i++) {
+		insn_byte_t p = insn->prefixes.bytes[i];
+
+		if (p == 0xf2 || p == 0xf3)
+			return true;
+	}
+
+	return false;
+}
+
+/**
  * get_seg_reg_override_idx() - obtain segment register override index
  * @insn:	Valid instruction with segment override prefixes
  *
