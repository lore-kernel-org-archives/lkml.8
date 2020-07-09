Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C87C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D877B20774
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594261359;
	bh=RJdV2DIzToOcfncq3WiDl+ziCtwNxeU7mYZYni3MdsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gEtbUdi5Qcr/e5dxaeODzRZUu/hlGG7TKZ+sKVdGijcxOxfGlZb5N+9mOzJaxGMGC
	 IR9H1JsNrnum061GqpTikLFGDIydn6RPIoqtu1fQTrHqbrYGBFbubvKegw/dMhqizD
	 gLHvrE8NCzArl7NVMH0Hv8eu1p0uhXy+ZEzBpfSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGICWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgGICWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 22:22:36 -0400
Received: from localhost.localdomain (unknown [42.120.72.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AB8320774;
        Thu,  9 Jul 2020 02:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594261355;
        bh=RJdV2DIzToOcfncq3WiDl+ziCtwNxeU7mYZYni3MdsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXWqGr4ELi5OlcGU6yZzPiZKzHRftBItJhapNhl2oeL4aY3XK+iAwrt2VakejFnYU
         8L7r54NxTPIzrbK379A7MiUcGh5cdoQ2Qli5yrODEf4mvFykL2+AELoM4aSbcapVdQ
         TbyQZLQz9Sb2PMpwCb22XrtBVBkEFDd9WiDNPKvE=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        me@packi.ch, bjorn.topel@gmail.com, atish.patra@wdc.com,
        penberg@kernel.org, mhiramat@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v2 6/6] riscv: Add KPROBES_ON_FTRACE supported
Date:   Thu,  9 Jul 2020 02:19:14 +0000
Message-Id: <1594261154-69745-7-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594261154-69745-1-git-send-email-guoren@kernel.org>
References: <1594261154-69745-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch adds support for kprobes on ftrace call sites to avoids
much of the overhead with regular kprobes. Try it with simple
steps:

1. Get _do_fork ftrace call site.
Dump of assembler code for function _do_fork:
   0xffffffe00020af64 <+0>:     addi    sp,sp,-128
   0xffffffe00020af66 <+2>:     sd      s0,112(sp)
   0xffffffe00020af68 <+4>:     sd      ra,120(sp)
   0xffffffe00020af6a <+6>:     addi    s0,sp,128
   0xffffffe00020af6c <+8>:     sd      s1,104(sp)
   0xffffffe00020af6e <+10>:    sd      s2,96(sp)
   0xffffffe00020af70 <+12>:    sd      s3,88(sp)
   0xffffffe00020af72 <+14>:    sd      s4,80(sp)
   0xffffffe00020af74 <+16>:    sd      s5,72(sp)
   0xffffffe00020af76 <+18>:    sd      s6,64(sp)
   0xffffffe00020af78 <+20>:    sd      s7,56(sp)
   0xffffffe00020af7a <+22>:    mv      s4,a0
   0xffffffe00020af7c <+24>:    mv      a0,ra
   0xffffffe00020af7e <+26>:    nop	<<<<<<<< here!
   0xffffffe00020af82 <+30>:    nop
   0xffffffe00020af86 <+34>:    ld      s3,0(s4)

2. Set _do_fork+26 as the kprobe.
  echo 'p:myprobe _do_fork+26 dfd=%a0 filename=%a1 flags=%a2 mode=+4($stack)' > /sys/kernel/debug/tracing/kprobe_events
  echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
  cat /sys/kernel/debug/tracing/trace
  tracer: nop

  entries-in-buffer/entries-written: 3/3   #P:1

                               _-----=> irqs-off
                              / _----=> need-resched
                             | / _---=> hardirq/softirq
                             || / _--=> preempt-depth
                             ||| /     delay
            TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
               | |       |   ||||       |         |
              sh-87    [000] ....   551.557031: myprobe: (_do_fork+0x1a/0x2e6) dfd=0xffffffe00020af7e filename=0xffffffe00020b34e flags=0xffffffe00101e7c0 mode=0x20af86ffffffe0

  cat /sys/kernel/debug/kprobes/list
ffffffe00020af7e  k  _do_fork+0x1a    [FTRACE]
                                       ^^^^^^

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Björn Töpel <bjorn.topel@gmail.com>
Cc: Zong Li <zong.li@sifive.com>
Cc: Pekka Enberg <penberg@kernel.org>
---
 arch/riscv/Kconfig                |  1 +
 arch/riscv/kernel/probes/Makefile |  1 +
 arch/riscv/kernel/probes/ftrace.c | 53 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 arch/riscv/kernel/probes/ftrace.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f927a91..91bfc6c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -58,6 +58,7 @@ config RISCV
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
 	select HAVE_KPROBES
+	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
index cb62991..7f0840d 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
 obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
+obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
new file mode 100644
index 00000000..08fc1cc
--- /dev/null
+++ b/arch/riscv/kernel/probes/ftrace.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kprobes.h>
+
+/* Ftrace callback handler for kprobes -- called under preepmt disabed */
+void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
+			   struct ftrace_ops *ops, struct pt_regs *regs)
+{
+	struct kprobe *p;
+	struct kprobe_ctlblk *kcb;
+
+	p = get_kprobe((kprobe_opcode_t *)ip);
+	if (unlikely(!p) || kprobe_disabled(p))
+		return;
+
+	kcb = get_kprobe_ctlblk();
+	if (kprobe_running()) {
+		kprobes_inc_nmissed_count(p);
+	} else {
+		/*
+		 * The regs->epc hasn't been saved by SAVE_ALL in mcount-dyn.S
+		 * So no need to resume it, just for kprobe handler.
+		 */
+		instruction_pointer_set(regs, ip);
+		__this_cpu_write(current_kprobe, p);
+		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+		if (!p->pre_handler || !p->pre_handler(p, regs)) {
+			/*
+			 * Emulate singlestep (and also recover regs->pc)
+			 * as if there is a nop
+			 */
+			instruction_pointer_set(regs,
+				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
+			if (unlikely(p->post_handler)) {
+				kcb->kprobe_status = KPROBE_HIT_SSDONE;
+				p->post_handler(p, regs, 0);
+			}
+		}
+
+		/*
+		 * If pre_handler returns !0, it changes regs->pc. We have to
+		 * skip emulating post_handler.
+		 */
+		__this_cpu_write(current_kprobe, NULL);
+	}
+}
+NOKPROBE_SYMBOL(kprobe_ftrace_handler);
+
+int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	p->ainsn.api.insn = NULL;
+	return 0;
+}
-- 
2.7.4

