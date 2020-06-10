Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9020FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B01207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgFJVeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgFJVeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:34:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33C5C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:34:43 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jj8MX-00045z-RH; Wed, 10 Jun 2020 23:34:22 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 403D61013D0; Wed, 10 Jun 2020 23:34:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "David P. Reed" <dpreed@deepplum.com>, dpreed@deepplum.com
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix undefined operation VMXOFF during reboot and crash
In-Reply-To: <20200610181254.2142-1-dpreed@deepplum.com>
References: <20200610181254.2142-1-dpreed@deepplum.com>
Date:   Wed, 10 Jun 2020 23:34:21 +0200
Message-ID: <878sgufvvm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"David P. Reed" <dpreed@deepplum.com> writes:
> +/*
> + * Fix any unwanted undefined operation fault due to VMXOFF instruction that
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
> +	const static u8 insn_vmxoff[3] = { 0x0f, 0x01, 0xc4 };
> +	u8 ud[3];
> +
> +	if (trapnr != X86_TRAP_UD)
> +		return 0;
> +	if (!cpu_vmx_enabled())
> +		return 0;
> +	if (!this_cpu_read(doing_emergency_vmxoff))
> +		return 0;
> +
> +	/* undefined instruction must be in kernel and be VMXOFF */
> +	if (regs->ip < TASK_SIZE_MAX)
> +		return 0;
> +	if (probe_kernel_address((u8 *)regs->ip, ud))
> +		return 0;
> +	if (memcmp(ud, insn_vmxoff, sizeof(insn_vmxoff)))
> +		return 0;
> +
> +	regs->ip += sizeof(insn_vmxoff);
> +	return 1;

We have exception fixups to avoid exactly that kind of horrible
workarounds all over the place.

static inline int cpu_vmxoff_safe(void)
{
        int err;
 
	asm volatile("2: vmxoff; xor %[err],%[err]\n"
		     "1:\n\t"
		     ".section .fixup,\"ax\"\n\t"
		     "3:  mov %[fault],%[err] ; jmp 1b\n\t"
		     ".previous\n\t"
		     _ASM_EXTABLE(2b, 3b)
		     : [err] "=a" (err)
		     : [fault] "i" (-EFAULT)
		     : "memory");
        return err;
}

static inline void __cpu_emergency_vmxoff(void)
{
        if (!cpu_vmx_enabled())
        	return;
        if (!cpu_vmxoff_safe())
        	cr4_clear_bits(X86_CR4_VMXE);
}

Problem solved.

Thanks,

        tglx
