Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623FDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441D5207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389959AbgFYGGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:06:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:40705 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbgFYGGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:06:40 -0400
IronPort-SDR: 9BRbVBKoLunCJAlAZuMYU2RcjWUZF4Joe4qUEfNZExaW7pbBHwDSsaA9lkH8Wx0u/Ta4yue1lz
 XTQuw76v3LVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="206313495"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="206313495"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 23:06:40 -0700
IronPort-SDR: KV2EeYtsgOpUEMuTQmojb/uFlpndbWT4nTpKIo8IJZPnx8tIUyGX3VhBgsflesTIr01LIMUDsl
 hBd/APZfmdyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="354362405"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2020 23:06:40 -0700
Date:   Wed, 24 Jun 2020 23:06:39 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "David P. Reed" <dpreed@deepplum.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Fix undefined operation VMXOFF during reboot and crash
Message-ID: <20200625060639.GB2141@linux.intel.com>
References: <CALCETrWw3WKLx1k94NfH1jJm-XLid_G-zy8jz_Afdf3KkWjquw@mail.gmail.com>
 <20200611194817.2303-1-dpreed@deepplum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611194817.2303-1-dpreed@deepplum.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 03:48:18PM -0400, David P. Reed wrote:
> -/** Disable VMX on the current CPU
> +/* Disable VMX on the current CPU
>   *
> - * vmxoff causes a undefined-opcode exception if vmxon was not run
> - * on the CPU previously. Only call this function if you know VMX
> - * is enabled.
> + * vmxoff causes an undefined-opcode exception if vmxon was not run
> + * on the CPU previously. Only call this function directly if you know VMX
> + * is enabled *and* CPU is in VMX root operation.
>   */
>  static inline void cpu_vmxoff(void)
>  {
> -	asm volatile ("vmxoff");
> +	asm volatile ("vmxoff" ::: "cc", "memory"); /* clears all flags on success */
>  	cr4_clear_bits(X86_CR4_VMXE);
>  }
>  
> @@ -47,17 +47,35 @@ static inline int cpu_vmx_enabled(void)
>  	return __read_cr4() & X86_CR4_VMXE;
>  }
>  
> -/** Disable VMX if it is enabled on the current CPU
> - *
> - * You shouldn't call this if cpu_has_vmx() returns 0.
> +/*
> + * Safely disable VMX root operation if active
> + * Note that if CPU is not in VMX root operation this
> + * VMXOFF will fault an undefined operation fault,
> + * so use the exception masking facility to handle that RARE
> + * case.
> + * You shouldn't call this directly if cpu_has_vmx() returns 0
> + */
> +static inline void cpu_vmxoff_safe(void)
> +{
> +       asm volatile("1:vmxoff\n\t" /* clears all flags on success */

Eh, I wouldn't bother with the comment, there are a million other caveats
with VMXOFF that are far more interesting.

> +		    "2:\n\t"
> +                    _ASM_EXTABLE(1b, 2b)
> +                    ::: "cc",  "memory");

Adding the memory and flags clobber should be a separate patch.

> +       cr4_clear_bits(X86_CR4_VMXE);
> +}


I don't see any value in safe/unsafe variants.  The only in-kernel user of
VMXOFF outside of the emergency flows is KVM, which has its own VMXOFF
helper, i.e. all users of cpu_vmxoff() want the "safe" variant.  Just add
the exception fixup to cpu_vmxoff() and call it good.

> +
> +/*
> + * Force disable VMX if it is enabled on the current CPU,
> + * when it is unknown whether CPU is in VMX operation.
>   */
>  static inline void __cpu_emergency_vmxoff(void)
>  {
> -	if (cpu_vmx_enabled())
> -		cpu_vmxoff();
> +	if (!cpu_vmx_enabled())
> +		return;
> +	cpu_vmxoff_safe();

Unnecessary churn.

>  }
>  
> -/** Disable VMX if it is supported and enabled on the current CPU
> +/* Force disable VMX if it is supported on current CPU
>   */
>  static inline void cpu_emergency_vmxoff(void)
>  {
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index e040ba6be27b..b0e6b106a67e 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -540,21 +540,14 @@ static void emergency_vmx_disable_all(void)
>  	 *
>  	 * For safety, we will avoid running the nmi_shootdown_cpus()
>  	 * stuff unnecessarily, but we don't have a way to check
> -	 * if other CPUs have VMX enabled. So we will call it only if the
> -	 * CPU we are running on has VMX enabled.
> -	 *
> -	 * We will miss cases where VMX is not enabled on all CPUs. This
> -	 * shouldn't do much harm because KVM always enable VMX on all
> -	 * CPUs anyway. But we can miss it on the small window where KVM
> -	 * is still enabling VMX.
> +	 * if other CPUs have VMX enabled.
>  	 */
> -	if (cpu_has_vmx() && cpu_vmx_enabled()) {
> +	if (cpu_has_vmx()) {
>  		/* Disable VMX on this CPU. */
> -		cpu_vmxoff();
> +		cpu_emergency_vmxoff();

This also needs to be in a separate patch.  And it should use
__cpu_emergency_vmxoff() instead of cpu_emergency_vmxoff().

>  
>  		/* Halt and disable VMX on the other CPUs */
>  		nmi_shootdown_cpus(vmxoff_nmi);
> -
>  	}
>  }
>  
> -- 
> 2.26.2
> 
