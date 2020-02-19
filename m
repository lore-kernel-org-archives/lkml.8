Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5855DC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27821208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuSeZQwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgBSPgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:36:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36799 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:36:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so846916ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 07:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tTYqiI2XE0FI71U+lA9HyQqoyVK3A/0rXuG1/SFCPQ=;
        b=iuSeZQwearV2fKHrfA+H+kQGrsn3B9fAltXjE6wipUFmOXwOK+J4Mqs3QDTJzkAey0
         90z8swo5Ztdjovby+eyf2wHlciMMjVx37FYy66KbOBdqu4KIPQWP8B3TrZAWuPJnjVbl
         ZV0U+j/0ZO2wPNb7emK12mdJa9Puv2flmwjHx/NgzvlYCe208h7LIumAE19ATIBBPVk6
         imugZxDTCbHBbmEH5GuEN6VWwH9w/KNmYs2CjA1mcFdwcY2aBCqo/uPOOsr4rQ+X/kV8
         7Kqf2HMeMuGRZSPq0SJYKSZ8nuPEs+dHalyKA7bXZmEsaNnrgozJXmUWTv7GnsroRVfU
         dcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tTYqiI2XE0FI71U+lA9HyQqoyVK3A/0rXuG1/SFCPQ=;
        b=lfpJBiXSMFnMgIw5ghmIeIaG8Q2MuHwc0M0yK51mCPaC1Q11KFFYPPK2zltOifkqdj
         m+D+pKyMiEJgpoWOPdw2igeaxhi0mOR6J7jKQ/PtOO/8HNEr8eGJvqdIUQ6y6dGrE9Xp
         KP+IUDfMAcjgVnhrbO5JxA1isxQFnh6S4X4STK+Hr0cBid4KAZarUpb5tESMonFSzPyP
         EM3MncIQMh76+JQb+WM5SXiYRJdY1nb4wjhGsiPB4QF1G097NcIqzXefBPGRlVpA1kXR
         1sB8l8lHX6FmcR/NBjo41KHF/3Zgbc6zoU/8mAec5E2SuayQa3mAz26lxNfgwcUqEVby
         1Pgg==
X-Gm-Message-State: APjAAAUEfe+aYU9FTql/OmaoQU5y+6xnhbXXUtOc1oL3ufdzPLd2nOmj
        mynO5wYmDwvo23ispKswwRqHEQ==
X-Google-Smtp-Source: APXvYqzx6nhZsTlXRtRpmdMR+DniVGZB2pzu5JFzIZhLE1ehK6HOgUsK5ph4YaJ7e7rkNRpNq/K9tA==
X-Received: by 2002:a2e:5304:: with SMTP id h4mr16066587ljb.75.1582126608365;
        Wed, 19 Feb 2020 07:36:48 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id s15sm28532ljs.58.2020.02.19.07.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 07:36:47 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] irqchip: vic: Support cascaded VIC in device tree
Date:   Wed, 19 Feb 2020 16:36:44 +0100
Message-Id: <20200219153644.137293-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.24.1
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
ChangeLog v1->v2:
- Drop the default assignment of 0 as parent IRQ.
- This is not tagged as fix: no regression.
---
 drivers/irqchip/irq-vic.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index f3f20a3cff50..3c87d925f74c 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -509,9 +509,7 @@ static int __init vic_of_init(struct device_node *node,
 	void __iomem *regs;
 	u32 interrupt_mask = ~0;
 	u32 wakeup_mask = ~0;
-
-	if (WARN(parent, "non-root VICs are not supported"))
-		return -EINVAL;
+	int parent_irq;
 
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
2.24.1

