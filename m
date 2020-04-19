Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B164C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A742078A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCl2/pww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDSFi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 01:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgDSFi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 01:38:26 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB99C061A0C;
        Sat, 18 Apr 2020 22:38:25 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id t11so5198404lfe.4;
        Sat, 18 Apr 2020 22:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pLxLZ6U1xkA5yiZbYuidUVm3065atpE39pborliHgTs=;
        b=XCl2/pwwSdF8hrlQ62iKaUc1SVIem2w1TxmJRFHTVKB0L5DlsZYLkf1oitqaqKWjuX
         PbjNSlTYv0ntIeULCPh+Ep5mfAgxzrsxD4KjaWlWnJtFrB5kK3O4UyriyY+tCvoL7qt5
         DhDlkpQVRahUG91eU1Xp/FSDGyR+9XXXuaxL1axPDsJnM2kB0z6LaAKzeY6zKW4zcnCw
         TzSpoSSvCibsRP6vR9+6K9hamlIhZdFBUlgBC0jOkfcpH+HusCQW4t6Ohp4d3ZJeb3Ut
         CpE73cVa7xcUYhZE6baMrXj6Q9cwmmF9KvoTvw22cNxdgb8PINFsSHiuWYMKkcr8i/GM
         Vm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pLxLZ6U1xkA5yiZbYuidUVm3065atpE39pborliHgTs=;
        b=pOadM/fXuH8zYTz/3QKTuGOieUAWQhxXu7nEoi/BuX6Xt+g+33x/pRq9B+JWafPy3S
         ++LjlvdztZdKFFk9Ojm/lE8VN5H83kN5MKcUVxSyXA35rXqdZxF0ytFGjjD/NfYq6bJT
         wuCEzWwYOH5z68xOs9l7mDbvWCOQd9ezhnD6yUujGta60vmLYJvnMvWKLZYxErWhBybP
         FJRnebTazfct0HsA3j6BhbZV36IhD69zaBOKLjZ3PvRmmKE5SIucSccUcBe+/R7QZaXm
         Il5GUu8RymVurFzv9fs+fSHhCA+ByFxmdJ9BRgs/dbsZjVUPnOXmZKqR74JAwLn8cNu1
         equw==
X-Gm-Message-State: AGi0PuZzwLL2D2H8fPm0XvLKcgwXsW9hWOEiZ8eae1zilonwHNdksn7g
        xhN0TQB5YXPkTZFytUDYTQM=
X-Google-Smtp-Source: APiQypKdLfNSchIZsXaPy0/PL4whmvu6HG8cUJ3PgsPTNtUTSsz8Fg8WVBhAF6hkfE4UlxoP1ezJ9w==
X-Received: by 2002:ac2:43c6:: with SMTP id u6mr6860631lfl.170.1587274704120;
        Sat, 18 Apr 2020 22:38:24 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r23sm20416619ljh.34.2020.04.18.22.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 22:38:23 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/5] arm64: dts: meson: create common hdmi/hdmi-spdif audio dtsi
Date:   Sun, 19 Apr 2020 05:38:11 +0000
Message-Id: <20200419053815.15731-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419053815.15731-1-christianshewitt@gmail.com>
References: <20200419053815.15731-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create common audio dtsi with the HDMI and HDMI+S/PDIF configs used with
many devices that follow Amlogic U200/W400 reference designs.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../amlogic/meson-g12-audio-hdmi-spdif.dtsi   | 139 ++++++++++++++++++
 .../dts/amlogic/meson-g12-audio-hdmi.dtsi     |  96 ++++++++++++
 2 files changed, 235 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12-audio-hdmi-spdif.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12-audio-hdmi.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-audio-hdmi-spdif.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-audio-hdmi-spdif.dtsi
new file mode 100644
index 000000000000..e7cc738c0c3a
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-audio-hdmi-spdif.dtsi
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	spdif_dit: audio-codec-1 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "G12-HDMI-SPDIF";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT",
+				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
+				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
+				"SPDIFOUT IN 2", "FRDDR_C OUT 3";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-3 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		/* spdif hdmi or toslink interface */
+		dai-link-4 {
+			sound-dai = <&spdifout>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+
+			codec-1 {
+				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_A>;
+			};
+		};
+
+		/* spdif hdmi interface */
+		dai-link-5 {
+			sound-dai = <&spdifout_b>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-6 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&arb {
+	status = "okay";
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
+&spdifout {
+	pinctrl-0 = <&spdif_out_h_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&spdifout_b {
+	status = "okay";
+};
+
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-audio-hdmi.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-audio-hdmi.dtsi
new file mode 100644
index 000000000000..445549c26ba8
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-audio-hdmi.dtsi
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "G12-HDMI";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-3 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		dai-link-4 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&arb {
+	status = "okay";
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
-- 
2.17.1

