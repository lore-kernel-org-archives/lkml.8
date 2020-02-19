Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02833C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAD824654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/Po18yO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBSPfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:35:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47023 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSPfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:35:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id x14so782235ljd.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 07:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tTYqiI2XE0FI71U+lA9HyQqoyVK3A/0rXuG1/SFCPQ=;
        b=E/Po18yOEv6N41T9n8m7/Z5I/hAn0Hssaag999poMmOzS2DXFaMu2kp81CrAnNFvUy
         lI6zZ8wd7W7VoCoMbGBOFS35CJOamIFSgfizXI9Dm7yZcLnt3VqeuoukkjTMcVNVy0KU
         kQK2zjIa6IvviDBC7WXSr13M4H9AGRo9cgIQTZ14xfDIvANE8qhhPas4JpJ1qmCPncIK
         bg8W3Mj+0prC3YzemQnGINJixRcBBkDo/j1o+9bGi4nniv0gH+c2aseu7sMGUJU639qj
         nekGtfUWmxROFEJhGIpRgZ5VB/TwgaPVg0ld9C++rje8uyPR/RPIXamAUtv0O2O5b+oS
         mTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tTYqiI2XE0FI71U+lA9HyQqoyVK3A/0rXuG1/SFCPQ=;
        b=ha2JdlTPji9Yq544tGtbAcwtT/FwIKLQIpDBO0zkNcijPIWWJPPoskNkvJhMBrN57x
         cliGg+Cz+YaSklwGSrD40y+g3uOG18B5iFYTZ6y5syoPI6KBgSGXTwxMDez6545oDLBS
         OI8iqZrCcq3RxuDII6N8BjU6WdevzeEEOXS9F8YpvVvTrG10g0vFBo9T4mUKBdxOHrOa
         GnsJkE4vz1f/WtduYMXemydY+NeATTAP9xSkAnpl8pwRzs07itfyEry+Y/jF25cKZLM/
         OPfzDmWoQO2MpLbAlsJSdBkD4E+nGj2+pfJoRgM1MxkQ2izvTGXLPdmQjfoLOiBDhJ5k
         ToaQ==
X-Gm-Message-State: APjAAAVQVUdUX+BvlLtq8csDQCc2XShUCJSj5fO2ve/0Ci6+8LADjM6d
        N0zmc01DSFcvplI2jPFRx46TPDDjOtI=
X-Google-Smtp-Source: APXvYqzd7/6ZNc3I5nBZwwQWiZxslKBC6dtIIexCX7OraX2xnSM//30bm5Tt2XpNxBfNJpFX/1vbqQ==
X-Received: by 2002:a2e:93c5:: with SMTP id p5mr16224498ljh.192.1582126549176;
        Wed, 19 Feb 2020 07:35:49 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z205sm1536587lfa.52.2020.02.19.07.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 07:35:48 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] irqchip: vic: Support cascaded VIC in device tree
Date:   Wed, 19 Feb 2020 16:35:43 +0100
Message-Id: <20200219153543.137153-1-linus.walleij@linaro.org>
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

