Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78364C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C88620723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PbXCQb0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbgFWN3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732726AbgFWN3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:29:02 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A048FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:29:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d8so9116499plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=APwDQH63ewaL2qHEi/Ing1YzxCpzIwvDW/C7xU97WY0=;
        b=PbXCQb0I5NcMaqeL2wj0y+gCoXWzoQHXd5NZSSIuOH0eAn5wdg+jYg3UH3rhFQPF0h
         AYzbC/q/fW5p6ikeJfsfrX/s+2FxNa3eLz0LsulX1zz7jNFi2uyKRGSXvLNvPmwsu5xL
         vskx139Bd95c7NkshprgseAjPT/4Bm/NMqafph1Boy9sryODU1rSRNI/U34xS/8N5rTA
         6gfFI5brWV24f+8IZnehVpqBZP1jHPEeAkJS05LtvDB8PGKhy1MTy2/+ZpeAzkazITpU
         HrlYvOAnGrYpIKvb0B5BCF9oy4BPyimIDpB9ozsu+oQc27pEYPxhO1Kte81+XKfdsGjT
         TjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APwDQH63ewaL2qHEi/Ing1YzxCpzIwvDW/C7xU97WY0=;
        b=QxcpzERNULDcMMKZY+h80BJ43vyZHzouoY3wci/RHTYZVIKiajNepaMV/hC0LLoPZd
         Btv4gyh4BWhSUm2yHWTL8a9mpcLGTn/oBY9lFI77bNQ8Ya0qMft5t4klQHzDadqK0hXj
         ooGqMAoRVK6u/a3yscX/lozjqrFrxFlXrwkBDYJa3e1g8ZkjptPCB0kkRFNZp9g+CdP0
         Q1fSs/jhl96b+dOJ/uK37B4Gp5S3paltYAQI+dlIjZlO13PBi4vKwtyWjDO+kFnnbtMa
         DfBAevPFtDuCXMLX8PDTXOfO/zlZYouDpB8m9oLDgckXf5TS1dZeWY5YvECqd3jWLKuR
         2ojQ==
X-Gm-Message-State: AOAM532pqFldrHKgznauaFigGilpAzVea+qfOc//zc0u/JaZeq+xDcBm
        WDKsel5SHCYCx0LVQoNRIL5Jlg==
X-Google-Smtp-Source: ABdhPJxpJPQHwBmh6Gu1YsWwEwlOOyqv34ySw/8ydXrPOqO/c52QijaV/el6WAIe1YmnTDfmfIBvPA==
X-Received: by 2002:a17:902:854c:: with SMTP id d12mr73433plo.343.1592918942115;
        Tue, 23 Jun 2020 06:29:02 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id z19sm1670602pjn.55.2020.06.23.06.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 06:29:01 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        guoren@linux.alibaba.com
Subject: [PATCH 2/2] riscv: Enable context tracking
Date:   Tue, 23 Jun 2020 21:28:52 +0800
Message-Id: <7a571e93cc12f8f57b77b2d33b214c3359013874.1592918110.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592918110.git.greentime.hu@sifive.com>
References: <cover.1592918110.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements and enables context tracking for riscv (which is a
prerequisite for CONFIG_NO_HZ_FULL support)

It adds checking for previous state in the entry that all excepttions and
interrupts goes to and calls context_tracking_user_exit() if it comes from
user space. It also calls context_tracking_user_enter() if it will return
to user space before restore_all.

This patch is tested with the dynticks-testing testcase in
qemu-system-riscv64 virt machine and Unleashed board.
git://git.kernel.org/pub/scm/linux/kernel/git/frederic/dynticks-testing.git

We can see the log here. The tick got mostly stopped during the execution
of the user loop.

                        _-----=> irqs-off
                       / _----=> need-resched
                      | / _---=> hardirq/softirq
                      || / _--=> preempt-depth
                      ||| /     delay
     TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
        | |       |   ||||       |         |
   <idle>-0     [001] d..2   604.183512: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=taskset next_pid=273 next_prio=120
user_loop-273   [001] d.h1   604.184788: hrtimer_expire_entry: hrtimer=000000002eda5fab function=tick_sched_timer now=604176096300
user_loop-273   [001] d.s2   604.184897: workqueue_queue_work: work struct=00000000383402c2 function=vmstat_update workqueue=00000000f36d35d4 req_cpu=1 cpu=1
user_loop-273   [001] dns2   604.185039: tick_stop: success=0 dependency=SCHED
user_loop-273   [001] dn.1   604.185103: tick_stop: success=0 dependency=SCHED
user_loop-273   [001] d..2   604.185154: sched_switch: prev_comm=taskset prev_pid=273 prev_prio=120 prev_state=R+ ==> next_comm=kworker/1:1 next_pid=46 next_prio=120
    <...>-46    [001] ....   604.185194: workqueue_execute_start: work struct 00000000383402c2: function vmstat_update
    <...>-46    [001] d..2   604.185266: sched_switch: prev_comm=kworker/1:1 prev_pid=46 prev_prio=120 prev_state=I ==> next_comm=taskset next_pid=273 next_prio=120
user_loop-273   [001] d.h1   604.188812: hrtimer_expire_entry: hrtimer=000000002eda5fab function=tick_sched_timer now=604180133400
user_loop-273   [001] d..1   604.189050: tick_stop: success=1 dependency=NONE
user_loop-273   [001] d..2   614.251386: sched_switch: prev_comm=user_loop prev_pid=273 prev_prio=120 prev_state=X ==> next_comm=swapper/1 next_pid=0 next_prio=120
   <idle>-0     [001] d..2   614.315391: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=taskset next_pid=276 next_prio=120

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/Kconfig        |  1 +
 arch/riscv/kernel/entry.S | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 128192e14ff2..17520e11815b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -52,6 +52,7 @@ config RISCV
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ASM_MODVERSIONS
+	select HAVE_CONTEXT_TRACKING
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_EBPF_JIT if MMU
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index cae7e6d4c7ef..6ed579fc1073 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -97,6 +97,14 @@ _save_context:
 	la gp, __global_pointer$
 .option pop
 
+#ifdef CONFIG_CONTEXT_TRACKING
+	/* If previous state is in user mode, call context_tracking_user_exit. */
+	andi a0, s1, SR_SPP
+	bnez a0, skip_context_tracking
+	call context_tracking_user_exit
+
+skip_context_tracking:
+#endif
 	la ra, ret_from_exception
 	/*
 	 * MSB of cause differentiates between
@@ -137,6 +145,17 @@ _save_context:
 	tail do_trap_unknown
 
 handle_syscall:
+#ifdef CONFIG_CONTEXT_TRACKING
+	/* Recover a0 - a7 for system calls */
+	REG_L x10, PT_A0(sp)
+	REG_L x11, PT_A1(sp)
+	REG_L x12, PT_A2(sp)
+	REG_L x13, PT_A3(sp)
+	REG_L x14, PT_A4(sp)
+	REG_L x15, PT_A5(sp)
+	REG_L x16, PT_A6(sp)
+	REG_L x17, PT_A7(sp)
+#endif
 	 /* save the initial A0 value (needed in signal handlers) */
 	REG_S a0, PT_ORIG_A0(sp)
 	/*
@@ -205,6 +224,10 @@ resume_userspace:
 	andi s1, s0, _TIF_WORK_MASK
 	bnez s1, work_pending
 
+#ifdef CONFIG_CONTEXT_TRACKING
+	call context_tracking_user_enter
+#endif
+
 	/* Save unwound kernel stack pointer in thread_info */
 	addi s0, sp, PT_SIZE_ON_STACK
 	REG_S s0, TASK_TI_KERNEL_SP(tp)
-- 
2.27.0

