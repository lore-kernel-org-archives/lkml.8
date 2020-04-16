Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B46C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7422222D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUqLcz4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbgDPSUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730886AbgDPSTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:19:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFCAC061A0C;
        Thu, 16 Apr 2020 11:19:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so5960288wrs.9;
        Thu, 16 Apr 2020 11:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=un5r5wTF9YSeE5H41tvnou6xOakyg+8DVX6yhx1HH88=;
        b=ZUqLcz4hHJEOkbo9fAObJQkyqo4pX0Cg8rMzkZa/eMXTQ2/+3RoO6qkNGZVtmL/Y2o
         GQtyHzHj4oCoRQNgPhyfof1gd9aZQjeWxANU27KsOxf8Jyq3tYnrDEgOFTYyLYG9ykVW
         uS24lqVzItzURKlIPSuCva4Uo90s9A7erCksXBlmh7icVU81rLqWYb2kpWIR5hob4a71
         WqNeseB4JSSJtp0qrBxosPI1yYOXza5aNDl9X7NJhS9Nt4cx1fnTUv8OSM1BOUpu/Xfy
         yBnabSPeLk0ZsrnGHLM/YtXE5JzIQOslDCDFmTFXsFvKyZsI8ocqj6hOaW7SQxXUUKyt
         D8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=un5r5wTF9YSeE5H41tvnou6xOakyg+8DVX6yhx1HH88=;
        b=llF5I122I4Fzhv8+bi6/94MkNF87SURbDTn9tTmFb9Jsh1m4aRvhG0/vS+xI8mYRWi
         bjXxSx4UX475ZRIvy77bcdrm0rULqhjvNxg/hsMauH3EtzocgoxtVoylr7MxDrhALsr7
         GwXXX4mFUUh39ZIeF6Moe72H+Vc2sji7bf+zvQ8VXChODd+jAHLUBYUW3YK3fh09zNeq
         QKKqofFcJFTA7Y5HdovbQOd2eIvIYO00qI8HNXoLTkeBWrt0sEE+tLr5tlgpCJkvtNsQ
         0wYvNRrSDo/lPdOUrufeHNVC0V0gG0/d9aY3qi2OY7ehyfV71gjMpcm75hxPVT4ksMjM
         0hdQ==
X-Gm-Message-State: AGi0PuaWXQLil3UxSeTUNT4zfeyvT3RGpiLA5b3n4albpRbZZxyGuf8d
        2yEEl2PbFLkn3bGRe0Odt6o=
X-Google-Smtp-Source: APiQypLCS49o+s1pMzcEqla3EhAESVxIpwpRuJ128hGVMG1TyTItLU0RQ+EfVAIWtH7wjgIJewKW/g==
X-Received: by 2002:adf:e88d:: with SMTP id d13mr9336514wrm.375.1587061192972;
        Thu, 16 Apr 2020 11:19:52 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u17sm31317719wra.63.2020.04.16.11.19.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 11:19:52 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: rockchip: add bus-width properties to mmc nodes for rk3368.dtsi
Date:   Thu, 16 Apr 2020 20:19:43 +0200
Message-Id: <20200416181944.5879-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200416181944.5879-1-jbx6244@gmail.com>
References: <20200416181944.5879-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'bus-width' and pinctrl containing the bus-pins
should be in the same file, so add them to
all mmc nodes in 'rk3368.dtsi'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index f22475016..0678c2e5c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -210,6 +210,7 @@
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		bus-width = <4>;
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		resets = <&cru SRST_MMC0>;
@@ -224,6 +225,7 @@
 		clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>,
 			 <&cru SCLK_SDIO0_DRV>, <&cru SCLK_SDIO0_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		bus-width = <4>;
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 		resets = <&cru SRST_SDIO0>;
@@ -238,6 +240,7 @@
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		bus-width = <8>;
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		resets = <&cru SRST_EMMC>;
-- 
2.11.0

