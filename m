Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A4C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8670521556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SEApkfvh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W62LrPRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgIJJXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbgIJJWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E43C061786;
        Thu, 10 Sep 2020 02:22:14 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTdy7/EBirJXydnNikKRqtOCcrlDzKtIRzM3jUW6CRc=;
        b=SEApkfvhDwcszC1xpl/XIuEfUKCzRuEOTg/w85qMQSlDLw1KCdMvhr7Rli+92M/9TZR9hY
        edeABXSqkneLmnInznUSrBps2cyR26k7x1wBb1BlZgTABlZQwY8NrfGm6sa5b6OlZcFJ00
        Q2wqLxWDIf6Sc6FYjqnuWUC+Sqq5NGl/3IRPQcnpSo7nSm9A8aZBMpnhfBcY6Kei08b3ZR
        cmvdmk4Z/ureCSBxFcxxIrQKXiabHIXjv2tRpSvDm8N6zlk0Q3CBGt6Egm75OHOHhd25gl
        Urtkvszb31OIdAAVmSYV1aG12hZR98+98fa6aj18K9uC+bwld7iDnE9jzZKH9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTdy7/EBirJXydnNikKRqtOCcrlDzKtIRzM3jUW6CRc=;
        b=W62LrPRT9IImw3snr+EAhL6afa2sxbAoervRio0q9KMtLBd1Rd6R+TYA3hZJatAYN9yl08
        rKVa+3YEvhCTnCDg==
From:   "tip-bot2 for Doug Covelli" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/vmware: Add VMware-specific handling for VMMCALL
 under SEV-ES
Cc:     Doug Covelli <dcovelli@vmware.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-65-joro@8bytes.org>
References: <20200907131613.12703-65-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972557.20229.773744278485296601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     1a222de8dcfb903d039810b0823570ee0be4e6c6
Gitweb:        https://git.kernel.org/tip/1a222de8dcfb903d039810b0823570ee0be4e6c6
Author:        Doug Covelli <dcovelli@vmware.com>
AuthorDate:    Mon, 07 Sep 2020 15:16:05 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/vmware: Add VMware-specific handling for VMMCALL under SEV-ES

Add VMware-specific handling for #VC faults caused by VMMCALL
instructions.

Signed-off-by: Doug Covelli <dcovelli@vmware.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: - Adapt to different paravirt interface ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-65-joro@8bytes.org
---
 arch/x86/kernel/cpu/vmware.c | 50 +++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 9b6fafa..924571f 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -33,6 +33,7 @@
 #include <asm/timer.h>
 #include <asm/apic.h>
 #include <asm/vmware.h>
+#include <asm/svm.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"vmware: " fmt
@@ -476,10 +477,49 @@ static bool __init vmware_legacy_x2apic_available(void)
 	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
 }
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+static void vmware_sev_es_hcall_prepare(struct ghcb *ghcb,
+					struct pt_regs *regs)
+{
+	/* Copy VMWARE specific Hypercall parameters to the GHCB */
+	ghcb_set_rip(ghcb, regs->ip);
+	ghcb_set_rbx(ghcb, regs->bx);
+	ghcb_set_rcx(ghcb, regs->cx);
+	ghcb_set_rdx(ghcb, regs->dx);
+	ghcb_set_rsi(ghcb, regs->si);
+	ghcb_set_rdi(ghcb, regs->di);
+	ghcb_set_rbp(ghcb, regs->bp);
+}
+
+static bool vmware_sev_es_hcall_finish(struct ghcb *ghcb, struct pt_regs *regs)
+{
+	if (!(ghcb_rbx_is_valid(ghcb) &&
+	      ghcb_rcx_is_valid(ghcb) &&
+	      ghcb_rdx_is_valid(ghcb) &&
+	      ghcb_rsi_is_valid(ghcb) &&
+	      ghcb_rdi_is_valid(ghcb) &&
+	      ghcb_rbp_is_valid(ghcb)))
+		return false;
+
+	regs->bx = ghcb->save.rbx;
+	regs->cx = ghcb->save.rcx;
+	regs->dx = ghcb->save.rdx;
+	regs->si = ghcb->save.rsi;
+	regs->di = ghcb->save.rdi;
+	regs->bp = ghcb->save.rbp;
+
+	return true;
+}
+#endif
+
 const __initconst struct hypervisor_x86 x86_hyper_vmware = {
-	.name			= "VMware",
-	.detect			= vmware_platform,
-	.type			= X86_HYPER_VMWARE,
-	.init.init_platform	= vmware_platform_setup,
-	.init.x2apic_available	= vmware_legacy_x2apic_available,
+	.name				= "VMware",
+	.detect				= vmware_platform,
+	.type				= X86_HYPER_VMWARE,
+	.init.init_platform		= vmware_platform_setup,
+	.init.x2apic_available		= vmware_legacy_x2apic_available,
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	.runtime.sev_es_hcall_prepare	= vmware_sev_es_hcall_prepare,
+	.runtime.sev_es_hcall_finish	= vmware_sev_es_hcall_finish,
+#endif
 };
