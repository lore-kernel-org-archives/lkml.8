Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8974CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5524206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o18xQCF5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r43De36c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgHFSuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:50:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59504 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbgHFSuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:50:17 -0400
Date:   Thu, 06 Aug 2020 18:50:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596739814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CEms7WvfXWEM83cireifolNM9kUFjf0kjE5lCr1yXlM=;
        b=o18xQCF5eA1vXUJo1CGPgH0fgKSsnr27BrSD6iXowVSPU4Fj2eTjE8Pni8goS1lqn4J2hf
        olBbCxiH62QEMl3ycs9istA1o0T0O+D5R5TmJ1u5Hj54D6X47W5nJeyTOCccQueDjuxHKG
        MqNtU+x9na9lxxXcwn6H6OwKFmn84ndP56iZVaMZHNIw9m3Uj4Y88ITGgwYin8yWO7/RL6
        TlRpAAdrxqxEgqazgcMoGb3h7aYZewPjNJuw/hIdyoGkGZdNb8LYPaKdbEbywxBIyVsc06
        ZUiavHr3sww4EFNQ72U3a1bwVLxzhQhxfIC54vETNda6+BNPChEmhnELwslTyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596739814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CEms7WvfXWEM83cireifolNM9kUFjf0kjE5lCr1yXlM=;
        b=r43De36c5dcsjoIsffKdrU/RcoiHbHB5ezRPkvN8yOj9MDd/Qb2FybrXxmspwbnXu1mEbC
        BFSegMoUNcFYrLAw==
From:   "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs/multihit: Fix mitigation reporting when
 VMX is not in use
Cc:     Nelson Dsouza <nelson.dsouza@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C0ba029932a816179b9d14a30db38f0f11ef1f166=2E15949?=
 =?utf-8?q?25782=2Egit=2Epawan=2Ekumar=2Egupta=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3C0ba029932a816179b9d14a30db38f0f11ef1f166=2E159492?=
 =?utf-8?q?5782=2Egit=2Epawan=2Ekumar=2Egupta=40linux=2Eintel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <159673981325.3192.5057160198465079415.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     31dccf7df081364045bff196bdc060ddda97f2e9
Gitweb:        https://git.kernel.org/tip/31dccf7df081364045bff196bdc060ddda97f2e9
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Thu, 16 Jul 2020 12:23:59 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 19:04:51 +02:00

x86/bugs/multihit: Fix mitigation reporting when VMX is not in use

On systems that have virtualization disabled or unsupported, sysfs
mitigation for X86_BUG_ITLB_MULTIHIT is reported incorrectly as:

  $ cat /sys/devices/system/cpu/vulnerabilities/itlb_multihit
  KVM: Vulnerable

System is not vulnerable to DoS attack from a rogue guest when
virtualization is disabled or unsupported in the hardware. Change the
mitigation reporting for these cases.

Fixes: b8e8c8303ff2 ("kvm: mmu: ITLB_MULTIHIT mitigation")
Reported-by: Nelson Dsouza <nelson.dsouza@linux.intel.com>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/0ba029932a816179b9d14a30db38f0f11ef1f166.1594925782.git.pawan.kumar.gupta@linux.intel.com
---
 Documentation/admin-guide/hw-vuln/multihit.rst | 4 ++++
 arch/x86/kernel/cpu/bugs.c                     | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/hw-vuln/multihit.rst b/Documentation/admin-guide/hw-vuln/multihit.rst
index ba9988d..140e4ce 100644
--- a/Documentation/admin-guide/hw-vuln/multihit.rst
+++ b/Documentation/admin-guide/hw-vuln/multihit.rst
@@ -80,6 +80,10 @@ The possible values in this file are:
        - The processor is not vulnerable.
      * - KVM: Mitigation: Split huge pages
        - Software changes mitigate this issue.
+     * - KVM: Mitigation: VMX unsupported
+       - KVM is not vulnerable because Virtual Machine Extensions (VMX) is not supported.
+     * - KVM: Mitigation: VMX disabled
+       - KVM is not vulnerable because Virtual Machine Extensions (VMX) is disabled.
      * - KVM: Vulnerable
        - The processor is vulnerable, but no mitigation enabled
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f0b743a..d3f0db4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -31,6 +31,7 @@
 #include <asm/intel-family.h>
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
+#include <asm/tlbflush.h>
 
 #include "cpu.h"
 
@@ -1549,7 +1550,12 @@ static ssize_t l1tf_show_state(char *buf)
 
 static ssize_t itlb_multihit_show_state(char *buf)
 {
-	if (itlb_multihit_kvm_mitigation)
+	if (!boot_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
+	    !boot_cpu_has(X86_FEATURE_VMX))
+		return sprintf(buf, "KVM: Mitigation: VMX unsupported\n");
+	else if (!(cr4_read_shadow() & X86_CR4_VMXE))
+		return sprintf(buf, "KVM: Mitigation: VMX disabled\n");
+	else if (itlb_multihit_kvm_mitigation)
 		return sprintf(buf, "KVM: Mitigation: Split huge pages\n");
 	else
 		return sprintf(buf, "KVM: Vulnerable\n");
