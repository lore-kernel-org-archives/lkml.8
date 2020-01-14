Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCCFC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAE420678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbgANKRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:17:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42318 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730572AbgANKQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:16:59 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFm-0007h1-GU; Tue, 14 Jan 2020 11:16:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2C3711C1928;
        Tue, 14 Jan 2020 11:16:54 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:54 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Clear VMX feature flag if VMX is not fully enabled
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-9-sean.j.christopherson@intel.com>
References: <20191221044513.21680-9-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701402.1022.5566010856636345851.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ef4d3bf19855641fc8a1f621eaf06e2a2bb872bb
Gitweb:        https://git.kernel.org/tip/ef4d3bf19855641fc8a1f621eaf06e2a2bb872bb
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:45:02 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 17:53:57 +01:00

x86/cpu: Clear VMX feature flag if VMX is not fully enabled

Now that IA32_FEAT_CTL is always configured and locked for CPUs that are
known to support VMX[*], clear the VMX capability flag if the MSR is
unsupported or BIOS disabled VMX, i.e. locked IA32_FEAT_CTL and didn't
set the appropriate VMX enable bit.

[*] Because init_ia32_feat_ctl() is called from vendors ->c_init(), it's
    still possible for IA32_FEAT_CTL to be left unlocked when VMX is
    supported by the CPU.  This is not fatal, and will be addressed in a
    future patch.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-9-sean.j.christopherson@intel.com
---
 arch/x86/kernel/cpu/feat_ctl.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index c4f8f76..a46c9e4 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -5,15 +5,21 @@
 #include <asm/msr-index.h>
 #include <asm/processor.h>
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"x86/cpu: " fmt
+
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 {
+	bool tboot = tboot_enabled();
 	u64 msr;
 
-	if (rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr))
+	if (rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr)) {
+		clear_cpu_cap(c, X86_FEATURE_VMX);
 		return;
+	}
 
 	if (msr & FEAT_CTL_LOCKED)
-		return;
+		goto update_caps;
 
 	/*
 	 * Ignore whatever value BIOS left in the MSR to avoid enabling random
@@ -29,9 +35,20 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_VMX) && IS_ENABLED(CONFIG_KVM_INTEL)) {
 		msr |= FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
 
-		if (tboot_enabled())
+		if (tboot)
 			msr |= FEAT_CTL_VMX_ENABLED_INSIDE_SMX;
 	}
 
 	wrmsrl(MSR_IA32_FEAT_CTL, msr);
+
+update_caps:
+	if (!cpu_has(c, X86_FEATURE_VMX))
+		return;
+
+	if ( (tboot && !(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)) ||
+	    (!tboot && !(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX))) {
+		pr_err_once("VMX (%s TXT) disabled by BIOS\n",
+			    tboot ? "inside" : "outside");
+		clear_cpu_cap(c, X86_FEATURE_VMX);
+	}
 }
