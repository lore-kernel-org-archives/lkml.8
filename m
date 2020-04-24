Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C283C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD502074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgDXFJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:09:09 -0400
Received: from mx133-tc.baidu.com ([61.135.168.133]:22648 "EHLO
        tc-sys-mailedm02.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725967AbgDXFJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:09:09 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm02.tc.baidu.com (Postfix) with ESMTP id 4E31611C0049;
        Fri, 24 Apr 2020 13:08:55 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        hpa@zytor.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        joro@8bytes.org, jmattson@google.com, wanpengli@tencent.com,
        vkuznets@redhat.com, sean.j.christopherson@intel.com,
        pbonzini@redhat.com
Subject: [PATCH] [RFC] kvm: x86: emulate APERF/MPERF registers
Date:   Fri, 24 Apr 2020 13:08:55 +0800
Message-Id: <1587704935-30960-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest kernel reports a fixed cpu frequency in /proc/cpuinfo,
this is confused to user when turbo is enable, and aperf/mperf
can be used to show current cpu frequency after 7d5905dc14a
"(x86 / CPU: Always show current CPU frequency in /proc/cpuinfo)"
so we should emulate aperf mperf to achieve it

the period of aperf/mperf in guest mode are accumulated
as emulated value

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/include/asm/kvm_host.h |  5 +++++
 arch/x86/kvm/cpuid.c            |  5 ++++-
 arch/x86/kvm/vmx/vmx.c          | 20 ++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 42a2d0d3984a..526bd13a3d3d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -820,6 +820,11 @@ struct kvm_vcpu_arch {
 
 	/* AMD MSRC001_0015 Hardware Configuration */
 	u64 msr_hwcr;
+
+	u64 host_mperf;
+	u64 host_aperf;
+	u64 v_mperf;
+	u64 v_aperf;
 };
 
 struct kvm_lpage_info {
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 901cd1fdecd9..00e4993cb338 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -558,7 +558,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	case 6: /* Thermal management */
 		entry->eax = 0x4; /* allow ARAT */
 		entry->ebx = 0;
-		entry->ecx = 0;
+		if (boot_cpu_has(X86_FEATURE_APERFMPERF))
+			entry->ecx = 0x1;
+		else
+			entry->ecx = 0x0;
 		entry->edx = 0;
 		break;
 	/* function 7 has additional index. */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 91749f1254e8..f20216fc0b57 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1064,6 +1064,11 @@ static inline void pt_save_msr(struct pt_ctx *ctx, u32 addr_range)
 
 static void pt_guest_enter(struct vcpu_vmx *vmx)
 {
+	struct kvm_vcpu *vcpu = &vmx->vcpu;
+
+	rdmsrl(MSR_IA32_MPERF, vcpu->arch.host_mperf);
+	rdmsrl(MSR_IA32_APERF, vcpu->arch.host_aperf);
+
 	if (vmx_pt_mode_is_system())
 		return;
 
@@ -1081,6 +1086,15 @@ static void pt_guest_enter(struct vcpu_vmx *vmx)
 
 static void pt_guest_exit(struct vcpu_vmx *vmx)
 {
+	struct kvm_vcpu *vcpu = &vmx->vcpu;
+	u64 perf;
+
+	rdmsrl(MSR_IA32_MPERF, perf);
+	vcpu->arch.v_mperf += perf - vcpu->arch.host_mperf;
+
+	rdmsrl(MSR_IA32_APERF, perf);
+	vcpu->arch.v_aperf += perf - vcpu->arch.host_aperf;
+
 	if (vmx_pt_mode_is_system())
 		return;
 
@@ -1914,6 +1928,12 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
 			return 1;
 		goto find_shared_msr;
+	case MSR_IA32_MPERF:
+		msr_info->data = vcpu->arch.v_mperf;
+		break;
+	case MSR_IA32_APERF:
+		msr_info->data = vcpu->arch.v_aperf;
+		break;
 	default:
 	find_shared_msr:
 		msr = find_msr_entry(vmx, msr_info->index);
-- 
2.16.2

