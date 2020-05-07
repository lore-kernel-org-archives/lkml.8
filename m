Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4BEC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F0720870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgEGJ2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:28:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbgEGJ2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:28:32 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4D9753340A18592668BD;
        Thu,  7 May 2020 17:28:30 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 17:28:20 +0800
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <Dave.Martin@arm.com>, <mark.rutland@arm.com>,
        <james.morse@arm.com>, <yeyunfeng@huawei.com>,
        <0x7f454c46@gmail.com>, <tglx@linutronix.de>,
        <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hushiyuan@huawei.com>, <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] arm64: stacktrace: Factor out some common code info
 on_stack()
Message-ID: <10b188af-a03b-3acc-8a06-cf31a46f735a@huawei.com>
Date:   Thu, 7 May 2020 17:28:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some common codes for stack checking, so factors it out into
the function on_stack() and on_valid_stack().

No functional change.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 arch/arm64/include/asm/stacktrace.h | 53 +++++++++++++++++--------------------
 arch/arm64/kernel/sdei.c            | 28 ++------------------
 2 files changed, 26 insertions(+), 55 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index fdb913cc0bcb..b92bef2fb6cd 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -69,27 +69,40 @@ extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,

 DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);

-static inline bool on_irq_stack(unsigned long sp,
+static inline bool on_stack(unsigned long sp, unsigned long low,
+				unsigned long high, enum stack_type type,
 				struct stack_info *info)
 {
-	unsigned long low = (unsigned long)raw_cpu_read(irq_stack_ptr);
-	unsigned long high = low + IRQ_STACK_SIZE;
-
-	if (!low)
-		return false;
-
 	if (sp < low || sp >= high)
 		return false;

 	if (info) {
 		info->low = low;
 		info->high = high;
-		info->type = STACK_TYPE_IRQ;
+		info->type = type;
 	}
-
 	return true;
 }

+static inline bool on_valid_stack(unsigned long sp, unsigned long low,
+				unsigned long high, enum stack_type type,
+				struct stack_info *info)
+{
+	if (!low)
+		return false;
+
+	return on_stack(sp, low, high, type, info);
+}
+
+static inline bool on_irq_stack(unsigned long sp,
+				struct stack_info *info)
+{
+	unsigned long low = (unsigned long)raw_cpu_read(irq_stack_ptr);
+	unsigned long high = low + IRQ_STACK_SIZE;
+
+	return on_valid_stack(sp, low, high, STACK_TYPE_IRQ, info);
+}
+
 static inline bool on_task_stack(const struct task_struct *tsk,
 				 unsigned long sp,
 				 struct stack_info *info)
@@ -97,16 +110,7 @@ static inline bool on_task_stack(const struct task_struct *tsk,
 	unsigned long low = (unsigned long)task_stack_page(tsk);
 	unsigned long high = low + THREAD_SIZE;

-	if (sp < low || sp >= high)
-		return false;
-
-	if (info) {
-		info->low = low;
-		info->high = high;
-		info->type = STACK_TYPE_TASK;
-	}
-
-	return true;
+	return on_stack(sp, low, high, STACK_TYPE_TASK, info);
 }

 #ifdef CONFIG_VMAP_STACK
@@ -118,16 +122,7 @@ static inline bool on_overflow_stack(unsigned long sp,
 	unsigned long low = (unsigned long)raw_cpu_ptr(overflow_stack);
 	unsigned long high = low + OVERFLOW_STACK_SIZE;

-	if (sp < low || sp >= high)
-		return false;
-
-	if (info) {
-		info->low = low;
-		info->high = high;
-		info->type = STACK_TYPE_OVERFLOW;
-	}
-
-	return true;
+	return on_stack(sp, low, high, STACK_TYPE_OVERFLOW, info);
 }
 #else
 static inline bool on_overflow_stack(unsigned long sp,
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index d6259dac62b6..1758fcaa45dd 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -95,19 +95,7 @@ static bool on_sdei_normal_stack(unsigned long sp, struct stack_info *info)
 	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
 	unsigned long high = low + SDEI_STACK_SIZE;

-	if (!low)
-		return false;
-
-	if (sp < low || sp >= high)
-		return false;
-
-	if (info) {
-		info->low = low;
-		info->high = high;
-		info->type = STACK_TYPE_SDEI_NORMAL;
-	}
-
-	return true;
+	return on_valid_stack(sp, low, high, STACK_TYPE_SDEI_NORMAL, info);
 }

 static bool on_sdei_critical_stack(unsigned long sp, struct stack_info *info)
@@ -115,19 +103,7 @@ static bool on_sdei_critical_stack(unsigned long sp, struct stack_info *info)
 	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
 	unsigned long high = low + SDEI_STACK_SIZE;

-	if (!low)
-		return false;
-
-	if (sp < low || sp >= high)
-		return false;
-
-	if (info) {
-		info->low = low;
-		info->high = high;
-		info->type = STACK_TYPE_SDEI_CRITICAL;
-	}
-
-	return true;
+	return on_valid_stack(sp, low, high, STACK_TYPE_SDEI_CRITICAL, info);
 }

 bool _on_sdei_stack(unsigned long sp, struct stack_info *info)
-- 
1.8.3.1

