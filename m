Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467B6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 21:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F93C2067B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 21:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yr6/QSsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgFGVxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 17:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgFGVxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 17:53:34 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B0DC08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 14:53:34 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j12so9017333lfh.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I1Uqb8YGlNDQxJScCH5PVUrrLere1ZfraaH/U8kZZlA=;
        b=Yr6/QSsZNA1gSHrMvpWG0UCFTZOZ4P+N4NJulQQ+NjRDIK4TfRR/6jenhKD0TCNQFX
         wxKdKAF/zF861egM0KZATyn/V/5hszd4GKSEuRilzZWgI4IiEskvzW11SaFg3a0arrhm
         k7CDeTLzFmWdn/Fqibxs4p0iebd6QamdfpyYGIiuY08LWFhDvVCtqkOO6WUqSJt2OlgV
         3mL9K/dh2ca9NKP0/l16yOypZmfuCFuDjyTjCOsZLrJKDOv76cgYdE9CEQyZJ5kLsE+z
         GG6S4vBi3e3NfL9adt9MGe9R/PYdEKwovFNBNWFQOKkNoZ+NtAwUG5BDlrlQezQHtYWg
         /izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I1Uqb8YGlNDQxJScCH5PVUrrLere1ZfraaH/U8kZZlA=;
        b=Ld3Ea1H2lLtha5nKdt6Z535FR85Fy3LSjJkGjpP0HWjloS5MbTd783v9i61YAXq2Fp
         kiDdn3uviBIw5YbQoPuWFOmqiLw6bI8Ndz+aii+YuKd9iYzOVZ80HS54Pfwll9jfDflG
         2xI+XijFZizr/nWz/aSQ8qSdW1yC71NDoUq9SHMTEzVLNGdlHF7MfuJRuBYGgeUIowli
         rphqKTX09Ez7OADzk1LQPORH7QTOz150Sv+j/YpyijGKOG2CKkrZ4GpnWvKRg4ORYCeL
         aLylp8XRAu7clDP8ue9/e5C0lyKnl+T52GKShxIleEXn6VFuc+27tpm7G5EQVv9mWSj5
         wNKw==
X-Gm-Message-State: AOAM532FHAMFVP415b3Gkio/8YwHYik2Nzr68Ck9o9y6peMgDYzVOpbB
        eEEsXUEdEirNTmo9g0+/LnN7ag==
X-Google-Smtp-Source: ABdhPJwt9sPGo2V3vTfl9vfv3FYXGjaQsYlMfpHsGgc7DfIkOHww+LiXy5SKyGOQW9XOe6tQ99rgBg==
X-Received: by 2002:a05:6512:3208:: with SMTP id d8mr10990169lfe.38.1591566812384;
        Sun, 07 Jun 2020 14:53:32 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id l7sm1975609ljj.55.2020.06.07.14.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 14:53:31 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] irqchip: vic: Drop cascaded intialization call
Date:   Sun,  7 Jun 2020 23:51:23 +0200
Message-Id: <20200607215124.48638-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We got rid of the last user of the cascaded intialization
from board files so drop this API.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/irqchip/irq-vic.c       | 21 ---------------------
 include/linux/irqchip/arm-vic.h |  2 --
 2 files changed, 23 deletions(-)

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 3c87d925f74c..927ff2c1bf67 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -481,27 +481,6 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 	__vic_init(base, 0, irq_start, vic_sources, resume_sources, NULL);
 }
 
-/**
- * vic_init_cascaded() - initialise a cascaded vectored interrupt controller
- * @base: iomem base address
- * @parent_irq: the parent IRQ we're cascaded off
- * @vic_sources: bitmask of interrupt sources to allow
- * @resume_sources: bitmask of interrupt sources to allow for resume
- *
- * This returns the base for the new interrupts or negative on error.
- */
-int __init vic_init_cascaded(void __iomem *base, unsigned int parent_irq,
-			      u32 vic_sources, u32 resume_sources)
-{
-	struct vic_device *v;
-
-	v = &vic_devices[vic_id];
-	__vic_init(base, parent_irq, 0, vic_sources, resume_sources, NULL);
-	/* Return out acquired base */
-	return v->irq;
-}
-EXPORT_SYMBOL_GPL(vic_init_cascaded);
-
 #ifdef CONFIG_OF
 static int __init vic_of_init(struct device_node *node,
 			      struct device_node *parent)
diff --git a/include/linux/irqchip/arm-vic.h b/include/linux/irqchip/arm-vic.h
index a158b97242c7..2a4b6a5d8522 100644
--- a/include/linux/irqchip/arm-vic.h
+++ b/include/linux/irqchip/arm-vic.h
@@ -19,7 +19,5 @@ struct pt_regs;
 void __vic_init(void __iomem *base, int parent_irq, int irq_start,
 		u32 vic_sources, u32 resume_sources, struct device_node *node);
 void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
-int vic_init_cascaded(void __iomem *base, unsigned int parent_irq,
-		      u32 vic_sources, u32 resume_sources);
 
 #endif
-- 
2.25.4

