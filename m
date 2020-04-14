Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0F2C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9FEF20732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOQVp73D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438248AbgDNKSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438220AbgDNKR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:17:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA9CC061A0F;
        Tue, 14 Apr 2020 03:17:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m16so4494529pls.4;
        Tue, 14 Apr 2020 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJqmAn8rCaC2zzDR7gsuH+oKcMAGO2Lxph4F4d0uXF4=;
        b=pOQVp73DmQfEEJ8VRBOL1zEL5JOuSlYiE/ZY73ciJ/35tl90AEHo7vD0NAJtDGhcDK
         ioZJNqXKHzRnztzNQ5PTHPwf5un7tLf73kgtkYZArjDAmqqST01HOXw5K03Qxtn9D4tp
         Wft7oIZhFxFIag9i4eXubo908qxWffAipcLg5q20XUVb/nIpyNMbPo1ci+whslW4kUjP
         MzS8HC7zw6x5/h4oVndR8+0ugtslhyTPwykCjCdmfSkDFEw9hiXlL9Hp9ey1mxV3fjpl
         i5MtdGR2tu8eA/WOQYzuqydEZ/05jHToYu3kpa9W4k1bxwAdy3OTbOYFjU1GbO6fpnr9
         NkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJqmAn8rCaC2zzDR7gsuH+oKcMAGO2Lxph4F4d0uXF4=;
        b=FJ/g5WYNimZRHpnQLcQBClEC9QlzCzKTDXVkRcPQ5EURcVrPfv5w0yPRoi91kUCI8C
         YKUTono3bM83Do6P6MWiWhjz0rRcmuXJZsVAz6XwYxFwfre0axU24/Irmam/mRJBD78y
         W03ic2ThbOT5rVoZSnCrT/pGE0zyFNoIEP77sB7ajbeGip5XGT2gOhAZyUzc9xbhYxVl
         XX0HqLp9uVlFu/OFM+1o4+NDMpzIGz/3z8M0qLNgd2SkzEDv0U48PvAistzPNXbNrDLY
         JTcEsB1fJFPEcjsYpgeQim/RMK214Z81IW1saHUEL99vRM2T2cFgjf2Py5iI8BY580xb
         0elw==
X-Gm-Message-State: AGi0PuYURP885Jgq70ZK++zu491TJLxsV2w09gzsZw7pIwPjayIKZhdy
        5m+PQccsgKAYpXeJL8Wkc9mD/ZMNju0=
X-Google-Smtp-Source: APiQypIpjF4jLy/Gs0Rx/IKhvZz5HygOEGHGnPXNy01Z7A3dG6YdziaxF6n5t/3yk97CM7ysXnIOjw==
X-Received: by 2002:a17:90a:e64e:: with SMTP id ep14mr9840194pjb.190.1586859445415;
        Tue, 14 Apr 2020 03:17:25 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r189sm9870182pgr.31.2020.04.14.03.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 03:17:24 -0700 (PDT)
From:   zhang.lyra@gmail.com
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RESEND PATCH 2/2] arm64: dts: Add SC9863A emmc and sd card nodes
Date:   Tue, 14 Apr 2020 18:16:36 +0800
Message-Id: <20200414101636.24503-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414101636.24503-1-zhang.lyra@gmail.com>
References: <20200414101636.24503-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add emmc and sd card devicetree nodes for SC9863A.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm64/boot/dts/sprd/sc9863a.dtsi | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
index 1ad6f6e95bca..8cf4a6575980 100644
--- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2019, Unisoc Inc.
  */
 
+#include <dt-bindings/clock/sprd,sc9863a-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "sharkl3.dtsi"
 
@@ -543,5 +544,46 @@
 				};
 			};
 		};
+
+		ap-ahb {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			sdio0: sdio@20300000 {
+				compatible  = "sprd,sdhci-r11";
+				reg = <0 0x20300000 0 0x1000>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+
+				clock-names = "sdio", "enable";
+				clocks = <&aon_clk CLK_SDIO0_2X>,
+					 <&apahb_gate CLK_SDIO0_EB>;
+				assigned-clocks = <&aon_clk CLK_SDIO0_2X>;
+				assigned-clock-parents = <&rpll CLK_RPLL_390M>;
+
+				bus-width = <4>;
+				no-sdio;
+				no-mmc;
+			};
+
+			sdio3: sdio@20600000 {
+				compatible  = "sprd,sdhci-r11";
+				reg = <0 0x20600000 0 0x1000>;
+				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+
+				clock-names = "sdio", "enable";
+				clocks = <&aon_clk CLK_EMMC_2X>,
+					 <&apahb_gate CLK_EMMC_EB>;
+				assigned-clocks = <&aon_clk CLK_EMMC_2X>;
+				assigned-clock-parents = <&rpll CLK_RPLL_390M>;
+
+				bus-width = <8>;
+				non-removable;
+				no-sdio;
+				no-sd;
+				cap-mmc-hw-reset;
+			};
+		};
 	};
 };
-- 
2.20.1

