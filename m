Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF1DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9859920772
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594261210;
	bh=gnUddFvJBhvfM3ugnRh9YBTiMPmrcX+YnUy9VnaSapM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=g0JLp+5iu+bmm8yEVO3Cf01xYdmLEnJBTWuPPGp2bTLQi6zTVTc+URmj+EpSimqCa
	 O9Gqcw7/+EhtfnddHiRgoR2HpJFJYmtCcN45M09L3QckjNteEfvV66hu7wCTkpCev8
	 nkE4Za8eYYeXuLtjHXbWaAFV0Ix2MImS4yOnk35Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgGICUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgGICUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 22:20:08 -0400
Received: from localhost.localdomain (unknown [42.120.72.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C4B2206F6;
        Thu,  9 Jul 2020 02:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594261207;
        bh=gnUddFvJBhvfM3ugnRh9YBTiMPmrcX+YnUy9VnaSapM=;
        h=From:To:Cc:Subject:Date:From;
        b=GgM/Oi8zj9KXIGP2V6HlPLxAwXAI8Pq98wtQDA7AK0PgqLPemEpteY5JyTHZnv/Or
         meu5EhcLw4L4+WTJwdwrdRiGI9JBV/EUK/WKfICKH4FlOMpKhbU3Xs90oy7e8PWWtk
         MAcXEw/ookSu6kmzoP3DAzOEIBugiEHifLLZuy+A=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        me@packi.ch, bjorn.topel@gmail.com, atish.patra@wdc.com,
        penberg@kernel.org, mhiramat@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v2 0/6] riscv: Add k/uprobe supported
Date:   Thu,  9 Jul 2020 02:19:08 +0000
Message-Id: <1594261154-69745-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The patchset includes kprobe/uprobe support and some related fixups.
Patrick provides HAVE_REGS_AND_STACK_ACCESS_API support and some
kprobe's code. The framework of k/uprobe is from csky but also refers
to other arches'. kprobes on ftrace is also supported in the patchset.

There is no single step exception in riscv ISA, only single-step
facility for jtag. See riscv-Privileged spec:

Interrupt Exception Code-Description
1 0 Reserved
1 1 Supervisor software interrupt
1 2–4 Reserved
1 5 Supervisor timer interrupt
1 6–8 Reserved
1 9 Supervisor external interrupt
1 10–15 Reserved
1 ≥16 Available for platform use
0 0 Instruction address misaligned
0 1 Instruction access fault
0 2 Illegal instruction
0 3 Breakpoint
0 4 Load address misaligned
0 5 Load access fault
0 6 Store/AMO address misaligned
0 7 Store/AMO access fault
0 8 Environment call from U-mode
0 9 Environment call from S-mode
0 10–11 Reserved
0 12 Instruction page fault
0 13 Load page fault
0 14 Reserved
0 15 Store/AMO page fault
0 16–23 Reserved
0 24–31 Available for custom use
0 32–47 Reserved
0 48–63 Available for custom use
0 ≥64 Reserved

No single step!

Other arches use hardware single-step exception for k/uprobe,  eg:
 - powerpc: regs->msr |= MSR_SINGLESTEP
 - arm/arm64: PSTATE.D for enabling software step exceptions
 - s390: Set PER control regs, turns on single step for the given address
 - x86: regs->flags |= X86_EFLAGS_TF
 - csky: of course use hw single step :)

All the above arches use a hardware single-step exception
mechanism to execute the instruction that was replaced with a probe
breakpoint. So utilize ebreak to simulate.

Some pc related instructions couldn't be executed out of line and some
system/fence instructions couldn't be a trace site at all. So we give
out a reject list and simulate list in decode-insn.c.

You could use uprobe to test simulate code like this:

 echo 'p:enter_current_state_one /hello:0x6e4 a0=%a0 a1=%a1' >> /sys/kernel/debug/tracing/uprobe_events
 echo 1 > /sys/kernel/debug/tracing/events/uprobes/enable
 /hello
 ^C
 cat /sys/kernel/debug/tracing/trace
 tracer: nop

 entries-in-buffer/entries-written: 1/1   #P:1

                              _-----=> irqs-off
                             / _----=> need-resched
                            | / _---=> hardirq/softirq
                            || / _--=> preempt-depth
                            ||| /     delay
           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
              | |       |   ||||       |         |
          hello-94    [000] d...    55.404242: enter_current_state_one: (0x106e4) a0=0x1 a1=0x3fffa8ada8

Be care /hello:0x6e4 is the file offset in elf and it relate to 0x106e4
in memory and hello is your target elf program.

Try kprobe like this:

 echo 'p:myprobe _do_fork dfd=%a0 filename=%a1 flags=%a2 mode=+4($stack)' > /sys/kernel/debug/tracing/kprobe_events
 echo 'r:myretprobe _do_fork $retval' >> /sys/kernel/debug/tracing/kprobe_event

 echo 1 >/sys/kernel/debug/tracing/events/kprobes/enable
 cat /sys/kernel/debug/tracing/trace
 tracer: nop

 entries-in-buffer/entries-written: 2/2   #P:1

                              _-----=> irqs-off
                             / _----=> need-resched
                            | / _---=> hardirq/softirq
                            || / _--=> preempt-depth
                            ||| /     delay
           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
              | |       |   ||||       |         |
             sh-92    [000] .n..   131.804230: myprobe: (_do_fork+0x0/0x2e6) dfd=0xffffffe03929fdf8 filename=0x0 flags=0x101000 mode=0x1200000ffffffe0
             sh-92    [000] d...   131.806607: myretprobe: (__do_sys_clone+0x70/0x82 <- _do_fork) arg1=0x5f
 cat /sys/kernel/debug/tracing/trace

Changes v2:
 - Add Reviewed-by, Tested-by, Acked-by, thx for all of you
 - Add kprobes on ftrace feature

Guo Ren (5):
  riscv: Fixup __vdso_gettimeofday broke dynamic ftrace
  riscv: Fixup compile error BUILD_BUG_ON failed
  riscv: Add kprobes supported
  riscv: Add uprobes supported
  riscv: Add KPROBES_ON_FTRACE supported

Patrick Stählin (1):
  RISC-V: Implement ptrace regs and stack API

 arch/riscv/Kconfig                            |   7 +
 arch/riscv/include/asm/kprobes.h              |  40 +++
 arch/riscv/include/asm/probes.h               |  24 ++
 arch/riscv/include/asm/processor.h            |   1 +
 arch/riscv/include/asm/ptrace.h               |  29 ++
 arch/riscv/include/asm/thread_info.h          |   4 +-
 arch/riscv/include/asm/uprobes.h              |  40 +++
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/patch.c                     |   8 +-
 arch/riscv/kernel/probes/Makefile             |   6 +
 arch/riscv/kernel/probes/decode-insn.c        |  48 +++
 arch/riscv/kernel/probes/decode-insn.h        |  18 +
 arch/riscv/kernel/probes/ftrace.c             |  53 +++
 arch/riscv/kernel/probes/kprobes.c            | 471 ++++++++++++++++++++++++++
 arch/riscv/kernel/probes/kprobes_trampoline.S |  93 +++++
 arch/riscv/kernel/probes/simulate-insn.c      |  85 +++++
 arch/riscv/kernel/probes/simulate-insn.h      |  47 +++
 arch/riscv/kernel/probes/uprobes.c            | 186 ++++++++++
 arch/riscv/kernel/ptrace.c                    |  99 ++++++
 arch/riscv/kernel/signal.c                    |   3 +
 arch/riscv/kernel/traps.c                     |  19 ++
 arch/riscv/kernel/vdso/Makefile               |   3 +
 arch/riscv/mm/fault.c                         |  11 +
 23 files changed, 1293 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/include/asm/probes.h
 create mode 100644 arch/riscv/include/asm/uprobes.h
 create mode 100644 arch/riscv/kernel/probes/Makefile
 create mode 100644 arch/riscv/kernel/probes/decode-insn.c
 create mode 100644 arch/riscv/kernel/probes/decode-insn.h
 create mode 100644 arch/riscv/kernel/probes/ftrace.c
 create mode 100644 arch/riscv/kernel/probes/kprobes.c
 create mode 100644 arch/riscv/kernel/probes/kprobes_trampoline.S
 create mode 100644 arch/riscv/kernel/probes/simulate-insn.c
 create mode 100644 arch/riscv/kernel/probes/simulate-insn.h
 create mode 100644 arch/riscv/kernel/probes/uprobes.c

-- 
2.7.4

