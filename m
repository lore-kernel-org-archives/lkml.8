Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E64DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC9C20709
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHJJQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:16:32 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:17305 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgHJJQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:16:32 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07A9GOdO000158;
        Mon, 10 Aug 2020 18:16:24 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Mon, 10 Aug 2020 18:16:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from localhost.localdomain (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07A9GLY0000140
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 10 Aug 2020 18:16:24 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v2] arm64: dts: rockchip: add SPDIF node for rk3399-rockpro64
Date:   Mon, 10 Aug 2020 18:16:19 +0900
Message-Id: <20200810091619.3170534-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 'disabled' SPDIF sound node and related settings
for rk3399-rockpro64.

There are 2 reasons:
  - All RK3399 dma-bus channels have been already used by I2S0/1/2
  - RockPro64 does not have SPDIF optical nor coaxial connector,
    just have 3pins

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

---

Changes in v2:
  - Remove redundant status property
---
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 6e553ff47534..58097245994a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -76,6 +76,23 @@ sound {
 		dais = <&i2s1_p0>;
 	};
 
+	sound-dit {
+		compatible = "audio-graph-card";
+		label = "rockchip,rk3399";
+		dais = <&spdif_p0>;
+	};
+
+	spdif-dit {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+
+		port {
+			dit_p0_0: endpoint {
+				remote-endpoint = <&spdif_p0_0>;
+			};
+		};
+	};
+
 	vcc12v_dcin: vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -698,6 +715,16 @@ &sdhci {
 	status = "okay";
 };
 
+&spdif {
+	pinctrl-0 = <&spdif_bus_1>;
+
+	spdif_p0: port {
+		spdif_p0_0: endpoint {
+			remote-endpoint = <&dit_p0_0>;
+		};
+	};
+};
+
 &spi1 {
 	status = "okay";
 
-- 
2.28.0

