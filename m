Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0277FC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC42B20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404899AbgDNQkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:40:21 -0400
Received: from mail.manjaro.org ([176.9.38.148]:47556 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404764AbgDNQkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:40:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 965683742B3A;
        Tue, 14 Apr 2020 18:40:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sjrZlbV75HIo; Tue, 14 Apr 2020 18:40:01 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 1/2] arm64: dts: rockchip: fix inverted headphone detection
Date:   Tue, 14 Apr 2020 18:39:51 +0200
Message-Id: <20200414163952.1093784-2-t.schramm@manjaro.org>
In-Reply-To: <20200414163952.1093784-1-t.schramm@manjaro.org>
References: <20200414163952.1093784-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Pinebook Pro the headphone jack is dual use. It can be used either
as a normal headphone jack or as a debug serial connection. This
functionality is controlled via a small hardware switch on the mainboard.
Unfortunately flipping this switch biases the headphone detection switch
inside the headphone jack at 3.3 V if in `debug UART` position but
to GND when in `headphone out` position.
This results in an inversion of the headphone detection logic depending
on the switch position.
Since the headphone jack can only be used for audio when in
`headphone out` position this commit changes the headphone detect GPIO
logic to be correct for that case rather than for the debug UART.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 5ea281b55fe2..c3f15f5bd550 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -147,7 +147,7 @@ es8316-sound {
 			"Speaker", "Speaker Amplifier OUTL",
 			"Speaker", "Speaker Amplifier OUTR";
 
-		simple-audio-card,hp-det-gpio = <&gpio0 RK_PB0 GPIO_ACTIVE_LOW>;
+		simple-audio-card,hp-det-gpio = <&gpio0 RK_PB0 GPIO_ACTIVE_HIGH>;
 		simple-audio-card,aux-devs = <&speaker_amp>;
 		simple-audio-card,pin-switches = "Speaker";
 
@@ -794,7 +794,7 @@ dc_det_gpio: dc-det-gpio {
 
 	es8316 {
 		hp_det_gpio: hp-det-gpio {
-			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_down>;
+			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
-- 
2.26.0

