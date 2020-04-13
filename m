Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB79C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F97206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZaDP9ZQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbgDMQfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:35:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58844 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731558AbgDMQfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:35:51 -0400
Received: from zn.tnic (p200300EC2F06C900B81659E8D550758A.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:c900:b816:59e8:d550:758a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7EEE31EC027A;
        Mon, 13 Apr 2020 18:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586795745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oPglS7eAaMJB5fCUABSjjyJ2Kgcsb+azvJZUN+3081I=;
        b=ZaDP9ZQWN8IvAcl21tcODQBHumgs4IPqIDNtTNdWSYJu/aanV+/J5X1VUw3DUt4J7NAgY8
        nhLpj65P42DD6BTGrr4ERaBhQ3FHhd1npK+tmnmjlUsSWQKFT99xkeutd1xfGzOjYZlt+I
        tRMjzrt9O7rHu+Is5YNnE03vEnxXBKU=
Date:   Mon, 13 Apr 2020 18:35:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jakub Jelinek <jakub@redhat.com>, Michael Matz <matz@suse.de>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200413163540.GD3772@zn.tnic>
References: <20200326223501.GK11398@zn.tnic>
 <20200328084858.421444-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200328084858.421444-1-slyfox@gentoo.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 08:48:58AM +0000, Sergei Trofimovich wrote:
> @@ -207,8 +207,11 @@ static int cpu0_logical_apicid;
>  static int enable_start_cpu0;
>  /*
>   * Activate a secondary processor.
> + *
> + * Note: 'boot_init_stack_canary' changes canary value. Omit
> + * stack protection to avoid canary check (and boot) failure.
>   */
> -static void notrace start_secondary(void *unused)
> +static void __no_stack_protector notrace start_secondary(void *unused)

Hmm, so we did this per-function marking only but that explodes on
32-bit, see splat at the end. gcc guys, any ideas?

The null pointer deref happens this way:

The __no_stack_protector annotated function start_secondary() calls
trace_hardirqs_on(). On entry, that function pushes the frame pointer on
the stack:

trace_hardirqs_on:
        pushl   %ebp    #
        movl    %esp, %ebp      #,
        subl    $20, %esp       #,
        movl    %ebx, -12(%ebp) #,
        movl    %esi, -8(%ebp)  #,
        movl    %edi, -4(%ebp)  #,


Singlestepping the whole thing in gdb looks like this:

Dump of assembler code from 0xc1158610 to 0xc1158624:
=> 0xc1158610 <trace_hardirqs_on+0>:    55      push   %ebp		<---
   0xc1158611 <trace_hardirqs_on+1>:    89 e5   mov    %esp,%ebp

and ebp has:

...
ebp            0x0      0x0		<---
esi            0x200002 2097154
edi            0x1      1
eip            0xc1158610
...

Later in the function, it will do __builtin_return_address(n), which
turns into:

# kernel/trace/trace_preemptirq.c:26:                   trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
        movl    0(%ebp), %eax   #, tmp133

<--- it loads the previously pushed 0 on the stack into %eax

# kernel/trace/trace_preemptirq.c:27:           tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
        movl    4(%eax), %edx   #, tmp130

<--- derefs it here. Boom.

So, could it be that marking this one function like this:

static void __attribute__((optimize("-fno-stack-protector"))) __attribute__((no_instrument_function)) start_secondary(void *unused)
{

would cause %ebp to be 0 for whatever reason on 32-bit?



Interestingly enough, if I use the first variant we had where we built
the whole compilation unit with -fno-stack-protector, the issue is gone
and %ebp has the correct value:

ebp            0xf1163fac       0xf1163fac
esi            0x200002 2097154
edi            0x1      1
eip            0xc11585c0       0xc11585c0 <trace_hardirqs_on>
eflags         0x200086 [ PF SF ID ]
cs             0x60     96
ss             0x68     104
ds             0x7b     123
es             0x7b     123
fs             0xd8     216
gs             0xe0     224
=> 0xc11585c0 <trace_hardirqs_on>:      push   %ebp
0xf1163f84:     0x00000000c104b016      0x0000000000000000
0xf1163f94:     0x0000000000000001      0x0000000000000002
0xf1163fa4:     0x0000000001000800      0xc10001e400000000
0xf1163fb4:     0x0000000000000000      0x0000000000000000
0xf1163fc4:     0x0000000000000000      0x0000000000000000
Dump of assembler code from 0xc11585c0 to 0xc11585d4:
=> 0xc11585c0 <trace_hardirqs_on+0>:    55      push   %ebp
   0xc11585c1 <trace_hardirqs_on+1>:    89 e5   mov    %esp,%ebp


Any ideas whether 32-bit behaves like this here?

Thx.

[    0.269147] smpboot: CPU 1 Converting physical 0 to logical die 1
[    0.269147] BUG: kernel NULL pointer dereference, address: 00000004
[    0.269147] #PF: supervisor read access in kernel mode
[    0.269147] #PF: error_code(0x0000) - not-present page
[    0.269147] *pdpt = 0000000000000000 *pde = f000ff53f000ff53 
[    0.269147] Oops: 0000 [#1] PREEMPT SMP
[    0.269147] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.7.0-rc1+ #3
[    0.269147] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[    0.269147] EIP: trace_hardirqs_on+0x5e/0x110
[    0.269147] Code: 00 00 64 c7 05 f8 20 c2 c1 00 00 00 00 8b 45 04 e8 e7 3b f7 ff 8b 5d f4 8b 75 f8 8b 7d fc c9 c3 8d 74 26 00 8b 15 00 b4 b3 c1 <8b> 48 04 8b 5d 04 85 d2 7e c4 64 a1 d4 a2 c0 c1 0f a3 05 1c 89 b4
[    0.269147] EAX: 00000000 EBX: f1163f98 ECX: 00000000 EDX: 00000000
[    0.269147] ESI: 00200002 EDI: 00000001 EBP: f1163f84 ESP: f1163f70
[    0.269147] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210046
[    0.269147] CR0: 80050033 CR2: 00000004 CR3: 01c2e000 CR4: 003406f0
[    0.269147] Call Trace:
[    0.269147]  ? _raw_spin_unlock+0x27/0x50
[    0.269147]  start_secondary+0x159/0x220
[    0.269147]  ? startup_32_smp+0x164/0x168
[    0.269147] Modules linked in:
[    0.269147] CR2: 0000000000000004
[    0.269147] ---[ end trace e721c1dd98762fde ]---
[    0.269147] EIP: trace_hardirqs_on+0x5e/0x110
[    0.269147] Code: 00 00 64 c7 05 f8 20 c2 c1 00 00 00 00 8b 45 04 e8 e7 3b f7 ff 8b 5d f4 8b 75 f8 8b 7d fc c9 c3 8d 74 26 00 8b 15 00 b4 b3 c1 <8b> 48 04 8b 5d 04 85 d2 7e c4 64 a1 d4 a2 c0 c1 0f a3 05 1c 89 b4
[    0.269147] EAX: 00000000 EBX: f1163f98 ECX: 00000000 EDX: 00000000
[    0.269147] ESI: 00200002 EDI: 00000001 EBP: f1163f84 ESP: f1163f70
[    0.269147] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210046
[    0.269147] CR0: 80050033 CR2: 00000004 CR3: 01c2e000 CR4: 003406f0
[    0.269147] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.269147] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
