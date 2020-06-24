Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D28C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7CB20857
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EebCq36d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbgFXJDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389043AbgFXJDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:03:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C404C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:03:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ga6so927008pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=APwDQH63ewaL2qHEi/Ing1YzxCpzIwvDW/C7xU97WY0=;
        b=EebCq36d0n00dZfafkmwSeo5Kh9YCqdxCmikfSs628rB+ud+0owUwlvXwPQg9kQ7PW
         cQyhyg3uX2G3fcuHZ0KTGxyo/v+/FM1RwL0P8xNU5HdiqJs3yUMnpofHSczVhW2v4+kd
         rUA+IuQ0tpZdFa8hlW8P9aY0jW31mSmr8O7VXhO9EPj3ouHcv/0z0xXrfdCBByyY6U/3
         bo2I7Buym1YxdatSOSSqTpY9Ntnnl4g+P4bFWkdxALJalVHhKYQM66m2v71FOSby38cs
         lIJAyzNEBH/+ewOfe7bJCgRRs6BsODQ5nI9q8K+3perwfUXyr5XvfoUPWyUfwpzisfoq
         EG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APwDQH63ewaL2qHEi/Ing1YzxCpzIwvDW/C7xU97WY0=;
        b=jf4uXXbZJkVZUAhOg7GTNvrBX7cosikgwh/DxETD6zt2lcYjAjO5a1BfONIlCUoyJx
         IdERYVFP2RO2+RPuBZKzdfUxiunI7jO3MOKFgrtjXG8fJUqEir8q89W1UDFZ5tHcwElH
         sOiPVaD+4T/2V8a9cYfyPWE8pMQR9wi9YRK/Z0A/3uZBwp15VpCH5jaSLkZZYVwHcfnB
         v8nrYUeeFJmCwH6IBkYUvdlKOKQz4Gem2qY9vMDhhhqG3MYZh5Cv5TaFC08tNZHlFZBK
         Ng/NRnfNxWZcfrfV8lDuXLqH4diFJbvi2HEOUa36eIeszWgXner8wTkfvII0PwTsewrV
         TeeQ==
X-Gm-Message-State: AOAM5302GYQM1HBAlOhLYJ9C60WEu0RZGUuBa/LJl7OcbXHe/PjHMXLG
        zmnibZ6y93d2nFmSh1DEA7xENA==
X-Google-Smtp-Source: ABdhPJxtISH0SfgZOfx/uwGsVvKIQ1d9K61asvDGx9hoUzFaDYg3+j/yH5O3Rkcq+SMAOv6bat4HqQ==
X-Received: by 2002:a17:90a:a116:: with SMTP id s22mr26713129pjp.202.1592989409684;
        Wed, 24 Jun 2020 02:03:29 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id v1sm8062046pfn.210.2020.06.24.02.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 02:03:29 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        guoren@linux.alibaba.com
Subject: [PATCH v2 2/2] riscv: Enable context tracking
Date:   Wed, 24 Jun 2020 17:03:16 +0800
Message-Id: <1d89d5a6b54ca3d3203cb02ff4548b4eb9820c61.1592989082.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592989082.git.greentime.hu@sifive.com>
References: <cover.1592989082.git.greentime.hu@sifive.com>
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

