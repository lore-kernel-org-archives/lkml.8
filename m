Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4D8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A565120702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGGFJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:09:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:33299 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgGGFJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:09:34 -0400
IronPort-SDR: YWsy+C/S7ExO0UmKUYBTMLHHDTL7epyR7I7qngUxCv749/04iGMnAIofC1MFsSXEnrzdG0kqsh
 qLgtSrV4JbdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="209061775"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="209061775"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 22:09:33 -0700
IronPort-SDR: f/9beZVbR0NOrJqRH44hjU6uz7MqG9WCQj8U3OXBJ6uGDPbw6iCFWZHYWHRETebT/roATGJrv1
 +UKH6K9vXAnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="314195913"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2020 22:09:32 -0700
Date:   Mon, 6 Jul 2020 22:09:32 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "David P. Reed" <dpreed@deepplum.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH v3 2/3] Fix undefined operation fault that can hang a cpu
 on crash or panic
Message-ID: <20200707050932.GF5208@linux.intel.com>
References: <20200629214956.GA12962@linux.intel.com>
 <20200704203809.76391-1-dpreed@deepplum.com>
 <20200704203809.76391-3-dpreed@deepplum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704203809.76391-3-dpreed@deepplum.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 04:38:08PM -0400, David P. Reed wrote:
> Fix: Mask undefined operation fault during emergency VMXOFF that must be
> attempted to force cpu exit from VMX root operation.
> Explanation: When a cpu may be in VMX root operation (only possible when
> CR4.VMXE is set), crash or panic reboot tries to exit VMX root operation
> using VMXOFF. This is necessary, because any INIT will be masked while cpu
> is in VMX root operation, but that state cannot be reliably
> discerned by the state of the cpu.
> VMXOFF faults if the cpu is not actually in VMX root operation, signalling
> undefined operation.
> Discovered while debugging an out-of-tree x-visor with a race. Can happen
> due to certain kinds of bugs in KVM.
> 
> Fixes: 208067 <https://bugzilla.kernel.org/show_bug.cgi?id=208067>
> Reported-by: David P. Reed <dpreed@deepplum.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: David P. Reed <dpreed@deepplum.com>
> ---
>  arch/x86/include/asm/virtext.h | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
> index 0ede8d04535a..0e0900eacb9c 100644
> --- a/arch/x86/include/asm/virtext.h
> +++ b/arch/x86/include/asm/virtext.h
> @@ -30,11 +30,11 @@ static inline int cpu_has_vmx(void)
>  }
>  
>  
> -/* Disable VMX on the current CPU
> +/* Exit VMX root mode and isable VMX on the current CPU.
>   *
>   * vmxoff causes a undefined-opcode exception if vmxon was not run
> - * on the CPU previously. Only call this function if you know VMX
> - * is enabled.
> + * on the CPU previously. Only call this function if you know cpu
> + * is in VMX root mode.
>   */
>  static inline void cpu_vmxoff(void)
>  {
> @@ -47,14 +47,22 @@ static inline int cpu_vmx_enabled(void)
>  	return __read_cr4() & X86_CR4_VMXE;
>  }
>  
> -/* Disable VMX if it is enabled on the current CPU
> +/* Safely exit VMX root mode and disable VMX if VMX enabled
> + * on the current CPU. Handle undefined-opcode fault
> + * that can occur if cpu is not in VMX root mode, due
> + * to a race.
>   *
>   * You shouldn't call this if cpu_has_vmx() returns 0.
>   */
>  static inline void __cpu_emergency_vmxoff(void)
>  {
> -	if (cpu_vmx_enabled())
> -		cpu_vmxoff();
> +	if (!cpu_vmx_enabled())
> +		return;
> +	asm volatile ("1:vmxoff\n\t"
> +		      "2:\n\t"
> +		      _ASM_EXTABLE(1b, 2b)
> +		      ::: "cc", "memory");
> +	cr4_clear_bits(X86_CR4_VMXE);

Open coding vmxoff doesn't make sense, and IMO is flat out wrong as it fixes
flows that use __cpu_emergency_vmxoff() but leaves the same bug hanging
around in emergency_vmx_disable_all() until the next patch.

The reason I say it doesn't make sense is that there is no sane scenario
where the generic vmxoff helper should _not_ eat the fault.  All other VMXOFF
faults are mode related, i.e. any fault is guaranteed to be due to the
!post-VMXON check unless we're magically in RM, VM86, compat mode, or at
CPL>0.  Given that the whole point of this series is that it's impossible to
determine whether or not the CPU if post-VMXON if CR4.VMXE=1 without taking a
fault of some form, there's simply no way that anything except the hypervisor
(in normal operation) can know the state of VMX.  And given that the only
in-tree hypervisor (KVM) has its own version of vmxoff, that means there is
no scenario in which cpu_vmxoff() can safely be used.  Case in point, after
the next patch there are no users of cpu_vmxoff().

TL;DR: Just do fixup on cpu_vmxoff().

>  }
>  
>  /* Disable VMX if it is supported and enabled on the current CPU
> -- 
> 2.26.2
> 
