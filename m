Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A81C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A2120786
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQ/wTmkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgHQNmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgHQNlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:41:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0351C061358
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 06:41:12 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so17527960ljc.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=frzL2DLHwYvpLbcVF+BQ0a2PY0Hd2ua7rlCrnnnS4iw=;
        b=UQ/wTmknQMhog1wmIO5rJfA79XJvlXor2LAoB70HRnID+sphf9o9+m7gJg3flV1w5O
         uzF9+23Tp5eh1yYLY8A9bXI2HDhC4hZ+GMvRNPyjC8ZEKWR1ejvT1UjpKv0YE6yVPvRj
         khZ/XsvmZkULDjFzlKm9uvxBy6PTfVk3NtYGAy/SnbiwDPMyIoG+CkqodY4aBhvBbUN6
         XtZJkdxNE95L+s2E+dOGSeVXfgXQR4NlVEvdD23dCam8seLxHMDh2heb5+Cq5c6/ak8i
         agWfUJ68D55vR1uU9TYOd8WM0beZfd+Jxrv8GEwZAfqyspwoT900Fhslzksxg/S+IcjT
         XSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=frzL2DLHwYvpLbcVF+BQ0a2PY0Hd2ua7rlCrnnnS4iw=;
        b=PqEXnhpxFfOhp2/rgWuv8nuAqksRuoYZmiTdu9iEINQIuLnqa2QQCMsdo4KHeAF4WE
         Pvk19N3V1m4waOYULYv5Kc6SlLthcFDl+Oj8eGFhpjFiO3UxPAmY0/KIt0Lvs52FZXk2
         k2SAykD0AOT4Fxzwh5GzSfVGmjZTvCAmtCmL+MaIZaGXvdzRy/kv2cEpWA1MjHzA0RYJ
         ZM13FmRmd3Cptzop68mmWa9y/cLSZtw1pcnsBYU/xVGYTSkhVK+/HVpcxOKmp2tqW0wg
         1XOmfS3UOsZLaw0n2j0qMYNeblaMlSNJrB3P+J62TdAeA4Zci+5XZzrANlBWbsNTEnxS
         z33A==
X-Gm-Message-State: AOAM530vUkiZeWxUxGjE7xYjyUFfPGTWWTyM+kyyIH2u/hut4tHi9qKc
        n5Pd+JFd5IaTYrdMvjxre3rHOA==
X-Google-Smtp-Source: ABdhPJy4aaiF8qOICfByVONC0MVmCClxwRzY87w1wPh5D4T/z2ObxWuZzRUVuY6Nc3XgSrGHfxcUCA==
X-Received: by 2002:a2e:3609:: with SMTP id d9mr7131951lja.106.1597671661262;
        Mon, 17 Aug 2020 06:41:01 -0700 (PDT)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id g22sm3443791lja.29.2020.08.17.06.41.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 06:41:00 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, david@lechnology.com,
        praneeth@ti.com
Subject: [PATCH v5 5/5] irqchip/irq-pruss-intc: Add support for ICSSG INTC on K3 SoCs
Date:   Mon, 17 Aug 2020 15:40:13 +0200
Message-Id: <1597671613-20879-6-git-send-email-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597671613-20879-1-git-send-email-grzegorz.jaszczyk@linaro.org>
References: <1597671613-20879-1-git-send-email-grzegorz.jaszczyk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The K3 AM65x and J721E SoCs have the next generation of the PRU-ICSS IP,
commonly called ICSSG. The PRUSS INTC present within the ICSSG supports
more System Events (160 vs 64), more Interrupt Channels and Host Interrupts
(20 vs 10) compared to the previous generation PRUSS INTC instances. The
first 2 and the last 10 of these host interrupt lines are used by the
PRU and other auxiliary cores and sub-modules within the ICSSG, with 8
host interrupts connected to MPU. The host interrupts 5, 6, 7 are also
connected to the other ICSSG instances within the SoC and can be
partitioned as per system integration through the board dts files.

Enhance the PRUSS INTC driver to add support for this ICSSG INTC
instance.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
v4->v5:
- Rename: s/num_host_intrs/num_host_events/ regarding to change
  introduced in patch #2.
v3->v4:
- Move generic part to "irqchip/irq-pruss-intc: Add a PRUSS irqchip
  driver for PRUSS interrupts" patch and leave only platform related
  code.
v2->v3:
- Change patch order: use it directly after "irqchip/irq-pruss-intc:
  Implement irq_{get,set}_irqchip_state ops" and before new
  "irqchip/irq-pruss-intc: Add event mapping support" in order to reduce
  diff.
v1->v2:
- https://patchwork.kernel.org/patch/11069773/
---
 drivers/irqchip/Kconfig          | 2 +-
 drivers/irqchip/irq-pruss-intc.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a112a76..7fe4e30 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -495,7 +495,7 @@ config TI_SCI_INTA_IRQCHIP
 
 config TI_PRUSS_INTC
 	tristate "TI PRU-ICSS Interrupt Controller"
-	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE
+	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3
 	select IRQ_DOMAIN
 	help
 	   This enables support for the PRU-ICSS Local Interrupt Controller
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 15f0407..9e540af 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -622,11 +622,20 @@ static const struct pruss_intc_match_data pruss_intc_data = {
 	.num_host_events = 10,
 };
 
+static const struct pruss_intc_match_data icssg_intc_data = {
+	.num_system_events = 160,
+	.num_host_events = 20,
+};
+
 static const struct of_device_id pruss_intc_of_match[] = {
 	{
 		.compatible = "ti,pruss-intc",
 		.data = &pruss_intc_data,
 	},
+	{
+		.compatible = "ti,icssg-intc",
+		.data = &icssg_intc_data,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, pruss_intc_of_match);
-- 
2.7.4

