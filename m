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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0174FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CC9222C4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vkkolzdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgCAMXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 07:23:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47009 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCAMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 07:23:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so3060512pll.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 04:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ewaZEUklPCqTGahCa9RshiNF9Igtxf0iAmKwAeMUoo8=;
        b=VkkolzdblZoL+viE7Lu2cuU7bztOqRr1iGoo4D48IN8NrWYfkEl/pAxiQxuGz/B49J
         5s3K7COXyP3Y6xRI2x1K3vfQrvEwGEHji9Bt+dzefPRWm3Dil/UIGv+5RW3LhY7asQQc
         mwyVmnGF0QLPwKhOcfpBosekIfgt8vmWZAaIJq9O03es3q6N9EjFBxSgtm6TL5aybj3f
         wYr35PN/yU2DaGMrM08+nreSgL6CoB1BANeDIK5hF8KREJJ7iGkITQaeUjG8DxiYg/LH
         ADgpGrLf49QBnkTm+KzXfKZqF2Qp1RaMpkqEN7gGiF/od7cWV0Mb2OMe35RxVhD71D6M
         WPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ewaZEUklPCqTGahCa9RshiNF9Igtxf0iAmKwAeMUoo8=;
        b=UXVn2qKt+hhubdZj89Qjy/o8obKeUsz1B4333Z72ZsKvNxJKAJZFNVu1WLup1YKYtf
         rUYtJTnMCWjZJxVAnkjZhNoqx9/zltp86rXSBWeBqsugJYwLbZwNMUDz7GdF+N2N955d
         6s1g3/1aKggnZFpLA2656LZfw/7bdjRnb9MhnVXI1+h/xYiCccNFu/MD+KMCiJg17Gv1
         /NWGMDUimRhPSis+5qAPMmkSrbmIsu48IWXTZCx3acaoqYxD56meZNExLyfyNTwu+VaZ
         wUX56/TtouR6ERXlgE2QB+BBMmBLgK194+Utz9vwVDk0V/OJbhStkCL2cNrKmqFTE0gQ
         aioA==
X-Gm-Message-State: APjAAAU1qsiTnP0wCWLmvJiFUlO7pEhpyO1q2a0v288hM8eKjdqP1ZFU
        1hJcuIsjrfbtOxFQs+YKLn9sGx1W
X-Google-Smtp-Source: APXvYqydsSedEMUYW+topsgYcenMqVp/QVRnBO4ynDxScEYQ1+a4GyUt2RwiOz/ifl1Tybko7hwsOQ==
X-Received: by 2002:a17:90a:858c:: with SMTP id m12mr14473757pjn.127.1583065401367;
        Sun, 01 Mar 2020 04:23:21 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id c184sm17352878pfa.39.2020.03.01.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 04:23:20 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH v3] ARM: spear: replace setup_irq() by request_irq()
Date:   Sun,  1 Mar 2020 17:53:15 +0530
Message-Id: <20200301122315.4240-1-afzal.mohd.ma@gmail.com>
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

 arch/arm/mach-spear/time.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index 289e036c9c30..d1fdb6066f7b 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -181,12 +181,6 @@ static irqreturn_t spear_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction spear_timer_irq = {
-	.name = "timer",
-	.flags = IRQF_TIMER,
-	.handler = spear_timer_interrupt
-};
-
 static void __init spear_clockevent_init(int irq)
 {
 	u32 tick_rate;
@@ -201,7 +195,8 @@ static void __init spear_clockevent_init(int irq)
 
 	clockevents_config_and_register(&clkevt, tick_rate, 3, 0xfff0);
 
-	setup_irq(irq, &spear_timer_irq);
+	if (request_irq(irq, spear_timer_interrupt, IRQF_TIMER, "timer", NULL))
+		pr_err("Failed to request irq %d (timer)\n", irq);
 }
 
 static const struct of_device_id timer_of_match[] __initconst = {
-- 
2.25.1

