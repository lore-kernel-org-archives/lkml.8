Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA249C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADB5207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbgANKSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:18:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42307 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbgANKQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:16:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFl-0007gB-1O; Tue, 14 Jan 2020 11:16:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B45131C001A;
        Tue, 14 Jan 2020 11:16:52 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:52 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Add flag to track whether MSR
 IA32_FEAT_CTL is configured
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-14-sean.j.christopherson@intel.com>
References: <20191221044513.21680-14-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701251.1022.4546938145887744610.tip-bot2@tip-bot2>
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

Commit-ID:     85c17291e2eb4903bf73e5d3f588f41dbcc6f115
Gitweb:        https://git.kernel.org/tip/85c17291e2eb4903bf73e5d3f588f41dbcc6f115
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:45:07 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 18:49:00 +01:00

x86/cpufeatures: Add flag to track whether MSR IA32_FEAT_CTL is configured

Add a new feature flag, X86_FEATURE_MSR_IA32_FEAT_CTL, to track whether
IA32_FEAT_CTL has been initialized.  This will allow KVM, and any future
subsystems that depend on IA32_FEAT_CTL, to rely purely on cpufeatures
to query platform support, e.g. allows a future patch to remove KVM's
manual IA32_FEAT_CTL MSR checks.

Various features (on platforms that support IA32_FEAT_CTL) are dependent
on IA32_FEAT_CTL being configured and locked, e.g. VMX and LMCE.  The
MSR is always configured during boot, but only if the CPU vendor is
recognized by the kernel.  Because CPUID doesn't incorporate the current
IA32_FEAT_CTL value in its reporting of relevant features, it's possible
for a feature to be reported as supported in cpufeatures but not truly
enabled, e.g. if the CPU supports VMX but the kernel doesn't recognize
the CPU.

As a result, without the flag, KVM would see VMX as supported even if
IA32_FEAT_CTL hasn't been initialized, and so would need to manually
read the MSR and check the various enabling bits to avoid taking an
unexpected #GP on VMXON.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-14-sean.j.christopherson@intel.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/feat_ctl.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index e9b6249..67d21b2 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -220,6 +220,7 @@
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
+#define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index fcbb355..24a4fdc 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -126,6 +126,8 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 	wrmsrl(MSR_IA32_FEAT_CTL, msr);
 
 update_caps:
+	set_cpu_cap(c, X86_FEATURE_MSR_IA32_FEAT_CTL);
+
 	if (!cpu_has(c, X86_FEATURE_VMX))
 		return;
 
