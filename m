Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433E1C4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 00:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2016F24672
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 00:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgB0AQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 19:16:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:18213 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgB0AQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 19:16:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 16:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="350518753"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [134.134.177.84]) ([134.134.177.84])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2020 16:16:13 -0800
Subject: Re: [PATCH] x86/pkeys: Manually set X86_FEATURE_OSPKE to preserve
 existing changes
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20200226231615.13664-1-sean.j.christopherson@intel.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <a492b4f4-4a54-5e5a-b79f-e21f9038f259@intel.com>
Date:   Wed, 26 Feb 2020 16:16:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226231615.13664-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/2020 3:16 PM, Sean Christopherson wrote:
> Explicitly set X86_FEATURE_OSPKE via set_cpu_cap() instead of calling
> get_cpu_cap() to pull the feature bit from CPUID after enabling CR4.PKE.
> Invoking get_cpu_cap() effectively wipes out any {set,clear}_cpu_cap()
> changes that were made between this_cpu->c_init() and setup_pku(), as
> all non-synthetic feature words are reinitialized from the CPU's CPUID
> values.
> 
> Blasting away capability updates manifests most visibility when running
> on a VMX capable CPU, but with VMX disabled by BIOS.  To indicate that
> VMX is disabled, init_ia32_feat_ctl() clears X86_FEATURE_VMX, using
> clear_cpu_cap() instead of setup_clear_cpu_cap() so that KVM can report
> which CPU is misconfigured (KVM needs to probe every CPU anyways).
> Restoring X86_FEATURE_VMX from CPUID causes KVM to think VMX is enabled,
> ultimately leading to an unexpected #GP when KVM attempts to do VMXON.
> 
> Arguably, init_ia32_feat_ctl() should use setup_clear_cpu_cap() and let
> KVM figure out a different way to report the misconfigured CPU, but VMX
> is not the only feature bit that is affected, i.e. there is precedent
> that tweaking feature bits via {set,clear}_cpu_cap() after ->c_init()
> is expected to work.  Most notably, x86_init_rdrand()'s clearing of
> X86_FEATURE_RDRAND when RDRAND malfunctions is also overwritten.
> 
> Fixes: 0697694564c8 ("x86/mm/pkeys: Actually enable Memory Protection Keys in the CPU")
> Cc: stable@vger.kernel.org
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Reported-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> 

I tested this and it resolves my report! Thanks for a timely fix.

I agree with the analysis. Perhaps it would make sense in the long term
to find a solution where get_cpu_cap can remember what was cleared for
each CPU and restore those? It already does this using the global
variables...

Thanks,
Jake
