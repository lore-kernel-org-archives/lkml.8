Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96792C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA8B206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgA2Xqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:46:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:46688 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgA2Xqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 18:46:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 15:46:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; 
   d="scan'208";a="309551694"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2020 15:46:43 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/26] KVM: x86: Purge kvm_x86_ops->*_supported()
Date:   Wed, 29 Jan 2020 15:46:14 -0800
Message-Id: <20200129234640.8147-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our benevolent dictator decreed that "all *_supported() should be removed,
and the code moved from __do_cpuid_func() to set_supported_cpuid"[*].

To make that happen, move CPUID and MSR checks from x86 into SVM/VMX via
the existing ->set_supported_cpuid() and a ->new has_virtualized_msr() ops
respectively.

As usual, there's a fair amount of cleanup in between the mechanical
changes.  Most notable is the introduction of cpuid entry accessors and
mutators to replace all of the code to manipulate individual feature bits
in cpuid entries, which is error prone and annoying.  MPX (*sigh*) also
gets a healthly dose of cleanup.

I don't love every patch in this series.  Specifically, adding an extra
call to ->set_supported_cpuid() to handle XSAVES is ugly.  But, I do like
that it purges all ->*_supported() hooks.  And practically speaking, odds
are good that CPUID 0xD.1 will get more feature bits, i.e. keeping
->xsaves_supported() would likely lead to another ->*_supported() hook.

Paolo also expressed a dislike for clearing bits in set_supported_cpuid().
I don't have a strong opinion regarding clearing bits, but the alternative
approach, i.e. leave the bits clear and then set them in vendor code,
gets quite kludgy because the vendor code (mostly VMX) would need to
manually recheck boot_cpu_data to ensure it wasn't advertising a feature
that the user/kernel expressly disabled.  IMO, forcing manual checks is
more likely to introduce errors and provides less insight into why VMX
needs to adjust the advertised CPUID values (VMCS != CPUID).

Tested on Intel by verifying the output of KVM_GET_SUPPORTED_CPUID is
identical before and after (on almost every patch) on a Haswell and Coffee
Lake.  The big untested pieces are PKU and PT on Intel, and everything AMD.

[*] https://lkml.kernel.org/r/8a77e3b9-049e-e622-9332-9bebb829bc3d@redhat.com

Sean Christopherson (26):
  KVM: x86: Remove superfluous brackets from case statement
  KVM: x86: Take an unsigned 32-bit int for has_emulated_msr()'s index
  KVM: x86: Snapshot MSR index in a local variable when processing lists
  KVM: x86: Add a kvm_x86_ops hook to query virtualized MSR support
  KVM: x86: Move MSR_TSC_AUX existence checks into vendor code
  KVM: x86: Move MSR_IA32_BNDCFGS existence checks into vendor code
  KVM: VMX: Add helpers to query Intel PT mode
  KVM: x86: Move RTIT (Intel PT) MSR existence checks into vendor code
  KVM: x86: Calculate the supported xcr0 mask at load time
  KVM: x86: Use supported_xcr0 to detect MPX support
  KVM: x86: Make kvm_mpx_supported() an inline function
  KVM: x86: Drop explicit @func param from ->set_supported_cpuid()
  KVM: x86: Use u32 for holding CPUID register value in helpers
  KVM: x86: Introduce cpuid_entry_{get,has}() accessors
  KVM: x86: Introduce cpuid_entry_{change,set,clear}() mutators
  KVM: x86: Add Kconfig-controlled auditing of reverse CPUID lookups
  KVM: x86: Handle MPX CPUID adjustment in vendor code
  KVM: x86: Handle INVPCID CPUID adjustment in vendor code
  KVM: x86: Handle UMIP emulation CPUID adjustment in VMX code
  KVM: x86: Handle PKU CPUID adjustment in SVM code
  KVM: x86: Handle RDTSCP CPUID adjustment in VMX code
  KVM: x86: Handle XSAVES CPUID adjustment in VMX code
  KVM: x86: Handle Intel PT CPUID adjustment in vendor code
  KVM: x86: Clear output regs for CPUID 0x14 if PT isn't exposed to
    guest
  KVM: x86: Handle main Intel PT CPUID leaf in vendor code
  KVM: VMX: Directly query Intel PT mode when refreshing PMUs

 arch/x86/include/asm/kvm_host.h |  12 +--
 arch/x86/kvm/Kconfig            |  10 +++
 arch/x86/kvm/cpuid.c            | 147 +++++++++++++-------------------
 arch/x86/kvm/cpuid.h            |  85 +++++++++++++++---
 arch/x86/kvm/svm.c              |  88 ++++++++++---------
 arch/x86/kvm/vmx/capabilities.h |  25 ++++--
 arch/x86/kvm/vmx/nested.c       |   2 +-
 arch/x86/kvm/vmx/pmu_intel.c    |   2 +-
 arch/x86/kvm/vmx/vmx.c          | 119 ++++++++++++++++++--------
 arch/x86/kvm/vmx/vmx.h          |   4 +-
 arch/x86/kvm/x86.c              |  76 +++++++----------
 arch/x86/kvm/x86.h              |  10 +--
 12 files changed, 331 insertions(+), 249 deletions(-)

-- 
2.24.1

