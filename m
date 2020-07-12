Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6E2C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE9420674
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgGLNQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:16:17 -0400
Received: from mta-out1.inet.fi ([62.71.2.202]:55040 "EHLO julia1.inet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgGLNQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:16:16 -0400
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrvdeigdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfenuceurghilhhouhhtmecufedttdenucenucfjughrpefuhffvfhfkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefklhhkkhgrucfrrhhushhiuceoihhlkhhkrgdrphhruhhsihesphhprdhinhgvthdrfhhiqeenucggtffrrghtthgvrhhnpeeufeduleegkefhgeektdetieegfedvtdehvdevheduffduiedvueevjeegieekkeenucfkphepkeegrddvhedurdduleegrdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdehngdpihhnvghtpeekgedrvdehuddrudelgedrudeigedpmhgrihhlfhhrohhmpeeophhruhhsihhlqddusehmsghogidrihhnvghtrdhfihequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
Received: from [192.168.1.105] (84.251.194.164) by julia1.inet.fi (9.0.019.26-1) (authenticated as prusil-1)
        id 5EFB425600416465 for linux-kernel@vger.kernel.org; Sun, 12 Jul 2020 16:16:05 +0300
Subject: Re: splat and freeze (2 instances)
From:   Ilkka Prusi <ilkka.prusi@pp.inet.fi>
To:     linux-kernel@vger.kernel.org
References: <40e7f7f4-88f5-da0f-bf7f-067b74ac7714@pp.inet.fi>
 <d462da83-4657-1844-9fcf-c3782354c44a@pp.inet.fi>
Message-ID: <c1fa157d-1653-0ce8-2660-a298ce73cb15@pp.inet.fi>
Date:   Sun, 12 Jul 2020 16:16:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d462da83-4657-1844-9fcf-c3782354c44a@pp.inet.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a second splat with some additional tracing enabled.

Again this is gathered with phonecamera from frozen machine (dmesg -w) 
and full logs could not be saved.

Linux version 5.8.0-rc4+ (gcc (Debian 9.3.0-14) 9.3.0, GNU ld (GNU 
Binutils for Debian) 2.34.90.20200706) #95 SMP PREEMPT Sun Jul 12 
12:29:16 EEST 2020

schedule_timeout+0x162/0x1a0
? trace_hardirqs_on+0x1c/0xf0
wait_for_completion+0x84/0xe0
virt_efi_query_variable_info+0x163/0x170
efi_query_variable_store+0x53/0x190
? _raw_spin_unlock_irqrestore+0x41/0x70
efivar_entry_set_safe+0xbf/0x210
efi_pstore_write+0x116/0x160/ [efi_pstore]
pstore_dump+0x10c/0x2e0
? kmsg_dump+0xd5/0x1c0
kmsg_dump+0x7b/0x1c0
oops_end+0x6f/0xc0
do_trap+0x8c/0x100
? do_futex+0x15e/0x560
do_error_trap+0x86/0x100
? do_futex+0x15e/0x560
? do_futex+0x15e/0x560
exc_invalid_op+0x4c/0x60
? do_futex+0x15e/0x560
asm_exc_invalid_op+0xf/0x20
RIP: 0010:do_futex+0x15e/0x560
Code: 85 c0 75 4b c7 84 24 a8 00 00 00 ff ff ff ff 41 b8 ff ff ff ff 4c 
89 e9 44 89 f2 44 89 e6 48 89 ef e8 d6 e0 ff ff 48 98 e9 62 <ff> ff ff 
83 f8 08 74 61 83 f8 09 75 18 44 8b 84 24 a8 00 00 00 eb
RSP: 0018:ffffc9000128fe08 EFLAGS: 00010282
RAX: 00000000ffffff92 RBX: 0000000000000000 RCX: 0000000000ae8b8c
RDX: ffff8887fe8dde80 RSI: ffff8887fa562720 RDI: ffffc9000128fd10
RBP: 0000000057b01018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc9000128fed0 R14: 0000000000000000 R15: 0000000000000000
? do_futex+0x15e/0x560
? lockdep_hardirqs_on_prepare+0xcf/0x170
? _raw_spin_unlock_irq+0x24/0x50
? trace_hardirqs_on+0x1c/0xf0
? _raw_spin_unlock_irq+0x35/0x50
? finish_task_switch+0x9e/0x280
? finish_task_switch+0x70/0x280
? __switch_to+0x361/0x480
? __switch_to_asm+0x36/0x70
__ia32_sys_futex_time32+0x13a/0x168
do_syscall_32_irqs_on+0x45/0x60
do_fast_syscall_32+0x6b/0xf0
entry_SYSCALL_compat_after_hwframe+0x45/0x4d
RIP: 0023:0xf7f06579
Code: Bad RIP value.
RSP: 002b:00000000be3faec0 EFLAGS: 00200282 ORIG_RAX: 00000000000000f0
RAX: ffffffffffffffda RBX: 0000000057b01018 RCX: 0000000000000089
RDX: 0000000000000000 RSI: 00000000be3faf90 RDI: 0000000000000000
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
irq event stamp: 455331
hardirqs last  enabled at (455331): [<ffffffff8102e03e>] 
do_error_trap+0xbe/0x100
hardirqs last disabled at (455330): [<ffffffff818b071d>] 
idtentry_enter_cond_rcu+0x1d/0x50
softirqs last  enabled at (454086): [<ffffffff81c003aa>] 
__do_softirq+0x3aa/0x4af
softirqs last disabled at (454075): [<ffffffff81a00f82>] 
asm_call_on_stack+0x12/0x20
---[ end trace 87cc90f8d863ccc2 ]---

decode stacktrace:
$ cat ~/crashdata/580rc4/irq | ./scripts/decode_stacktrace.sh vmlinux . 
/lib/modules/5.8.0-rc4+/
schedule_timeout (/usr/src/linux/kernel/time/timer.c:1874)
? trace_hardirqs_on (/usr/src/linux/kernel/trace/trace_preemptirq.c:50 
(discriminator 42))
wait_for_completion (/usr/src/linux/kernel/sched/completion.c:86 
/usr/src/linux/kernel/sched/completion.c:106 
/usr/src/linux/kernel/sched/completion.c:117 
/usr/src/linux/kernel/sched/completion.c:138)
virt_efi_query_variable_info 
(/usr/src/linux/drivers/firmware/efi/runtime-wrappers.c:374 
(discriminator 7))
efi_query_variable_store 
(/usr/src/linux/arch/x86/platform/efi/quirks.c:165 
/usr/src/linux/arch/x86/platform/efi/quirks.c:151)
? _raw_spin_unlock_irqrestore 
(/usr/src/linux/./arch/x86/include/asm/preempt.h:102 
/usr/src/linux/./include/linux/spinlock_api_smp.h:161 
/usr/src/linux/kernel/locking/spinlock.c:191)
efivar_entry_set_safe (/usr/src/linux/drivers/firmware/efi/vars.c:784)
efi_pstore_write (/usr/src/linux/drivers/firmware/efi/efi-pstore.c:243) 
efi_pstore
pstore_dump (/usr/src/linux/fs/pstore/platform.c:456)
? kmsg_dump (/usr/src/linux/kernel/printk/printk.c:3221)
kmsg_dump (/usr/src/linux/kernel/printk/printk.c:3231 (discriminator 4))
oops_end (/usr/src/linux/arch/x86/kernel/dumpstack.c:348)
do_trap (/usr/src/linux/arch/x86/kernel/traps.c:119 
/usr/src/linux/arch/x86/kernel/traps.c:157)
? do_futex (/usr/src/linux/kernel/futex.c:3811)
do_error_trap (/usr/src/linux/arch/x86/kernel/traps.c:83 
/usr/src/linux/arch/x86/kernel/traps.c:178)
? do_futex (/usr/src/linux/kernel/futex.c:3811)
? do_futex (/usr/src/linux/kernel/futex.c:3811)
exc_invalid_op (/usr/src/linux/arch/x86/kernel/traps.c:262)
? do_futex (/usr/src/linux/kernel/futex.c:3811)
asm_exc_invalid_op (/usr/src/linux/./arch/x86/include/asm/idtentry.h:542)
RIP: 0010:do_futex (/usr/src/linux/kernel/futex.c:3811)
Code: 85 c0 75 4b c7 84 24 a8 00 00 00 ff ff ff ff 41 b8 ff ff ff ff 4c 
89 e9 44 89 f2 44 89 e6 48 89 ef e8 d6 e0 ff ff 48 98 e9 62 <ff> ff ff 
83 f8 08 74 61 83 f8 09 75 18 44 8b 84 24 a8 00 00 00 eb
All code
========
    0:    85 c0                    test   %eax,%eax
    2:    75 4b                    jne    0x4f
    4:    c7 84 24 a8 00 00 00     movl   $0xffffffff,0xa8(%rsp)
    b:    ff ff ff ff
    f:    41 b8 ff ff ff ff        mov    $0xffffffff,%r8d
   15:    4c 89 e9                 mov    %r13,%rcx
   18:    44 89 f2                 mov    %r14d,%edx
   1b:    44 89 e6                 mov    %r12d,%esi
   1e:    48 89 ef                 mov    %rbp,%rdi
   21:    e8 d6 e0 ff ff           callq  0xffffffffffffe0fc
   26:    48 98                    cltq
   28:*    e9 62 ff ff ff           jmpq   0xffffffffffffff8f     <-- 
trapping instruction
   2d:    83 f8 08                 cmp    $0x8,%eax
   30:    74 61                    je     0x93
   32:    83 f8 09                 cmp    $0x9,%eax
   35:    75 18                    jne    0x4f
   37:    44 8b 84 24 a8 00 00     mov    0xa8(%rsp),%r8d
   3e:    00
   3f:    eb                       .byte 0xeb

Code starting with the faulting instruction
===========================================
    0:    ff                       (bad)
    1:    ff                       (bad)
    2:    ff 83 f8 08 74 61        incl   0x617408f8(%rbx)
    8:    83 f8 09                 cmp    $0x9,%eax
    b:    75 18                    jne    0x25
    d:    44 8b 84 24 a8 00 00     mov    0xa8(%rsp),%r8d
   14:    00
   15:    eb                       .byte 0xeb
RSP: 0018:ffffc9000128fe08 EFLAGS: 00010282
RAX: 00000000ffffff92 RBX: 0000000000000000 RCX: 0000000000ae8b8c
RDX: ffff8887fe8dde80 RSI: ffff8887fa562720 RDI: ffffc9000128fd10
RBP: 0000000057b01018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc9000128fed0 R14: 0000000000000000 R15: 0000000000000000
? do_futex (/usr/src/linux/kernel/futex.c:3811)
? lockdep_hardirqs_on_prepare 
(/usr/src/linux/kernel/locking/lockdep.c:3635 
/usr/src/linux/kernel/locking/lockdep.c:3686)
? _raw_spin_unlock_irq 
(/usr/src/linux/./arch/x86/include/asm/paravirt.h:775 
/usr/src/linux/./include/linux/spinlock_api_smp.h:168 
/usr/src/linux/kernel/locking/spinlock.c:199)
? trace_hardirqs_on (/usr/src/linux/kernel/trace/trace_preemptirq.c:50 
(discriminator 42))
? _raw_spin_unlock_irq 
(/usr/src/linux/./arch/x86/include/asm/preempt.h:102 
/usr/src/linux/./include/linux/spinlock_api_smp.h:169 
/usr/src/linux/kernel/locking/spinlock.c:199)
? finish_task_switch 
(/usr/src/linux/./arch/x86/include/asm/jump_label.h:25 
/usr/src/linux/kernel/sched/core.c:3103 
/usr/src/linux/kernel/sched/core.c:3296)
? finish_task_switch (/usr/src/linux/kernel/sched/core.c:3163 
/usr/src/linux/kernel/sched/core.c:3291)
? __switch_to (/usr/src/linux/./arch/x86/include/asm/paravirt.h:283 
/usr/src/linux/arch/x86/kernel/process_64.c:225 
/usr/src/linux/arch/x86/kernel/process_64.c:274 
/usr/src/linux/arch/x86/kernel/process_64.c:283 
/usr/src/linux/arch/x86/kernel/process_64.c:482)
? __switch_to_asm (/usr/src/linux/arch/x86/entry/entry_64.S:252)
__ia32_sys_futex_time32 (/usr/src/linux/kernel/futex.c:4060 
/usr/src/linux/kernel/futex.c:4034 /usr/src/linux/kernel/futex.c:4034)
do_syscall_32_irqs_on (/usr/src/linux/arch/x86/entry/common.c:428)
do_fast_syscall_32 (/usr/src/linux/arch/x86/entry/common.c:121 
/usr/src/linux/arch/x86/entry/common.c:506)
entry_SYSCALL_compat_after_hwframe 
(/usr/src/linux/arch/x86/entry/entry_64_compat.S:256)
RIP: 0023:0xf7f06579
Code: Bad RIP value.
objdump: '/tmp/tmp.a5phocvdOL.o': No such file

Code starting with the faulting instruction
===========================================
RSP: 002b:00000000be3faec0 EFLAGS: 00200282 ORIG_RAX: 00000000000000f0
RAX: ffffffffffffffda RBX: 0000000057b01018 RCX: 0000000000000089
RDX: 0000000000000000 RSI: 00000000be3faf90 RDI: 0000000000000000
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
irq event stamp: 455331
hardirqs last enabled at (455331): do_error_trap 
(/usr/src/linux/./arch/x86/include/asm/paravirt.h:775 
/usr/src/linux/arch/x86/kernel/traps.c:78 
/usr/src/linux/arch/x86/kernel/traps.c:176)
hardirqs last disabled at (455330): idtentry_enter_cond_rcu 
(/usr/src/linux/arch/x86/entry/common.c:652)
softirqs last enabled at (454086): __do_softirq 
(/usr/src/linux/./arch/x86/include/asm/preempt.h:26 
/usr/src/linux/kernel/softirq.c:320)
softirqs last disabled at (454075): asm_call_on_stack 
(/usr/src/linux/arch/x86/entry/entry_64.S:719)
---[ end trace 87cc90f8d863ccc2 ]---

--

  - Ilkka


