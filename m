Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B99C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852C121582
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HNKeNf94";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VAhF0dPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgIJJgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgIJJW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDDCC061795;
        Thu, 10 Sep 2020 02:22:14 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CgdvPA5jOWO7ev0Hks2iEx4O+05hPkIh+LQJzXx3gRA=;
        b=HNKeNf94RJdBRLTptkiPyeVZEZz31pxop8X+al6Vg5btKl1notK7w1xjmi4j/09Tem0Jrl
        xhrwEBxMiO50ihjfVvZaWOPlwWUFiEPaMd2Lj8EF6klANlscpVuNBJyZpDwid71tLsneBO
        9FjfMO1XdSlFOhBEaFTuMfDmtlrpRpfKVcScD5zWrxXO/k+EkbhekIlWzjqM0Hw/8kFY5w
        Pkwf3TBOAVoYEMHQFtJCgAnDSTQyyQ+srtUo3MbnRu20gAmQR8xntutKBIJAQ6fH/tAIqs
        ZE6FGn9LbhNpkhwfr6DcOK648XBAgOAokmMfNvh7PKzif5g+zVTxWFj4T2lnPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CgdvPA5jOWO7ev0Hks2iEx4O+05hPkIh+LQJzXx3gRA=;
        b=VAhF0dPsE2ryIBnkyWvLEzS2iAH7PYuItw9AiXkqDHA7mDpMMT7FMHXTg+bpC7cWQHd7UN
        xCK3J29u1oBsvDAA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/paravirt: Allow hypervisor-specific VMMCALL
 handling under SEV-ES
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-63-joro@8bytes.org>
References: <20200907131613.12703-63-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972645.20229.17971210808448409139.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     f6a9f8a45810d2914ea422ff39bfe2e0251c50f2
Gitweb:        https://git.kernel.org/tip/f6a9f8a45810d2914ea422ff39bfe2e0251c50f2
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:16:03 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/paravirt: Allow hypervisor-specific VMMCALL handling under SEV-ES

Add two new paravirt callbacks to provide hypervisor-specific processor
state in the GHCB and to copy state from the hypervisor back to the
processor.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-63-joro@8bytes.org
---
 arch/x86/include/asm/x86_init.h | 16 +++++++++++++++-
 arch/x86/kernel/sev-es.c        | 12 ++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 6807153..0304e29 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -4,8 +4,10 @@
 
 #include <asm/bootparam.h>
 
+struct ghcb;
 struct mpc_bus;
 struct mpc_cpu;
+struct pt_regs;
 struct mpc_table;
 struct cpuinfo_x86;
 
@@ -236,10 +238,22 @@ struct x86_legacy_features {
 /**
  * struct x86_hyper_runtime - x86 hypervisor specific runtime callbacks
  *
- * @pin_vcpu:		pin current vcpu to specified physical cpu (run rarely)
+ * @pin_vcpu:			pin current vcpu to specified physical
+ *				cpu (run rarely)
+ * @sev_es_hcall_prepare:	Load additional hypervisor-specific
+ *				state into the GHCB when doing a VMMCALL under
+ *				SEV-ES. Called from the #VC exception handler.
+ * @sev_es_hcall_finish:	Copies state from the GHCB back into the
+ *				processor (or pt_regs). Also runs checks on the
+ *				state returned from the hypervisor after a
+ *				VMMCALL under SEV-ES.  Needs to return 'false'
+ *				if the checks fail.  Called from the #VC
+ *				exception handler.
  */
 struct x86_hyper_runtime {
 	void (*pin_vcpu)(int cpu);
+	void (*sev_es_hcall_prepare)(struct ghcb *ghcb, struct pt_regs *regs);
+	bool (*sev_es_hcall_finish)(struct ghcb *ghcb, struct pt_regs *regs);
 };
 
 /**
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 79d5190..6d89df9 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -897,6 +897,9 @@ static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
 	ghcb_set_rax(ghcb, ctxt->regs->ax);
 	ghcb_set_cpl(ghcb, user_mode(ctxt->regs) ? 3 : 0);
 
+	if (x86_platform.hyper.sev_es_hcall_prepare)
+		x86_platform.hyper.sev_es_hcall_prepare(ghcb, ctxt->regs);
+
 	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_VMMCALL, 0, 0);
 	if (ret != ES_OK)
 		return ret;
@@ -906,6 +909,15 @@ static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
 
 	ctxt->regs->ax = ghcb->save.rax;
 
+	/*
+	 * Call sev_es_hcall_finish() after regs->ax is already set.
+	 * This allows the hypervisor handler to overwrite it again if
+	 * necessary.
+	 */
+	if (x86_platform.hyper.sev_es_hcall_finish &&
+	    !x86_platform.hyper.sev_es_hcall_finish(ghcb, ctxt->regs))
+		return ES_VMM_ERROR;
+
 	return ES_OK;
 }
 
