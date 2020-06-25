Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E64C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2A820768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRDjwSeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgFYXfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgFYXed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:34:33 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D2C08C5DD;
        Thu, 25 Jun 2020 16:34:33 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l12so7578111ejn.10;
        Thu, 25 Jun 2020 16:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CT7VnGE0mSgmZO1Evmd8H2kDVfkxx8YIKsuOGdaw2Wo=;
        b=IRDjwSeAQuf4vJk6CH5AanE4mnrWhe3dqoNXYZSQsXQeLfFhRTUyQsHWmitjeJ3ZwT
         gyPGmMIcUKC5xsK92Lp7vsJ7Us8blLENnaoTCu/YAofrRIAMZEZ75FUJ1Q2hXJ3YpamY
         d4h2yDKTzASEFoBPqvWcsHhaG9IKs3HZG/Rg8Ff95XjLXaPaTbozAR3lRK28WVcuqot7
         KIXu8ChGXGU+e8LZ6wgH5eB+NwHjwAydZRQFVmy8Wu6PpT1NafxVrrzSSYcbb37oRiKI
         Ko5X9Y/Aya4Awz2j0SpB5T8Y3S6/oi4W8+tWP0T2HbUqGdX/6jwlrcPDm36ca8e1tbg6
         ZOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CT7VnGE0mSgmZO1Evmd8H2kDVfkxx8YIKsuOGdaw2Wo=;
        b=BopBqK1bQeAE3aOS1oYufPDBCkTgQrBb/9Z8FjaQIAKa0V9pcqM94aiEaSfAqNlSzN
         nG6m3VKcslT32SaNTNw1EL5j4tfmUnTZ4jQQB/k0OQwXua5DiurxZ3m/TL2loxLeaxad
         v74vUNPMGxSeA+OjS/65dWDij1F+g7ZNCZy1UpqF5feTan7cMOQ+g/Z8QF7TAsK264v3
         hIvi+uWd6MUpPS2UKIkdXatwS+mV2hfLXQgR31T6JeAz4v6FpEC6feNRGqP6sRuwAFt8
         37ruzWMNWaTMomUhaUwX29URW2Vkxzc+pItsZbi4EXKO8ouXXjg+GBhvJ59pfrhDDmXM
         TgBg==
X-Gm-Message-State: AOAM532F1Sq0r2TzfsN7+BTvIjIo8305l0CmRIGdwbtUoYWnHXY3BWwL
        NeDDSUwOO7aQGIgeObC3mjI=
X-Google-Smtp-Source: ABdhPJwxQlw6RDyRqj8sxq8BzyLXfL37ngDHVo/gjGrDs6jWTOHMVejNSjRVlGB+aTzmSQF7MifvyQ==
X-Received: by 2002:a17:906:c672:: with SMTP id ew18mr198125ejb.404.1593128071940;
        Thu, 25 Jun 2020 16:34:31 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id u2sm13699184edq.29.2020.06.25.16.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:34:31 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH 06/10] arm: dts: owl-s500: Add MMC nodes
Date:   Fri, 26 Jun 2020 02:34:18 +0300
Message-Id: <2a08075ab09975cbd1c3cee73d425e8f8fef6598.1593124368.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
References: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MMC controller nodes for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 3b625358d786..778775ac42f7 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -241,5 +241,38 @@ dma: dma-controller@b0260000 {
 			clocks = <&cmu CLK_DMAC>;
 			power-domains = <&sps S500_PD_DMA>;
 		};
+
+		mmc0: mmc@b0230000 {
+			compatible = "actions,owl-mmc";
+			reg = <0xb0230000 0x38>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD0>;
+			resets = <&cmu RESET_SD0>;
+			dmas = <&dma 2>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc1: mmc@b0234000 {
+			compatible = "actions,owl-mmc";
+			reg = <0xb0234000 0x38>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD1>;
+			resets = <&cmu RESET_SD1>;
+			dmas = <&dma 3>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc2: mmc@b0238000 {
+			compatible = "actions,owl-mmc";
+			reg = <0xb0238000 0x38>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD2>;
+			resets = <&cmu RESET_SD2>;
+			dmas = <&dma 4>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
 	};
 };
-- 
2.27.0

