Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DFEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC1524649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOMzlfWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbgBNKcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 05:32:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45232 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387419AbgBNKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581676333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j8Qv2G1USmaN3X7ZSQbGrtsmCgkb3FQbsYMVl1V7FoM=;
        b=FOMzlfWgoHemUgAlM23SgATKRrzohNK/C8AtoKgXscj4Yq+7ts/EyvLTY38LcfT5HnNwzh
        vPRloiu7J0EqpWvi4sE8tNmGzuB/upnW7wMMzoPOjMDdQo8zlJYyh3EQ1s9vV+ioRtbSpR
        p1tn/305T9cygZEcdRpaUc4KBB55pS8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-hr6X3fsCP4mH08oB3sHNiQ-1; Fri, 14 Feb 2020 05:32:11 -0500
X-MC-Unique: hr6X3fsCP4mH08oB3sHNiQ-1
Received: by mail-wr1-f69.google.com with SMTP id o6so3781979wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 02:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j8Qv2G1USmaN3X7ZSQbGrtsmCgkb3FQbsYMVl1V7FoM=;
        b=QqTL+JDwoaMsNtDxF97bR+kF4/NYFL3GZDLmTecI1rgTN15EECcRdzfMfVs0/CmCPp
         ymnq7pKhaxGeukgQq/miMaLZRg49W693o2Y3BsQhy6GhjUv8eHqSvVmOSWlSMXs+ciLF
         PuY/k0lS24551C4DhAkhIED4mY+3siDwlyUlQsDXFA9uRQpsEkc6/sQumVFHBS3KaFbk
         NuOUNp9rQXcI1uhNJtZPHs/QQkc+u5E6NQFW7QemrSPvSJakl8Su007RREiPfRiHMJ+E
         DH/4IIhbYJIaL8xSEsR+cRjo8p9y+oNX35hdCzPaD/sTYtPTTv6uMoVSw+XUsZdgWFL0
         CU/g==
X-Gm-Message-State: APjAAAXbUfAN3yb3b1T3J1gM/cDJDbhGe5d4BdnrsQmetqpVsVt/j+f+
        IOZBHxmTA7z/DYWohmPrsksBTEJaUob1wD8oJVDYs1cy7GZWDBPLrZ4TKXp6foOd4z0fCbLwN11
        rvx3KObJkANpPP5hwvS3D0YxW
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr3446540wrs.92.1581676329836;
        Fri, 14 Feb 2020 02:32:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/92+nWcI39Q3lxmegrkcWojVnqqzKX9tp3vod/Kfo9qphtcMkfu69ze/x6Yd+XicMxyUN1Q==
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr3446505wrs.92.1581676329434;
        Fri, 14 Feb 2020 02:32:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id f62sm6934572wmf.36.2020.02.14.02.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 02:32:08 -0800 (PST)
Subject: Re: [patch V2 09/17] x86/vdso: Use generic VDSO clock mode storage
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andrei Vagin <avagin@gmail.com>
References: <20200207123847.339896630@linutronix.de>
 <20200207124403.152039903@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8cb6e4f0-2fef-e8f4-4bef-862aa113d278@redhat.com>
Date:   Fri, 14 Feb 2020 11:32:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200207124403.152039903@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/20 13:38, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Switch to the generic VDSO clock mode storage.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Juergen Gross <jgross@suse.com> (Xen parts)

Acked-by: Paolo Bonzini <pbonzini@redhat.com> (KVM parts)

Thanks,

Paolo

> ---
>  arch/x86/Kconfig                         |    2 +-
>  arch/x86/entry/vdso/vma.c                |    6 +++---
>  arch/x86/include/asm/clocksource.h       |   13 ++++---------
>  arch/x86/include/asm/mshyperv.h          |    4 ++--
>  arch/x86/include/asm/vdso/gettimeofday.h |    6 +++---
>  arch/x86/include/asm/vdso/vsyscall.h     |    7 -------
>  arch/x86/kernel/kvmclock.c               |    4 ++--
>  arch/x86/kernel/pvclock.c                |    2 +-
>  arch/x86/kernel/time.c                   |   12 +++---------
>  arch/x86/kernel/tsc.c                    |    6 +++---
>  arch/x86/kvm/trace.h                     |    4 ++--
>  arch/x86/kvm/x86.c                       |   22 +++++++++++-----------
>  arch/x86/xen/time.c                      |   21 +++++++++++----------
>  13 files changed, 46 insertions(+), 63 deletions(-)
> 
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -57,7 +57,6 @@ config X86
>  	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
>  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>  	select ARCH_32BIT_OFF_T			if X86_32
> -	select ARCH_CLOCKSOURCE_DATA
>  	select ARCH_CLOCKSOURCE_INIT
>  	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
>  	select ARCH_HAS_DEBUG_VIRTUAL
> @@ -126,6 +125,7 @@ config X86
>  	select GENERIC_STRNLEN_USER
>  	select GENERIC_TIME_VSYSCALL
>  	select GENERIC_GETTIMEOFDAY
> +	select GENERIC_VDSO_CLOCK_MODE
>  	select GENERIC_VDSO_TIME_NS
>  	select GUP_GET_PTE_LOW_HIGH		if X86_PAE
>  	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -221,7 +221,7 @@ static vm_fault_t vvar_fault(const struc
>  	} else if (sym_offset == image->sym_pvclock_page) {
>  		struct pvclock_vsyscall_time_info *pvti =
>  			pvclock_get_pvti_cpu0_va();
> -		if (pvti && vclock_was_used(VCLOCK_PVCLOCK)) {
> +		if (pvti && vclock_was_used(VDSO_CLOCKMODE_PVCLOCK)) {
>  			return vmf_insert_pfn_prot(vma, vmf->address,
>  					__pa(pvti) >> PAGE_SHIFT,
>  					pgprot_decrypted(vma->vm_page_prot));
> @@ -229,7 +229,7 @@ static vm_fault_t vvar_fault(const struc
>  	} else if (sym_offset == image->sym_hvclock_page) {
>  		struct ms_hyperv_tsc_page *tsc_pg = hv_get_tsc_page();
>  
> -		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
> +		if (tsc_pg && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
>  			return vmf_insert_pfn(vma, vmf->address,
>  					virt_to_phys(tsc_pg) >> PAGE_SHIFT);
>  	} else if (sym_offset == image->sym_timens_page) {
> @@ -447,7 +447,7 @@ static __init int vdso_setup(char *s)
>  
>  static int __init init_vdso(void)
>  {
> -	BUILD_BUG_ON(VCLOCK_MAX >= 32);
> +	BUILD_BUG_ON(VDSO_CLOCKMODE_MAX >= 32);
>  
>  	init_vdso_image(&vdso_image_64);
>  
> --- a/arch/x86/include/asm/clocksource.h
> +++ b/arch/x86/include/asm/clocksource.h
> @@ -4,15 +4,10 @@
>  #ifndef _ASM_X86_CLOCKSOURCE_H
>  #define _ASM_X86_CLOCKSOURCE_H
>  
> -#define VCLOCK_NONE	0	/* No vDSO clock available.		*/
> -#define VCLOCK_TSC	1	/* vDSO should use vread_tsc.		*/
> -#define VCLOCK_PVCLOCK	2	/* vDSO should use vread_pvclock.	*/
> -#define VCLOCK_HVCLOCK	3	/* vDSO should use vread_hvclock.	*/
> -#define VCLOCK_MAX	3
> -
> -struct arch_clocksource_data {
> -	int vclock_mode;
> -};
> +#define VDSO_ARCH_CLOCKMODES	\
> +	VDSO_CLOCKMODE_TSC,	\
> +	VDSO_CLOCKMODE_PVCLOCK,	\
> +	VDSO_CLOCKMODE_HVCLOCK
>  
>  extern unsigned int vclocks_used;
>  
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -46,9 +46,9 @@ typedef int (*hyperv_fill_flush_list_fun
>  #define hv_set_reference_tsc(val) \
>  	wrmsrl(HV_X64_MSR_REFERENCE_TSC, val)
>  #define hv_set_clocksource_vdso(val) \
> -	((val).archdata.vclock_mode = VCLOCK_HVCLOCK)
> +	((val).vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK)
>  #define hv_enable_vdso_clocksource() \
> -	vclocks_set_used(VCLOCK_HVCLOCK);
> +	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
>  #define hv_get_raw_timer() rdtsc_ordered()
>  
>  void hyperv_callback_vector(void);
> --- a/arch/x86/include/asm/vdso/gettimeofday.h
> +++ b/arch/x86/include/asm/vdso/gettimeofday.h
> @@ -243,7 +243,7 @@ static u64 vread_hvclock(void)
>  
>  static inline u64 __arch_get_hw_counter(s32 clock_mode)
>  {
> -	if (likely(clock_mode == VCLOCK_TSC))
> +	if (likely(clock_mode == VDSO_CLOCKMODE_TSC))
>  		return (u64)rdtsc_ordered();
>  	/*
>  	 * For any memory-mapped vclock type, we need to make sure that gcc
> @@ -252,13 +252,13 @@ static inline u64 __arch_get_hw_counter(
>  	 * question isn't enabled, which will segfault.  Hence the barriers.
>  	 */
>  #ifdef CONFIG_PARAVIRT_CLOCK
> -	if (clock_mode == VCLOCK_PVCLOCK) {
> +	if (clock_mode == VDSO_CLOCKMODE_PVCLOCK) {
>  		barrier();
>  		return vread_pvclock();
>  	}
>  #endif
>  #ifdef CONFIG_HYPERV_TIMER
> -	if (clock_mode == VCLOCK_HVCLOCK) {
> +	if (clock_mode == VDSO_CLOCKMODE_HVCLOCK) {
>  		barrier();
>  		return vread_hvclock();
>  	}
> --- a/arch/x86/include/asm/vdso/vsyscall.h
> +++ b/arch/x86/include/asm/vdso/vsyscall.h
> @@ -21,13 +21,6 @@ struct vdso_data *__x86_get_k_vdso_data(
>  }
>  #define __arch_get_k_vdso_data __x86_get_k_vdso_data
>  
> -static __always_inline
> -int __x86_get_clock_mode(struct timekeeper *tk)
> -{
> -	return tk->tkr_mono.clock->archdata.vclock_mode;
> -}
> -#define __arch_get_clock_mode __x86_get_clock_mode
> -
>  /* The asm-generic header needs to be included after the definitions above */
>  #include <asm-generic/vdso/vsyscall.h>
>  
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -161,7 +161,7 @@ bool kvm_check_and_clear_guest_paused(vo
>  
>  static int kvm_cs_enable(struct clocksource *cs)
>  {
> -	vclocks_set_used(VCLOCK_PVCLOCK);
> +	vclocks_set_used(VDSO_CLOCKMODE_PVCLOCK);
>  	return 0;
>  }
>  
> @@ -279,7 +279,7 @@ static int __init kvm_setup_vsyscall_tim
>  	if (!(flags & PVCLOCK_TSC_STABLE_BIT))
>  		return 0;
>  
> -	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
> +	kvm_clock.vdso_clock_mode = VDSO_CLOCKMODE_PVCLOCK;
>  #endif
>  
>  	kvmclock_init_mem();
> --- a/arch/x86/kernel/pvclock.c
> +++ b/arch/x86/kernel/pvclock.c
> @@ -145,7 +145,7 @@ void pvclock_read_wallclock(struct pvclo
>  
>  void pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti)
>  {
> -	WARN_ON(vclock_was_used(VCLOCK_PVCLOCK));
> +	WARN_ON(vclock_was_used(VDSO_CLOCKMODE_PVCLOCK));
>  	pvti_cpu0_va = pvti;
>  }
>  
> --- a/arch/x86/kernel/time.c
> +++ b/arch/x86/kernel/time.c
> @@ -114,18 +114,12 @@ void __init time_init(void)
>   */
>  void clocksource_arch_init(struct clocksource *cs)
>  {
> -	if (cs->archdata.vclock_mode == VCLOCK_NONE)
> +	if (cs->vdso_clock_mode == VDSO_CLOCKMODE_NONE)
>  		return;
>  
> -	if (cs->archdata.vclock_mode > VCLOCK_MAX) {
> -		pr_warn("clocksource %s registered with invalid vclock_mode %d. Disabling vclock.\n",
> -			cs->name, cs->archdata.vclock_mode);
> -		cs->archdata.vclock_mode = VCLOCK_NONE;
> -	}
> -
>  	if (cs->mask != CLOCKSOURCE_MASK(64)) {
> -		pr_warn("clocksource %s registered with invalid mask %016llx. Disabling vclock.\n",
> +		pr_warn("clocksource %s registered with invalid mask %016llx for VDSO. Disabling VDSO support.\n",
>  			cs->name, cs->mask);
> -		cs->archdata.vclock_mode = VCLOCK_NONE;
> +		cs->vdso_clock_mode = VDSO_CLOCKMODE_NONE;
>  	}
>  }
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1110,7 +1110,7 @@ static void tsc_cs_tick_stable(struct cl
>  
>  static int tsc_cs_enable(struct clocksource *cs)
>  {
> -	vclocks_set_used(VCLOCK_TSC);
> +	vclocks_set_used(VDSO_CLOCKMODE_TSC);
>  	return 0;
>  }
>  
> @@ -1124,7 +1124,7 @@ static struct clocksource clocksource_ts
>  	.mask			= CLOCKSOURCE_MASK(64),
>  	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
>  				  CLOCK_SOURCE_MUST_VERIFY,
> -	.archdata		= { .vclock_mode = VCLOCK_TSC },
> +	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
>  	.enable			= tsc_cs_enable,
>  	.resume			= tsc_resume,
>  	.mark_unstable		= tsc_cs_mark_unstable,
> @@ -1145,7 +1145,7 @@ static struct clocksource clocksource_ts
>  	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
>  				  CLOCK_SOURCE_VALID_FOR_HRES |
>  				  CLOCK_SOURCE_MUST_VERIFY,
> -	.archdata		= { .vclock_mode = VCLOCK_TSC },
> +	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
>  	.enable			= tsc_cs_enable,
>  	.resume			= tsc_resume,
>  	.mark_unstable		= tsc_cs_mark_unstable,
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -815,8 +815,8 @@ TRACE_EVENT(kvm_write_tsc_offset,
>  #ifdef CONFIG_X86_64
>  
>  #define host_clocks					\
> -	{VCLOCK_NONE, "none"},				\
> -	{VCLOCK_TSC,  "tsc"}				\
> +	{VDSO_CLOCKMODE_NONE, "none"},			\
> +	{VDSO_CLOCKMODE_TSC,  "tsc"}			\
>  
>  TRACE_EVENT(kvm_update_master_clock,
>  	TP_PROTO(bool use_master_clock, unsigned int host_clock, bool offset_matched),
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1635,7 +1635,7 @@ static void update_pvclock_gtod(struct t
>  	write_seqcount_begin(&vdata->seq);
>  
>  	/* copy pvclock gtod data */
> -	vdata->clock.vclock_mode	= tk->tkr_mono.clock->archdata.vclock_mode;
> +	vdata->clock.vclock_mode	= tk->tkr_mono.clock->vdso_clock_mode;
>  	vdata->clock.cycle_last		= tk->tkr_mono.cycle_last;
>  	vdata->clock.mask		= tk->tkr_mono.mask;
>  	vdata->clock.mult		= tk->tkr_mono.mult;
> @@ -1643,7 +1643,7 @@ static void update_pvclock_gtod(struct t
>  	vdata->clock.base_cycles	= tk->tkr_mono.xtime_nsec;
>  	vdata->clock.offset		= tk->tkr_mono.base;
>  
> -	vdata->raw_clock.vclock_mode	= tk->tkr_raw.clock->archdata.vclock_mode;
> +	vdata->raw_clock.vclock_mode	= tk->tkr_raw.clock->vdso_clock_mode;
>  	vdata->raw_clock.cycle_last	= tk->tkr_raw.cycle_last;
>  	vdata->raw_clock.mask		= tk->tkr_raw.mask;
>  	vdata->raw_clock.mult		= tk->tkr_raw.mult;
> @@ -1844,7 +1844,7 @@ static u64 compute_guest_tsc(struct kvm_
>  
>  static inline int gtod_is_based_on_tsc(int mode)
>  {
> -	return mode == VCLOCK_TSC || mode == VCLOCK_HVCLOCK;
> +	return mode == VDSO_CLOCKMODE_TSC || mode == VDSO_CLOCKMODE_HVCLOCK;
>  }
>  
>  static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
> @@ -1937,7 +1937,7 @@ static inline bool kvm_check_tsc_unstabl
>  	 * TSC is marked unstable when we're running on Hyper-V,
>  	 * 'TSC page' clocksource is good.
>  	 */
> -	if (pvclock_gtod_data.clock.vclock_mode == VCLOCK_HVCLOCK)
> +	if (pvclock_gtod_data.clock.vclock_mode == VDSO_CLOCKMODE_HVCLOCK)
>  		return false;
>  #endif
>  	return check_tsc_unstable();
> @@ -2092,30 +2092,30 @@ static inline u64 vgettsc(struct pvclock
>  	u64 tsc_pg_val;
>  
>  	switch (clock->vclock_mode) {
> -	case VCLOCK_HVCLOCK:
> +	case VDSO_CLOCKMODE_HVCLOCK:
>  		tsc_pg_val = hv_read_tsc_page_tsc(hv_get_tsc_page(),
>  						  tsc_timestamp);
>  		if (tsc_pg_val != U64_MAX) {
>  			/* TSC page valid */
> -			*mode = VCLOCK_HVCLOCK;
> +			*mode = VDSO_CLOCKMODE_HVCLOCK;
>  			v = (tsc_pg_val - clock->cycle_last) &
>  				clock->mask;
>  		} else {
>  			/* TSC page invalid */
> -			*mode = VCLOCK_NONE;
> +			*mode = VDSO_CLOCKMODE_NONE;
>  		}
>  		break;
> -	case VCLOCK_TSC:
> -		*mode = VCLOCK_TSC;
> +	case VDSO_CLOCKMODE_TSC:
> +		*mode = VDSO_CLOCKMODE_TSC;
>  		*tsc_timestamp = read_tsc();
>  		v = (*tsc_timestamp - clock->cycle_last) &
>  			clock->mask;
>  		break;
>  	default:
> -		*mode = VCLOCK_NONE;
> +		*mode = VDSO_CLOCKMODE_NONE;
>  	}
>  
> -	if (*mode == VCLOCK_NONE)
> +	if (*mode == VDSO_CLOCKMODE_NONE)
>  		*tsc_timestamp = v = 0;
>  
>  	return v * clock->mult;
> --- a/arch/x86/xen/time.c
> +++ b/arch/x86/xen/time.c
> @@ -147,7 +147,7 @@ static struct notifier_block xen_pvclock
>  
>  static int xen_cs_enable(struct clocksource *cs)
>  {
> -	vclocks_set_used(VCLOCK_PVCLOCK);
> +	vclocks_set_used(VDSO_CLOCKMODE_PVCLOCK);
>  	return 0;
>  }
>  
> @@ -419,12 +419,13 @@ void xen_restore_time_memory_area(void)
>  	ret = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_time_memory_area, 0, &t);
>  
>  	/*
> -	 * We don't disable VCLOCK_PVCLOCK entirely if it fails to register the
> -	 * secondary time info with Xen or if we migrated to a host without the
> -	 * necessary flags. On both of these cases what happens is either
> -	 * process seeing a zeroed out pvti or seeing no PVCLOCK_TSC_STABLE_BIT
> -	 * bit set. Userspace checks the latter and if 0, it discards the data
> -	 * in pvti and fallbacks to a system call for a reliable timestamp.
> +	 * We don't disable VDSO_CLOCKMODE_PVCLOCK entirely if it fails to
> +	 * register the secondary time info with Xen or if we migrated to a
> +	 * host without the necessary flags. On both of these cases what
> +	 * happens is either process seeing a zeroed out pvti or seeing no
> +	 * PVCLOCK_TSC_STABLE_BIT bit set. Userspace checks the latter and
> +	 * if 0, it discards the data in pvti and fallbacks to a system
> +	 * call for a reliable timestamp.
>  	 */
>  	if (ret != 0)
>  		pr_notice("Cannot restore secondary vcpu_time_info (err %d)",
> @@ -450,7 +451,7 @@ static void xen_setup_vsyscall_time_info
>  
>  	ret = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_time_memory_area, 0, &t);
>  	if (ret) {
> -		pr_notice("xen: VCLOCK_PVCLOCK not supported (err %d)\n", ret);
> +		pr_notice("xen: VDSO_CLOCKMODE_PVCLOCK not supported (err %d)\n", ret);
>  		free_page((unsigned long)ti);
>  		return;
>  	}
> @@ -467,14 +468,14 @@ static void xen_setup_vsyscall_time_info
>  		if (!ret)
>  			free_page((unsigned long)ti);
>  
> -		pr_notice("xen: VCLOCK_PVCLOCK not supported (tsc unstable)\n");
> +		pr_notice("xen: VDSO_CLOCKMODE_PVCLOCK not supported (tsc unstable)\n");
>  		return;
>  	}
>  
>  	xen_clock = ti;
>  	pvclock_set_pvti_cpu0_va(xen_clock);
>  
> -	xen_clocksource.archdata.vclock_mode = VCLOCK_PVCLOCK;
> +	xen_clocksource.vdso_clock_mode = VDSO_CLOCKMODE_PVCLOCK;
>  }
>  
>  static void __init xen_time_init(void)
> 

