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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85139C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCFC20866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uM6cMGzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgCDAuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:50:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37833 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgCDAuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:50:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id b8so209001plx.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 16:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=swFmjqT0Y56MB/TOvfNBHX4apZk62pGEUutP8ASnJ/M=;
        b=uM6cMGzrfOwQsHIcvLUkxA8pQDog4rx8wGssXKC0F/0lgoTQLBAstM+Ts6JYs1Cxlo
         gWQeVAnxrJkWPseuB94YJBkJ/sgl4UbfiwRSjIjKrITHRezRrXgP7MhiNCbEtU3IEYbw
         K/T1txQeNidnJ2DgLjOsPSz/eXZZMQhvYzNZHz9TImTRdGs0dgvF2V2twV9CMA7TtUbC
         bc5sxck8d5I7ijiw6F9bTNbNf919RP1duE5IFoLP5nMrH0Q5m/CcfyiXNLJFLKqmmSbi
         BStL8bwR43ypHCVqHcPKtBS0aK3EW8isTIsOLcygsqKDaJdrHsNevYNkaWyafyDZF79f
         cXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=swFmjqT0Y56MB/TOvfNBHX4apZk62pGEUutP8ASnJ/M=;
        b=pnfONvG5prrtcA+nrP69bV+4SfsulcGTXqVjQDwjYdgp43ZbSlBecoMc2nBA1OMmgq
         efArpTDG+wEtw/CZLvOAOLRtCBAFN6eiZm4dDWTCbt4/K5sxQbRNPzUAKAbNk2i1HcHa
         bCRm6Q50fzNwH3xwGC+93reqcUV5qDMOPWH3PaVy9PMmLbquD6VMrOouxkfaPjXsTz2X
         DvHt64uzC0TZ47piWm22r8Me+Is0HhFDyjdU8jlOD1jSGDYSuI0xerDLI0wcxEUbBFBj
         TtORlRaj+5J8HrAfCNjIVFPvd8xz0vtA7uhcnZlv1KqWopukoQfmcedVixppyvMwCwDE
         rLYQ==
X-Gm-Message-State: ANhLgQ26A1R4F2XOrOn3BQbTQIPrvVAgmu3h/qhS8V40Sgj3+D0xb3Fl
        ailnCAKbyMTTnKhE9mGifF9BfaAc
X-Google-Smtp-Source: ADFU+vsdgQ49d62NMFlFkwvqhLXSb+Da+GFUYBlf9OhKflUb54ou/xhiWVxlgjbIBluXQDp+LEnPDA==
X-Received: by 2002:a17:902:b904:: with SMTP id bf4mr549216plb.151.1583283004702;
        Tue, 03 Mar 2020 16:50:04 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id p7sm13972637pfb.135.2020.03.03.16.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 16:50:04 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v3] microblaze: Replace setup_irq() by request_irq()
Date:   Wed,  4 Mar 2020 06:19:59 +0530
Message-Id: <20200304005000.5067-1-afzal.mohd.ma@gmail.com>
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
Hi microblaze maintainers,

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

 arch/microblaze/kernel/timer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
index a6683484b3a1..f8832cf49384 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -161,13 +161,6 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction timer_irqaction = {
-	.handler = timer_interrupt,
-	.flags = IRQF_TIMER,
-	.name = "timer",
-	.dev_id = &clockevent_xilinx_timer,
-};
-
 static __init int xilinx_clockevent_init(void)
 {
 	clockevent_xilinx_timer.mult =
@@ -309,7 +302,8 @@ static int __init xilinx_timer_init(struct device_node *timer)
 
 	freq_div_hz = timer_clock_freq / HZ;
 
-	ret = setup_irq(irq, &timer_irqaction);
+	ret = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer",
+			  &clockevent_xilinx_timer);
 	if (ret) {
 		pr_err("Failed to setup IRQ");
 		return ret;
-- 
2.25.1

