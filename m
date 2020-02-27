Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C23C3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D9A24650
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgB0WbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:31:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:35152 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbgB0Wav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:30:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 14:30:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="385312253"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2020 14:30:49 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] KVM: VMX: Gracefully handle faults on VMXON
Date:   Thu, 27 Feb 2020 14:30:46 -0800
Message-Id: <20200227223047.13125-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227223047.13125-1-sean.j.christopherson@intel.com>
References: <20200227223047.13125-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gracefully handle faults on VMXON, e.g. #GP due to VMX being disabled by
BIOS, instead of letting the fault crash the system.  Now that KVM uses
cpufeatures to query support instead of reading MSR_IA32_FEAT_CTL
directly, it's possible for a bug in a different subsystem to cause KVM
to incorrectly attempt VMXON[*].  Crashing the system is especially
annoying if the system is configured such that hardware_enable() will
be triggered during boot.

Oppurtunistically rename @addr to @vmxon_pointer and use a named param
to reference it in the inline assembly.

Print 0xdeadbeef in the ultra-"rare" case that reading MSR_IA32_FEAT_CTL
also faults.

[*] https://lkml.kernel.org/r/20200226231615.13664-1-sean.j.christopherson@intel.com
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2648b2214407..a5109804abee 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2236,18 +2236,33 @@ static __init int vmx_disabled_by_bios(void)
 	       !boot_cpu_has(X86_FEATURE_VMX);
 }
 
-static void kvm_cpu_vmxon(u64 addr)
+static int kvm_cpu_vmxon(u64 vmxon_pointer)
 {
+	u64 msr;
+
 	cr4_set_bits(X86_CR4_VMXE);
 	intel_pt_handle_vmx(1);
 
-	asm volatile ("vmxon %0" : : "m"(addr));
+	asm_volatile_goto("1: vmxon %[vmxon_pointer]\n\t"
+			  _ASM_EXTABLE(1b, %l[fault])
+			  : : [vmxon_pointer] "m"(vmxon_pointer)
+			  : : fault);
+	return 0;
+
+fault:
+	WARN_ONCE(1, "VMXON faulted, MSR_IA32_FEAT_CTL (0x3a) = 0x%llx\n",
+		  rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr) ? 0xdeadbeef : msr);
+	intel_pt_handle_vmx(0);
+	cr4_clear_bits(X86_CR4_VMXE);
+
+	return -EFAULT;
 }
 
 static int hardware_enable(void)
 {
 	int cpu = raw_smp_processor_id();
 	u64 phys_addr = __pa(per_cpu(vmxarea, cpu));
+	int r;
 
 	if (cr4_read_shadow() & X86_CR4_VMXE)
 		return -EBUSY;
@@ -2264,7 +2279,10 @@ static int hardware_enable(void)
 	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
 	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
 
-	kvm_cpu_vmxon(phys_addr);
+	r = kvm_cpu_vmxon(phys_addr);
+	if (r)
+		return r;
+
 	if (enable_ept)
 		ept_sync_global();
 
-- 
2.24.1

