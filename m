Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4E8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7A12074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="sX04N19G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgFJV7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgFJV7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:59:22 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954B9C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:59:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n2so1478558pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:mime-version:subject:from:in-reply-to:cc
         :date:message-id:references:to;
        bh=NdBvIyN0+B0E+FLHRKmrKKKiEB2XJE5/pjm/mjwpHTs=;
        b=sX04N19GXfRQX8rNdpHD5ZDiZskcch+5v3jbdpARA5u7TXiIi32qsqDk5VIUjMiPa2
         X8LqFoF/OB4j1JOC4GVZ8EbV1Mfvkg2LF3T+k8RtHZUnmQ19eYqjoMGmBT3KPgmLgwFv
         UG4hNosQ2YOi042eT0N2F45P0R66CMIsQfVz+yxUK1yaCLVKEtsdHWXLypRS6cs1xYX6
         pgVE19Qe0CC0Phmni3SmHIw1H0uNU9oA1W/oxX05cmpT0ZF0SZu4Jp0g1H7Kd4Jv6dQd
         rVe8vZeBGbjCHpwAok6aFD2Tjh5wNHKArFq1MF1lsXLCzP/SWTDNyPdwrRBtqvD/JV30
         CQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:mime-version:subject
         :from:in-reply-to:cc:date:message-id:references:to;
        bh=NdBvIyN0+B0E+FLHRKmrKKKiEB2XJE5/pjm/mjwpHTs=;
        b=q64Q/dUwBu27Lb7N+Z8kBCENFPmz/4COyUCWfqeZGUbyeZLDRO9TvAIzjn0C0xX1XT
         xPiDp01ryqUp0Ai+SFLEgMwrkWrXReqpul6/8RdVM6F09wfEwlZaZpgIqKZ3JFN5v7cR
         kbwehHixTzJSPdbbfjRWxC7eq8RQyQewElbwpSzSuvwVq+w2znWM1816quUoUbird8uo
         878J9oirg6PiaAWFd/f1w3/ox1smKcotN86bG5zqLnZRkfIVj5dNQ0uQatliz+WrDMiG
         cId7kA2ZOIUtWBjS6pC3kTarWe++W2Ozk9q3GMY4L2K05nulttx0ho60lPVj7gPAo3y1
         fODA==
X-Gm-Message-State: AOAM530n5LEqdg3aBkBeNeowTc8i7F2NKtiEg0Ii04yqrx2GNA7fT33M
        rLAZEkEiDVywX/uZmDceMYRRXg==
X-Google-Smtp-Source: ABdhPJw6F4ktaaYVa9zObAtqY6PwjWUT4r06kxEolKugT8xUrflAmSiP0imO6BwetHuudumugg7kAw==
X-Received: by 2002:a17:90a:aa8f:: with SMTP id l15mr5402889pjq.156.1591826362035;
        Wed, 10 Jun 2020 14:59:22 -0700 (PDT)
Received: from ?IPv6:2600:1010:b02a:3dac:540d:35b0:24d1:3df? ([2600:1010:b02a:3dac:540d:35b0:24d1:3df])
        by smtp.gmail.com with ESMTPSA id z1sm849071pfr.88.2020.06.10.14.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 14:59:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Fix undefined operation VMXOFF during reboot and crash
From:   Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <20200610181254.2142-1-dpreed@deepplum.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Jun 2020 14:59:19 -0700
Message-Id: <3F5CEF02-0561-4E28-851B-8E993F76DC9B@amacapital.net>
References: <20200610181254.2142-1-dpreed@deepplum.com>
To:     "David P. Reed" <dpreed@deepplum.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 10, 2020, at 11:21 AM, David P. Reed <dpreed@deepplum.com> wrote:
>=20
> =EF=BB=BFIf a panic/reboot occurs when CR4 has VMX enabled, a VMXOFF is
> done on all CPUS, to allow the INIT IPI to function, since
> INIT is suppressed when CPUs are in VMX root operation.
> However, VMXOFF causes an undefined operation fault if the CPU is not
> in VMX operation, that is, VMXON has not been executed, or VMXOFF
> has been executed, but VMX is enabled.

I=E2=80=99m surprised. Wouldn=E2=80=99t this mean that emergency reboots alw=
ays fail it a VM is running?  I would think someone would have noticed befor=
e.

> This fix makes the reboot
> work more reliably by modifying the #UD handler to skip the VMXOFF
> if VMX is enabled on the CPU and the VMXOFF is executed as part
> of cpu_emergency_vmxoff().

NAK. See below.

> The logic in reboot.c is also corrected, since the point of forcing
> the processor out of VMX root operation is because when VMX root
> operation is enabled, the processor INIT signal is always masked.
> See Intel SDM section on differences between VMX Root operation and normal=

> operation. Thus every CPU must be forced out of VMX operation.
> Since the CPU will hang rather than restart, a manual "reset" is the
> only way out of this state (or if there is a BMC, it can issue a RESET
> to the chip).
>=20
> Signed-off-by: David P. Reed <dpreed@deepplum.com>
> ---
> arch/x86/include/asm/virtext.h | 24 ++++++++++++----
> arch/x86/kernel/reboot.c       | 13 ++-------
> arch/x86/kernel/traps.c        | 52 ++++++++++++++++++++++++++++++++--
> 3 files changed, 71 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext=
.h
> index 9aad0e0876fb..ea2d67191684 100644
> --- a/arch/x86/include/asm/virtext.h
> +++ b/arch/x86/include/asm/virtext.h
> @@ -13,12 +13,16 @@
> #ifndef _ASM_X86_VIRTEX_H
> #define _ASM_X86_VIRTEX_H
>=20
> +#include <linux/percpu.h>
> +
> #include <asm/processor.h>
>=20
> #include <asm/vmx.h>
> #include <asm/svm.h>
> #include <asm/tlbflush.h>
>=20
> +DECLARE_PER_CPU_READ_MOSTLY(int, doing_emergency_vmxoff);
> +
> /*
> * VMX functions:
> */
> @@ -33,8 +37,8 @@ static inline int cpu_has_vmx(void)
> /** Disable VMX on the current CPU
> *
> * vmxoff causes a undefined-opcode exception if vmxon was not run
> - * on the CPU previously. Only call this function if you know VMX
> - * is enabled.
> + * on the CPU previously. Only call this function directly if you know VM=
X
> + * is enabled *and* CPU is in VMX root operation.
> */

So presumably the bug is someone calling this inappropriatelet?

> static inline void cpu_vmxoff(void)
> {
> @@ -47,17 +51,25 @@ static inline int cpu_vmx_enabled(void)
>   return __read_() & X86_CR4_VMXE;
> }
>=20
> -/** Disable VMX if it is enabled on the current CPU
> +/** Force disable VMX if it is enabled on the current CPU.
> + * Note that if CPU is not in VMX root operation this
> + * VMXOFF will fault an undefined operation fault.
> + * So the 'doing_emergency_vmxoff' percpu flag is set,
> + * the trap handler for just restarts execution after
> + * the VMXOFF instruction.
> *
> - * You shouldn't call this if cpu_has_vmx() returns 0.
> + * You shouldn't call this directly if cpu_has_vmx() returns 0.
> */
> static inline void __cpu_emergency_vmxoff(void)
> {
> -    if (cpu_vmx_enabled())
> +    if (cpu_vmx_enabled()) {
> +        this_cpu_write(doing_emergency_vmxoff, 1);
>       cpu_vmxoff();
> +        this_cpu_write(doing_emergency_vmxoff, 0);
> +    }
> }

NAK. Just write this in asm with an exception handler that does the right th=
ing.

Please also try to identify the actual bug.  Because I have a sneaking suspi=
cion that you are running an out of tree module that has issues. If so, the p=
atch should explain this.

>=20
> -/** Disable VMX if it is supported and enabled on the current CPU
> +/** Force disable VMX if it is supported and enabled on the current CPU
> */
> static inline void cpu_emergency_vmxoff(void)
> {
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 3ca43be4f9cf..abc8b51a57c7 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -540,21 +540,14 @@ static void emergency_vmx_disable_all(void)
>    *
>    * For safety, we will avoid running the nmi_shootdown_cpus()
>    * stuff unnecessarily, but we don't have a way to check
> -     * if other CPUs have VMX enabled. So we will call it only if the
> -     * CPU we are running on has VMX enabled.
> -     *
> -     * We will miss cases where VMX is not enabled on all CPUs. This
> -     * shouldn't do much harm because KVM always enable VMX on all
> -     * CPUs anyway. But we can miss it on the small window where KVM
> -     * is still enabling VMX.
> +     * if other CPUs have VMX enabled.
>    */
> -    if (cpu_has_vmx() && cpu_vmx_enabled()) {
> +    if (cpu_has_vmx()) {
>       /* Disable VMX on this CPU. */
> -        cpu_vmxoff();
> +        cpu_emergency_vmxoff();
>=20
>       /* Halt and disable VMX on the other CPUs */
>       nmi_shootdown_cpus(vmxoff_nmi);
> -
>   }
> }
>=20
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 4cc541051994..2dcf57ef467e 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -39,6 +39,7 @@
> #include <linux/io.h>
> #include <linux/hardirq.h>
> #include <linux/atomic.h>
> +#include <linux/percpu.h>
>=20
> #include <asm/stacktrace.h>
> #include <asm/processor.h>
> @@ -59,6 +60,7 @@
> #include <asm/umip.h>
> #include <asm/insn.h>
> #include <asm/insn-eval.h>
> +#include <asm/virtext.h>
>=20
> #ifdef CONFIG_X86_64
> #include <asm/x86_init.h>
> @@ -70,6 +72,8 @@
> #include <asm/proto.h>
> #endif
>=20
> +DEFINE_PER_CPU_READ_MOSTLY(int, doing_emergency_vmxoff) =3D 0;
> +
> DECLARE_BITMAP(system_vectors, NR_VECTORS);
>=20
> static inline void cond_local_irq_enable(struct pt_regs *regs)
> @@ -115,6 +119,43 @@ int fixup_bug(struct pt_regs *regs, int trapnr)
>   return 0;
> }
>=20
> +/*
> + * Fix any unwanted undefined operation fault due to VMXOFF instruction t=
hat
> + * is needed to ensure that CPU is not in VMX root operation at time of
> + * a reboot/panic CPU reset. There is no safe and reliable way to know
> + * if a processor is in VMX root operation, other than to skip the
> + * VMXOFF. It is safe to just skip any VMXOFF that might generate this
> + * exception, when VMX operation is enabled in CR4. In the extremely
> + * rare case that a VMXOFF is erroneously executed while VMX is enabled,
> + * but VMXON has not been executed yet, the undefined opcode fault
> + * should not be missed by valid code, though it would be an error.
> + * To detect this, we could somehow restrict the instruction address
> + * to the specific use during reboot/panic.
> + */
> +static int fixup_emergency_vmxoff(struct pt_regs *regs, int trapnr)
> +{

NAK.

