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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE03C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4C0222C2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruPt+BeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCAMWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 07:22:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38225 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgCAMWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 07:22:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id d6so3983308pgn.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 04:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=47sAR4RM+l9ifNugZ2XimQ03YrAvKZblQRJbV80CDnY=;
        b=ruPt+BeHg2jDq1DensdQVbCDxYLCujvm+38bs/wIJaYLsPFCjgUpPK8GJahHoxdAGR
         VpjHCSp2DqEbZywMrIA/nCN7aN7hbvl9f3cgwYkXSVUUFGiv1BcGDlPexH0uFRh6q+zA
         u8MnTwJhh1tT0yzLgUU4cKbYVPwtGAuS0Pr/4gmZiSr8WevwtonVb1dIJgoU/VW4uXsl
         coOWleJfxl4LXSLTLYEfFTWlJzNzgN4ibaNCHz8BoY9OVz+Z9ywodjTkXZOyMFbz/ISE
         OQaglJQukm+OXYVc9pG5uG3Cj3nXqr8THTgMQUgQ/5JHv1ZNf2pDMtM3IeQAuMprqD9K
         oFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=47sAR4RM+l9ifNugZ2XimQ03YrAvKZblQRJbV80CDnY=;
        b=ZswzzKYx8w8USz9Aw1FZ0dASYccAIq/QUit+enqhkpWc3TiALoqRK6PuBdmXcJ9Js5
         orx4ZxyOQMyxD+KchEazQXflWpicKEdxDoAUJGzDVrm1odfF2mIa4PT49LOipuYyyA24
         ulMnvzEGlRG3NAiE0j89DBM2H2wEIolHAQR7tizPqbv1OMtWJ5Sq/ORyaxCxx40i1NnJ
         7hEft9dG+7XCMWYefaQ5Bm2UD6lC7Xa5vx0Hrc30aHPq73p3zBObBjsoc2CvxsAGvXBg
         02/WQbhuxkMs+w+JFK2vEcl5sHjfKTNDT/mwHlGODg1heOYWszcQ0KRxhOUf5tHjpMxd
         mvjQ==
X-Gm-Message-State: APjAAAWU7Znjse7R83Qk0DahFVfFDZ9nth16m5XIMq4jB7YBzJKyJ4SK
        /VqYtFkvMqADWFp77ctOIBsZYNuX
X-Google-Smtp-Source: APXvYqwCHroCEmwoMdPYwteD6bOcMqgSO/kQohmjMZ0naPIRmxVQYvXIP5xnpZ3u/RJf/wqZ5twucA==
X-Received: by 2002:a63:1e44:: with SMTP id p4mr14268394pgm.367.1583065368821;
        Sun, 01 Mar 2020 04:22:48 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id q8sm8463118pje.2.2020.03.01.04.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 04:22:48 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH v3] ARM: mmp: replace setup_irq() by request_irq()
Date:   Sun,  1 Mar 2020 17:52:41 +0530
Message-Id: <20200301122243.4129-1-afzal.mohd.ma@gmail.com>
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

 arch/arm/mach-mmp/time.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index c65cfc1ad99b..049a65f47b42 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -175,13 +175,6 @@ static void __init timer_config(void)
 	__raw_writel(0x2, mmp_timer_base + TMR_CER);
 }
 
-static struct irqaction timer_irq = {
-	.name		= "timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= timer_interrupt,
-	.dev_id		= &ckevt,
-};
-
 void __init mmp_timer_init(int irq, unsigned long rate)
 {
 	timer_config();
@@ -190,7 +183,9 @@ void __init mmp_timer_init(int irq, unsigned long rate)
 
 	ckevt.cpumask = cpumask_of(0);
 
-	setup_irq(irq, &timer_irq);
+	if (request_irq(irq, timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			"timer", &ckevt))
+		pr_err("Failed to request irq %d (timer)\n", irq);
 
 	clocksource_register_hz(&cksrc, rate);
 	clockevents_config_and_register(&ckevt, rate, MIN_DELTA, MAX_DELTA);
-- 
2.25.1

