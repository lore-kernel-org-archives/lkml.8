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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FB8C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF2720661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2rWZgdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgBLIFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:05:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43941 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgBLIF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:05:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id s1so829620pfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7cVJrf+4rXD3RIvKPMDPkxaYFB3IsTOj78t7ZIWn1gM=;
        b=b2rWZgdTS+HavWtrTjLQrHTONKBSuIgdXx6mgRc1+KE2M2+sTlKIfE+pEP2oUglRjA
         SqSCImuVddgreHZII0cvxRG7LSH6Gid0BMel/HQhdaD2HOap8nFJRotmzz8mNWGki35E
         0F/ndCza8rBC7MrfxMuXoTfPE2vBsg/LmSkh3/QI4DhvEG01cdCLb/Qw4hrz+46py+bQ
         rmo+mAVXPUixKaVaBlTQWhz/+e6lPA13o9eRNtBd8rw0JXi0NF45w/seYrG+MdOjfw48
         pZAuXpzo7SoqK42Hzj8oRkGpN9kt3rgf269kbkiF5aLrlIxHFdq9eul+GVUOSIA9ZJPu
         8ULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7cVJrf+4rXD3RIvKPMDPkxaYFB3IsTOj78t7ZIWn1gM=;
        b=aW1Ya8oVPBmptsv9+eIvRZXXiWRiA85sx8Ilr3XJ2pKjDrBKBbISTeprrBigbmBH7p
         /X9rJbdcF49TEcg/6zKCHu1Z7pisn/AunzuvhOAw8Vy+tBM/IL2rFY2X9MfuI/RQpl6D
         S2sA3M4AtIc2VKIF6WHE7c8sPl7WXU5EGAaP2e/zQAcVBu8dR/6CmJuPAwj5tSg3X2OA
         b6ifQsd6ErA4ymztyoe/EdH2TMZujlRVXvYQEYP85vG0ABcvfApS6xgSzEGQ/ZMox61U
         wsd1hnZcgOEyYmB1v+Z6vPBfBl++SYMDiMi7IOVgi7mHudWGgdKk0QnhEd8uhjWfAhgC
         p2pg==
X-Gm-Message-State: APjAAAVDnbUn1qm1gVxMiSsJ/4nize77+59tD6DbRQ1NhilTudscOVLB
        v2RPdIg3/MbVqLDXG/PAlRE=
X-Google-Smtp-Source: APXvYqwoSIuklDxB/zT59bsO9z7KoWjif6ryTXMbCWHhiwrIZ5TNoyZqviTrUKNsMR4xuvFo+evjdQ==
X-Received: by 2002:a63:d04c:: with SMTP id s12mr11239449pgi.105.1581494728515;
        Wed, 12 Feb 2020 00:05:28 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id o10sm6508939pgq.68.2020.02.12.00.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:05:28 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:35:26 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH 15/18] xtensa: replace setup_irq() by request_irq()
Message-ID: <85574e1ae1e6870ef01b6e61c5b1c5f393c2ac4b.1581478324.git.afzal.mohd.ma@gmail.com>
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

 arch/xtensa/kernel/smp.c  |  8 ++------
 arch/xtensa/kernel/time.c | 10 +++-------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 83b244ce61ee..22a117ca0c4d 100644
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
+		pr_err("request_irq() on %s failed\n", "ipi");
 }
 
 static inline unsigned int get_core_count(void)
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index 69db8c93c1f9..cd7651c603d2 100644
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
+		pr_err("request_irq() on %s failed\n", "timer");
 	sched_clock_register(ccount_sched_clock_read, 32, ccount_freq);
 	timer_probe();
 }
-- 
2.24.1

