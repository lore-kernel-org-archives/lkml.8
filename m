Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7893DC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E0B20665
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgICObI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:31:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54668 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgICO23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:28:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 9F6EC29AB6D
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     enric.balletbo@collabora.com, kernel@collabora.com,
        dafna3@gmail.com, Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Subject: [PATCH] arm64: dts: mt8173-elm: fix supported values for regulator-allowed-modes of da9211
Date:   Thu,  3 Sep 2020 16:28:19 +0200
Message-Id: <20200903142819.24487-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet the allowed modes for the da9211
regulator are sync and auto mode. This should be changed in the
devicetree. This also fix an error message
'BUCKA: invalid regulator-allowed-modes element 0'
since value 0 is invalid.

Fixes: 689b937beddeb ("arm64: dts: mediatek: add mt8173 elm and hana board")
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 1fe5dac24ba1..1a51879d5c6f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/regulator/dlg,da9211-regulator.h>
 #include <dt-bindings/gpio/gpio.h>
 #include "mt8173.dtsi"
 
@@ -293,7 +294,8 @@
 				regulator-max-microamp  = <4400000>;
 				regulator-ramp-delay = <10000>;
 				regulator-always-on;
-				regulator-allowed-modes = <0 1>;
+				regulator-allowed-modes = <DA9211_BUCK_MODE_SYNC
+							   DA9211_BUCK_MODE_AUTO>;
 			};
 
 			da9211_vgpu_reg: BUCKB {
-- 
2.17.1

