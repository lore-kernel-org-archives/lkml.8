Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7329EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 21:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485FE2067B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 21:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gDj5vRtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgFGVyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 17:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgFGVyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 17:54:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6B6C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 14:54:45 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so18031870ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qK9kBq4blNXo7I1d5/dLedRzfEwPwXrnOkEFQSQpfAg=;
        b=gDj5vRtBsBNuoC0/YZrGtdzDgTkcJVLvwoHI4sirFsHpd7TWw1eIwi7foAbrMdne77
         MDUV/LKS9y4hHXGlA6MTqVzlasVZIiyULeC5EU4khJjSRlFRVqTNXV5ni9MDH+2MPkGH
         RVXgVMTva3P9mv3XC+dWJPdR6sG+QjIF45ScahvvWHe9I7AXDvAKMSlQzAUC+CJCNf+D
         Zx67pgDADXYAQk7aIFY3CkwV7YYkdvKP+diW/5x9QFxN4/+VVuncB6bx63rBRS4+yMWj
         pyCLLzlmdz7CUxV7Szx7l55QtTjIfreQhEMbkLRV7/8oHsuz/NQllY/WCmJ/3IR2xmgC
         v0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qK9kBq4blNXo7I1d5/dLedRzfEwPwXrnOkEFQSQpfAg=;
        b=Vy6fDVWkMjQ5Tu2cPA5dQUo/5UQya1ZgrNw5sk/UC5QRCf6GxtxMPUclprobKvwvxe
         FiIWdsl+es41SzIERKJ7gEBIPDw6s9sDyTyHIwKGldB5NcKAMh2EntoAxLYMlqqRrA/B
         o2HC5IkGi1MBYVI810mFtI+4RKA4/CsFs67js5gQq4VAsR+PdBKuetGOqj0jciTuFx5D
         04JGtlogPC5jTJLl2+5UmDuwYn03noqYwbeCpZh5VWg6CM8NIrSqLnnfkRpQCbvMICjo
         bQXmp1iYTpfjGPABqPf8ZhBZ3OUlu7V5JtexpU8w9EjJWEuF8jwqXRzFXctquAaRDG3K
         X15Q==
X-Gm-Message-State: AOAM5335uzE9Lbo0K207A+hK0pGIg8RJO1oniEVo9Ck6pqlt6CL/bSjW
        SaIeCC3usyTIR+XDtconP3ZFuPCu40k=
X-Google-Smtp-Source: ABdhPJyxZV1k2GXE9kxAdp66ysDNkfhGGulaIftD8Gw8zkBid3fDBx4xJGsPVkQouJKGgTEqxOjcAg==
X-Received: by 2002:a2e:a16d:: with SMTP id u13mr1817108ljl.362.1591566883738;
        Sun, 07 Jun 2020 14:54:43 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id l7sm1975609ljj.55.2020.06.07.14.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 14:54:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] irqchip: vic: Cut down the external API
Date:   Sun,  7 Jun 2020 23:51:24 +0200
Message-Id: <20200607215124.48638-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200607215124.48638-1-linus.walleij@linaro.org>
References: <20200607215124.48638-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are registers and functions in the header file
that are only used inside the driver. Move these into
the driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/irqchip/irq-vic.c       | 5 ++++-
 include/linux/irqchip/arm-vic.h | 9 ---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 927ff2c1bf67..bc235db8a4c5 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -27,7 +27,10 @@
 
 #define VIC_IRQ_STATUS			0x00
 #define VIC_FIQ_STATUS			0x04
+#define VIC_RAW_STATUS			0x08
 #define VIC_INT_SELECT			0x0c	/* 1 = FIQ, 0 = IRQ */
+#define VIC_INT_ENABLE			0x10	/* 1 = enable, 0 = disable */
+#define VIC_INT_ENABLE_CLEAR		0x14
 #define VIC_INT_SOFT			0x18
 #define VIC_INT_SOFT_CLEAR		0x1c
 #define VIC_PROTECT			0x20
@@ -428,7 +431,7 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
 	vic_register(base, 0, irq_start, vic_sources, 0, node);
 }
 
-void __init __vic_init(void __iomem *base, int parent_irq, int irq_start,
+static void __init __vic_init(void __iomem *base, int parent_irq, int irq_start,
 			      u32 vic_sources, u32 resume_sources,
 			      struct device_node *node)
 {
diff --git a/include/linux/irqchip/arm-vic.h b/include/linux/irqchip/arm-vic.h
index 2a4b6a5d8522..f2b11d1df23d 100644
--- a/include/linux/irqchip/arm-vic.h
+++ b/include/linux/irqchip/arm-vic.h
@@ -9,15 +9,6 @@
 
 #include <linux/types.h>
 
-#define VIC_RAW_STATUS			0x08
-#define VIC_INT_ENABLE			0x10	/* 1 = enable, 0 = disable */
-#define VIC_INT_ENABLE_CLEAR		0x14
-
-struct device_node;
-struct pt_regs;
-
-void __vic_init(void __iomem *base, int parent_irq, int irq_start,
-		u32 vic_sources, u32 resume_sources, struct device_node *node);
 void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
 
 #endif
-- 
2.25.4

