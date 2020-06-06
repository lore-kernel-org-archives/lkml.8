Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7926C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 02:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC306206F0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 02:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgFFCvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 22:51:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:21205 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgFFCvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 22:51:12 -0400
IronPort-SDR: Rbpzwml1qMEyLSmSyXpPmq2i37Ps3/DeNoFy0J3fFKjmMUz23YXhB317xpXq9vQdMxrmVk8sj2
 /ACsjAew/wuw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 19:51:11 -0700
IronPort-SDR: b/lX3XbUp/qyzs84TWnMmpT2KdGsPviQJKtci31yC3hJRd0s7wsCupX3GT1jULtoKRQm9FQWhi
 smhHs+LCcTKg==
X-IronPort-AV: E=Sophos;i="5.73,478,1583222400"; 
   d="scan'208";a="446108824"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.169.79]) ([10.249.169.79])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 19:51:09 -0700
Subject: Re: [PATCH] x86/split_lock: Don't write MSR_TEST_CTRL on CPUs that
 aren't whitelisted
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20200605192605.7439-1-sean.j.christopherson@intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <985fb434-523d-3fa0-072c-c039d532bbb0@intel.com>
Date:   Sat, 6 Jun 2020 10:51:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605192605.7439-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/2020 3:26 AM, Sean Christopherson wrote:
> Choo! Choo!  All aboard the Split Lock Express, with direct service to
> Wreckage!
> 
> Skip split_lock_verify_msr() if the CPU isn't whitelisted as a possible
> SLD-enabled CPU model to avoid writing MSR_TEST_CTRL.  MSR_TEST_CTRL
> exists, and is writable, on many generations of CPUs.  Writing the MSR,
> even with '0', can result in bizarre, undocumented behavior.
> 
> This fixes a crash on Haswell when resuming from suspend with a live KVM
> guest.  Because APs use the standard SMP boot flow for resume, they will
> go through split_lock_init() and the subsequent RDMSR/WRMSR sequence,
> which runs even when sld_state==sld_off to ensure SLD is disabled.  On
> Haswell (at least, my Haswell), writing MSR_TEST_CTRL with '0' will
> succeed and _may_ take the SMT _sibling_ out of VMX root mode.
> 
> When KVM has an active guest, KVM performs VMXON as part of CPU onlining
> (see kvm_starting_cpu()).  Because SMP boot is serialized, the resulting
> flow is effectively:
> 
>    on_each_ap_cpu() {
>       WRMSR(MSR_TEST_CTRL, 0)
>       VMXON
>    }
> 
> As a result, the WRMSR can disable VMX on a different CPU that has
> already done VMXON.  This ultimately results in a #UD on VMPTRLD when
> KVM regains control and attempt run its vCPUs.
> 
> The above voodoo was confirmed by reworking KVM's VMXON flow to write
> MSR_TEST_CTRL prior to VMXON, and to serialize the sequence as above.
> Further verification of the insanity was done by redoing VMXON on all
> APs after the initial WRMSR->VMXON sequence.  The additional VMXON,
> which should VM-Fail, occasionally succeeded, and also eliminated the
> unexpected #UD on VMPTRLD.
> 
> The damage done by writing MSR_TEST_CTRL doesn't appear to be limited
> to VMX, e.g. after suspend with an active KVM guest, subsequent reboots
> almost always hang (even when fudging VMXON), a #UD on a random Jcc was
> observed, suspend/resume stability is qualitatively poor, and so on and
> so forth.
> 

I'm wondering if all those side-effects of MSR_TEST_CTRL exist on CPUs 
have SLD feature, have you ever tested on a SLD capable CPU?

