Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD53C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5CE20661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA394d5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgBLIDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:03:09 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36930 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgBLIDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:03:08 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so543210pjb.2;
        Wed, 12 Feb 2020 00:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=js3m1GRJWAzwHRVNbuv8Yo8F0b3Y/0tD1p72T0JsIgY=;
        b=iA394d5UYe1aB937cb4A8d6BIgNag9uRRjNEHG3KXbE83HUYelShMerBc/GzaJOTww
         UH0MjxzHm30XlYL4X1//xmuWvii0HglyFyf+4G4H0iMEaS/SMz+AsyOMCckoGeZhr79i
         gsp9h84e42oCD3ZkG0LlYTkpQwv7tbl9FTMxIs4eSRFVPpC2yIDmT/KQewIOC+7rdiOJ
         VikWfWXRy7xU4XxWt8rgKNZe5YTNzHZ1FCppNwBqvW0HVr4EypvkxIgiPIx1gLDD+KlM
         DL+AvKcBeI4MnD4VszncCPsOwMN2GMxaxMZFuf8WHdIHc5zilrXJoyVzTzNEvcGLBIWh
         PrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=js3m1GRJWAzwHRVNbuv8Yo8F0b3Y/0tD1p72T0JsIgY=;
        b=Jifaf+fGnJ1vOUHDckTq/3/mIUAAsLTkoH3Yf7L1zxagVjK4y/Z7HJVh7eT9Viy6fy
         9fZ4GEUNcnLQzEYaH/aJR8NSN8iNEmPxEPfwdsPqNAJto/xv+raxeaqj/abBuVciSpQo
         v4KRAFoM7GI0yvz343KANROUac0h5T2p+GIazZrWUsipqVkv+Ldj/LkpdRx16Y2wKBnm
         /hFTQdaeYkvK4MhwMiCLzuVCt2/Pq/mGxqpjfff2A+tJTQdToidccmtX24Cbw65Wq57N
         PqVZWVQ1UJWjs/QqGnV05/aUhkPfxFMLrRghmxHGBK37pNICKnW/32+zAZEh+b8zeYI6
         9EKA==
X-Gm-Message-State: APjAAAVT9Qvhgzp66qUkKh+b9eftlwcLttXm3BB6QzNDYaZfstO/wBV1
        h4ArBk6BK5/fSU1q7u/Nc+0eZPpkvrU=
X-Google-Smtp-Source: APXvYqzhrJqK3cUZLDf9NYaZXHHZh0Zrx3XTbMqJ99mNoT6S/alMlR3WJsFglJQlG8aCPK73hmBc2g==
X-Received: by 2002:a17:902:503:: with SMTP id 3mr7382210plf.78.1581494588006;
        Wed, 12 Feb 2020 00:03:08 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id c6sm6653064pgk.78.2020.02.12.00.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:03:07 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:33:05 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Brian Cain <bcain@codeaurora.org>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>
Subject: [PATCH 04/18] hexagon: replace setup_irq() by request_irq()
Message-ID: <0413a7d89e648c6259b466b07b635a4509cdefd5.1581478324.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Existing callers of
setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Since cc'ing cover letter to all maintainers/reviewers would be too
many, refer for cover letter,
 https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

 arch/hexagon/kernel/smp.c  | 17 ++++++++---------
 arch/hexagon/kernel/time.c | 11 +++--------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 0bbbe652a513..50a75af5540b 100644
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
+		pr_err("request_irq() on %s failed\n", "ipi_handler");
 
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
+			pr_err("request_irq() on %s failed\n", "ipi_handler");
+	}
 }
 
 void smp_send_reschedule(int cpu)
diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
index f99e9257bed4..f5a558a9d287 100644
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
+		pr_err("request_irq() on %s failed\n", "rtos_timer");
 }
 
 void __init time_init(void)
-- 
2.24.1

