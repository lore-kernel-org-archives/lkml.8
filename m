Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C77FC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F96218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/JO0TEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgBMMsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:48:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34050 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbgBMMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:48:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so6448590ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 04:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ozcJGd45GZHFrAOdAe8Frh6X5osTbMchVYGqh4Wj1Fs=;
        b=B/JO0TEx2I6E6Km70y+FfnCM3t+xURsU2UCYhNCSFbBsLyLKy26Buw12qgXWn9UpeP
         ITahbw266K0QszVx7+MyMU4r7trYXejORoyp/E44C6dbjjLCLqPeQcqK5z5Z7EHTF/O/
         PH5oCl8TZbZ8XpAdnpy7zPCsVTIh/qeFFDEOoUn8gimId5GzLKQTSXLxgGWSW+RHddGt
         3QP22AmkRVTzLMUZsHhTO1tdTzO7RdwlJnUQ6W/drRdyMlilByJp6xrnObOagjeVfWaP
         2QXzzMKf3w5+jltwy1qoQY7RN+VpAULo8W6wsHbS9JFGSDGkxThyo47tqlWunQ9ZXgD6
         k5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ozcJGd45GZHFrAOdAe8Frh6X5osTbMchVYGqh4Wj1Fs=;
        b=mlHC5OqXZpMUMOmi6tUv4oiLQiBkpxf3cUWRQJsOJ3c37zYlMbV8cjUQHLeVvYEqBu
         ozOn3ovSKn79oetCD6m3/K0cUzB/TAzujUTj2aLcLCB5Y54S10BDrVNzRp4Kr3SCMbuH
         fILdtdFlsXVPUDd/EF22eepMDHk3pESGCaHOR5piec0h7DcJ3R0hCh94uITixjVvesMI
         oGvkVwP0r8YRLzMqfwDL4kAgr0l311j/hQQYgU0aPefoKKYSLRAr1WhrtUD+6ezIAY9T
         0ETe2DII0OHLhWRkaZ8y7fJJJ4RvgRwDMwaD2t0C3UkQIfSSoYySIieHstlRZeTgWDsy
         XraA==
X-Gm-Message-State: APjAAAXsaSVmF2k1d0pvOrU7N67h27gy/EWHTR57Y+eXBQUYwp6v0lol
        3ibUBALI6o9sLyvvBw1hDZnQZw==
X-Google-Smtp-Source: APXvYqwUJi048wT/Yp5QqvS8Zhw9mcyVtQ1iP9VeSnCknwW2zckQ1bFjaEdLBgw53TlhJMNk+DoHcg==
X-Received: by 2002:a2e:548:: with SMTP id 69mr11541731ljf.67.1581598081439;
        Thu, 13 Feb 2020 04:48:01 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z205sm1216137lfa.52.2020.02.13.04.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 04:48:00 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] irqchip: vic: Support cascaded VIC in device tree
Date:   Thu, 13 Feb 2020 13:47:57 +0100
Message-Id: <20200213124757.35385-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When transitioning some elder platforms to device tree it
becomes necessary to cascade VIC IRQ chips off another
interrupt controller.

Tested with the cascaded VIC on the Integrator/AP attached
logic module IM-PD1.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/irqchip/irq-vic.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index f3f20a3cff50..caff21b4bac6 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -509,9 +509,7 @@ static int __init vic_of_init(struct device_node *node,
 	void __iomem *regs;
 	u32 interrupt_mask = ~0;
 	u32 wakeup_mask = ~0;
-
-	if (WARN(parent, "non-root VICs are not supported"))
-		return -EINVAL;
+	int parent_irq = 0;
 
 	regs = of_iomap(node, 0);
 	if (WARN_ON(!regs))
@@ -519,11 +517,14 @@ static int __init vic_of_init(struct device_node *node,
 
 	of_property_read_u32(node, "valid-mask", &interrupt_mask);
 	of_property_read_u32(node, "valid-wakeup-mask", &wakeup_mask);
+	parent_irq = of_irq_get(node, 0);
+	if (parent_irq < 0)
+		parent_irq = 0;
 
 	/*
 	 * Passing 0 as first IRQ makes the simple domain allocate descriptors
 	 */
-	__vic_init(regs, 0, 0, interrupt_mask, wakeup_mask, node);
+	__vic_init(regs, parent_irq, 0, interrupt_mask, wakeup_mask, node);
 
 	return 0;
 }
-- 
2.23.0

