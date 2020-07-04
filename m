Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA94C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 03:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9881420899
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 03:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593833674;
	bh=eTy2eFqdtYkG5FT9y7JyU5E4q34c6fUXRLFGwI6SVv0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IKxPUmsVcITRwN38MH6Zvqx2fC9qfTFs2+OT7ZBFQj6/3grRR4W/WxSHz/a9jILUW
	 +7H/h9WZKgB5iq66IHWlaU8dRAPzLmICsLQTivvlzyhVDXqC+8lWCOXJzIrRF1+WcS
	 O0HzA7MpHuwAq0yAsvtItEZxGYdOrCdn2PgacVd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGDDeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 23:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgGDDeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 23:34:31 -0400
Received: from localhost.localdomain (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E73B20899;
        Sat,  4 Jul 2020 03:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593833670;
        bh=eTy2eFqdtYkG5FT9y7JyU5E4q34c6fUXRLFGwI6SVv0=;
        h=From:To:Cc:Subject:Date:From;
        b=Mip3htu2BiZjSdSMqYC7r5gtY2NOS7SFQXicW+fYddcldPhpvpkhMnVfYk4CTMtZW
         c21VJrSu4B4Gba8KFXGPr3bXEO7K21LYFcGlFORoj0pmEO2oEnVJMAkLnN8FG0AK/u
         oHlNwdAlCXEzWmYSgHlnC9f0NvEufYf+6F9b7fMA=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        me@packi.ch, bjorn.topel@gmail.com, atish.patra@wdc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V1 0/5] riscv: Add k/uprobe supported
Date:   Sat,  4 Jul 2020 03:34:14 +0000
Message-Id: <1593833659-26224-1-git-send-email-guoren@kernel.org>
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
to other arches'.

There is no single step exception in riscv ISA, so utilize ebreak to
simulate. Some pc related instructions couldn't be executed out of line
and some system/fence instructions couldn't be a trace site at all.
So we give out a reject list and simulate list in decode-insn.c.

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

Guo Ren (4):
  riscv: Fixup __vdso_gettimeofday broke dynamic ftrace
  riscv: Fixup compile error BUILD_BUG_ON failed
  riscv: Add kprobes supported
  riscv: Add uprobes supported

Patrick Stählin (1):
  RISC-V: Implement ptrace regs and stack API

 arch/riscv/Kconfig                            |   6 +
 arch/riscv/include/asm/kprobes.h              |  40 +++
 arch/riscv/include/asm/probes.h               |  24 ++
 arch/riscv/include/asm/processor.h            |   1 +
 arch/riscv/include/asm/ptrace.h               |  29 ++
 arch/riscv/include/asm/thread_info.h          |   4 +-
 arch/riscv/include/asm/uprobes.h              |  40 +++
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/patch.c                     |   8 +-
 arch/riscv/kernel/probes/Makefile             |   5 +
 arch/riscv/kernel/probes/decode-insn.c        |  48 +++
 arch/riscv/kernel/probes/decode-insn.h        |  18 +
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
 22 files changed, 1238 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/include/asm/probes.h
 create mode 100644 arch/riscv/include/asm/uprobes.h
 create mode 100644 arch/riscv/kernel/probes/Makefile
 create mode 100644 arch/riscv/kernel/probes/decode-insn.c
 create mode 100644 arch/riscv/kernel/probes/decode-insn.h
 create mode 100644 arch/riscv/kernel/probes/kprobes.c
 create mode 100644 arch/riscv/kernel/probes/kprobes_trampoline.S
 create mode 100644 arch/riscv/kernel/probes/simulate-insn.c
 create mode 100644 arch/riscv/kernel/probes/simulate-insn.h
 create mode 100644 arch/riscv/kernel/probes/uprobes.c

-- 
2.7.4

