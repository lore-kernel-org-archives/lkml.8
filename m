Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8744C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D2A20848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703348;
	bh=Elypwm/GdKoQjG1p8rjSFWmks3rnxmuWqZfaNPE83j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=adnL5DybBr/3Ntf47x0ViR7zB+fd3KwElvqaV4ubg9HtCwwMhre6+F+n0N0A+5lIK
	 kS3dXpaI9BNgk15OnfEsjNRk0I1e6+6+3kuENb1qWi5Ic6ZMI1ksgkpBXPlVEjx3nC
	 hmN3TofrQNM6mn6IrC4PoBn7unPueLBRtBRW9IcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbgBNSC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:02:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731639AbgBNP4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:56:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56D252465D;
        Fri, 14 Feb 2020 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695761;
        bh=Elypwm/GdKoQjG1p8rjSFWmks3rnxmuWqZfaNPE83j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goDNNeaOUWDT/OEz6V889NIrQrl251BDjjDEv+McexenstBoweps0EsL6rEgehOhb
         sg37lKGibc83QtU/0Z0rw7MtWV4ix+LhL/7OnG3F3KW3wArbKUSzVFxatioB2OS7EH
         7+yzSaCMoWKJvNjzle6yuldjfSq1ztq3sNy1VJ5U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 329/542] arm64: dts: rockchip: fix dwmmc clock name for px30
Date:   Fri, 14 Feb 2020 10:45:21 -0500
Message-Id: <20200214154854.6746-329-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 7f2147350291569acd1df5a26dcdfc573916016f ]

An experimental test with the command below gives this error:
px30-evb.dt.yaml: dwmmc@ff390000: clock-names:2:
'ciu-drive' was expected

'ciu-drv' is not a valid dwmmc clock name,
so fix this by changing it to 'ciu-drive'.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/20200110161200.22755-1-jbx6244@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 8812b70f39111..5acd5ce714d4a 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -826,7 +826,7 @@
 		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		pinctrl-names = "default";
@@ -841,7 +841,7 @@
 		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		pinctrl-names = "default";
@@ -856,7 +856,7 @@
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		pinctrl-names = "default";
-- 
2.20.1

