Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D983AC47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B69218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEINt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 09:49:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727834AbgEINt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:49:29 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 359F62E12B047D20BB97;
        Sat,  9 May 2020 21:49:14 +0800 (CST)
Received: from euler.huawei.com (10.175.101.6) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 21:49:09 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <daniel.thompson@linaro.org>, <jason.wessel@windriver.com>,
        <dianders@chromium.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
        <mhiramat@kernel.org>, <davem@davemloft.net>, <will@kernel.org>,
        <catalin.marinas@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liwei1412@163.com>
Subject: [PATCH 3/4] arm64: kgdb: Fix single-stepping into the irq handler wrongly
Date:   Sun, 10 May 2020 05:41:58 +0800
Message-ID: <20200509214159.19680-4-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200509214159.19680-1-liwei391@huawei.com>
References: <20200509214159.19680-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the single-step exception handling oops is fixed, when we execute
single-step in kdb/kgdb, we may see it jumps to the irq_handler (where
PSTATE.D is cleared) instead of the next instruction.

Add the prepare and cleanup work for single-step when enabling and
disabling to maintain the PSTATE.I and PSTATE.D carefully.

Before this patch:
* kdb:
Entering kdb (current=0xffff8000119e2dc0, pid 0) on processor 0 due to Keyboard Entry
[0]kdb> bp printk
Instruction(i) BP #0 at 0xffff8000101486cc (printk)
    is enabled   addr at ffff8000101486cc, hardtype=0 installed=0

[0]kdb> g

/ # echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff0000fada65c0, pid 267) on processor 0 due to Breakpoint @ 0xffff8000101486cc
[0]kdb> ss

Entering kdb (current=0xffff0000fada65c0, pid 267) on processor 0 due to SS trap @ 0xffff800010082ab8
[0]kdb> 0xffff800010082ab8
0xffff800010082ab8 = 0xffff800010082ab8 (el1_irq+0x78)
[0]kdb>

   0xffff800010082ab0 <+112>:	nop
   0xffff800010082ab4 <+116>:	msr	daifclr, #0xd
   0xffff800010082ab8 <+120>:	adrp	x1, 0xffff8000113a7000 <cpu_ops+1288>
   0xffff800010082abc <+124>:	ldr	x1, [x1, #1408]

* kgdb:
(gdb) target remote 127.1:23002
Remote debugging using 127.1:23002
arch_kgdb_breakpoint () at /home/liwei/main_code/linux/arch/arm64/include/asm/kgdb.h:21
21		asm ("brk %0" : : "I" (KGDB_COMPILED_DBG_BRK_IMM));
(gdb) b printk
Breakpoint 1 at 0xffff8000101486cc: file /home/liwei/main_code/linux/kernel/printk/printk.c, line 2076.
(gdb) c
Continuing.
[New Thread 287]
[Switching to Thread 283]

Thread 177 hit Breakpoint 1, printk (fmt=0xffff80001130c9d8 "\001\066sysrq: HELP : ")
    at /home/liwei/main_code/linux/kernel/printk/printk.c:2076
2076	{
(gdb) stepi
el1_irq () at /home/liwei/main_code/linux/arch/arm64/kernel/entry.S:608
608		irq_handler
(gdb)

After this patch:
* kdb:
Entering kdb (current=0xffff8000119d2dc0, pid 0) on processor 0 due to Keyboard Entry
[0]kdb> bp printk
Instruction(i) BP #0 at 0xffff80001014874c (printk)
    is enabled   addr at ffff80001014874c, hardtype=0 installed=0

[0]kdb> g

/ # echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff0000fa6948c0, pid 265) on processor 0 due to Breakpoint @ 0xffff80001014874c
[0]kdb> ss

Entering kdb (current=0xffff0000fa6948c0, pid 265) on processor 0 due to SS trap @ 0xffff800010148750
[0]kdb>

* kgdb:
(gdb) target remote 127.1:23002
Remote debugging using 127.1:23002
arch_kgdb_breakpoint () at /home/liwei/main_code/linux/arch/arm64/include/asm/kgdb.h:21
21		asm ("brk %0" : : "I" (KGDB_COMPILED_DBG_BRK_IMM));
(gdb) b printk
Breakpoint 1 at 0xffff80001014874c: file /home/liwei/main_code/linux/kernel/printk/printk.c, line 2076.
(gdb) c
Continuing.
[New Thread 277]
[Switching to Thread 276]

Thread 171 hit Breakpoint 1, printk (fmt=0xffff8000112fc130 "\001\066sysrq: HELP : ")
    at /home/liwei/main_code/linux/kernel/printk/printk.c:2076
2076	{
(gdb) stepi
0xffff800010148750	2076	{
(gdb)

Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 arch/arm64/kernel/kgdb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 1a157ca33262..3910ac06c261 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -100,6 +100,8 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
 	{ "fpcr", 4, -1 },
 };
 
+static DEFINE_PER_CPU(unsigned long, kgdb_ss_flags);
+
 char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
 {
 	if (regno >= DBG_MAX_REG_NUM || regno < 0)
@@ -200,8 +202,11 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		/*
 		 * Received continue command, disable single step
 		 */
-		if (kernel_active_single_step())
+		if (kernel_active_single_step()) {
+			kernel_cleanup_single_step(per_cpu(kgdb_ss_flags,
+					raw_smp_processor_id()), linux_regs);
 			kernel_disable_single_step();
+		}
 
 		err = 0;
 		break;
@@ -221,8 +226,12 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		/*
 		 * Enable single step handling
 		 */
-		if (!kernel_active_single_step())
+		if (!kernel_active_single_step()) {
+			kernel_prepare_single_step(&per_cpu(kgdb_ss_flags,
+					raw_smp_processor_id()), linux_regs);
 			kernel_enable_single_step(linux_regs);
+		}
+
 		err = 0;
 		break;
 	default:
-- 
2.17.1

