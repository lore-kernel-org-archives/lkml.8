Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D3AC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A548A20797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WF/ZjbSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgIEBRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 21:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgIEBRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 21:17:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32C5C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 18:17:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c15so1930198plq.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 18:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6m0dbKyQXxeXLEzMXpg1ctlvtrEkR+VkffHMyqwyVzk=;
        b=WF/ZjbSvfAnFulSMTnjvqvM9DeHHhYL3gq4V2UQTBh/KOkxGxFhnroWUztIlfK1saf
         q7TlVALn6ZbmB4L8/EpjFwEN8Mix3GNxBPWTLkST6ld58gXY6eeicawv4a2d0TwDg27I
         3tRAUoPpyCvpAxozykIYhItAU62gK8l3dyoqGHuTd4ZZMW6RnAx9LLTtkjfiQuEbECVx
         Yi1wXYcjBJSddZGLoRKGhPPvc2yBRyt2CqY8GjelWceU86MOvKNkeFlqeIpZAonuiWMD
         6f9nwfWui4Mt/cHJ0GSo6IFks/F9FjDyK+IiRaTo3o7D3FlZDARe2CbJHzhBlv5wzpAM
         XD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6m0dbKyQXxeXLEzMXpg1ctlvtrEkR+VkffHMyqwyVzk=;
        b=ovme6rWnlRWqvs9rqFUlOOFM2f14XhTU8NMcCe7HbJMJFSWTLfcdcYYXt5/c5+4+ak
         WUzX0WBQ/2+gPWo6ckRXm+1y2obzWGsYRUj7JiYBJ1K3ImaU0GHKvrfS2GnyUoY7wMUT
         CTykzDddze1b4h3pRM5ysHnUzghMMljORvUPtvy0VeD3gnXcyg1j1Do4PcBAJdg+dUG/
         C7G4l6FDHpZx/dxEfmlE7LEL78sQy+vOhQQ/MIsXMN9zHHjR2s6RljPRpDX5eUHH6CMO
         tAgMGLtFs/pQXTC+vRy7dQn0vboD53B21G+Z45vWFC+AmZfraFe8c7xtltacfE11aC8o
         knEQ==
X-Gm-Message-State: AOAM5330Z263+6g7h3Ea8pht+57UurvLRpsJHApgOEN3lHDPZyeBdkwF
        Itd+OSsYdCMbtA/5usgdrgOqDg==
X-Google-Smtp-Source: ABdhPJykmXEN6n39UTPlMwiMnIXK4xvARKqrLOwEKYSy06DZN/Fx1xgeBYR5M+l/xXsQYWYxP6/BXA==
X-Received: by 2002:a17:90a:e795:: with SMTP id iz21mr10377074pjb.8.1599268672105;
        Fri, 04 Sep 2020 18:17:52 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u22sm6401781pgi.85.2020.09.04.18.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 18:17:51 -0700 (PDT)
Date:   Fri, 04 Sep 2020 18:17:51 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Sep 2020 18:17:48 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Allow drivers to provide custom read_cycles64 for M-mode kernel
In-Reply-To: <20200904165709.GA32667@lst.de>
CC:     anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-5249e999-3e82-417d-8d39-dcb4a159bd83@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Sep 2020 09:57:09 PDT (-0700), Christoph Hellwig wrote:
> On Fri, Sep 04, 2020 at 10:13:18PM +0530, Anup Patel wrote:
>> I respectfully disagree. IMHO, the previous code made the RISC-V
>> timer driver convoluted (both SBI call and CLINT in one place) and
>> mandated CLINT for NoMMU kernel. In fact, RISC-V spec does not
>> mandate CLINT or PLIC. The RISC-V SOC vendors are free to
>> implement their own timer device, IPI device and interrupt controller.
>
> Yes, exactly what we need is everyone coming up with another stupid
> non-standard timer and irq driver.

Well, we don't have a standard one so there's really no way around people
coming up with their own.  It doesn't seem reasonable to just say "SiFive's
driver landed first, so we will accept no other timer drivers for RISC-V
systems".

> But the point is this crap came in after -rc1, and it adds totally
> pointless indirect calls to the IPI path, and with your "fix" also
> to get_cycles which all have exactly one implementation for MMU or
> NOMMU kernels.
>
> So the only sensible thing is to revert all this crap.  And if at some
> point we actually have to deal with different implementations do it
> with alternatives or static_branch infrastructure so that we don't
> pay the price for indirect calls in the super hot path.

I'm OK reverting the dynamic stuff, as I can buy it needs more time to bake,
but I'm not sure performance is the right argument -- while this is adding an
indirection, decoupling MMU/NOMMU from the timer driver is the first step
towards getting rid of the traps which are a way bigger performance issue than
the indirection (not to mention the issue of relying on instructions that don't
technically exist in the ISA we're relying on any more).

I'm not really convinced the timers are on such a hot path that an extra load
is that bad, but I don't have that much experience with this stuff so you may
be right.  I'd prefer to keep the driver separate, though, and just bring back
the direct CLINT implementation in timex.h -- we've only got one implementation
for now anyway, so it doesn't seem that bad to just inline it (and I suppose I
could buy that the ISA says this register has to behave this way, though I
don't think that's all that strong of an argument).

I'm not convinced this is a big performance hit for IPIs either, but we could
just do the same thing over there -- though I guess I'd be much less convinced
about any arguments as to the ISA having a say in that as IIRC it's a lot more
hands off.

Something like this seems to fix the rdtime issue without any extra overhead,
but I haven't tested it 

diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
new file mode 100644
index 000000000000..51909ab60ad0
--- /dev/null
+++ b/arch/riscv/include/asm/clint.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Google, Inc
+ */
+
+#ifndef _ASM_RISCV_CLINT_H
+#define _ASM_RISCV_CLINT_H
+
+#include <linux/types.h>
+#include <asm/mmio.h>
+
+#ifdef CONFIG_RISCV_M_MODE
+/*
+ * This lives in the CLINT driver, but is accessed directly by timex.h to avoid
+ * any overhead when accessing the MMIO timer.
+ */
+extern u64 __iomem *clint_time_val;
+#endif
+
+#endif
diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index a3fb85d505d4..7f659dda0032 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -10,6 +10,31 @@
 
 typedef unsigned long cycles_t;
 
+#ifdef CONFIG_RISCV_M_MODE
+
+#include <asm/clint.h>
+
+#ifdef CONFIG_64BIT
+static inline cycles_t get_cycles(void)
+{
+	return readq_relaxed(clint_time_val);
+}
+#else /* !CONFIG_64BIT */
+static inline u32 get_cycles(void)
+{
+	return readl_relaxed(((u32 *)clint_time_val));
+}
+#define get_cycles get_cycles
+
+static inline u32 get_cycles_hi(void)
+{
+	return readl_relaxed(((u32 *)clint_time_val) + 1);
+}
+#define get_cycles_hi get_cycles_hi
+#endif /* CONFIG_64BIT */
+
+#else /* CONFIG_RISCV_M_MODE */
+
 static inline cycles_t get_cycles(void)
 {
 	return csr_read(CSR_TIME);
@@ -41,6 +66,8 @@ static inline u64 get_cycles64(void)
 }
 #endif /* CONFIG_64BIT */
 
+#endif /* !CONFIG_RISCV_M_MODE */
+
 #define ARCH_HAS_READ_CURRENT_TIMER
 static inline int read_current_timer(unsigned long *timer_val)
 {
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 8eeafa82c03d..43ae0f885bfa 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -19,6 +19,11 @@
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
 #include <linux/smp.h>
+#include <linux/timex.h>
+
+#ifndef CONFIG_MMU
+#include <asm/clint.h>
+#endif
 
 #define CLINT_IPI_OFF		0
 #define CLINT_TIMER_CMP_OFF	0x4000
@@ -31,6 +36,10 @@ static u64 __iomem *clint_timer_val;
 static unsigned long clint_timer_freq;
 static unsigned int clint_timer_irq;
 
+#ifdef CONFIG_RISCV_M_MODE
+u64 __iomem *clint_time_val;
+#endif
+
 static void clint_send_ipi(const struct cpumask *target)
 {
 	unsigned int cpu;
@@ -184,6 +193,14 @@ static int __init clint_timer_init_dt(struct device_node *np)
 	clint_timer_val = base + CLINT_TIMER_VAL_OFF;
 	clint_timer_freq = riscv_timebase;
 
+#ifdef CONFIG_RISCV_M_MODE
+	/*
+	 * Yes, that's an odd naming scheme.  time_val is public, but hopefully
+	 * will die in favor of something cleaner.
+	 */
+	clint_time_val = clint_timer_val;
+#endif
+
 	pr_info("%pOFP: timer running at %ld Hz\n", np, clint_timer_freq);
 
 	rc = clocksource_register_hz(&clint_clocksource, clint_timer_freq);

