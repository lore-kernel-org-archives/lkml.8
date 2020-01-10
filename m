Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07495C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62B8206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgAJWmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:42:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60029 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgAJWmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:42:16 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iq2yj-0006Fk-RI; Fri, 10 Jan 2020 23:42:05 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3A41A105BDB; Fri, 10 Jan 2020 23:42:05 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        vincenzo.frascino@arm.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc/32: Switch VDSO to C implementation.
In-Reply-To: <09d07ad3-47a2-db2f-2f14-e002b22d8d9e@c-s.fr>
References: <8ce3582f7f7da9ff0286ced857e5aa2e5ae6746e.1571662378.git.christophe.leroy@c-s.fr> <alpine.DEB.2.21.1910212312520.2078@nanos.tec.linutronix.de> <f4486e86-3c0c-0eec-1639-0e5956cdb8f1@c-s.fr> <95bd2367-8edc-29db-faa3-7729661e05f2@c-s.fr> <alpine.DEB.2.21.1910261751140.10190@nanos.tec.linutronix.de> <439bce37-9c2c-2afe-9c9e-2f500472f9f8@c-s.fr> <alpine.DEB.2.21.1910262026340.10190@nanos.tec.linutronix.de> <207cef10-3da8-6a52-139c-0620b21b64af@c-s.fr> <87d0bslo7b.fsf@nanos.tec.linutronix.de> <09d07ad3-47a2-db2f-2f14-e002b22d8d9e@c-s.fr>
Date:   Fri, 10 Jan 2020 23:42:05 +0100
Message-ID: <87h813rl1e.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe,

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> On 01/09/2020 02:05 PM, Thomas Gleixner wrote:
>> The reason why this is implemented in this way is that
>> __arch_get_hw_counter() needs a way to express that the clocksource of
>> the moment is not suitable for VDSO so that the syscall fallback gets
>> invoked.
>> 
>> Sure we could have used a pointer for the value and a return value
>> indicating the validity, but given the required uptime the resulting
>> code overhead seemed to be not worth it. At least not for me as I'm not
>> planning to be around 58 years from now :)
>> 
>
> I managed to get better code and better performance by splitting out the 
> validity check as follows. Would it be suitable for all arches ?

A quick test on x86 shows only a minimal impact, but it's in the
noise. So from my side that's fine, but I can't talk for ARM[64]/MIPS

> diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h 
> b/arch/powerpc/include/asm/vdso/gettimeofday.h
> index 689f51b0d8c9..11cdd6faa4ad 100644
> --- a/arch/powerpc/include/asm/vdso/gettimeofday.h
> +++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
> @@ -114,15 +114,17 @@ int clock_getres32_fallback(clockid_t _clkid, 
> struct old_timespec32 *_ts)
>   	return ret;
>   }
>
> -static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
> +static __always_inline bool __arch_is_hw_counter_valid(s32 clock_mode)
>   {
>   	/*
>   	 * clock_mode == 0 implies that vDSO are enabled otherwise
>   	 * fallback on syscall.
>   	 */
> -	if (clock_mode)
> -		return ULLONG_MAX;
> +	return clock_mode ? false : true;

I don't think we need an arch specific function here. I rather convert
the boolean of ARM[64] to the x86/MIPS way of VCLOCK_* modes and let the
generic code check for clock_mode == VCLOCK_NONE.

There is some magic in ARM and MIPS which wants to be able to disable
the whole thing at compile time, but that can be handled in the generic
code with just an extra config switch.

I'll have a stab at that tomorrow.

Thanks,

        tglx
