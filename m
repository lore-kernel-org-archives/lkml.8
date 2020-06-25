Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3467C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAC12076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390944AbgFYKSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:18:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35104 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403900AbgFYKSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:18:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B4E8D2A39A2
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, erwanaliasr1@gmail.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 5/7] arm64: dts: mt8183-evb: Fix unit name warnings
Date:   Thu, 25 Jun 2020 12:17:55 +0200
Message-Id: <20200625101757.101775-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625101757.101775-1-enric.balletbo@collabora.com>
References: <20200625101757.101775-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unit address from the DT nodes that doesn't have a reg
property. This fixes the following unit name warnings:

    Warning (unit_address_vs_reg): /soc/pinctrl@10005000/mmc0@0: node has a unit name, but no reg or ranges property
    Warning (unit_address_vs_reg): /soc/pinctrl@10005000/mmc1@0: node has a unit name, but no reg or ranges property

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2: None

 arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index afd6ddbcbdf2c..ae405bd8f06b0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -205,7 +205,7 @@ pins_rst {
 		};
 	};
 
-	mmc0_pins_uhs: mmc0@0{
+	mmc0_pins_uhs: mmc0 {
 		pins_cmd_dat {
 			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_DAT0>,
 				 <PINMUX_GPIO128__FUNC_MSDC0_DAT1>,
@@ -264,7 +264,7 @@ pins_pmu {
 		};
 	};
 
-	mmc1_pins_uhs: mmc1@0{
+	mmc1_pins_uhs: mmc1 {
 		pins_cmd_dat {
 			pinmux = <PINMUX_GPIO31__FUNC_MSDC1_CMD>,
 				   <PINMUX_GPIO32__FUNC_MSDC1_DAT0>,
-- 
2.27.0

