Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24611C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D59F24956
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgEINtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 09:49:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbgEINtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:49:17 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2D35DFA87879A8FDE183;
        Sat,  9 May 2020 21:49:14 +0800 (CST)
Received: from euler.huawei.com (10.175.101.6) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 21:49:11 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <daniel.thompson@linaro.org>, <jason.wessel@windriver.com>,
        <dianders@chromium.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
        <mhiramat@kernel.org>, <davem@davemloft.net>, <will@kernel.org>,
        <catalin.marinas@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liwei1412@163.com>
Subject: [PATCH 4/4] arm64: kgdb: Set PSTATE.SS to 1 to reenable single-step
Date:   Sun, 10 May 2020 05:41:59 +0800
Message-ID: <20200509214159.19680-5-liwei391@huawei.com>
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

After fixing wrongly single-stepping into the irq handler, when we execute
single-step in kdb/kgdb, we can see only the first step can work.

Refer to the ARM Architecture Reference Manual (ARM DDI 0487E.a) D2.12,
i think PSTATE.SS=1 should be set each step for transferring the PE to the
'Active-not-pending' state. The problem here is PSTATE.SS=1 is not set
since the second single-step.

After the first single-step, the PE transferes to the 'Inactive' state,
with PSTATE.SS=0 and MDSCR.SS=1, thus PSTATE.SS won't be set to 1 due to
kernel_active_single_step()=true. Then the PE transferes to the
'Active-pending' state when ERET and returns to the debugger by step
exception.

Before this patch:
* kdb:
Entering kdb (current=0xffff8000119d2dc0, pid 0) on processor 0 due to Keyboard Entry
[0]kdb> bp printk
Instruction(i) BP #0 at 0xffff80001014874c (printk)
    is enabled   addr at ffff80001014874c, hardtype=0 installed=0

[0]kdb> g

/ # echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff0000fa6948c0, pid 265) on processor 3 due to Breakpoint @ 0xffff80001014874c
[3]kdb> ss

Entering kdb (current=0xffff0000fa6948c0, pid 265) on processor 3 due to SS trap @ 0xffff800010148750
[3]kdb> ss

Entering kdb (current=0xffff0000fa6948c0, pid 265) on processor 3 due to SS trap @ 0xffff800010148750
[3]kdb> ss

Entering kdb (current=0xffff0000fa6948c0, pid 265) on processor 3 due to SS trap @ 0xffff800010148750
[3]kdb>

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
(gdb) stepi
0xffff800010148750	2076	{
(gdb) stepi
0xffff800010148750	2076	{
(gdb)

After this patch:
* kdb:
Entering kdb (current=0xffff8000119d2dc0, pid 0) on processor 0 due to Keyboard Entry
[0]kdb> bp printk
Instruction(i) BP #0 at 0xffff80001014874c (printk)
    is enabled   addr at ffff80001014874c, hardtype=0 installed=0

[0]kdb> g

/ # echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff0000fa800040, pid 264) on processor 2 due to Breakpoint @ 0xffff80001014874c
[2]kdb> ss

Entering kdb (current=0xffff0000fa800040, pid 264) on processor 2 due to SS trap @ 0xffff800010148750
[2]kdb> ss

Entering kdb (current=0xffff0000fa800040, pid 264) on processor 2 due to SS trap @ 0xffff800010148754
[2]kdb> ss

Entering kdb (current=0xffff0000fa800040, pid 264) on processor 2 due to SS trap @ 0xffff800010148758
[2]kdb>

* kgdb:
(gdb) target remote 127.1:23002
Remote debugging using 127.1:23002
arch_kgdb_breakpoint () at /home/liwei/main_code/linux/arch/arm64/include/asm/kgdb.h:21
21		asm ("brk %0" : : "I" (KGDB_COMPILED_DBG_BRK_IMM));
(gdb) b printk
Breakpoint 1 at 0xffff80001014874c: file /home/liwei/main_code/linux/kernel/printk/printk.c, line 2076.
(gdb) c
Continuing.
[New Thread 281]
[New Thread 280]
[Switching to Thread 281]

Thread 174 hit Breakpoint 1, printk (fmt=0xffff8000112fc138 "\001\066sysrq: HELP : ")
    at /home/liwei/main_code/linux/kernel/printk/printk.c:2076
2076	{
(gdb) stepi
0xffff800010148750	2076	{
(gdb) stepi
2080		va_start(args, fmt);
(gdb) stepi
0xffff800010148758	2080		va_start(args, fmt);
(gdb)

Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 arch/arm64/include/asm/debug-monitors.h | 2 ++
 arch/arm64/kernel/debug-monitors.c      | 2 +-
 arch/arm64/kernel/kgdb.c                | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index b62469f3475b..a48b507c89ee 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -78,6 +78,8 @@ struct step_hook {
 	int (*fn)(struct pt_regs *regs, unsigned int esr);
 };
 
+void set_regs_spsr_ss(struct pt_regs *regs);
+
 void register_user_step_hook(struct step_hook *hook);
 void unregister_user_step_hook(struct step_hook *hook);
 
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 25ce6b5a52d2..7a58233677de 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -141,7 +141,7 @@ postcore_initcall(debug_monitors_init);
 /*
  * Single step API and exception handling.
  */
-static void set_regs_spsr_ss(struct pt_regs *regs)
+void set_regs_spsr_ss(struct pt_regs *regs)
 {
 	regs->pstate |= DBG_SPSR_SS;
 }
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 3910ac06c261..093ad9d2e5e6 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -230,7 +230,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 			kernel_prepare_single_step(&per_cpu(kgdb_ss_flags,
 					raw_smp_processor_id()), linux_regs);
 			kernel_enable_single_step(linux_regs);
-		}
+		} else
+			set_regs_spsr_ss(linux_regs);
 
 		err = 0;
 		break;
-- 
2.17.1

