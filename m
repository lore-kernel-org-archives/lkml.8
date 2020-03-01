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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01190C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C913C222C4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1xoBje+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgCAMWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 07:22:01 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54399 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgCAMWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 07:22:01 -0500
Received: by mail-pj1-f66.google.com with SMTP id dw13so3214767pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 04:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9cIS9wI0z/ly272acO4wuXYRhTq0u593vlOIO8zfEwQ=;
        b=J1xoBje+Kv+ieI2iI8o2Qh4gAtjEIRvTDeYBaJ/Dh2ZXyPrcDZoYJqcqd4hJRmKP2h
         qDro6FnOJFAxIGt1A9SziQoamobw/g1oRljc4Ypt9BlAp1MJIc3HFPq8eMbA7fOmwy+B
         DqiTiiHtfMMaUpQVsUFdPm8EPB0XMhuN2ZycFtvP96nAjoBdfsNAnUiTIgGCy6Oo/Hsk
         rBCEgV7qTEwEo2TO1Tidn4l1bvd4B+RBkbNKMaZ9AhsJ3g/3s3L4jmR+1TBh0rVzsdhl
         SnbJl8s+b1wGrjtBSKp7WXrxcLnZszLT7wDV8GY4ECjxq4OpDpM014urhhdGuw83CKe1
         0fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9cIS9wI0z/ly272acO4wuXYRhTq0u593vlOIO8zfEwQ=;
        b=HkJ6wgKyynNrr6XX9U492He3hf0dNKCtgbE9DzlFbJghtGZCftABLZq3oW+lBqcaId
         uRW8fAtW/wRhqvTZKrpU/hlVqID7ieB/gOSAINt4RFyOfTC3IbifdK/ezXdVPomgqu7H
         gFglaiEbYvKmObJkCSqxneWzt0cFUSnRz6UhAXUnzPmAtaw5wPq9TSZwubNZrgLsdNx2
         iirRihlLwX3gX22lIlF9QFeHHd7GszA66GCOMlvQk2GI9Am56DtmkBtF41ectc22+Joy
         fdwaTJ8i8BSXN/twi896TAIJafvg89ZpbqZq1oWKBCtsm5+1wAJheHDF4/fwnRa8MxHI
         fd3g==
X-Gm-Message-State: APjAAAWHwhyoDRMpQB6r3sPKgqbExYBdHfy2M9FwxZ+1B29nzZ5vZ3Uc
        k5W9lIsOXsvIIpqLXJwzHP8=
X-Google-Smtp-Source: APXvYqzQ7LSePL09cmdsNNGSRe3otnppD5HDry8uOivFlQnPHuYZM3uBcbGiBjIjHFC1YfNG4s0fEw==
X-Received: by 2002:a17:902:8a83:: with SMTP id p3mr13595862plo.56.1583065320065;
        Sun, 01 Mar 2020 04:22:00 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id d77sm4081997pfd.109.2020.03.01.04.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 04:21:59 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH v3] ARM: cns3xxx: replace setup_irq() by request_irq()
Date:   Sun,  1 Mar 2020 17:51:55 +0530
Message-Id: <20200301122155.3957-1-afzal.mohd.ma@gmail.com>
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

 arch/arm/mach-cns3xxx/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 1d61a7701c11..e4f4b20b83a2 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -189,12 +189,6 @@ static irqreturn_t cns3xxx_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction cns3xxx_timer_irq = {
-	.name		= "timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= cns3xxx_timer_interrupt,
-};
-
 /*
  * Set up the clock source and clock events devices
  */
@@ -245,7 +239,9 @@ static void __init __cns3xxx_timer_init(unsigned int timer_irq)
 	writel(val, cns3xxx_tmr1 + TIMER1_2_CONTROL_OFFSET);
 
 	/* Make irqs happen for the system timer */
-	setup_irq(timer_irq, &cns3xxx_timer_irq);
+	if (request_irq(timer_irq, cns3xxx_timer_interrupt,
+			IRQF_TIMER | IRQF_IRQPOLL, "timer", NULL))
+		pr_err("Failed to request irq %d (timer)\n", timer_irq);
 
 	cns3xxx_clockevents_init(timer_irq);
 }
-- 
2.25.1

