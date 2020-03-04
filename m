Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6232C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7128A206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ9loETb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbgCDAvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:51:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35198 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgCDAvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:51:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so216247plt.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 16:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hdzrj+/0GITywXuqmE/BdYb83L3PaarC8FVVq9YBCQ0=;
        b=nQ9loETbwYkZsls1MC3RvN7uX1q1IzFiennt9Ym3kn9J6/goAM0oF3/PFqPlyWDLuU
         QgUi62rKTuk4ksZUExIuLtdlF9tljpl+iOl+DPJD8kNRjahO2orbds1hSiLRMft+2oxR
         iKZ41MvJY4pWf4P6uSe2Vgpbya7fXpwYmPuQiyX7I3XZ+iy2NCN1mz4d4jjAGCmaBsNg
         h81zbF5+uWob837zVQtqKMRRpnLb8gQ6bogXahHMMQhlM8Xz8ZVwlQlAQgI1Sgg4C9AU
         7xHoCoWYACNASstCAagbNQhXdcvkcf0UfrAmvoANGP0tu0eIBu0yv4mt71BNI+QKIOwa
         00dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hdzrj+/0GITywXuqmE/BdYb83L3PaarC8FVVq9YBCQ0=;
        b=IAUEl1APwiwVIg+wrE7+ofkjU7wHDtAcdo+Ct2tHgiovyT8LZW8BBwfXHMm6bzWAJN
         euk2WJprlv/OA1oUuiI0+u4N/xcCiQrRRbecR24yAqHR0iezS+2JRZAdoQmAYyutkXAv
         E6zO89nibZ3LHiiZd/GquNX10sNYN50eaGoqOE9ANRKoBNKMhAyCrk5P30OraIFyVT++
         4B5FSRbmn4KDenoeFXG3GP1Awla7VleNMAR2LqtDZfqbyvdjvSl2C0cibmNgkRMsggxF
         Kqoi9wW1NjLIYUfLqbUW0IRusXHLf9SGLGz0NepMM4T6YFg3DiGcR4Bw5e8BKoMuyojh
         ISWA==
X-Gm-Message-State: ANhLgQ38eeDViRPZl/YETGba8/ViYp7WvMzPO+ycxGDBTrbVvlL2xtrw
        fdVjAfiP9///sSfZcqJqDONHBKyT
X-Google-Smtp-Source: ADFU+vvJDgMWNu9bgTzRwQTN+fDW5ypQ9GiIe+KfQ+Ir55EGKUagQrAYcxbjtV+nXrF3yDFktfikFw==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr273787pjq.5.1583283101850;
        Tue, 03 Mar 2020 16:51:41 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id 188sm1640585pfx.47.2020.03.03.16.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 16:51:41 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH v3] unicore32: replace setup_irq() by request_irq()
Date:   Wed,  4 Mar 2020 06:21:37 +0530
Message-Id: <20200304005137.5523-1-afzal.mohd.ma@gmail.com>
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
Hi unicorn maintainers,

if okay w/ this change, please consider taking it thr' your tree, else please
let me know.

Regards
afzal

Link to v2 & v1,
[v2] https://lkml.kernel.org/r/cover.1582471508.git.afzal.mohd.ma@gmail.com
[v1] https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

v3:
 * Split out from tree wide series, as Thomas suggested to get it thr'
	respective maintainers
 * Modify pr_err displayed in case of error
 * Re-arrange code & choose pr_err args as required to improve readability
 * Remove irrelevant parts from commit message & improve
 
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/unicore32/kernel/time.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/unicore32/kernel/time.c b/arch/unicore32/kernel/time.c
index 8b217a761bf0..c3a37edf4d40 100644
--- a/arch/unicore32/kernel/time.c
+++ b/arch/unicore32/kernel/time.c
@@ -72,13 +72,6 @@ static struct clocksource cksrc_puv3_oscr = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static struct irqaction puv3_timer_irq = {
-	.name		= "ost0",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= puv3_ost0_interrupt,
-	.dev_id		= &ckevt_puv3_osmr0,
-};
-
 void __init time_init(void)
 {
 	writel(0, OST_OIER);		/* disable any timer interrupts */
@@ -94,7 +87,9 @@ void __init time_init(void)
 	ckevt_puv3_osmr0.min_delta_ticks = MIN_OSCR_DELTA * 2;
 	ckevt_puv3_osmr0.cpumask = cpumask_of(0);
 
-	setup_irq(IRQ_TIMER0, &puv3_timer_irq);
+	if (request_irq(IRQ_TIMER0, puv3_ost0_interrupt,
+			IRQF_TIMER | IRQF_IRQPOLL, "ost0", &ckevt_puv3_osmr0))
+		pr_err("Failed to register ost0 interrupt\n");
 
 	clocksource_register_hz(&cksrc_puv3_oscr, CLOCK_TICK_RATE);
 	clockevents_register_device(&ckevt_puv3_osmr0);
-- 
2.25.1

