Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E525BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A7620C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="30wMjznA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N3BUd1fI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbgIJJcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbgIJJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2BCC0617A4;
        Thu, 10 Sep 2020 02:22:19 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729737;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gJQaWnsl32pW9W2kKDG4+0+f/CUWbZHNlR76kAjoE8=;
        b=30wMjznAK4WFAAjOsCu9TUHzpuJ3972tGwiIGk5m13A3jltlg1ueu7/SnWryGNFxjPWpyD
        0IpEbktxD75+8pA6aJtRrrMaR0r7KSmjdjAZAOmLMO52G3wSBItfIxcrCl+AjhqnfHbZeW
        pPWKdU3LGL6h3CTMIjD+5LD9tjIKosuFFGl0liXpymlP86pQrlWLJ/SWoDRXtGW1EYTiJK
        B3dGOxGMvvOlbtnoZssOGR6C1/cRTV/jSIoknjdUAf3hPPtmTIqjwEiXyW2IlnZdovYHo8
        HDCF+nqVQLK6AjNEuYhdoChhQZR1V+s38zi1gUAmw+Tx6nsRDps383kUyKy/Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729737;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gJQaWnsl32pW9W2kKDG4+0+f/CUWbZHNlR76kAjoE8=;
        b=N3BUd1fIc9UoD1LRTHv6PsSiUJ8j27JB8PrB5tDsb60W6JM/thoF1ePTCBxF80xoBH/xFS
        rMyv6M+6nztCRkAg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Compile early handler code into kernel image
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-39-joro@8bytes.org>
References: <20200907131613.12703-39-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973646.20229.4790989922662268354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     f980f9c31a923e9040dee0bc679a5f5b09e61f40
Gitweb:        https://git.kernel.org/tip/f980f9c31a923e9040dee0bc679a5f5b09e61f40
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:39 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 10:44:46 +02:00

x86/sev-es: Compile early handler code into kernel image

Setup sev-es.c and include the code from the pre-decompression stage
to also build it into the image of the running kernel. Temporarily add
__maybe_unused annotations to avoid build warnings until the functions
get used.

 [ bp: Use the non-tracing rd/wrmsr variants because:
   vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0x11f: \
	   call to do_trace_write_msr() leaves .noinstr.text section
   as __sev_es_nmi_complete() is noinstr due to being called from the
   NMI handler exc_nmi(). ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-39-joro@8bytes.org
---
 arch/x86/kernel/Makefile        |   1 +-
 arch/x86/kernel/sev-es-shared.c |  21 ++--
 arch/x86/kernel/sev-es.c        | 163 +++++++++++++++++++++++++++++++-
 3 files changed, 175 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/kernel/sev-es.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index e77261d..23bc0f8 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
+obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev-es.o
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index a6b4191..1861927 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -9,7 +9,7 @@
  * and is included directly into both code-bases.
  */
 
-static void sev_es_terminate(unsigned int reason)
+static void __maybe_unused sev_es_terminate(unsigned int reason)
 {
 	u64 val = GHCB_SEV_TERMINATE;
 
@@ -27,7 +27,7 @@ static void sev_es_terminate(unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
-static bool sev_es_negotiate_protocol(void)
+static bool __maybe_unused sev_es_negotiate_protocol(void)
 {
 	u64 val;
 
@@ -46,7 +46,7 @@ static bool sev_es_negotiate_protocol(void)
 	return true;
 }
 
-static void vc_ghcb_invalidate(struct ghcb *ghcb)
+static void __maybe_unused vc_ghcb_invalidate(struct ghcb *ghcb)
 {
 	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
 }
@@ -58,9 +58,9 @@ static bool vc_decoding_needed(unsigned long exit_code)
 		 exit_code <= SVM_EXIT_LAST_EXCP);
 }
 
-static enum es_result vc_init_em_ctxt(struct es_em_ctxt *ctxt,
-				      struct pt_regs *regs,
-				      unsigned long exit_code)
+static enum es_result __maybe_unused vc_init_em_ctxt(struct es_em_ctxt *ctxt,
+						     struct pt_regs *regs,
+						     unsigned long exit_code)
 {
 	enum es_result ret = ES_OK;
 
@@ -73,7 +73,7 @@ static enum es_result vc_init_em_ctxt(struct es_em_ctxt *ctxt,
 	return ret;
 }
 
-static void vc_finish_insn(struct es_em_ctxt *ctxt)
+static void __maybe_unused vc_finish_insn(struct es_em_ctxt *ctxt)
 {
 	ctxt->regs->ip += ctxt->insn.length;
 }
@@ -325,7 +325,8 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 	return ES_OK;
 }
 
-static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+static enum es_result __maybe_unused
+vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct pt_regs *regs = ctxt->regs;
 	u64 exit_info_1, exit_info_2;
@@ -433,8 +434,8 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
-static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
-				      struct es_em_ctxt *ctxt)
+static enum es_result __maybe_unused vc_handle_cpuid(struct ghcb *ghcb,
+						     struct es_em_ctxt *ctxt)
 {
 	struct pt_regs *regs = ctxt->regs;
 	u32 cr4 = native_read_cr4();
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
new file mode 100644
index 0000000..4b1d217
--- /dev/null
+++ b/arch/x86/kernel/sev-es.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Memory Encryption Support
+ *
+ * Copyright (C) 2019 SUSE
+ *
+ * Author: Joerg Roedel <jroedel@suse.de>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+
+#include <asm/sev-es.h>
+#include <asm/insn-eval.h>
+#include <asm/fpu/internal.h>
+#include <asm/processor.h>
+#include <asm/trap_pf.h>
+#include <asm/trapnr.h>
+#include <asm/svm.h>
+
+static inline u64 sev_es_rd_ghcb_msr(void)
+{
+	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
+}
+
+static inline void sev_es_wr_ghcb_msr(u64 val)
+{
+	u32 low, high;
+
+	low  = (u32)(val);
+	high = (u32)(val >> 32);
+
+	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
+}
+
+static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
+				unsigned char *buffer)
+{
+	return copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
+}
+
+static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+{
+	char buffer[MAX_INSN_SIZE];
+	enum es_result ret;
+	int res;
+
+	res = vc_fetch_insn_kernel(ctxt, buffer);
+	if (unlikely(res == -EFAULT)) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = 0;
+		ctxt->fi.cr2        = ctxt->regs->ip;
+		return ES_EXCEPTION;
+	}
+
+	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
+	insn_get_length(&ctxt->insn);
+
+	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
+
+	return ret;
+}
+
+static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
+				   char *dst, char *buf, size_t size)
+{
+	unsigned long error_code = X86_PF_PROT | X86_PF_WRITE;
+	char __user *target = (char __user *)dst;
+	u64 d8;
+	u32 d4;
+	u16 d2;
+	u8  d1;
+
+	switch (size) {
+	case 1:
+		memcpy(&d1, buf, 1);
+		if (put_user(d1, target))
+			goto fault;
+		break;
+	case 2:
+		memcpy(&d2, buf, 2);
+		if (put_user(d2, target))
+			goto fault;
+		break;
+	case 4:
+		memcpy(&d4, buf, 4);
+		if (put_user(d4, target))
+			goto fault;
+		break;
+	case 8:
+		memcpy(&d8, buf, 8);
+		if (put_user(d8, target))
+			goto fault;
+		break;
+	default:
+		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
+		return ES_UNSUPPORTED;
+	}
+
+	return ES_OK;
+
+fault:
+	if (user_mode(ctxt->regs))
+		error_code |= X86_PF_USER;
+
+	ctxt->fi.vector = X86_TRAP_PF;
+	ctxt->fi.error_code = error_code;
+	ctxt->fi.cr2 = (unsigned long)dst;
+
+	return ES_EXCEPTION;
+}
+
+static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
+				  char *src, char *buf, size_t size)
+{
+	unsigned long error_code = X86_PF_PROT;
+	char __user *s = (char __user *)src;
+	u64 d8;
+	u32 d4;
+	u16 d2;
+	u8  d1;
+
+	switch (size) {
+	case 1:
+		if (get_user(d1, s))
+			goto fault;
+		memcpy(buf, &d1, 1);
+		break;
+	case 2:
+		if (get_user(d2, s))
+			goto fault;
+		memcpy(buf, &d2, 2);
+		break;
+	case 4:
+		if (get_user(d4, s))
+			goto fault;
+		memcpy(buf, &d4, 4);
+		break;
+	case 8:
+		if (get_user(d8, s))
+			goto fault;
+		memcpy(buf, &d8, 8);
+		break;
+	default:
+		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
+		return ES_UNSUPPORTED;
+	}
+
+	return ES_OK;
+
+fault:
+	if (user_mode(ctxt->regs))
+		error_code |= X86_PF_USER;
+
+	ctxt->fi.vector = X86_TRAP_PF;
+	ctxt->fi.error_code = error_code;
+	ctxt->fi.cr2 = (unsigned long)src;
+
+	return ES_EXCEPTION;
+}
+
+/* Include code shared with pre-decompression boot stage */
+#include "sev-es-shared.c"
