Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9602BC3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674E220880
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHa2iPWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCAMWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 07:22:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46986 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgCAMWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 07:22:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so3060113pll.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 04:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8DnSngTmvzsd65+fjVgdabNJJWbP31CoAeIiDzwcTxc=;
        b=SHa2iPWW/niSpSf3cfP6JGgRIP6IKYAiwhBfSzd9Z9BnleNtOAbzXQw0wzgQAVAuXQ
         8YP7h2g8CZoRyyC+lkV7bbo0aHCSrbxMFQh1t6Y85L0cL0Vku17MsNMnlnlV7Sp7yg+C
         iAB7onY4u+HNEMgDzInde3O8y5wr36OsOqzjtRtvITPAowj/lmKB48qVN1GCBtlEzAKz
         BbmdMlb1lZM4o74oB+n6E4BUzpw9twyNsV85cT8xDggchIq5wCls46jYxfLbhT0N9gq6
         4nk3OPAUueQc23ZwGYnxvptPPFYQAMkOK6WmLnkUqryiPToQ6PT8W+rq00sIfdpWStWB
         84Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8DnSngTmvzsd65+fjVgdabNJJWbP31CoAeIiDzwcTxc=;
        b=O02GMxMAlEPthgZaDbSdwHlMB6h6X1X+R2ZuGNP3YHvJmP1HOqvG9r1HcXCVIQRj/q
         aSu3XI8xMb3v8x2KH53wXCRfM0o88cjP52ABzT/2RZSWk20WnCd42FF1G2nuBDoAn4Tg
         /CWthIhTY5jVOVa5JCloxQnhwttAztXSa31xxUvUivzEiEDAu00zthhmh5KkPI6ktxTU
         U2jW0iO33tH7QLSjINCf/M5DjY4dGy6VUeFapteLYgpGbek85n8rgUDO94oGSeiCh6xe
         udtLlOItXTQAywo+lm/LfAeUK0c88rJC4ZH0uD7wTK78pAI+Ot/BsEzgdX5+1c9dB104
         LILg==
X-Gm-Message-State: ANhLgQ1x0kKHIgVY2eDoqH+RJFbHAzds/UySels15zfqJWJZph+UByWN
        DpVj/S79l5SZdisCs5Tcqw4=
X-Google-Smtp-Source: ADFU+vtgZDqLq8qgq7cBmuez/0NVgFMd37RvN5fOD22JK6zkTlXJaygnGb4FycXfbqiHgJRos3bonA==
X-Received: by 2002:a17:90a:8d03:: with SMTP id c3mr6978240pjo.7.1583065351992;
        Sun, 01 Mar 2020 04:22:31 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id z10sm16519219pgf.35.2020.03.01.04.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 04:22:31 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH v3] ARM: iop32x: replace setup_irq() by request_irq()
Date:   Sun,  1 Mar 2020 17:52:20 +0530
Message-Id: <20200301122226.4068-1-afzal.mohd.ma@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
Hi sub-arch maintainers,

If the patch is okay, please take it thr' your tree.

Regards
afzal

v3:
 * Split out from series, also split out from ARM patch to subarch level
	as Thomas suggested to take it thr' respective maintainers
 * Modify string displayed in case of error as suggested by Thomas
 * Re-arrange code as required to improve readability
 * Remove irrelevant parts from commit message & improve
 
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/arm/mach-iop32x/time.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-iop32x/time.c b/arch/arm/mach-iop32x/time.c
index 18a4df5c1baa..ae533b66fefd 100644
--- a/arch/arm/mach-iop32x/time.c
+++ b/arch/arm/mach-iop32x/time.c
@@ -137,13 +137,6 @@ iop_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction iop_timer_irq = {
-	.name		= "IOP Timer Tick",
-	.handler	= iop_timer_interrupt,
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.dev_id		= &iop_clockevent,
-};
-
 static unsigned long iop_tick_rate;
 unsigned long get_iop_tick_rate(void)
 {
@@ -154,6 +147,7 @@ EXPORT_SYMBOL(get_iop_tick_rate);
 void __init iop_init_time(unsigned long tick_rate)
 {
 	u32 timer_ctl;
+	int irq = IRQ_IOP32X_TIMER0;
 
 	sched_clock_register(iop_read_sched_clock, 32, tick_rate);
 
@@ -168,7 +162,9 @@ void __init iop_init_time(unsigned long tick_rate)
 	 */
 	write_tmr0(timer_ctl & ~IOP_TMR_EN);
 	write_tisr(1);
-	setup_irq(IRQ_IOP32X_TIMER0, &iop_timer_irq);
+	if (request_irq(irq, iop_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			"IOP Timer Tick", &iop_clockevent))
+		pr_err("Failed to request irq() %d (IOP Timer Tick)\n", irq);
 	iop_clockevent.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&iop_clockevent, tick_rate,
 					0xf, 0xfffffffe);
-- 
2.25.1

