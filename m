Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B10C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ACE921556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+as8mnz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kl92oT2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgIJJgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730397AbgIJJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57B3C06179A;
        Thu, 10 Sep 2020 02:22:16 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729731;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QvRFdvfhfoVKWWGeCfMZBsRDYcT75pRGqc3JbPoxo+Y=;
        b=c+as8mnzG2bsSHSPGHp3tOnDBoVFM+Y9+SaRthdfDfy12nc2YYvbVgsQ4LjOGxOCojN7Xj
        NAnP+PKfNQ+uAZFMgonrYXOpIlnbwf3fPgFYbRIl7SRyAz6J1D9N62mseDMBuZWSzzKyFk
        I75pMnsCrkqqTPjT+MQcc4MAi+5oZY9CnNM2JJHHEvAsLQW5qJVu0BBYI0zVq0JYJ3PWEm
        RkSPt/oQfn8s30jz8FIdKSS1QpPN02f57CM4YZqJrEtB8A5RMy1J34K3R9jK+awvFmFYsa
        F5g6aqWlC64GHlW8Pv2NBe5NfUchYxrZbXflVJf3PSmPktsJzPZydevkCNy+iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729731;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QvRFdvfhfoVKWWGeCfMZBsRDYcT75pRGqc3JbPoxo+Y=;
        b=Kl92oT2e9VOPA16cdTGFrkkvspg7C0wi5D3g6aKI7TtSBjErLBRxEO8r6rH/WrhM+1OoOY
        O2rXE5iWC2a6NrDA==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle DR7 read/write events
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-53-joro@8bytes.org>
References: <20200907131613.12703-53-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973057.20229.2773010329298619685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     479a7bf5c1f7f14eb37c6d6aeb401562efc1fcad
Gitweb:        https://git.kernel.org/tip/479a7bf5c1f7f14eb37c6d6aeb401562efc1fcad
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:15:53 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/sev-es: Handle DR7 read/write events

Add code to handle #VC exceptions on DR7 register reads and writes.
This is needed early because show_regs() reads DR7 to print it out.

Under SEV-ES, there is currently no support for saving/restoring the
DRx registers but software expects to be able to write to the DR7
register. For now, cache the value written to DR7 and return it on
read attempts, but do not touch the real hardware DR7.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: - Adapt to #VC handling framework
                   - Support early usage ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-53-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c | 85 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 6205100..391b9c7 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -29,6 +29,8 @@
 #include <asm/traps.h>
 #include <asm/svm.h>
 
+#define DR7_RESET_VALUE        0x400
+
 /* For early boot hypervisor communication in SEV-ES enabled guests */
 static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
 
@@ -76,6 +78,13 @@ struct sev_es_runtime_data {
 	 */
 	bool ghcb_active;
 	bool backup_ghcb_active;
+
+	/*
+	 * Cached DR7 value - write it on DR7 writes and return it on reads.
+	 * That value will never make it to the real hardware DR7 as debugging
+	 * is currently unsupported in SEV-ES guests.
+	 */
+	unsigned long dr7;
 };
 
 struct ghcb_state {
@@ -519,6 +528,21 @@ static long *vc_insn_get_reg(struct es_em_ctxt *ctxt)
 	return reg_array + offset;
 }
 
+static long *vc_insn_get_rm(struct es_em_ctxt *ctxt)
+{
+	long *reg_array;
+	int offset;
+
+	reg_array = (long *)ctxt->regs;
+	offset    = insn_get_modrm_rm_off(&ctxt->insn, ctxt->regs);
+
+	if (offset < 0)
+		return NULL;
+
+	offset /= sizeof(long);
+
+	return reg_array + offset;
+}
 static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 				 unsigned int bytes, bool read)
 {
@@ -768,6 +792,61 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb,
 	return ret;
 }
 
+static enum es_result vc_handle_dr7_write(struct ghcb *ghcb,
+					  struct es_em_ctxt *ctxt)
+{
+	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
+	long val, *reg = vc_insn_get_rm(ctxt);
+	enum es_result ret;
+
+	if (!reg)
+		return ES_DECODE_FAILED;
+
+	val = *reg;
+
+	/* Upper 32 bits must be written as zeroes */
+	if (val >> 32) {
+		ctxt->fi.vector = X86_TRAP_GP;
+		ctxt->fi.error_code = 0;
+		return ES_EXCEPTION;
+	}
+
+	/* Clear out other reserved bits and set bit 10 */
+	val = (val & 0xffff23ffL) | BIT(10);
+
+	/* Early non-zero writes to DR7 are not supported */
+	if (!data && (val & ~DR7_RESET_VALUE))
+		return ES_UNSUPPORTED;
+
+	/* Using a value of 0 for ExitInfo1 means RAX holds the value */
+	ghcb_set_rax(ghcb, val);
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (data)
+		data->dr7 = val;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_dr7_read(struct ghcb *ghcb,
+					 struct es_em_ctxt *ctxt)
+{
+	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
+	long *reg = vc_insn_get_rm(ctxt);
+
+	if (!reg)
+		return ES_DECODE_FAILED;
+
+	if (data)
+		*reg = data->dr7;
+	else
+		*reg = DR7_RESET_VALUE;
+
+	return ES_OK;
+}
+
 static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code)
@@ -775,6 +854,12 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	enum es_result result;
 
 	switch (exit_code) {
+	case SVM_EXIT_READ_DR7:
+		result = vc_handle_dr7_read(ghcb, ctxt);
+		break;
+	case SVM_EXIT_WRITE_DR7:
+		result = vc_handle_dr7_write(ghcb, ctxt);
+		break;
 	case SVM_EXIT_CPUID:
 		result = vc_handle_cpuid(ghcb, ctxt);
 		break;
