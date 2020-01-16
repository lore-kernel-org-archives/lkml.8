Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAFEC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F77207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193320;
	bh=cEW1tkWwCZjtFHFuLDAR/CAkbHVDx+5KeZ9SbT1N4Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oyO2JQDf/eDC6/vWij8vjFnw5lG6ZD9zc3AibttYH0vrJrDzmlk+LV79Z4vHOg/gF
	 daHROpSSqTEHnmkwoaJVTi5FagymEu/CPl7T/6JzvfkpNk6fQtBM0Z+Da9c79amNX9
	 x3PKbBeHzmGjgUA2rhu1n17rFG0kpzuiOz09O/Gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgAPQsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:48:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbgAPQsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:48:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18A3F2081E;
        Thu, 16 Jan 2020 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193317;
        bh=cEW1tkWwCZjtFHFuLDAR/CAkbHVDx+5KeZ9SbT1N4Lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrKM2Sqcs0wKI9HiP9vL4DTYjhO4dEBpj46MurcZPZQoTguxjw0QlMsKhOz7Q/9g1
         5z+vzQVeGkW75kVIw7aWHPDE+dnMoMk4Vh9dj1w6otsN5HNH/UkZ7Bzy+thBum56Z8
         dWRbm6dWkGZ7f782+HX7qr3Hr1HUY+hgnK0b/TUY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 073/205] arm64: dts: imx8mm-evk: Assigned clocks for audio plls
Date:   Thu, 16 Jan 2020 11:40:48 -0500
Message-Id: <20200116164300.6705-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "S.j. Wang" <shengjiu.wang@nxp.com>

[ Upstream commit e8b395b23643ca26e62a3081130d895e198c6154 ]

Assign clocks and clock-rates for audio plls, that audio
drivers can utilize them.

Add dai-tdm-slot-num and dai-tdm-slot-width for sound-wm8524,
that sai driver can generate correct bit clock.

Fixes: 13f3b9fdef6c ("arm64: dts: imx8mm-evk: Enable audio codec wm8524")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 2 ++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi    | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index f7a15f3904c2..13137451b438 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -62,6 +62,8 @@
 
 		cpudai: simple-audio-card,cpu {
 			sound-dai = <&sai3>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <32>;
 		};
 
 		simple-audio-card,codec {
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 23c8fad7932b..0435c64c92c8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -479,14 +479,18 @@
 						<&clk IMX8MM_CLK_AUDIO_AHB>,
 						<&clk IMX8MM_CLK_IPG_AUDIO_ROOT>,
 						<&clk IMX8MM_SYS_PLL3>,
-						<&clk IMX8MM_VIDEO_PLL1>;
+						<&clk IMX8MM_VIDEO_PLL1>,
+						<&clk IMX8MM_AUDIO_PLL1>,
+						<&clk IMX8MM_AUDIO_PLL2>;
 				assigned-clock-parents = <&clk IMX8MM_SYS_PLL3_OUT>,
 							 <&clk IMX8MM_SYS_PLL1_800M>;
 				assigned-clock-rates = <0>,
 							<400000000>,
 							<400000000>,
 							<750000000>,
-							<594000000>;
+							<594000000>,
+							<393216000>,
+							<361267200>;
 			};
 
 			src: reset-controller@30390000 {
-- 
2.20.1

