Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4880FC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3184A206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgEONMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:12:38 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:53568 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgEONMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:12:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id BA145FB03;
        Fri, 15 May 2020 15:12:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7VPSUBShava6; Fri, 15 May 2020 15:12:26 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 98055445AC; Fri, 15 May 2020 15:12:15 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 6/6] arm64: dts: imx8mq-librem5-devkit: Enable MIPI DSI panel
Date:   Fri, 15 May 2020 15:12:15 +0200
Message-Id: <7f91beb1ce51a88dbe43e69c8af35b8684c0ac4c.1589548223.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1589548223.git.agx@sigxcpu.org>
References: <cover.1589548223.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable MIPI LCD panel output by adding nodes for the NWL DSI host
controller, the mux-input-bridge, the Rocktech panel and the eLCDIF
display controller.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 7fc31c71a626..d98f9b8dede8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -841,6 +841,87 @@ MX8MQ_IOMUXC_NAND_DATA03_GPIO3_IO9	0x19 /* WWAN_RESET */
 	};
 };
 
+&lcdif {
+	status = "okay";
+
+	port@0 {
+		lcdif_dpi_out: endpoint {
+			remote-endpoint = <&dpi_mux_from_lcdif>;
+		};
+	};
+};
+
+&iomuxc_gpr {
+	mipi_mux: mipi-mux {
+		compatible = "mux-input-bridge";
+		mux-controls = <&mux 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		default-input = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				dpi_mux_from_lcdif: endpoint {
+					remote-endpoint = <&lcdif_dpi_out>;
+				};
+			};
+
+			port@1 { /* dcss */
+				reg = <1>;
+			};
+
+			port@2 {
+				reg = <2>;
+				dpi_mux_out: endpoint {
+					remote-endpoint = <&nwl_dpi_in>;
+				};
+
+			};
+		};
+	};
+};
+
+&mipi_dsi {
+	status = "okay";
+	panel@0 {
+		compatible = "rocktech,jh057n00900";
+		reg = <0>;
+		backlight = <&backlight_dsi>;
+		reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
+		vcc-supply = <&reg_2v8_p>;
+		iovcc-supply = <&reg_1v8_p>;
+		port@0 {
+			panel_in: endpoint {
+				remote-endpoint = <&nwl_dsi_out>;
+			};
+		};
+	};
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			nwl_dpi_in: endpoint {
+				remote-endpoint = <&dpi_mux_out>;
+			};
+		};
+		port@1 {
+			reg = <1>;
+			nwl_dsi_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
 &pgc_gpu {
 	power-supply = <&buck3_reg>;
 };
-- 
2.26.1

