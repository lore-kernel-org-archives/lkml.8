Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071F0C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F2E207FD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtQmgpIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCFI14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:27:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27870 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726010AbgCFI14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583483273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/eV4Jl7MJmgIx3ljM9FkIlfcB2xroWb7S6wokZGiX2Y=;
        b=RtQmgpIT4O34vTs4F8rXJ1yehgYBifEls6fB1kjJ4XFJR2T3nzmrtJWuIPkco5rfZFfTf/
        VVM0MzSJsoUxv+xrgWOCk/ocNFSNH2+pZVhji03Se1MW/R33I9UHC2pRdFo0Q89ZUp3JQc
        pX4Ek4pjKGZnYcYZxJNiP/wmkCdHbNU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-X64cMdXvOC6m2zykpw2cSA-1; Fri, 06 Mar 2020 03:27:51 -0500
X-MC-Unique: X64cMdXvOC6m2zykpw2cSA-1
Received: by mail-wr1-f69.google.com with SMTP id t14so682127wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 00:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/eV4Jl7MJmgIx3ljM9FkIlfcB2xroWb7S6wokZGiX2Y=;
        b=ocU+DARvVrQQML0bJWgF0COKF2CQkgXK95VSklpdYg1pWmp5e5IwQ9zo5Sk2Xysgno
         XQGWXJg8OUCTLbfvhBBdiZqqaI7gARxMtZGiw0jFlwXRAr8QY7fd4RgHDI9Vz4s+YdUf
         tNHGl5QQGYjB/o4yWcD3do/58FTRVbDpzV3oLVfNH+ibZeZkfZNF2z2aBM/4tX2VgpOv
         hH0KYIewd2dPlGVeCjdNm07jhoR5lDn+IM7J9UEdThpLyRxegviFJWJm/KbmOs6ICb9k
         ppUWdBhtYVIkZG2hBR9AXLF/xjoaHX0zsMnxP8E5x0wuPgZMSA3hTXPlX3l8l528hib9
         6xlQ==
X-Gm-Message-State: ANhLgQ2Ce+Zk9dQiQ2YfqsYX7CciD5PFm7CLlT8hE8h+e6XuiiDPAIyK
        D5hQgZH6gZrW89jqoo/xmZlDFy5S0kt+R8Pf0PrYjWWPkYakY3jzeSrvOUlD4lGsMxqXh5vzHSt
        b1IZyHTrk8ivVJGD9Bj6c5ol4
X-Received: by 2002:adf:fec4:: with SMTP id q4mr2801906wrs.368.1583483270195;
        Fri, 06 Mar 2020 00:27:50 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtAhMdeOb8wAM7/MRIbkEb0R1rnEdu2FH7kQs6Tjpdc2loRGjArDjlgm7WprYogupVpA7csrg==
X-Received: by 2002:adf:fec4:: with SMTP id q4mr2801878wrs.368.1583483269849;
        Fri, 06 Mar 2020 00:27:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b99a:4374:773d:f32e? ([2001:b07:6468:f312:b99a:4374:773d:f32e])
        by smtp.gmail.com with ESMTPSA id n3sm19656093wrv.91.2020.03.06.00.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 00:27:49 -0800 (PST)
Subject: Re: [PATCH v2 00/66] KVM: x86: Introduce KVM cpu caps
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd8eae75-b85b-59a9-24ea-c8bde7bd7cee@redhat.com>
Date:   Fri, 6 Mar 2020 09:27:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302235709.27467-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 00:56, Sean Christopherson wrote:
> Introduce what is effectively a KVM-specific copy of the x86_capabilities
> array in boot_cpu_data, kvm_cpu_caps.  kvm_cpu_caps is initialized by
> copying boot_cpu_data.x86_capabilities before ->hardware_setup().  It is
> then updated by KVM's CPUID logic (both common x86 and VMX/SVM specific)
> to adjust the caps to reflect the CPU that KVM will expose to the guest.
> 
> Quick synopsis:
>   1. Refactor the KVM_GET_SUPPORTED_CPUID stack to consolidate code,
>      remove crustiness, and set the stage for introducing kvm_cpu_caps.
> 
>   2. Introduce cpuid_entry_*() accessors/mutators to automatically
>      handle retrieving the correct reg from a CPUID entry, and to audit
>      that the entry matches the reserve CPUID lookup entry.  The
>      cpuid_entry_*() helpers make moving the code from common x86 to
>      vendor code much less risky.
> 
>   3. Move CPUID adjustments to vendor code in preparation for kvm_cpu_caps,
>      which will be initialized at load time before the kvm_x86_ops hooks
>      are ready to be used, i.e. before ->hardware_setup().
> 
>   4. Introduce kvm_cpu_caps and move all the CPUID code over to kvm_cpu_caps.
> 
>   5. Use kvm_cpu_cap_has() to kill off a bunch of ->*_supported() hooks.
> 
>   6. Additional cleanup in tangentially related areas to kill off even more
>      ->*_supported() hooks, including ->set_supported_cpuid().
> 
> Tested by verifying the output of KVM_GET_SUPPORTED_CPUID is identical
> before and after on every patch on a Haswell and Coffee Lake, and for the
> "before vs. after" output on Ice Lake.
> 
> Verified correctness when hiding features via Qemu (running this version
> of KVM in L1), e.g. that UMIP is correctly emulated for L2 when it's
> hidden from L1, on relevant patches.
> 
> Boot tested and ran kvm-unit-tests at key points, e.g. large page
> handling.
> 
> All AMD patches are build-tested only.

I put the complete series on the cpu-caps branch of kvm.git.

Thanks,

Paolo

> v2:
>   - Opportunistically remove bare "unsigned" usgae. [Vitaly]
>   - Remove CPUID auditing (Vitaly and Paolo suggested making it
>     unconditional, then I realized it would trigger false positives).
>   - Fix a bug in the series that broke SVM features enumeration.
>   - Only advertise SVM features when nested SVM is enabled. [Paolo]
>   - Fully remove support for stateful CPUID.0x2. [Vitaly, Paolo]
>   - Call out in patch 01's changelog that it technically breaks the
>     ABI, but that no known VMM is affected. [Vitaly, Paolo]
>   - Use @function instead of hardcoding "2" for thes stateful code (which
>     eventually gets tossed anyways). [Vitaly]
>   - Move 0x8000000A into common code and kill ->set_supported_cpuid().
>     [Vitaly]
>   - Call out the subtle emulation handling in ->set_supported_cpuid(),
>     which also gets tossed :-).  [Vitaly]
>   - Fix the BUILG_BUG_ON() in patch 38. [Vitaly]
>   - Use !! to explicitly cast a u32 to a bool. [Vitaly, Paolo]
>   - Sort kvm_cpu_cap_mask() calls by leaf number, ascending. [Vitaly]
>   - Collect reviews. [Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly,
>     Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly,
>     Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly,
>     Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly,
>     Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly,
>     Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly,
>     Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Vitaly,
>     Vitaly, Vitaly, Vitaly, Vitaly, Vitaly, Xiaoyao, Xiaoyao, Xiaoyao]
> 
> Sean Christopherson (66):
>   KVM: x86: Return -E2BIG when KVM_GET_SUPPORTED_CPUID hits max entries
>   KVM: x86: Refactor loop around do_cpuid_func() to separate helper
>   KVM: x86: Simplify handling of Centaur CPUID leafs
>   KVM: x86: Clean up error handling in kvm_dev_ioctl_get_cpuid()
>   KVM: x86: Check userapce CPUID array size after validating sub-leaf
>   KVM: x86: Move CPUID 0xD.1 handling out of the index>0 loop
>   KVM: x86: Check for CPUID 0xD.N support before validating array size
>   KVM: x86: Warn on zero-size save state for valid CPUID 0xD.N sub-leaf
>   KVM: x86: Refactor CPUID 0xD.N sub-leaf entry creation
>   KVM: x86: Clean up CPUID 0x7 sub-leaf loop
>   KVM: x86: Drop the explicit @index from do_cpuid_7_mask()
>   KVM: x86: Drop redundant boot cpu checks on SSBD feature bits
>   KVM: x86: Consolidate CPUID array max num entries checking
>   KVM: x86: Hoist loop counter and terminator to top of
>     __do_cpuid_func()
>   KVM: x86: Refactor CPUID 0x4 and 0x8000001d handling
>   KVM: x86: Encapsulate CPUID entries and metadata in struct
>   KVM: x86: Drop redundant array size check
>   KVM: x86: Use common loop iterator when handling CPUID 0xD.N
>   KVM: VMX: Add helpers to query Intel PT mode
>   KVM: x86: Calculate the supported xcr0 mask at load time
>   KVM: x86: Use supported_xcr0 to detect MPX support
>   KVM: x86: Make kvm_mpx_supported() an inline function
>   KVM: x86: Clear output regs for CPUID 0x14 if PT isn't exposed to
>     guest
>   KVM: x86: Drop explicit @func param from ->set_supported_cpuid()
>   KVM: x86: Use u32 for holding CPUID register value in helpers
>   KVM: x86: Replace bare "unsigned" with "unsigned int" in cpuid helpers
>   KVM: x86: Introduce cpuid_entry_{get,has}() accessors
>   KVM: x86: Introduce cpuid_entry_{change,set,clear}() mutators
>   KVM: x86: Refactor cpuid_mask() to auto-retrieve the register
>   KVM: x86: Handle MPX CPUID adjustment in VMX code
>   KVM: x86: Handle INVPCID CPUID adjustment in VMX code
>   KVM: x86: Handle UMIP emulation CPUID adjustment in VMX code
>   KVM: x86: Handle PKU CPUID adjustment in VMX code
>   KVM: x86: Handle RDTSCP CPUID adjustment in VMX code
>   KVM: x86: Handle Intel PT CPUID adjustment in VMX code
>   KVM: x86: Handle GBPAGE CPUID adjustment for EPT in VMX code
>   KVM: x86: Refactor handling of XSAVES CPUID adjustment
>   KVM: x86: Introduce kvm_cpu_caps to replace runtime CPUID masking
>   KVM: SVM: Convert feature updates from CPUID to KVM cpu caps
>   KVM: VMX: Convert feature updates from CPUID to KVM cpu caps
>   KVM: x86: Move XSAVES CPUID adjust to VMX's KVM cpu cap update
>   KVM: x86: Add a helper to check kernel support when setting cpu cap
>   KVM: x86: Use KVM cpu caps to mark CR4.LA57 as not-reserved
>   KVM: x86: Use KVM cpu caps to track UMIP emulation
>   KVM: x86: Fold CPUID 0x7 masking back into __do_cpuid_func()
>   KVM: x86: Remove the unnecessary loop on CPUID 0x7 sub-leafs
>   KVM: x86: Squash CPUID 0x2.0 insanity for modern CPUs
>   KVM: x86: Remove stateful CPUID handling
>   KVM: x86: Do host CPUID at load time to mask KVM cpu caps
>   KVM: x86: Override host CPUID results with kvm_cpu_caps
>   KVM: x86: Set emulated/transmuted feature bits via kvm_cpu_caps
>   KVM: x86: Use kvm_cpu_caps to detect Intel PT support
>   KVM: x86: Do kvm_cpuid_array capacity checks in terminal functions
>   KVM: x86: Use KVM cpu caps to detect MSR_TSC_AUX virt support
>   KVM: VMX: Directly use VMX capabilities helper to detect RDTSCP
>     support
>   KVM: x86: Check for Intel PT MSR virtualization using KVM cpu caps
>   KVM: VMX: Directly query Intel PT mode when refreshing PMUs
>   KVM: SVM: Refactor logging of NPT enabled/disabled
>   KVM: x86/mmu: Merge kvm_{enable,disable}_tdp() into a common function
>   KVM: x86/mmu: Configure max page level during hardware setup
>   KVM: x86: Don't propagate MMU lpage support to memslot.disallow_lpage
>   KVM: Drop largepages_enabled and its accessor/mutator
>   KVM: x86: Move VMX's host_efer to common x86 code
>   KVM: nSVM: Expose SVM features to L1 iff nested is enabled
>   KVM: nSVM: Advertise and enable NRIPS for L1 iff nrips is enabled
>   KVM: x86: Move nSVM CPUID 0x8000000A handing into common x86 code
> 
>  Documentation/virt/kvm/api.rst  |  22 +-
>  arch/x86/include/asm/kvm_host.h |  15 +-
>  arch/x86/kvm/cpuid.c            | 874 +++++++++++++++-----------------
>  arch/x86/kvm/cpuid.h            | 134 ++++-
>  arch/x86/kvm/mmu/mmu.c          |  29 +-
>  arch/x86/kvm/svm.c              | 130 ++---
>  arch/x86/kvm/vmx/capabilities.h |  25 +-
>  arch/x86/kvm/vmx/nested.c       |   2 +-
>  arch/x86/kvm/vmx/pmu_intel.c    |   2 +-
>  arch/x86/kvm/vmx/vmx.c          | 121 +++--
>  arch/x86/kvm/vmx/vmx.h          |   5 +-
>  arch/x86/kvm/x86.c              |  48 +-
>  arch/x86/kvm/x86.h              |  10 +-
>  include/linux/kvm_host.h        |   2 -
>  virt/kvm/kvm_main.c             |  13 -
>  15 files changed, 695 insertions(+), 737 deletions(-)
> 

