Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758D4C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 04:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48CFA206A5
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 04:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGKEyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 00:54:50 -0400
Received: from mta-out1.inet.fi ([62.71.2.202]:52686 "EHLO julia1.inet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgGKEyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 00:54:49 -0400
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrvddvgdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfenuceurghilhhouhhtmecufedttdenucenucfjughrpefufhfvhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefklhhkkhgrucfrrhhushhiuceoihhlkhhkrgdrphhruhhsihesphhprdhinhgvthdrfhhiqeenucggtffrrghtthgvrhhnpeejjeelueekkeduueejleehgfeuvddvleektedvvdehgeelfeeukeekudeufeehueenucfkphepkeegrddvhedurdduleegrdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdehngdpihhnvghtpeekgedrvdehuddrudelgedrudeigedpmhgrihhlfhhrohhmpeeophhruhhsihhlqddusehmsghogidrihhnvghtrdhfihequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
Received: from [192.168.1.105] (84.251.194.164) by julia1.inet.fi (9.0.019.26-1) (authenticated as prusil-1)
        id 5EFB4256003CBDBC for linux-kernel@vger.kernel.org; Sat, 11 Jul 2020 07:54:38 +0300
Subject: splat and freeze (2 instances)
References: <40e7f7f4-88f5-da0f-bf7f-067b74ac7714@pp.inet.fi>
To:     linux-kernel@vger.kernel.org
From:   Ilkka Prusi <ilkka.prusi@pp.inet.fi>
X-Forwarded-Message-Id: <40e7f7f4-88f5-da0f-bf7f-067b74ac7714@pp.inet.fi>
Message-ID: <d462da83-4657-1844-9fcf-c3782354c44a@pp.inet.fi>
Date:   Sat, 11 Jul 2020 07:54:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <40e7f7f4-88f5-da0f-bf7f-067b74ac7714@pp.inet.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have to splats followed by freezing, first one was saved in logs but 
second one is only what I could gather from screen of frozen machine. 
First one is 5.7.7 and second with 5.8.0-rc4+.

Logs from second one could not be saved but part of it could be captured 
with phonecamera (dmesg -w).

Computer:

- AMD Ryzen 7 2700, [AMD] 400 Series Chipset

- efi: EFI v2.60 by American Megatrends
- efi: ACPI 2.0=0xd13f2000 ACPI=0xd13f2000 SMBIOS=0xdb647000 SMBIOS 
3.0=0xdb646000 ESRT=0xd7bdd918 MEMATTR=0xd7c3e018
- SMBIOS 3.1.1 present.
- DMI: System manufacturer System Product Name/TUF B450-PLUS GAMING, 
BIOS 2008 12/06/2019
- gcc (Debian 9.3.0-14) 9.3.0

First one:

Linux version 5.7.7 (gcc version 9.3.0 (Debian 9.3.0-14), GNU ld (GNU 
Binutils for Debian) 2.34) #2 SMP PREEMPT Fri Jul 3 10:16:05 EEST 2020

[16835.276319][    C3] rcu: INFO: rcu_preempt self-detected stall on CPU
[16835.276331][    C3] rcu:  3-....: (5250 ticks this GP) 
idle=526/1/0x4000000000000002 softirq=1880877/1880877 fqs=2299
[16835.276338][    C3]       (t=5250 jiffies g=3603393 q=18733)
[16835.276342][    C3] NMI backtrace for cpu 3
[16835.276347][    C3] CPU: 3 PID: 26434 Comm: CJobMgr::m_Work Tainted: 
G            E     5.7.7 #2
[16835.276351][    C3] Hardware name: System manufacturer System Product 
Name/TUF B450-PLUS GAMING, BIOS 2008 12/06/2019
[16835.276353][    C3] Call Trace:
[16835.276358][    C3]  <IRQ>
[16835.276367][    C3]  dump_stack+0x66/0x90
[16835.276373][    C3]  nmi_cpu_backtrace.cold+0x14/0x52
[16835.276378][    C3]  ? lapic_can_unplug_cpu.cold+0x40/0x40
[16835.276382][    C3]  nmi_trigger_cpumask_backtrace+0xfc/0x121
[16835.276388][    C3]  rcu_dump_cpu_stacks+0xa1/0xcf
[16835.276393][    C3]  rcu_sched_clock_irq.cold+0xab/0x16d
[16835.276397][    C3]  update_process_times+0x24/0x50
[16835.276402][    C3]  tick_sched_timer+0x5a/0x170
[16835.276405][    C3]  ? tick_switch_to_oneshot.cold+0x6f/0x6f
[16835.276409][    C3]  __hrtimer_run_queues+0xf6/0x2c0
[16835.276414][    C3]  hrtimer_interrupt+0x118/0x240
[16835.276421][    C3]  smp_apic_timer_interrupt+0x88/0x190
[16835.276425][    C3]  apic_timer_interrupt+0xf/0x20
[16835.276428][    C3]  </IRQ>
[16835.276433][    C3] RIP: 0010:native_queued_spin_lock_slowpath+0x6a/0x200
[16835.276438][    C3] Code: 73 f0 0f ba 2b 08 0f 92 c0 0f b6 c0 c1 e0 
08 89 c2 8b 03 30 e4 09 d0 a9 00 01 ff ff 75 4d 85 c0 74 0e 8b 03 84 c0 
74 08 f3 90 <8b> 03 84 c0 75 f8 b8 01 00 00 00 66 89 03 5b 5d 41 5c 41 
5d c3 8b
[16835.276441][    C3] RSP: 0018:ffffc90003d57cb0 EFLAGS: 00000206 
ORIG_RAX: ffffffffffffff13
[16835.276445][    C3] RAX: 0000000000000105 RBX: ffff8887fabf6200 RCX: 
0000000000000000
[16835.276447][    C3] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
ffff8887fabf6200
[16835.276449][    C3] RBP: ffffc90003d57d08 R08: 0000000000000000 R09: 
0000000000000000
[16835.276451][    C3] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[16835.276454][    C3] R13: 0000000000000000 R14: ffff8887fabf6200 R15: 
00000000db007e1c
[16835.276461][    C3]  _raw_spin_lock+0x2c/0x30
[16835.276465][    C3]  futex_wait+0x102/0x220
[16835.276470][    C3]  ? hrtimer_init_sleeper+0xa0/0xa0
[16835.276476][    C3]  do_futex+0x15a/0x8b0
[16835.276481][    C3]  __ia32_sys_futex_time32+0x13a/0x168
[16835.276488][    C3]  do_fast_syscall_32+0x94/0x280
[16835.276492][    C3] entry_SYSCALL_compat_after_hwframe+0x45/0x4d

And decode_stacktrace.sh gives me following:

$ cat ~/crashdata/577/rcustall | ./scripts/decode_stacktrace.sh vmlinux 
. /lib/modules/5.7.7/
[16835.276319][    C3] rcu: INFO: rcu_preempt self-detected stall on CPU
[16835.276331][    C3] rcu:  3-....: (5250 ticks this GP) 
idle=526/1/0x4000000000000002 softirq=1880877/1880877 fqs=2299
[16835.276338][    C3]       (t=5250 jiffies g=3603393 q=18733)
[16835.276342][    C3] NMI backtrace for cpu 3
[16835.276347][    C3] CPU: 3 PID: 26434 Comm: CJobMgr::m_Work Tainted: 
G            E     5.7.7 #2
[16835.276351][    C3] Hardware name: System manufacturer System Product 
Name/TUF B450-PLUS GAMING, BIOS 2008 12/06/2019
[16835.276353][    C3] Call Trace:
[16835.276358][    C3]  <IRQ>
[16835.276367][ C3] dump_stack (/usr/src/linux-5.7.7/lib/dump_stack.c:120)
[16835.276373][ C3] nmi_cpu_backtrace.cold 
(/usr/src/linux-5.7.7/./include/linux/cpumask.h:350 
/usr/src/linux-5.7.7/lib/nmi_backtrace.c:103)
[16835.276378][ C3] ? lapic_can_unplug_cpu.cold 
(/usr/src/linux-5.7.7/arch/x86/kernel/apic/hw_nmi.c:32)
[16835.276382][ C3] nmi_trigger_cpumask_backtrace 
(/usr/src/linux-5.7.7/lib/nmi_backtrace.c:62)
[16835.276388][ C3] rcu_dump_cpu_stacks 
(/usr/src/linux-5.7.7/kernel/rcu/tree_stall.h:252 (discriminator 5))
[16835.276393][ C3] rcu_sched_clock_irq.cold 
(/usr/src/linux-5.7.7/kernel/rcu/tree_stall.h:477 
/usr/src/linux-5.7.7/kernel/rcu/tree_stall.h:549 
/usr/src/linux-5.7.7/kernel/rcu/tree.c:3225 
/usr/src/linux-5.7.7/kernel/rcu/tree.c:2296)
[16835.276397][ C3] update_process_times 
(/usr/src/linux-5.7.7/./arch/x86/include/asm/preempt.h:26 
/usr/src/linux-5.7.7/kernel/time/timer.c:1729)
[16835.276402][ C3] tick_sched_timer 
(/usr/src/linux-5.7.7/kernel/time/tick-sched.c:177 
/usr/src/linux-5.7.7/kernel/time/tick-sched.c:1320)
[16835.276405][ C3] ? tick_switch_to_oneshot.cold 
(/usr/src/linux-5.7.7/kernel/time/tick-sched.c:1307)
[16835.276409][ C3] __hrtimer_run_queues 
(/usr/src/linux-5.7.7/kernel/time/hrtimer.c:1520 
/usr/src/linux-5.7.7/kernel/time/hrtimer.c:1584)
[16835.276414][ C3] hrtimer_interrupt 
(/usr/src/linux-5.7.7/kernel/time/hrtimer.c:1649)
[16835.276421][ C3] smp_apic_timer_interrupt 
(/usr/src/linux-5.7.7/./arch/x86/include/asm/jump_label.h:25 
/usr/src/linux-5.7.7/./include/linux/jump_label.h:200 
/usr/src/linux-5.7.7/./arch/x86/include/asm/trace/irq_vectors.h:56 
/usr/src/linux-5.7.7/arch/x86/kernel/apic/apic.c:1139)
[16835.276425][ C3] apic_timer_interrupt 
(/usr/src/linux-5.7.7/arch/x86/entry/entry_64.S:829)
[16835.276428][    C3]  </IRQ>
[16835.276433][ C3] RIP: 0010:native_queued_spin_lock_slowpath 
(/usr/src/linux-5.7.7/./include/linux/compiler.h:199 
/usr/src/linux-5.7.7/kernel/locking/qspinlock.c:382 
/usr/src/linux-5.7.7/kernel/locking/qspinlock.c:315)
[16835.276438][ C3] Code: 73 f0 0f ba 2b 08 0f 92 c0 0f b6 c0 c1 e0 08 
89 c2 8b 03 30 e4 09 d0 a9 00 01 ff ff 75 4d 85 c0 74 0e 8b 03 84 c0 74 
08 f3 90 <8b> 03 84 c0 75 f8 b8 01 00 00 00 66 89 03 5b 5d 41 5c 41 5d c3 8b
All code
========
    0:    73 f0                    jae    0xfffffffffffffff2
    2:    0f ba 2b 08              btsl   $0x8,(%rbx)
    6:    0f 92 c0                 setb   %al
    9:    0f b6 c0                 movzbl %al,%eax
    c:    c1 e0 08                 shl    $0x8,%eax
    f:    89 c2                    mov    %eax,%edx
   11:    8b 03                    mov    (%rbx),%eax
   13:    30 e4                    xor    %ah,%ah
   15:    09 d0                    or     %edx,%eax
   17:    a9 00 01 ff ff           test   $0xffff0100,%eax
   1c:    75 4d                    jne    0x6b
   1e:    85 c0                    test   %eax,%eax
   20:    74 0e                    je     0x30
   22:    8b 03                    mov    (%rbx),%eax
   24:    84 c0                    test   %al,%al
   26:    74 08                    je     0x30
   28:    f3 90                    pause
   2a:*    8b 03                    mov    (%rbx),%eax <-- trapping 
instruction
   2c:    84 c0                    test   %al,%al
   2e:    75 f8                    jne    0x28
   30:    b8 01 00 00 00           mov    $0x1,%eax
   35:    66 89 03                 mov    %ax,(%rbx)
   38:    5b                       pop    %rbx
   39:    5d                       pop    %rbp
   3a:    41 5c                    pop    %r12
   3c:    41 5d                    pop    %r13
   3e:    c3                       retq
   3f:    8b                       .byte 0x8b

Code starting with the faulting instruction
===========================================
    0:    8b 03                    mov    (%rbx),%eax
    2:    84 c0                    test   %al,%al
    4:    75 f8                    jne    0xfffffffffffffffe
    6:    b8 01 00 00 00           mov    $0x1,%eax
    b:    66 89 03                 mov    %ax,(%rbx)
    e:    5b                       pop    %rbx
    f:    5d                       pop    %rbp
   10:    41 5c                    pop    %r12
   12:    41 5d                    pop    %r13
   14:    c3                       retq
   15:    8b                       .byte 0x8b
[16835.276441][    C3] RSP: 0018:ffffc90003d57cb0 EFLAGS: 00000206 
ORIG_RAX: ffffffffffffff13
[16835.276445][    C3] RAX: 0000000000000105 RBX: ffff8887fabf6200 RCX: 
0000000000000000
[16835.276447][    C3] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
ffff8887fabf6200
[16835.276449][    C3] RBP: ffffc90003d57d08 R08: 0000000000000000 R09: 
0000000000000000
[16835.276451][    C3] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[16835.276454][    C3] R13: 0000000000000000 R14: ffff8887fabf6200 R15: 
00000000db007e1c
[16835.276461][ C3] _raw_spin_lock 
(/usr/src/linux-5.7.7/./arch/x86/include/asm/paravirt.h:645 
/usr/src/linux-5.7.7/./arch/x86/include/asm/qspinlock.h:50 
/usr/src/linux-5.7.7/./include/asm-generic/qspinlock.h:81 
/usr/src/linux-5.7.7/./include/linux/spinlock.h:182 
/usr/src/linux-5.7.7/./include/linux/spinlock_api_smp.h:143 
/usr/src/linux-5.7.7/kernel/locking/spinlock.c:151)
[16835.276465][ C3] futex_wait (/usr/src/linux-5.7.7/kernel/futex.c:2334 
/usr/src/linux-5.7.7/kernel/futex.c:2742)
[16835.276470][ C3] ? hrtimer_init_sleeper 
(/usr/src/linux-5.7.7/kernel/time/hrtimer.c:1767)
[16835.276476][ C3] do_futex (/usr/src/linux-5.7.7/kernel/futex.c:3808)
[16835.276481][ C3] __ia32_sys_futex_time32 
(/usr/src/linux-5.7.7/kernel/futex.c:4057 
/usr/src/linux-5.7.7/kernel/futex.c:4031 
/usr/src/linux-5.7.7/kernel/futex.c:4031)
[16835.276488][ C3] do_fast_syscall_32 
(/usr/src/linux-5.7.7/arch/x86/entry/common.c:337 
/usr/src/linux-5.7.7/arch/x86/entry/common.c:396)
[16835.276492][ C3] entry_SYSCALL_compat_after_hwframe 
(/usr/src/linux-5.7.7/arch/x86/entry/entry_64_compat.S:259)

Second one with kernel version: Linux version 5.8.0-rc4+ (gcc (Debian 
9.3.0-14) 9.3.0, GNU ld (GNU Binutils for Debian) 2.34) #87 SMP PREEMPT 
Fri Jul 10 11:38:32 EEST 2020

I could not save logs from this instance so captured with phonecamera: I 
had dmesg -w in one terminal but window was too small to fit it entirely:

? _raw_spin_unlock_irqrestore+0x02/0x40

? try_to_wake_up+0x7a/0x460

wait_for_completion+0x84/0xe0

virt_efi_query_variable+0x141/0x150

efi_query_variable_store+0x53/0x190

? preempt_count_add+0x68/0xa0

? _raw_spin_lock_irqsave+0x26/0x50

efivar_entry_set_safe+0xbf/0x210

efi_pstore_write+0x116/0x160 [efi_pstore]

pstore_dump+0x10c/0x2e0

? wake_up_klogd.part.0+0x4f/0x70

kmsg_dump+0xb8/0xe0

oops_end+0x6f/0xc0

exc_general_protection+0x18f/0x2e0

asm_exc_general_protection+0x1b/0x20

RIP: 0010:do_syscall_64+0x34/0xb0

Code: 00 65 48 8b 04 25 c0 7b 01 00 48 8b 00 a9 c1 01 00 10 75 40 48 81 
ff b7 01 00 00 77 4b 48 81 ff b8 01 00 48 19 c0 48 21 c7 <48> 8b 04 fd 
a0 02 c0 81 48 89 ef e8 4c 94 23 00 48 89 45 50 48 89

RSP: 0018:ffffc90003a1ff48 EFLAGS: 00010292
RAX: ffffffffffffff92 RBX: 0000000000000000 RCX: 00000000018dafa4
RDX: 00000000ffffffff RSI: 0000000000000000 RDI: ffffc90003a1fd20
RBP: ffffc90003a1ff58 R08: 0000000000000000 R09: ffff8887f7b13c00
R10: 0000000000000057 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? do_syscall_64+0x34/0xb0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7feedffe590a
Code: Bad RIP value.
RSP: 002b:00007feecee06b60 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000003245 RCX: 00007feedffe590a
RDX: 0000000000000000 RSI: 0000000000000089 RDI: 00007feedf8490e4
RBP: 00007feedf8490b8 R08: 0000000000000000 R09: 00000000ffffffff
R10: 00007feecee06c40 R11: 0000000000000246 R12: 0000000000000000
R13: 00007feedf849088 R14: 00007feedf8490e4 R15: 00007feecee06ba0
----[ end trace 91dfe9f4af058936 ]---

This gives me:

$ cat ~/crashdata/580rc4/eficrash | ./scripts/decode_stacktrace.sh 
vmlinux . /lib/modules/5.8.0-rc4+/
? _raw_spin_unlock_irqrestore (/usr/src/linux/kernel/locking/spinlock.c:190)

? try_to_wake_up (/usr/src/linux/./arch/x86/include/asm/preempt.h:102 
/usr/src/linux/kernel/sched/core.c:2669)

wait_for_completion (/usr/src/linux/kernel/sched/completion.c:86 
/usr/src/linux/kernel/sched/completion.c:106 
/usr/src/linux/kernel/sched/completion.c:117 
/usr/src/linux/kernel/sched/completion.c:138)

virt_efi_query_variable (??:?)

efi_query_variable_store 
(/usr/src/linux/arch/x86/platform/efi/quirks.c:165 
/usr/src/linux/arch/x86/platform/efi/quirks.c:151)

? preempt_count_add (/usr/src/linux/./include/linux/ftrace.h:821 
/usr/src/linux/kernel/sched/core.c:3851 
/usr/src/linux/kernel/sched/core.c:3848 
/usr/src/linux/kernel/sched/core.c:3876)

? _raw_spin_lock_irqsave 
(/usr/src/linux/./arch/x86/include/asm/atomic.h:204 
/usr/src/linux/./include/asm-generic/atomic-instrumented.h:707 
/usr/src/linux/./include/asm-generic/qspinlock.h:78 
/usr/src/linux/./include/linux/spinlock.h:194 
/usr/src/linux/./include/linux/spinlock_api_smp.h:119 
/usr/src/linux/kernel/locking/spinlock.c:159)

efivar_entry_set_safe (/usr/src/linux/drivers/firmware/efi/vars.c:784)

efi_pstore_write (/usr/src/linux/drivers/firmware/efi/efi-pstore.c:266 
(discriminator 6)) efi_pstore

pstore_dump (/usr/src/linux/fs/pstore/platform.c:456)

? wake_up_klogd.part.0 
(/usr/src/linux/./arch/x86/include/asm/preempt.h:102 
/usr/src/linux/kernel/printk/printk.c:3039)

kmsg_dump (/usr/src/linux/kernel/printk/printk.c:3231)

oops_end (/usr/src/linux/arch/x86/kernel/dumpstack.c:348)

exc_general_protection (/usr/src/linux/arch/x86/kernel/traps.c:83 
/usr/src/linux/arch/x86/kernel/traps.c:596 
/usr/src/linux/arch/x86/kernel/traps.c:523)

asm_exc_general_protection 
(/usr/src/linux/./arch/x86/include/asm/idtentry.h:538)

RIP: 0010:do_syscall_64 (/usr/src/linux/arch/x86/entry/common.c:384)

Code: 00 65 48 8b 04 25 c0 7b 01 00 48 8b 00 a9 c1 01 00 10 75 40 48 81 
ff b7 01 00 00 77 4b 48 81 ff b8 01 00 48 19 c0 48 21 c7 <48> 8b 04 fd 
a0 02 c0 81 48 89 ef e8 4c 94 23 00 48 89 45 50 48 89
All code
========
    0:    00 65 48                 add    %ah,0x48(%rbp)
    3:    8b 04 25 c0 7b 01 00     mov    0x17bc0,%eax
    a:    48 8b 00                 mov    (%rax),%rax
    d:    a9 c1 01 00 10           test   $0x100001c1,%eax
   12:    75 40                    jne    0x54
   14:    48 81 ff b7 01 00 00     cmp    $0x1b7,%rdi
   1b:    77 4b                    ja     0x68
   1d:    48 81 ff b8 01 00 48     cmp    $0x480001b8,%rdi
   24:    19 c0                    sbb    %eax,%eax
   26:    48 21 c7                 and    %rax,%rdi
   29:*    48 8b 04 fd a0 02 c0     mov -0x7e3ffd60(,%rdi,8),%rax        
<-- trapping instruction
   30:    81
   31:    48 89 ef                 mov    %rbp,%rdi
   34:    e8 4c 94 23 00           callq  0x239485
   39:    48 89 45 50              mov    %rax,0x50(%rbp)
   3d:    48                       rex.W
   3e:    89                       .byte 0x89

Code starting with the faulting instruction
===========================================
    0:    48 8b 04 fd a0 02 c0     mov    -0x7e3ffd60(,%rdi,8),%rax
    7:    81
    8:    48 89 ef                 mov    %rbp,%rdi
    b:    e8 4c 94 23 00           callq  0x23945c
   10:    48 89 45 50              mov    %rax,0x50(%rbp)
   14:    48                       rex.W
   15:    89                       .byte 0x89

RSP: 0018:ffffc90003a1ff48 EFLAGS: 00010292
RAX: ffffffffffffff92 RBX: 0000000000000000 RCX: 00000000018dafa4
RDX: 00000000ffffffff RSI: 0000000000000000 RDI: ffffc90003a1fd20
RBP: ffffc90003a1ff58 R08: 0000000000000000 R09: ffff8887f7b13c00
R10: 0000000000000057 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
? do_syscall_64 (/usr/src/linux/arch/x86/entry/common.c:384)
entry_SYSCALL_64_after_hwframe 
(/usr/src/linux/arch/x86/entry/entry_64.S:124)
RIP: 0033:0x7feedffe590a
Code: Bad RIP value.
objdump: '/tmp/tmp.GTDYXyBfvG.o': No such file

Code starting with the faulting instruction
===========================================
RSP: 002b:00007feecee06b60 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000003245 RCX: 00007feedffe590a
RDX: 0000000000000000 RSI: 0000000000000089 RDI: 00007feedf8490e4
RBP: 00007feedf8490b8 R08: 0000000000000000 R09: 00000000ffffffff
R10: 00007feecee06c40 R11: 0000000000000246 R12: 0000000000000000
R13: 00007feedf849088 R14: 00007feedf8490e4 R15: 00007feecee06ba0
----[ end trace 91dfe9f4af058936 ]---

--

  - Ilkka


