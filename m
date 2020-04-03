Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BC6C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66432077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404424AbgDCSBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:01:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:28139 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbgDCSBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:01:50 -0400
IronPort-SDR: 82Bzw5O0eHrsmSfUoyIOj06jUZVy2fuXdVE+sbop+qXeC0btyz2F3VQ2Ynk1LhAwCKvMvu3NFU
 Jl9R/oJrEz9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 11:01:50 -0700
IronPort-SDR: 2b7OEGq4QfLhhmmmByN1BmTBmmSsQ3lrxnE3BBHCpEHTulud/fRarfBEFeLNuMXkSExIT8K7sF
 ZS/pgVvA2WAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="242869295"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga008.fm.intel.com with ESMTP; 03 Apr 2020 11:01:49 -0700
Date:   Fri, 3 Apr 2020 11:01:49 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
Cc:     xiaoyao.li@intel.com, philipp.eppelt@kernkonzept.com, bp@alien8.de,
        fenghua.yu@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, nivedita@alum.mit.edu,
        pbonzini@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH 1/1] x86/split_lock: check split lock feature on
 initialization
Message-ID: <20200403180149.GH2701@linux.intel.com>
References: <20200325030924.132881-1-xiaoyao.li@intel.com>
 <20200403174403.306363-1-benjamin.lamowski@kernkonzept.com>
 <20200403174403.306363-2-benjamin.lamowski@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403174403.306363-2-benjamin.lamowski@kernkonzept.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 07:44:03PM +0200, Benjamin Lamowski wrote:
> While the setup code probes for the availability of the TEST_CTRL MSR,
> the current initialization code unconditionally probes it even on
> systems where this architectural MSR is not available.
> 
> This commit changes the code to check for the availability of the split
> lock detect feature before initializing it.
> 
> Fixes: dbaba47085b0c ("x86/split_lock: Rework the initialization flow of split lock detection")
> Signed-off-by: Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 9a26e972cdea..70d338ff4807 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -586,7 +586,7 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
>  	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
>  }
>  
> -static void split_lock_init(void);
> +static void split_lock_init(struct cpuinfo_x86 *c);
>  
>  static void init_intel(struct cpuinfo_x86 *c)
>  {
> @@ -703,7 +703,7 @@ static void init_intel(struct cpuinfo_x86 *c)
>  	if (tsx_ctrl_state == TSX_CTRL_DISABLE)
>  		tsx_disable();
>  
> -	split_lock_init();
> +	split_lock_init(c);
>  }
>  
>  #ifdef CONFIG_X86_32
> @@ -1061,9 +1061,10 @@ static void sld_update_msr(bool on)
>  	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
>  }
>  
> -static void split_lock_init(void)
> +static void split_lock_init(struct cpuinfo_x86 *c)
>  {
> -	split_lock_verify_msr(sld_state != sld_off);
> +	if (cpu_has(c, X86_FEATURE_SPLIT_LOCK_DETECT))
> +		split_lock_verify_msr(sld_state != sld_off);

Calling split_lock_verify_msr() with X86_FEATURE_SPLIT_LOCK_DETECT=0 is
intentional, the idea is to ensure SLD is disabled on all CPUs, e.g. in the
unlikely scenario that BIOS enabled SLD.

The first rdmsrl_safe() should short circuit split_lock_verify_msr() if
the RDMSR faults, i.e. it might fault, but it shouldn't WARN.  Are you
seeing issues or was this found via code inspection?

>  }
>  
>  bool handle_user_split_lock(struct pt_regs *regs, long error_code)
> -- 
> 2.25.1
> 
