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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C1AC4CC77
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E2E2078A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4hAnc57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDSFie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 01:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgDSFib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 01:38:31 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BBFC061A0C;
        Sat, 18 Apr 2020 22:38:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k28so5197176lfe.10;
        Sat, 18 Apr 2020 22:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vLg2vS6vbwaLD4bumFzJqQXM6o/qVInbvW6e8omW3YI=;
        b=Y4hAnc57B0cQGO5KZdXkt8myF8rs756MwxTr2Wb53uR/s6pHoG8gBpRjjlLJ1BedYE
         kYTNhe2Urdazuh7+wpOx8wGOiVAuq+k+FvDjK2CcjZ0U66PKJ4UGbFqik7Xseb6eb3r6
         S5WnLC3Os4lrpmkX3+22D3rMyrbQ/ifijc3VIDPaOfOkk+rKb4ifW8S392xRDbQL99ZA
         I7xbacArb/BLsSU/O/qMutriu6spjY8aM1A9Wr6JL/4TaSBXLU28tmR7+QUrIl9I2ITP
         tCOoyyNG5ez7zKmNDOh41N8RzsrCfTJ9aQKCmhhQnLqCC4at6fd9KNOCRkRluyoN750x
         KB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vLg2vS6vbwaLD4bumFzJqQXM6o/qVInbvW6e8omW3YI=;
        b=Sp8ezy1GN63WfUahx/QZDnTPIFK4UVkswL5ViieXXhXeKc+30yCgq6OoZ8FXmGLX4t
         BweU4+QjrZiu/xt4cCpccFQN0qpCpf4Nyhn3MJNMVQDiZOjkv70mAmJzEyfuWM3YVN9m
         2CeAdVp4tyimR/CrVDBdsYv1pq+xHD+xvwYzrm45y/de33UmJsFqiu3KpmALjRIqSSXj
         di9ZZktt/smPdpgLO3MLuPw4xMjOvMP4FqJ4a4eHjmgS18fkZ4zXBaSSB6y8je7ZA62F
         r8+Bhg0KOknZ1+4uMx4Mo974aMQWTPlCnPU9VaDU7PXq1ayCNYZQa4getI78JHbzrm3G
         uV9w==
X-Gm-Message-State: AGi0PuYc7EC8WdtSP4hDlhFRw4Rq5zELEBAZVX0HQI+v3BTJHPLnabq2
        JQMzqA7cmNOW1FpCkgkgHCQ=
X-Google-Smtp-Source: APiQypIaK3mv2I1tg6U9iBlWpxXNzg5HvmZEysNlupNPr+cXsUEVaMbshur0i4d37ESxnGuvIbB+Vw==
X-Received: by 2002:a19:43:: with SMTP id 64mr6462595lfa.67.1587274709684;
        Sat, 18 Apr 2020 22:38:29 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r23sm20416619ljh.34.2020.04.18.22.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 22:38:29 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 3/5] arm64: dts: meson: convert odroid-n2 to hdmi dtsi
Date:   Sun, 19 Apr 2020 05:38:13 +0000
Message-Id: <20200419053815.15731-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419053815.15731-1-christianshewitt@gmail.com>
References: <20200419053815.15731-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the N2 device-tree by using meson-g12-audio-hdmi.dtsi

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 89 +------------------
 1 file changed, 1 insertion(+), 88 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 169ea283d4ee..e75d859e76dd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -7,9 +7,9 @@
 /dts-v1/;
 
 #include "meson-g12b-s922x.dtsi"
+#include "meson-g12-audio-hdmi.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
-#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
 	compatible = "hardkernel,odroid-n2", "amlogic,s922x", "amlogic,g12b";
@@ -205,65 +205,6 @@
 			};
 		};
 	};
-
-	sound {
-		compatible = "amlogic,axg-sound-card";
-		model = "G12B-ODROID-N2";
-		audio-aux-devs = <&tdmout_b>;
-		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
-				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
-				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
-				"TDM_B Playback", "TDMOUT_B OUT";
-
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-		status = "okay";
-
-		dai-link-0 {
-			sound-dai = <&frddr_a>;
-		};
-
-		dai-link-1 {
-			sound-dai = <&frddr_b>;
-		};
-
-		dai-link-2 {
-			sound-dai = <&frddr_c>;
-		};
-
-		/* 8ch hdmi interface */
-		dai-link-3 {
-			sound-dai = <&tdmif_b>;
-			dai-format = "i2s";
-			dai-tdm-slot-tx-mask-0 = <1 1>;
-			dai-tdm-slot-tx-mask-1 = <1 1>;
-			dai-tdm-slot-tx-mask-2 = <1 1>;
-			dai-tdm-slot-tx-mask-3 = <1 1>;
-			mclk-fs = <256>;
-
-			codec {
-				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
-			};
-		};
-
-		/* hdmi glue */
-		dai-link-4 {
-			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
-
-			codec {
-				sound-dai = <&hdmi_tx>;
-			};
-		};
-	};
-};
-
-&arb {
-	status = "okay";
 };
 
 &cec_AO {
@@ -280,10 +221,6 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
-&clkc_audio {
-	status = "okay";
-};
-
 &cpu0 {
 	cpu-supply = <&vddcpu_b>;
 	operating-points-v2 = <&cpu_opp_table_0>;
@@ -351,18 +288,6 @@
 	amlogic,tx-delay-ns = <2>;
 };
 
-&frddr_a {
-	status = "okay";
-};
-
-&frddr_b {
-	status = "okay";
-};
-
-&frddr_c {
-	status = "okay";
-};
-
 &gpio {
 	/*
 	 * WARNING: The USB Hub on the Odroid-N2 needs a reset signal
@@ -472,18 +397,6 @@
 	};
 };
 
-&tdmif_b {
-	status = "okay";
-};
-
-&tdmout_b {
-	status = "okay";
-};
-
-&tohdmitx {
-	status = "okay";
-};
-
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.17.1

