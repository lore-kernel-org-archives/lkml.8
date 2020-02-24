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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D287C35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41532206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/7+FoB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgBXAti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:49:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34966 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgBXAth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:49:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so3338908plt.2;
        Sun, 23 Feb 2020 16:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Meowi5DfMOFxxX4xOwtpguRWIG7M6enGckZnIU74nGo=;
        b=W/7+FoB+ozkb+Xyyu4fSfdCAdsMwfsUrHmvM+zIYWkrC4IDkacHAv5yJjhxw8eGbHM
         K5zmd2tsZ08+yz4hXj+t1SrUrpYWok5Hehs29Fz2y8KASRqHGUnVIFRN/iHcUH3bougI
         ME62u7PNQFHIMrcxB8YPUf1ctok/reiQZ6qKxXSOUJ7YPvfAUHR49P2t1E3OPUwh5pX8
         JgqwSSB+JyvlSC+8TDPyj2JpVR0aah6/fkKqo9563ICz3Ii436VD/3yS3FwUxGeFzAdS
         V0U4cLpZ6qN6UwvgVNSJ8JLZIDHBtuJvhRRqz6AUCbL5kpUaWl8uE5GZOmC8oN02y3FT
         JUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Meowi5DfMOFxxX4xOwtpguRWIG7M6enGckZnIU74nGo=;
        b=ZI6hNGNsMZ2ptmHBcQd6eJvqCFg8q9Y8cz5ovdof4QjuoZpkT3MmziEQu4qqpJKzdo
         lTSZcIIXLSNGbfeKKRzZFm4Pdy9PtNvrxJu/ztuF7GP36w52W+mI0K6tqHS+NSlTJ5Lz
         N/hPoqPxtDvQY+HF4Es7SCrcrcjoETPebcaOKAUQyV19mKy6j0T3wD2lxXlnluTDb0X3
         TI9YZNHQaQ8H/PH0vEneqmRCa4cYFThq9bSgtEZ/QlGJUsOM7n8VRhhsBjapzAiVQT7F
         iwZSUyoBo20vNdDzpgRxpC00/mKaMAJ9KEd5dOERUjSO3fvTraL5Dk+T10hHKBuDdJgn
         kN3g==
X-Gm-Message-State: APjAAAWYCXwi4hdHm3mN/JkoTCJHy2to77e+JXoGmIfhnKkehjcEbwST
        oB997NFrhuVBrdT7l0FEPsLNIbPVhA8=
X-Google-Smtp-Source: APXvYqxJuhp+NjLXk/V2SFRgmnc6mX+B5KA2khn1FT6uE3njP24qOzgfQ0B3aPcDoXNOLUsRyCUTgA==
X-Received: by 2002:a17:902:8a81:: with SMTP id p1mr47501862plo.284.1582505376985;
        Sun, 23 Feb 2020 16:49:36 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id 70sm10063367pfw.140.2020.02.23.16.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 16:49:36 -0800 (PST)
Date:   Mon, 24 Feb 2020 06:19:35 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Brian Cain <bcain@codeaurora.org>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>
Subject: [PATCH v2 04/18] hexagon: replace setup_irq() by request_irq()
Message-ID: <44775ff418e0b784311c1d86aae4927da7fcc645.1582471508.git.afzal.mohd.ma@gmail.com>
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
---

v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/hexagon/kernel/smp.c  | 17 ++++++++---------
 arch/hexagon/kernel/time.c | 11 +++--------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 0bbbe652a513..67f4b0bff250 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -114,12 +114,6 @@ void send_ipi(const struct cpumask *cpumask, enum ipi_message_type msg)
 	local_irq_restore(flags);
 }
 
-static struct irqaction ipi_intdesc = {
-	.handler = handle_ipi,
-	.flags = IRQF_TRIGGER_RISING,
-	.name = "ipi_handler"
-};
-
 void __init smp_prepare_boot_cpu(void)
 {
 }
@@ -155,7 +149,9 @@ void start_secondary(void)
 
 	cpu = smp_processor_id();
 
-	setup_irq(BASE_IPI_IRQ + cpu, &ipi_intdesc);
+	if (request_irq(BASE_IPI_IRQ + cpu, handle_ipi, IRQF_TRIGGER_RISING,
+			"ipi_handler", NULL))
+		pr_err("%s: request_irq() failed\n", "ipi_handler");
 
 	/*  Register the clock_event dummy  */
 	setup_percpu_clockdev();
@@ -213,8 +209,11 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		set_cpu_present(i, true);
 
 	/*  Also need to register the interrupts for IPI  */
-	if (max_cpus > 1)
-		setup_irq(BASE_IPI_IRQ, &ipi_intdesc);
+	if (max_cpus > 1) {
+		if (request_irq(BASE_IPI_IRQ, handle_ipi, IRQF_TRIGGER_RISING,
+				"ipi_handler", NULL))
+			pr_err("%s: request_irq() failed\n", "ipi_handler");
+	}
 }
 
 void smp_send_reschedule(int cpu)
diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
index f99e9257bed4..26550e46cf91 100644
--- a/arch/hexagon/kernel/time.c
+++ b/arch/hexagon/kernel/time.c
@@ -143,13 +143,6 @@ static irqreturn_t timer_interrupt(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-/*  This should also be pulled from devtree  */
-static struct irqaction rtos_timer_intdesc = {
-	.handler = timer_interrupt,
-	.flags = IRQF_TIMER | IRQF_TRIGGER_RISING,
-	.name = "rtos_timer"
-};
-
 /*
  * time_init_deferred - called by start_kernel to set up timer/clock source
  *
@@ -195,7 +188,9 @@ void __init time_init_deferred(void)
 #endif
 
 	clockevents_register_device(ce_dev);
-	setup_irq(ce_dev->irq, &rtos_timer_intdesc);
+	if (request_irq(ce_dev->irq, timer_interrupt,
+			IRQF_TIMER | IRQF_TRIGGER_RISING, "rtos_timer", NULL))
+		pr_err("%s: request_irq() failed\n", "rtos_timer");
 }
 
 void __init time_init(void)
-- 
2.25.1

