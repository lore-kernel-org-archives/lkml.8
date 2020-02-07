Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A307C35242
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6090F21775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgBGONg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:13:36 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53914 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGONg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 09:13:36 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B13AD2958AC
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        dafna.hirschfeld@collabora.com, heiko@sntech.de,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: rk3399: Remove extcon unit address and extcon-cells from Gru
Date:   Fri,  7 Feb 2020 15:13:24 +0100
Message-Id: <20200207141324.3188898-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cros-ec-extcon has no reg property so remove the unit address from
the DT node to make DT compiler happy.

While here, remove the inexistent extcon-cells property from the extcon
nodes.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Thanks to the Dafna's work and Rob's review I got noticed that the old
txt binding was wrong, and also, that the current cros-ec-extcon node in
Gru is wrong, so sending this patch now that is fresh in our minds and
update the node accordingly. There is an extcon-cells property that seems
to not exist and is not documented, so remove it.

For reference, see https://lkml.org/lkml/2020/2/5/176.

 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi | 4 +---
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi            | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 7cd6d470c1cb..1384dabbdf40 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -291,11 +291,9 @@ cros_ec_pwm: ec-pwm {
 		#pwm-cells = <1>;
 	};
 
-	usbc_extcon1: extcon@1 {
+	usbc_extcon1: extcon1 {
 		compatible = "google,extcon-usbc-cros-ec";
 		google,usb-port-id = <1>;
-
-		#extcon-cells = <0>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index dd5624975c9b..2f3997740068 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -570,11 +570,9 @@ i2c_tunnel: i2c-tunnel {
 			#size-cells = <0>;
 		};
 
-		usbc_extcon0: extcon@0 {
+		usbc_extcon0: extcon0 {
 			compatible = "google,extcon-usbc-cros-ec";
 			google,usb-port-id = <0>;
-
-			#extcon-cells = <0>;
 		};
 	};
 };
-- 
2.24.1

