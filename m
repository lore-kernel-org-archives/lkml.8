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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2101C3F2D4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7020222C2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK5HCV40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCAMXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 07:23:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35567 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCAMXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 07:23:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so3080763plt.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 04:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GR/xI2gMyvXWdFF9S5uRZpICRt+f76h6nOitHcoQYmY=;
        b=UK5HCV40LjKSntbr1iFufyeFeOXrmKYkN2ZIwvyGnR4UH3pldM0FCkS0Mmg/uqK7+p
         bFypS/136bNGzhW+erlbqIlAlTxlvavQGDgEuqQ340AnRsFHIy5a74Mj7nysOkOpHvKt
         tLes7YFdOiW1lAA0QvFfI64LRKMsgBuDWJlZ3g+VrxW86hpzpeHN69qnrSwXScq1yzS8
         l+nXaxJN2vnvclJAB1H0nDqPNK9jL/Oi9tk0PDyHPwC3Y1kUhShqk2qTWQsdOPYpggXU
         x8QA4pdaauaYHm5J56DXVrDR2QbvJU67q8ByUJD37GGO0gkWsOE5Enarqs8npp/mbMrg
         IdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GR/xI2gMyvXWdFF9S5uRZpICRt+f76h6nOitHcoQYmY=;
        b=iiDZtX9TCkQv+B+hOAbh669j/x4wUo/d7W9wYtGkgSTrPru3y9PEOltDaBR53SVCwH
         qrxkngJRVRfadYQvHH1xE27V6fPoLKFpGWxciJo6i+FKyjb+xLJvnTf3YPaMTL4wSqYy
         3f28cMeXD3/iWDoWTGj7gmvQCV05tHzf8ZEGAXU78j7pu6kkMy9sMN5O5iaMHKqzppiQ
         oT7W9JuJayHylEaHeuEhef9dN5lf8Z4qi8IdvXVxYtJWf2qKxn/oAACkvXJD68vnbx9u
         vcBEpq8Z7ZYMshi2GfQaoM5BP/psvgZ4a3eQ+bxZF7oi6Q/lArAU610JBRGKsTW44I+U
         TXNg==
X-Gm-Message-State: APjAAAUxmwDvxd7pOod1jt1LCrsCY4NzGOu78m+uIxjoMBW2E0S/4pM4
        ZcRLYDasVMZhd2tZJUG/6mk=
X-Google-Smtp-Source: APXvYqwlZsfL3WAhOxz2WFCSDWj8yvihulLTiLUQ2dLZnNhHKL6Vu8FNH9VWJHCtmK8WzaTqZE2kxA==
X-Received: by 2002:a17:902:104:: with SMTP id 4mr12889185plb.24.1583065389361;
        Sun, 01 Mar 2020 04:23:09 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id 26sm8623725pjk.3.2020.03.01.04.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 04:23:08 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH v3] ARM: rpc: replace setup_irq() by request_irq()
Date:   Sun,  1 Mar 2020 17:53:00 +0530
Message-Id: <20200301122300.4185-1-afzal.mohd.ma@gmail.com>
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

 arch/arm/mach-rpc/time.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rpc/time.c b/arch/arm/mach-rpc/time.c
index 1d750152b160..da85cac761ba 100644
--- a/arch/arm/mach-rpc/time.c
+++ b/arch/arm/mach-rpc/time.c
@@ -85,11 +85,6 @@ ioc_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction ioc_timer_irq = {
-	.name		= "timer",
-	.handler	= ioc_timer_interrupt
-};
-
 /*
  * Set up timer interrupt.
  */
@@ -97,5 +92,6 @@ void __init ioc_timer_init(void)
 {
 	WARN_ON(clocksource_register_hz(&ioctime_clocksource, RPC_CLOCK_FREQ));
 	ioctime_init();
-	setup_irq(IRQ_TIMER0, &ioc_timer_irq);
+	if (request_irq(IRQ_TIMER0, ioc_timer_interrupt, 0, "timer", NULL))
+		pr_err("Failed to request irq %d (timer)\n", IRQ_TIMER0);
 }
-- 
2.25.1

