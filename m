Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5092CC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2736C20838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPkSw08S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgAJQMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:12:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37206 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgAJQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:12:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so2552815wmf.2;
        Fri, 10 Jan 2020 08:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xkMOmNmLa62Vpfa8/ICLyRTkAbbIVBU7ErtKb0uzIMQ=;
        b=aPkSw08SMUilULHj7HsZy/gdCwo3Abv1ABNWaL48dKNFzHJDyXA/Yz4/F0YVY1jkDo
         lhP+Pox6M56eJW/hGKC6Tij4PUxV3RJrHSSUiKta+i1LBsgvkc/rfQNL3pHfSYonDvCq
         +BZU5WF2BhqM37KlGhgv7jAgx7Vmx46Fw67w7QekdaKwOSMdbmhbOBgCer1EjC4riXaB
         uNWGAtr+tWsO7JOtMKgs/8fv2p4oVebAwKgpiQJU9jRIQig/UaTuvTbRNhgSOPYuwm14
         QYYo8gkDPgpY2c/UygtbWCK5g7gibLoVKxF9R82X8vXy/n0U19hq2NJaZC0BEuhPafF3
         3YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xkMOmNmLa62Vpfa8/ICLyRTkAbbIVBU7ErtKb0uzIMQ=;
        b=QJV+ZhQxSSFYutTihLY8rxZdwlFquCMOXAnJHKp7U+EHS2lKCOq4sjckOr/rmu4md4
         7BeNcK8JwKScIkXbqOGuTLyc1hqjE64NUqF7bFCR3BTG4bhCCXRtXX4ZapsF/M7caFSs
         rKq84pHYsUgjoL+RvdtNJDtMOot3uPjx2qRW8UH7mToXaMsfUds1cG5gKIdT3OwiA04A
         rJQW7BT23JdGxrS/vPR9qjuLzx3EOUDzw/JOjIk0RVbOsQ9O6x0oFBSctgMv9mcvlG1f
         3t29+9NIaPUXWigf/Bl4iIk/+T7p7dH9v+Xq3W2mYhno8CI2VO+lYj8z2GHe6BJJN9WT
         uf7g==
X-Gm-Message-State: APjAAAVsitahzmJyvGASlNeG4cwxeLbZlba9ZdmE1xj+kewj7A9RmE05
        zp8nm1fTbPqHNz8+1UuQ3Rs=
X-Google-Smtp-Source: APXvYqzAXbMEDqrzxi6gn4Xy/KMH6yHFAQP4FHoyyt5JulLOcl6Xolbecb4sqUX5qD/e9+jnjevHCw==
X-Received: by 2002:a1c:a982:: with SMTP id s124mr5063032wme.132.1578672728261;
        Fri, 10 Jan 2020 08:12:08 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x10sm2713533wrp.58.2020.01.10.08.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 08:12:07 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: fix dwmmc clock name for px30 and rk3308
Date:   Fri, 10 Jan 2020 17:12:00 +0100
Message-Id: <20200110161200.22755-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An experimental test with the command below gives this error:
px30-evb.dt.yaml: dwmmc@ff390000: clock-names:2:
'ciu-drive' was expected
rk3308-evb.dt.yaml: dwmmc@ff480000: clock-names:2:
'ciu-drive' was expected

'ciu-drv' is not a valid dwmmc clock name,
so fix this by changing it to 'ciu-drive'.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi   | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 9a0f77ea4..07fe187cf 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -885,7 +885,7 @@
 		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		pinctrl-names = "default";
@@ -900,7 +900,7 @@
 		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		pinctrl-names = "default";
@@ -915,7 +915,7 @@
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 8bdc66c62..fa0d55f1a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -591,7 +591,7 @@
 		bus-width = <4>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		pinctrl-names = "default";
@@ -606,7 +606,7 @@
 		bus-width = <8>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		status = "disabled";
@@ -619,7 +619,7 @@
 		bus-width = <4>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		pinctrl-names = "default";
-- 
2.11.0

