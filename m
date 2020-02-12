Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E54C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6772073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="FjivCGHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgBLPmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:42:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42600 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgBLPmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:42:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so2919948wrd.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 07:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j1xGUYoq6T5SfqGP52nutR/J2B1Kug99JeCU5ThWrGU=;
        b=FjivCGHN8Dy78mITH/5zTk7carjkiVcklR3ELH5cNj8WhHz+oIyHKu0P+HV7ELkdkx
         HOWL/S/a86ggw0rFlmRWYgYZfxVsPdCa49RLDEwMssxse2sL1gIQgpxXmo3yLRqBolTw
         HG2hXOO7jktDkTwMCVrsgVAt9YrB3LNKA2Tl4chIAvv61FU/QfYO1rmxa+XN2FR2tqVT
         nJKGDY+cYK/MZeUgXhxMlGQjn6+KYFy3nHEVk45vEXTGC+NMvvg073W6nMU3k8DRSnjX
         N3ttYzWW9Qmmd36lOpXIZfkTyvF4QVOquDV62aXqz3s9nq/JG4NAyuHQIvxAmvC0UcHu
         PMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=j1xGUYoq6T5SfqGP52nutR/J2B1Kug99JeCU5ThWrGU=;
        b=fh1p7NNt5sKXhWdl389gzhKX4fxMdyk5Kux7JJi5s+dXSttxPwLOdRAFpbVEIj1xwN
         yqdHFla69jjCAaZttYf6eUhuWB/eJ+NT9ejcpRXOm3DGaXH9PHjER038LvVsiwoYmF5V
         6rOmhqmizQAi4ftVvj8O1FKACxSzvucEzDPa1mLb3ThnxN60heBOeZTBY++uKmCTymdM
         p/FdrAAdND0J0jsFvspqssRvG/5lWHwdKT1x+ZwQfffe8g2v5vNbmcfAObsbH0v2KLtb
         Ibopo6rFr+VvDU1P/az4nCYhYYu0dXU4YOrv1I43CY+Ma1n1cldMMtw58a7c8XUU8KPK
         BuvQ==
X-Gm-Message-State: APjAAAXf46vwExUDzRXrdMGMvXs9tnGf98QfmGUYjakBpU1obA7gUEXt
        Gqkr0J63VB5SwS8LbaEgJz90s4rrepoeA3Cq
X-Google-Smtp-Source: APXvYqwn2KK2GI7LSaObE+IS3ZxKuKtLQr618YXKk+C/qDmyK8K/kQntIxdyUipJRal60QLWVkmSsQ==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr15908641wrm.59.1581522154130;
        Wed, 12 Feb 2020 07:42:34 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id h10sm1226617wml.18.2020.02.12.07.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 07:42:33 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/7] microblaze: Make cpuinfo structure SMP aware
Date:   Wed, 12 Feb 2020 16:42:24 +0100
Message-Id: <f6bca66fa1c0c4f7321bbac3906fdf87652285d1.1581522136.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581522136.git.michal.simek@xilinx.com>
References: <cover.1581522136.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Asserhall <stefan.asserhall@xilinx.com>

Define struct cpuinfo per cpu and also fill it based on information from DT
or PVR.

Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/include/asm/cpuinfo.h |   2 +-
 arch/microblaze/kernel/cpu/cache.c    | 154 +++++++++++--------
 arch/microblaze/kernel/cpu/cpuinfo.c  |  38 +++--
 arch/microblaze/kernel/cpu/mb.c       | 207 ++++++++++++++------------
 arch/microblaze/mm/consistent.c       |   8 +-
 5 files changed, 236 insertions(+), 173 deletions(-)

diff --git a/arch/microblaze/include/asm/cpuinfo.h b/arch/microblaze/include/asm/cpuinfo.h
index 786ffa669bf1..b8b04cd0095d 100644
--- a/arch/microblaze/include/asm/cpuinfo.h
+++ b/arch/microblaze/include/asm/cpuinfo.h
@@ -84,7 +84,7 @@ struct cpuinfo {
 	u32 pvr_user2;
 };
 
-extern struct cpuinfo cpuinfo;
+DECLARE_PER_CPU(struct cpuinfo, cpu_info);
 
 /* fwd declarations of the various CPUinfo populators */
 void setup_cpuinfo(void);
diff --git a/arch/microblaze/kernel/cpu/cache.c b/arch/microblaze/kernel/cpu/cache.c
index dcba53803fa5..818152e37375 100644
--- a/arch/microblaze/kernel/cpu/cache.c
+++ b/arch/microblaze/kernel/cpu/cache.c
@@ -12,6 +12,7 @@
 
 #include <asm/cacheflush.h>
 #include <linux/cache.h>
+#include <linux/smp.h>
 #include <asm/cpuinfo.h>
 #include <asm/pvr.h>
 
@@ -158,6 +159,8 @@ do {									\
 
 static void __flush_icache_range_msr_irq(unsigned long start, unsigned long end)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 	unsigned long flags;
 #ifndef ASM_LOOP
 	int i;
@@ -166,15 +169,15 @@ static void __flush_icache_range_msr_irq(unsigned long start, unsigned long end)
 				(unsigned int)start, (unsigned int) end);
 
 	CACHE_LOOP_LIMITS(start, end,
-			cpuinfo.icache_line_length, cpuinfo.icache_size);
+			cpuinfo->icache_line_length, cpuinfo->icache_size);
 
 	local_irq_save(flags);
 	__disable_icache_msr();
 
 #ifdef ASM_LOOP
-	CACHE_RANGE_LOOP_1(start, end, cpuinfo.icache_line_length, wic);
+	CACHE_RANGE_LOOP_1(start, end, cpuinfo->icache_line_length, wic);
 #else
-	for (i = start; i < end; i += cpuinfo.icache_line_length)
+	for (i = start; i < end; i += cpuinfo->icache_line_length)
 		__asm__ __volatile__ ("wic	%0, r0;"	\
 				: : "r" (i));
 #endif
@@ -185,6 +188,8 @@ static void __flush_icache_range_msr_irq(unsigned long start, unsigned long end)
 static void __flush_icache_range_nomsr_irq(unsigned long start,
 				unsigned long end)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 	unsigned long flags;
 #ifndef ASM_LOOP
 	int i;
@@ -193,15 +198,15 @@ static void __flush_icache_range_nomsr_irq(unsigned long start,
 				(unsigned int)start, (unsigned int) end);
 
 	CACHE_LOOP_LIMITS(start, end,
-			cpuinfo.icache_line_length, cpuinfo.icache_size);
+			cpuinfo->icache_line_length, cpuinfo->icache_size);
 
 	local_irq_save(flags);
 	__disable_icache_nomsr();
 
 #ifdef ASM_LOOP
-	CACHE_RANGE_LOOP_1(start, end, cpuinfo.icache_line_length, wic);
+	CACHE_RANGE_LOOP_1(start, end, cpuinfo->icache_line_length, wic);
 #else
-	for (i = start; i < end; i += cpuinfo.icache_line_length)
+	for (i = start; i < end; i += cpuinfo->icache_line_length)
 		__asm__ __volatile__ ("wic	%0, r0;"	\
 				: : "r" (i));
 #endif
@@ -213,6 +218,8 @@ static void __flush_icache_range_nomsr_irq(unsigned long start,
 static void __flush_icache_range_noirq(unsigned long start,
 				unsigned long end)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 #ifndef ASM_LOOP
 	int i;
 #endif
@@ -220,11 +227,11 @@ static void __flush_icache_range_noirq(unsigned long start,
 				(unsigned int)start, (unsigned int) end);
 
 	CACHE_LOOP_LIMITS(start, end,
-			cpuinfo.icache_line_length, cpuinfo.icache_size);
+			cpuinfo->icache_line_length, cpuinfo->icache_size);
 #ifdef ASM_LOOP
-	CACHE_RANGE_LOOP_1(start, end, cpuinfo.icache_line_length, wic);
+	CACHE_RANGE_LOOP_1(start, end, cpuinfo->icache_line_length, wic);
 #else
-	for (i = start; i < end; i += cpuinfo.icache_line_length)
+	for (i = start; i < end; i += cpuinfo->icache_line_length)
 		__asm__ __volatile__ ("wic	%0, r0;"	\
 				: : "r" (i));
 #endif
@@ -232,6 +239,8 @@ static void __flush_icache_range_noirq(unsigned long start,
 
 static void __flush_icache_all_msr_irq(void)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 	unsigned long flags;
 #ifndef ASM_LOOP
 	int i;
@@ -241,11 +250,10 @@ static void __flush_icache_all_msr_irq(void)
 	local_irq_save(flags);
 	__disable_icache_msr();
 #ifdef ASM_LOOP
-	CACHE_ALL_LOOP(cpuinfo.icache_size, cpuinfo.icache_line_length, wic);
+	CACHE_ALL_LOOP(cpuinfo->icache_size, cpuinfo->icache_line_length, wic);
 #else
-	for (i = 0; i < cpuinfo.icache_size;
-		 i += cpuinfo.icache_line_length)
-			__asm__ __volatile__ ("wic	%0, r0;" \
+	for (i = 0; i < cpuinfo->icache_size; i += cpuinfo->icache_line_length)
+		__asm__ __volatile__ ("wic	%0, r0;" \
 					: : "r" (i));
 #endif
 	__enable_icache_msr();
@@ -254,6 +262,8 @@ static void __flush_icache_all_msr_irq(void)
 
 static void __flush_icache_all_nomsr_irq(void)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 	unsigned long flags;
 #ifndef ASM_LOOP
 	int i;
@@ -263,11 +273,10 @@ static void __flush_icache_all_nomsr_irq(void)
 	local_irq_save(flags);
 	__disable_icache_nomsr();
 #ifdef ASM_LOOP
-	CACHE_ALL_LOOP(cpuinfo.icache_size, cpuinfo.icache_line_length, wic);
+	CACHE_ALL_LOOP(cpuinfo->icache_size, cpuinfo->icache_line_length, wic);
 #else
-	for (i = 0; i < cpuinfo.icache_size;
-		 i += cpuinfo.icache_line_length)
-			__asm__ __volatile__ ("wic	%0, r0;" \
+	for (i = 0; i < cpuinfo->icache_size; i += cpuinfo->icache_line_length)
+		__asm__ __volatile__ ("wic	%0, r0;" \
 					: : "r" (i));
 #endif
 	__enable_icache_nomsr();
@@ -276,22 +285,25 @@ static void __flush_icache_all_nomsr_irq(void)
 
 static void __flush_icache_all_noirq(void)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 #ifndef ASM_LOOP
 	int i;
 #endif
 	pr_debug("%s\n", __func__);
 #ifdef ASM_LOOP
-	CACHE_ALL_LOOP(cpuinfo.icache_size, cpuinfo.icache_line_length, wic);
+	CACHE_ALL_LOOP(cpuinfo->icache_size, cpuinfo->icache_line_length, wic);
 #else
-	for (i = 0; i < cpuinfo.icache_size;
-		 i += cpuinfo.icache_line_length)
-			__asm__ __volatile__ ("wic	%0, r0;" \
+	for (i = 0; i < cpuinfo->icache_size; i += cpuinfo->icache_line_length)
+		__asm__ __volatile__ ("wic	%0, r0;" \
 					: : "r" (i));
 #endif
 }
 
 static void __invalidate_dcache_all_msr_irq(void)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 	unsigned long flags;
 #ifndef ASM_LOOP
 	int i;
@@ -301,11 +313,10 @@ static void __invalidate_dcache_all_msr_irq(void)
 	local_irq_save(flags);
 	__disable_dcache_msr();
 #ifdef ASM_LOOP
-	CACHE_ALL_LOOP(cpuinfo.dcache_size, cpuinfo.dcache_line_length, wdc);
+	CACHE_ALL_LOOP(cpuinfo->dcache_size, cpuinfo->dcache_line_length, wdc);
 #else
-	for (i = 0; i < cpuinfo.dcache_size;
-		 i += cpuinfo.dcache_line_length)
-			__asm__ __volatile__ ("wdc	%0, r0;" \
+	for (i = 0; i < cpuinfo->dcache_size; i += cpuinfo->dcache_line_length)
+		__asm__ __volatile__ ("wdc	%0, r0;" \
 					: : "r" (i));
 #endif
 	__enable_dcache_msr();
@@ -314,6 +325,8 @@ static void __invalidate_dcache_all_msr_irq(void)
 
 static void __invalidate_dcache_all_nomsr_irq(void)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 	unsigned long flags;
 #ifndef ASM_LOOP
 	int i;
@@ -323,11 +336,10 @@ static void __invalidate_dcache_all_nomsr_irq(void)
 	local_irq_save(flags);
 	__disable_dcache_nomsr();
 #ifdef ASM_LOOP
-	CACHE_ALL_LOOP(cpuinfo.dcache_size, cpuinfo.dcache_line_length, wdc);
+	CACHE_ALL_LOOP(cpuinfo->dcache_size, cpuinfo->dcache_line_length, wdc);
 #else
-	for (i = 0; i < cpuinfo.dcache_size;
-		 i += cpuinfo.dcache_line_length)
-			__asm__ __volatile__ ("wdc	%0, r0;" \
+	for (i = 0; i < cpuinfo->dcache_size; i += cpuinfo->dcache_line_length)
+		__asm__ __volatile__ ("wdc	%0, r0;" \
 					: : "r" (i));
 #endif
 	__enable_dcache_nomsr();
@@ -336,16 +348,17 @@ static void __invalidate_dcache_all_nomsr_irq(void)
 
 static void __invalidate_dcache_all_noirq_wt(void)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 #ifndef ASM_LOOP
 	int i;
 #endif
 	pr_debug("%s\n", __func__);
 #ifdef ASM_LOOP
-	CACHE_ALL_LOOP(cpuinfo.dcache_size, cpuinfo.dcache_line_length, wdc);
+	CACHE_ALL_LOOP(cpuinfo->dcache_size, cpuinfo->dcache_line_length, wdc);
 #else
-	for (i = 0; i < cpuinfo.dcache_size;
-		 i += cpuinfo.dcache_line_length)
-			__asm__ __volatile__ ("wdc	%0, r0;" \
+	for (i = 0; i < cpuinfo->dcache_size; i += cpuinfo->dcache_line_length)
+		__asm__ __volatile__ ("wdc	%0, r0;" \
 					: : "r" (i));
 #endif
 }
@@ -359,17 +372,18 @@ static void __invalidate_dcache_all_noirq_wt(void)
  */
 static void __invalidate_dcache_all_wb(void)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 #ifndef ASM_LOOP
 	int i;
 #endif
 	pr_debug("%s\n", __func__);
 #ifdef ASM_LOOP
-	CACHE_ALL_LOOP(cpuinfo.dcache_size, cpuinfo.dcache_line_length,
+	CACHE_ALL_LOOP(cpuinfo->dcache_size, cpuinfo->dcache_line_length,
 					wdc);
 #else
-	for (i = 0; i < cpuinfo.dcache_size;
-		 i += cpuinfo.dcache_line_length)
-			__asm__ __volatile__ ("wdc	%0, r0;" \
+	for (i = 0; i < cpuinfo->dcache_size; i += cpuinfo->dcache_line_length)
+		__asm__ __volatile__ ("wdc	%0, r0;" \
 					: : "r" (i));
 #endif
 }
@@ -377,6 +391,8 @@ static void __invalidate_dcache_all_wb(void)
 static void __invalidate_dcache_range_wb(unsigned long start,
 						unsigned long end)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 #ifndef ASM_LOOP
 	int i;
 #endif
@@ -384,11 +400,11 @@ static void __invalidate_dcache_range_wb(unsigned long start,
 				(unsigned int)start, (unsigned int) end);
 
 	CACHE_LOOP_LIMITS(start, end,
-			cpuinfo.dcache_line_length, cpuinfo.dcache_size);
+			cpuinfo->dcache_line_length, cpuinfo->dcache_size);
 #ifdef ASM_LOOP
-	CACHE_RANGE_LOOP_2(start, end, cpuinfo.dcache_line_length, wdc.clear);
+	CACHE_RANGE_LOOP_2(start, end, cpuinfo->dcache_line_length, wdc.clear);
 #else
-	for (i = start; i < end; i += cpuinfo.dcache_line_length)
+	for (i = start; i < end; i += cpuinfo->dcache_line_length)
 		__asm__ __volatile__ ("wdc.clear	%0, r0;"	\
 				: : "r" (i));
 #endif
@@ -397,18 +413,20 @@ static void __invalidate_dcache_range_wb(unsigned long start,
 static void __invalidate_dcache_range_nomsr_wt(unsigned long start,
 							unsigned long end)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 #ifndef ASM_LOOP
 	int i;
 #endif
 	pr_debug("%s: start 0x%x, end 0x%x\n", __func__,
 				(unsigned int)start, (unsigned int) end);
 	CACHE_LOOP_LIMITS(start, end,
-			cpuinfo.dcache_line_length, cpuinfo.dcache_size);
+			cpuinfo->dcache_line_length, cpuinfo->dcache_size);
 
 #ifdef ASM_LOOP
-	CACHE_RANGE_LOOP_1(start, end, cpuinfo.dcache_line_length, wdc);
+	CACHE_RANGE_LOOP_1(start, end, cpuinfo->dcache_line_length, wdc);
 #else
-	for (i = start; i < end; i += cpuinfo.dcache_line_length)
+	for (i = start; i < end; i += cpuinfo->dcache_line_length)
 		__asm__ __volatile__ ("wdc	%0, r0;"	\
 				: : "r" (i));
 #endif
@@ -417,6 +435,8 @@ static void __invalidate_dcache_range_nomsr_wt(unsigned long start,
 static void __invalidate_dcache_range_msr_irq_wt(unsigned long start,
 							unsigned long end)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 	unsigned long flags;
 #ifndef ASM_LOOP
 	int i;
@@ -424,15 +444,15 @@ static void __invalidate_dcache_range_msr_irq_wt(unsigned long start,
 	pr_debug("%s: start 0x%x, end 0x%x\n", __func__,
 				(unsigned int)start, (unsigned int) end);
 	CACHE_LOOP_LIMITS(start, end,
-			cpuinfo.dcache_line_length, cpuinfo.dcache_size);
+			cpuinfo->dcache_line_length, cpuinfo->dcache_size);
 
 	local_irq_save(flags);
 	__disable_dcache_msr();
 
 #ifdef ASM_LOOP
-	CACHE_RANGE_LOOP_1(start, end, cpuinfo.dcache_line_length, wdc);
+	CACHE_RANGE_LOOP_1(start, end, cpuinfo->dcache_line_length, wdc);
 #else
-	for (i = start; i < end; i += cpuinfo.dcache_line_length)
+	for (i = start; i < end; i += cpuinfo->dcache_line_length)
 		__asm__ __volatile__ ("wdc	%0, r0;"	\
 				: : "r" (i));
 #endif
@@ -444,6 +464,8 @@ static void __invalidate_dcache_range_msr_irq_wt(unsigned long start,
 static void __invalidate_dcache_range_nomsr_irq(unsigned long start,
 							unsigned long end)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 	unsigned long flags;
 #ifndef ASM_LOOP
 	int i;
@@ -452,15 +474,15 @@ static void __invalidate_dcache_range_nomsr_irq(unsigned long start,
 				(unsigned int)start, (unsigned int) end);
 
 	CACHE_LOOP_LIMITS(start, end,
-			cpuinfo.dcache_line_length, cpuinfo.dcache_size);
+			cpuinfo->dcache_line_length, cpuinfo->dcache_size);
 
 	local_irq_save(flags);
 	__disable_dcache_nomsr();
 
 #ifdef ASM_LOOP
-	CACHE_RANGE_LOOP_1(start, end, cpuinfo.dcache_line_length, wdc);
+	CACHE_RANGE_LOOP_1(start, end, cpuinfo->dcache_line_length, wdc);
 #else
-	for (i = start; i < end; i += cpuinfo.dcache_line_length)
+	for (i = start; i < end; i += cpuinfo->dcache_line_length)
 		__asm__ __volatile__ ("wdc	%0, r0;"	\
 				: : "r" (i));
 #endif
@@ -471,23 +493,26 @@ static void __invalidate_dcache_range_nomsr_irq(unsigned long start,
 
 static void __flush_dcache_all_wb(void)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 #ifndef ASM_LOOP
 	int i;
 #endif
 	pr_debug("%s\n", __func__);
 #ifdef ASM_LOOP
-	CACHE_ALL_LOOP(cpuinfo.dcache_size, cpuinfo.dcache_line_length,
+	CACHE_ALL_LOOP(cpuinfo->dcache_size, cpuinfo->dcache_line_length,
 				wdc.flush);
 #else
-	for (i = 0; i < cpuinfo.dcache_size;
-		 i += cpuinfo.dcache_line_length)
-			__asm__ __volatile__ ("wdc.flush	%0, r0;" \
+	for (i = 0; i < cpuinfo->dcache_size; i += cpuinfo->dcache_line_length)
+		__asm__ __volatile__ ("wdc.flush	%0, r0;" \
 					: : "r" (i));
 #endif
 }
 
 static void __flush_dcache_range_wb(unsigned long start, unsigned long end)
 {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 #ifndef ASM_LOOP
 	int i;
 #endif
@@ -495,11 +520,11 @@ static void __flush_dcache_range_wb(unsigned long start, unsigned long end)
 				(unsigned int)start, (unsigned int) end);
 
 	CACHE_LOOP_LIMITS(start, end,
-			cpuinfo.dcache_line_length, cpuinfo.dcache_size);
+			cpuinfo->dcache_line_length, cpuinfo->dcache_size);
 #ifdef ASM_LOOP
-	CACHE_RANGE_LOOP_2(start, end, cpuinfo.dcache_line_length, wdc.flush);
+	CACHE_RANGE_LOOP_2(start, end, cpuinfo->dcache_line_length, wdc.flush);
 #else
-	for (i = start; i < end; i += cpuinfo.dcache_line_length)
+	for (i = start; i < end; i += cpuinfo->dcache_line_length)
 		__asm__ __volatile__ ("wdc.flush	%0, r0;"	\
 				: : "r" (i));
 #endif
@@ -608,16 +633,19 @@ static const struct scache wt_nomsr_noirq = {
 
 void microblaze_cache_init(void)
 {
-	if (cpuinfo.use_instr & PVR2_USE_MSR_INSTR) {
-		if (cpuinfo.dcache_wb) {
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
+
+	if (cpuinfo->use_instr & PVR2_USE_MSR_INSTR) {
+		if (cpuinfo->dcache_wb) {
 			pr_info("wb_msr\n");
 			mbc = (struct scache *)&wb_msr;
-			if (cpuinfo.ver_code <= CPUVER_7_20_D) {
+			if (cpuinfo->ver_code <= CPUVER_7_20_D) {
 				/* MS: problem with signal handling - hw bug */
 				pr_info("WB won't work properly\n");
 			}
 		} else {
-			if (cpuinfo.ver_code >= CPUVER_7_20_A) {
+			if (cpuinfo->ver_code >= CPUVER_7_20_A) {
 				pr_info("wt_msr_noirq\n");
 				mbc = (struct scache *)&wt_msr_noirq;
 			} else {
@@ -626,15 +654,15 @@ void microblaze_cache_init(void)
 			}
 		}
 	} else {
-		if (cpuinfo.dcache_wb) {
+		if (cpuinfo->dcache_wb) {
 			pr_info("wb_nomsr\n");
 			mbc = (struct scache *)&wb_nomsr;
-			if (cpuinfo.ver_code <= CPUVER_7_20_D) {
+			if (cpuinfo->ver_code <= CPUVER_7_20_D) {
 				/* MS: problem with signal handling - hw bug */
 				pr_info("WB won't work properly\n");
 			}
 		} else {
-			if (cpuinfo.ver_code >= CPUVER_7_20_A) {
+			if (cpuinfo->ver_code >= CPUVER_7_20_A) {
 				pr_info("wt_nomsr_noirq\n");
 				mbc = (struct scache *)&wt_nomsr_noirq;
 			} else {
diff --git a/arch/microblaze/kernel/cpu/cpuinfo.c b/arch/microblaze/kernel/cpu/cpuinfo.c
index cd9b4450763b..e2b87f136ba8 100644
--- a/arch/microblaze/kernel/cpu/cpuinfo.c
+++ b/arch/microblaze/kernel/cpu/cpuinfo.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2013-2020 Xilinx, Inc. All rights reserved.
  * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2007-2009 PetaLogix
  * Copyright (C) 2007 John Williams <john.williams@petalogix.com>
@@ -10,6 +11,7 @@
 
 #include <linux/clk.h>
 #include <linux/init.h>
+#include <linux/smp.h>
 #include <asm/cpuinfo.h>
 #include <asm/pvr.h>
 
@@ -56,7 +58,7 @@ const struct cpu_ver_key cpu_ver_lookup[] = {
 };
 
 /*
- * FIXME Not sure if the actual key is defined by Xilinx in the PVR
+ * The actual key is defined by Xilinx in the PVR
  */
 const struct family_string_key family_string_lookup[] = {
 	{"virtex2", 0x4},
@@ -85,37 +87,40 @@ const struct family_string_key family_string_lookup[] = {
 	{NULL, 0},
 };
 
-struct cpuinfo cpuinfo;
-static struct device_node *cpu;
+DEFINE_PER_CPU(struct cpuinfo, cpu_info);
 
 void __init setup_cpuinfo(void)
 {
-	cpu = of_get_cpu_node(0, NULL);
+	struct device_node *cpu;
+	unsigned int cpu_id = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu_id);
+
+	cpu = of_get_cpu_node(cpu_id, NULL);
 	if (!cpu)
 		pr_err("You don't have cpu or are missing cpu reg property!!!\n");
 
-	pr_info("%s: initialising\n", __func__);
+	pr_info("%s: initialising cpu %d\n", __func__, cpu_id);
 
 	switch (cpu_has_pvr()) {
 	case 0:
 		pr_warn("%s: No PVR support. Using static CPU info from FDT\n",
 			__func__);
-		set_cpuinfo_static(&cpuinfo, cpu);
+		set_cpuinfo_static(cpuinfo, cpu);
 		break;
 /* FIXME I found weird behavior with MB 7.00.a/b 7.10.a
  * please do not use FULL PVR with MMU */
 	case 1:
 		pr_info("%s: Using full CPU PVR support\n",
 			__func__);
-		set_cpuinfo_static(&cpuinfo, cpu);
-		set_cpuinfo_pvr_full(&cpuinfo, cpu);
+		set_cpuinfo_static(cpuinfo, cpu);
+		set_cpuinfo_pvr_full(cpuinfo, cpu);
 		break;
 	default:
 		pr_warn("%s: Unsupported PVR setting\n", __func__);
-		set_cpuinfo_static(&cpuinfo, cpu);
+		set_cpuinfo_static(cpuinfo, cpu);
 	}
 
-	if (cpuinfo.mmu_privins)
+	if (cpuinfo->mmu_privins)
 		pr_warn("%s: Stream instructions enabled"
 			" - USERSPACE CAN LOCK THIS KERNEL!\n", __func__);
 
@@ -125,17 +130,24 @@ void __init setup_cpuinfo(void)
 void __init setup_cpuinfo_clk(void)
 {
 	struct clk *clk;
+	struct device_node *cpu;
+	unsigned int cpu_id = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu_id);
+
+	cpu = of_get_cpu_node(cpu_id, NULL);
+	if (!cpu)
+		pr_err("You don't have cpu or are missing cpu reg property!!!\n");
 
 	clk = of_clk_get(cpu, 0);
 	if (IS_ERR(clk)) {
 		pr_err("ERROR: CPU CCF input clock not found\n");
 		/* take timebase-frequency from DTS */
-		cpuinfo.cpu_clock_freq = fcpu(cpu, "timebase-frequency");
+		cpuinfo->cpu_clock_freq = fcpu(cpu, "timebase-frequency");
 	} else {
-		cpuinfo.cpu_clock_freq = clk_get_rate(clk);
+		cpuinfo->cpu_clock_freq = clk_get_rate(clk);
 	}
 
-	if (!cpuinfo.cpu_clock_freq) {
+	if (!cpuinfo->cpu_clock_freq) {
 		pr_err("ERROR: CPU clock frequency not setup\n");
 		BUG();
 	}
diff --git a/arch/microblaze/kernel/cpu/mb.c b/arch/microblaze/kernel/cpu/mb.c
index 9581d194d9e4..7a6fc13f925a 100644
--- a/arch/microblaze/kernel/cpu/mb.c
+++ b/arch/microblaze/kernel/cpu/mb.c
@@ -1,6 +1,7 @@
 /*
  * CPU-version specific code
  *
+ * Copyright (C) 2013-2020 Xilinx, Inc. All rights reserved
  * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2006-2009 PetaLogix
  *
@@ -27,117 +28,135 @@
 
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
-	char *fpga_family = "Unknown";
-	char *cpu_ver = "Unknown";
-	int i;
-
-	/* Denormalised to get the fpga family string */
-	for (i = 0; family_string_lookup[i].s != NULL; i++) {
-		if (cpuinfo.fpga_family_code == family_string_lookup[i].k) {
-			fpga_family = (char *)family_string_lookup[i].s;
-			break;
+	unsigned int cpu;
+
+	for_each_online_cpu(cpu) {
+		struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
+		char *fpga_family = "Unknown";
+		char *cpu_ver = "Unknown";
+		int i;
+
+		/* Denormalised to get the fpga family string */
+		for (i = 0; family_string_lookup[i].s != NULL; i++) {
+			if (cpuinfo->fpga_family_code ==
+			    family_string_lookup[i].k) {
+				fpga_family = (char *)family_string_lookup[i].s;
+				break;
+			}
 		}
-	}
 
-	/* Denormalised to get the hw version string */
-	for (i = 0; cpu_ver_lookup[i].s != NULL; i++) {
-		if (cpuinfo.ver_code == cpu_ver_lookup[i].k) {
-			cpu_ver = (char *)cpu_ver_lookup[i].s;
-			break;
+		/* Denormalised to get the hw version string */
+		for (i = 0; cpu_ver_lookup[i].s != NULL; i++) {
+			if (cpuinfo->ver_code == cpu_ver_lookup[i].k) {
+				cpu_ver = (char *)cpu_ver_lookup[i].s;
+				break;
+			}
 		}
-	}
 
-	seq_printf(m,
-		   "CPU-Family:	MicroBlaze\n"
-		   "FPGA-Arch:	%s\n"
-		   "CPU-Ver:	%s, %s endian\n"
-		   "CPU-MHz:	%d.%02d\n"
-		   "BogoMips:	%lu.%02lu\n",
-		   fpga_family,
-		   cpu_ver,
-		   cpuinfo.endian ? "little" : "big",
-		   cpuinfo.cpu_clock_freq / 1000000,
-		   cpuinfo.cpu_clock_freq % 1000000,
-		   loops_per_jiffy / (500000 / HZ),
-		   (loops_per_jiffy / (5000 / HZ)) % 100);
-
-	seq_printf(m,
-		   "HW:\n Shift:\t\t%s\n"
-		   " MSR:\t\t%s\n"
-		   " PCMP:\t\t%s\n"
-		   " DIV:\t\t%s\n",
-		   (cpuinfo.use_instr & PVR0_USE_BARREL_MASK) ? "yes" : "no",
-		   (cpuinfo.use_instr & PVR2_USE_MSR_INSTR) ? "yes" : "no",
-		   (cpuinfo.use_instr & PVR2_USE_PCMP_INSTR) ? "yes" : "no",
-		   (cpuinfo.use_instr & PVR0_USE_DIV_MASK) ? "yes" : "no");
-
-	seq_printf(m, " MMU:\t\t%x\n", cpuinfo.mmu);
-
-	seq_printf(m,
-		   " MUL:\t\t%s\n"
-		   " FPU:\t\t%s\n",
-		   (cpuinfo.use_mult & PVR2_USE_MUL64_MASK) ? "v2" :
-		   (cpuinfo.use_mult & PVR0_USE_HW_MUL_MASK) ? "v1" : "no",
-		   (cpuinfo.use_fpu & PVR2_USE_FPU2_MASK) ? "v2" :
-		   (cpuinfo.use_fpu & PVR0_USE_FPU_MASK) ? "v1" : "no");
-
-	seq_printf(m,
-		   " Exc:\t\t%s%s%s%s%s%s%s%s\n",
-		   (cpuinfo.use_exc & PVR2_OPCODE_0x0_ILL_MASK) ? "op0x0 " : "",
-		   (cpuinfo.use_exc & PVR2_UNALIGNED_EXC_MASK) ? "unal " : "",
-		   (cpuinfo.use_exc & PVR2_ILL_OPCODE_EXC_MASK) ? "ill " : "",
-		   (cpuinfo.use_exc & PVR2_IOPB_BUS_EXC_MASK) ? "iopb " : "",
-		   (cpuinfo.use_exc & PVR2_DOPB_BUS_EXC_MASK) ? "dopb " : "",
-		   (cpuinfo.use_exc & PVR2_DIV_ZERO_EXC_MASK) ? "zero " : "",
-		   (cpuinfo.use_exc & PVR2_FPU_EXC_MASK) ? "fpu " : "",
-		   (cpuinfo.use_exc & PVR2_USE_FSL_EXC) ? "fsl " : "");
-
-	seq_printf(m,
-		   "Stream-insns:\t%sprivileged\n",
-		   cpuinfo.mmu_privins ? "un" : "");
-
-	if (cpuinfo.use_icache)
 		seq_printf(m,
-			   "Icache:\t\t%ukB\tline length:\t%dB\n",
-			   cpuinfo.icache_size >> 10,
-			   cpuinfo.icache_line_length);
-	else
-		seq_puts(m, "Icache:\t\tno\n");
+			"Processor:	%u\n"
+			"CPU-Family:	MicroBlaze\n"
+			"FPGA-Arch:	%s\n"
+			"CPU-Ver:	%s, %s endian\n"
+			"CPU-MHz:	%d.%02d\n"
+			"BogoMips:	%lu.%02lu\n",
+			cpu,
+			fpga_family,
+			cpu_ver,
+			cpuinfo->endian ? "little" : "big",
+			cpuinfo->cpu_clock_freq / 1000000,
+			cpuinfo->cpu_clock_freq % 1000000,
+			loops_per_jiffy / (500000 / HZ),
+			(loops_per_jiffy / (5000 / HZ)) % 100);
+
+		seq_printf(m,
+			"HW:\n Shift:\t\t%s\n"
+			" MSR:\t\t%s\n"
+			" PCMP:\t\t%s\n"
+			" DIV:\t\t%s\n",
+			(cpuinfo->use_instr & PVR0_USE_BARREL_MASK) ?
+			"yes" : "no",
+			(cpuinfo->use_instr & PVR2_USE_MSR_INSTR) ?
+			"yes" : "no",
+			(cpuinfo->use_instr & PVR2_USE_PCMP_INSTR) ?
+			"yes" : "no",
+			(cpuinfo->use_instr & PVR0_USE_DIV_MASK) ?
+			"yes" : "no");
+
+		seq_printf(m, " MMU:\t\t%x\n", cpuinfo->mmu);
+
+		seq_printf(m,
+			" MUL:\t\t%s\n"
+			" FPU:\t\t%s\n",
+			(cpuinfo->use_mult & PVR2_USE_MUL64_MASK) ? "v2" :
+			(cpuinfo->use_mult & PVR0_USE_HW_MUL_MASK) ?
+			"v1" : "no",
+			(cpuinfo->use_fpu & PVR2_USE_FPU2_MASK) ? "v2" :
+			(cpuinfo->use_fpu & PVR0_USE_FPU_MASK) ? "v1" : "no");
+
+		seq_printf(m,
+			" Exc:\t\t%s%s%s%s%s%s%s%s\n",
+			(cpuinfo->use_exc & PVR2_OPCODE_0x0_ILL_MASK) ?
+			"op0x0 " : "",
+			(cpuinfo->use_exc & PVR2_UNALIGNED_EXC_MASK) ?
+			"unal " : "",
+			(cpuinfo->use_exc & PVR2_ILL_OPCODE_EXC_MASK) ?
+			"ill " : "",
+			(cpuinfo->use_exc & PVR2_IOPB_BUS_EXC_MASK) ?
+			"iopb " : "",
+			(cpuinfo->use_exc & PVR2_DOPB_BUS_EXC_MASK) ?
+			"dopb " : "",
+			(cpuinfo->use_exc & PVR2_DIV_ZERO_EXC_MASK) ?
+			"zero " : "",
+			(cpuinfo->use_exc & PVR2_FPU_EXC_MASK) ? "fpu " : "",
+			(cpuinfo->use_exc & PVR2_USE_FSL_EXC) ? "fsl " : "");
 
-	if (cpuinfo.use_dcache) {
 		seq_printf(m,
-			   "Dcache:\t\t%ukB\tline length:\t%dB\n",
-			   cpuinfo.dcache_size >> 10,
-			   cpuinfo.dcache_line_length);
-		seq_puts(m, "Dcache-Policy:\t");
-		if (cpuinfo.dcache_wb)
-			seq_puts(m, "write-back\n");
+			"Stream-insns:\t%sprivileged\n",
+			cpuinfo->mmu_privins ? "un" : "");
+
+		if (cpuinfo->use_icache)
+			seq_printf(m,
+				"Icache:\t\t%ukB\tline length:\t%dB\n",
+				cpuinfo->icache_size >> 10,
+				cpuinfo->icache_line_length);
 		else
-			seq_puts(m, "write-through\n");
-	} else {
-		seq_puts(m, "Dcache:\t\tno\n");
-	}
+			seq_puts(m, "Icache:\t\tno\n");
+
+		if (cpuinfo->use_dcache) {
+			seq_printf(m,
+				"Dcache:\t\t%ukB\tline length:\t%dB\n",
+				cpuinfo->dcache_size >> 10,
+				cpuinfo->dcache_line_length);
+			seq_puts(m, "Dcache-Policy:\t");
+			if (cpuinfo->dcache_wb)
+				seq_puts(m, "write-back\n");
+			else
+				seq_puts(m, "write-through\n");
+		} else {
+			seq_puts(m, "Dcache:\t\tno\n");
+		}
 
-	seq_printf(m,
-		   "HW-Debug:\t%s\n",
-		   cpuinfo.hw_debug ? "yes" : "no");
+		seq_printf(m,
+			"HW-Debug:\t%s\n",
+			cpuinfo->hw_debug ? "yes" : "no");
 
-	seq_printf(m,
-		   "PVR-USR1:\t%02x\n"
-		   "PVR-USR2:\t%08x\n",
-		   cpuinfo.pvr_user1,
-		   cpuinfo.pvr_user2);
+		seq_printf(m,
+			"PVR-USR1:\t%02x\n"
+			"PVR-USR2:\t%08x\n",
+			cpuinfo->pvr_user1,
+			cpuinfo->pvr_user2);
 
-	seq_printf(m, "Page size:\t%lu\n", PAGE_SIZE);
+		seq_printf(m, "Page size:\t%lu\n", PAGE_SIZE);
+		seq_puts(m, "\n");
+	}
 
 	return 0;
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	int i = *pos;
-
-	return i < NR_CPUS ? (void *) (i + 1) : NULL;
+	return *pos < 1 ? (void *) 1 : NULL;
 }
 
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index 8c5f0c332d8b..ddccc2a29fbf 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -35,7 +35,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
  * I have to use dcache values because I can't relate on ram size:
  */
 #ifdef CONFIG_XILINX_UNCACHED_SHADOW
-#define UNCACHED_SHADOW_MASK (cpuinfo.dcache_high - cpuinfo.dcache_base + 1)
+#define UNCACHED_SHADOW_MASK (cpuinfo->dcache_high - cpuinfo->dcache_base + 1)
 #else
 #define UNCACHED_SHADOW_MASK 0
 #endif /* CONFIG_XILINX_UNCACHED_SHADOW */
@@ -43,9 +43,11 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 void *uncached_kernel_address(void *ptr)
 {
 	unsigned long addr = (unsigned long)ptr;
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 
 	addr |= UNCACHED_SHADOW_MASK;
-	if (addr > cpuinfo.dcache_base && addr < cpuinfo.dcache_high)
+	if (addr > cpuinfo->dcache_base && addr < cpuinfo->dcache_high)
 		pr_warn("ERROR: Your cache coherent area is CACHED!!!\n");
 	return (void *)addr;
 }
@@ -53,6 +55,8 @@ void *uncached_kernel_address(void *ptr)
 void *cached_kernel_address(void *ptr)
 {
 	unsigned long addr = (unsigned long)ptr;
+	unsigned int cpu = smp_processor_id();
+	struct cpuinfo *cpuinfo = per_cpu_ptr(&cpu_info, cpu);
 
 	return (void *)(addr & ~UNCACHED_SHADOW_MASK);
 }
-- 
2.25.0

