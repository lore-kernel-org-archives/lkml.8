Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3485BC35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5C72067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGRWBnzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgBXAwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:52:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35067 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgBXAwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:52:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so3341643plt.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 16:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EkJrYV9NW5v7JI25cfmTE4c1LpjI4vJZT80unhRKBzs=;
        b=gGRWBnzVl81llKsCV2p0eLp81Ky2WSG+mHk5aqBjScuwmIQ84JAuGD3AGopIQcKYn5
         J3WqCwmmSvvmFs+Q5qGsk/4+lCRnynq3jddYY6o9+kfnQHD/0RFMGjK3XYNpqnNpllOK
         tgKPOX2PmDNcAb58AIdCtGSQ1JFu23TZFNph07+3lHWfo1ik7uw5PNaNlI9RT8MqNfLR
         2cNNagtxFfjubRZan+lF86PpPYuHqyJ5GlFkUppesaTgHGfy1CgITBRMFjWmdmJcXFhV
         ol/PqlzcdArcfLybfUYLPRo4CJreWTqv1gYd+hcoiKGAPe2/Z9ZFGez50aQkuFGIUYx7
         Ze5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EkJrYV9NW5v7JI25cfmTE4c1LpjI4vJZT80unhRKBzs=;
        b=sEsbggsXEpcgraU5L2B5gngtp+R+i+ajJwpCmsl61Wb3iDWvrvbmWMVcspJvl1psR3
         ofdYYRBAp7Hcsq2fXz743GR99Qma0etPucJstMAprpdCuoe/M9koDL8eMvgWLWyTcA2W
         HxLN9HcJvOffZ14vbtiZbGeJo3g7FccpBZTlbJHcbHpaKjOB08hnv1ro2GGeuWTmbZiu
         ZtUDrUqPr57xoibR77VVPVeK4QgQqGYPrhUQ8HtLEFFo/5CgjLh63oZyhTKW4rgcA5sq
         TSetKzDWrt19flZk9j5L64eoWJyWqDjjf/bjZ67iFu4TAZdGSrBgYgi6vDL8bNJhf9Ly
         UByA==
X-Gm-Message-State: APjAAAWkPMmQnWL364uR57lHJJ+rghKsKNzAOJ3hZ77XASIzQrpiRLAj
        +0K8DjZGJZydMSTcfVfgQQY=
X-Google-Smtp-Source: APXvYqwMFsZ6y2WuHDmSZAgTtBCk/KeBgrabaZfwkjfzNfXg7N3IgRWwUN3Cq5IyrzYLnK5Lrx4PDw==
X-Received: by 2002:a17:90a:c708:: with SMTP id o8mr17656341pjt.104.1582505562717;
        Sun, 23 Feb 2020 16:52:42 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id k12sm8969578pgm.25.2020.02.23.16.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 16:52:42 -0800 (PST)
Date:   Mon, 24 Feb 2020 06:22:40 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v2 15/18] xtensa: replace setup_irq() by request_irq()
Message-ID: <79fac2f973605ac55fd1f5ab38f3afa20da07a84.1582471508.git.afzal.mohd.ma@gmail.com>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). The early boot setup_irq()
invocations happen either via 'init_IRQ()' or 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
---

v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/xtensa/kernel/smp.c  |  8 ++------
 arch/xtensa/kernel/time.c | 10 +++-------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 83b244ce61ee..b3f34030fa24 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -53,16 +53,12 @@ static void system_flush_invalidate_dcache_range(unsigned long start,
 #define IPI_IRQ	0
 
 static irqreturn_t ipi_interrupt(int irq, void *dev_id);
-static struct irqaction ipi_irqaction = {
-	.handler =	ipi_interrupt,
-	.flags =	IRQF_PERCPU,
-	.name =		"ipi",
-};
 
 void ipi_init(void)
 {
 	unsigned irq = irq_create_mapping(NULL, IPI_IRQ);
-	setup_irq(irq, &ipi_irqaction);
+	if (request_irq(irq, ipi_interrupt, IRQF_PERCPU, "ipi", NULL))
+		pr_err("%s: request_irq() failed\n", "ipi");
 }
 
 static inline unsigned int get_core_count(void)
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index 69db8c93c1f9..21d604af16b7 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -128,12 +128,6 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction timer_irqaction = {
-	.handler =	timer_interrupt,
-	.flags =	IRQF_TIMER,
-	.name =		"timer",
-};
-
 void local_timer_setup(unsigned cpu)
 {
 	struct ccount_timer *timer = &per_cpu(ccount_timer, cpu);
@@ -199,7 +193,9 @@ void __init time_init(void)
 	     __func__);
 	clocksource_register_hz(&ccount_clocksource, ccount_freq);
 	local_timer_setup(0);
-	setup_irq(this_cpu_ptr(&ccount_timer)->evt.irq, &timer_irqaction);
+	if (request_irq(this_cpu_ptr(&ccount_timer)->evt.irq, timer_interrupt,
+			IRQF_TIMER, "timer", NULL))
+		pr_err("%s: request_irq() failed\n", "timer");
 	sched_clock_register(ccount_sched_clock_read, 32, ccount_freq);
 	timer_probe();
 }
-- 
2.25.1

