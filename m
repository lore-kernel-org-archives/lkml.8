Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8658AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A0C2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gop3FjV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgIIIOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgIIIOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:14:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E9C061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:14:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kk9so969588pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3oz9E+wONrzUTZU79l0WpeVQcrmJpZqKnrl07vYkL+g=;
        b=Gop3FjV/+uMnAIYjTwuHk9mfpqIV/1ElZWNwys1AKUXB331HpDTbOHFEjvVlklQ6ah
         voPmW3BE/2PUFLx6vbWSATCv3K1L3QieKXr5JeKT8/Po1PwEJ5f/MQMF1P0K6dlDrc5T
         giu1rWaAaVgB8fNtx5gNRj/r/iRP2f5YRFBKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3oz9E+wONrzUTZU79l0WpeVQcrmJpZqKnrl07vYkL+g=;
        b=cGVES9nm+6lGw9lU8dNHpqvXwMfiguN3cyMSfty3onTLz/uojLpKG9hDA0PTPTFyUx
         LleXv0kB1lqa5wddsXzt/nfdB8W/rQbG7/2mDm3GN/TiGdiKD54GMHduJ+dZRNNGwVT4
         iBCzWx4cnAi0Kznv1+e5i+vA/pZFuFHNolO676bwSn7mn6cFnTJzANqxA9YpsAanLuRk
         F+nLyNCm9ogC6vv8FbcD7byqVbMeIIgkgXxW4bzl210DlysNQUoI+Upo8tWbdWdwxUxq
         T63EiaIZKABCJAWlvsmA8AUjD0GTjDK90AT6iRvMKf5djTIspsyUHTiOoneKInYx2HSj
         I8qA==
X-Gm-Message-State: AOAM530tlq6BIYoc6KoZnvk3qxOiPmE3iGiWN/PL4NrOfsdwdFwcy5LG
        4D+ffZUi0EUtERhz1yeI8pMwPg==
X-Google-Smtp-Source: ABdhPJwg6B7l65a9hELb6cekXm4yKt+0iW4AaOGJbjBziTTzDb99jUePR+aVNG3qQVxLlAFSRquzNQ==
X-Received: by 2002:a17:90a:b64:: with SMTP id 91mr2530834pjq.93.1599639267650;
        Wed, 09 Sep 2020 01:14:27 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id s9sm1439672pgm.40.2020.09.09.01.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:14:27 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] arm64: dts: mt8183-kukui: add scp node
Date:   Wed,  9 Sep 2020 16:14:22 +0800
Message-Id: <20200909081422.2412795-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add scp node to mt8183-kukui

Fixes: 0d5e41709f76 ("arm64: dts: mt8183: add scp node")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---

Change since v1:
* Add Fixes tag.

---
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index f0a070535b34..85f7c33ba446 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -90,6 +90,18 @@ pp3300_alw: regulator6 {
 		regulator-max-microvolt = <3300000>;
 	};
 
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scp_mem_reserved: scp_mem_region {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+	};
+
 	max98357a: codec0 {
 		compatible = "maxim,max98357a";
 		sdmode-gpios = <&pio 175 0>;
@@ -524,6 +536,13 @@ pins_clk {
 		};
 	};
 
+	scp_pins: scp {
+		pins_scp_uart {
+			pinmux = <PINMUX_GPIO110__FUNC_TP_URXD1_AO>,
+				 <PINMUX_GPIO112__FUNC_TP_UTXD1_AO>;
+		};
+	};
+
 	spi0_pins: spi0 {
 		pins_spi{
 			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
@@ -651,6 +670,17 @@ pins_wifi_wakeup {
 	};
 };
 
+&scp {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&scp_pins>;
+
+	cros_ec {
+		compatible = "google,cros-ec-rpmsg";
+		mtk,rpmsg-name = "cros-ec-rpmsg";
+	};
+};
+
 &soc_data {
 	status = "okay";
 };
-- 
2.28.0.526.ge36021eeef-goog

