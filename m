Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F595C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C1820663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LOn2ya0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgGMG7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgGMG7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:59:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57391C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:59:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so14382314wrw.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kinXBvz5+I1FgSK2RxVnBM/4h4YycBTf3sfQytiCbSA=;
        b=LOn2ya0S5OB7Y5uvhFHYl/XEYXEVgKVvfjwGLeRxcYVK8kubTPZZMct7qQYidJpeJo
         5RUTN+UHsk4k/Qyma5I22GYlfRjlugEU7XomNMheUP3bbRuVS3/7SVVRaLlvSvu9kIv0
         zNERj4P/Ai70ommBpNcyUDpRDqCTUpmukH7M8y7dkrOPktVxKlk2m9rIEQYdjNL4DXJf
         3dHT+wE8SFOp+bWdrs5z8K/msRqurH1sHrU/3qxb9ytCFJsAv3jeVQCpy/h6kbMLwWvc
         JUuFw3rEpW2tqWqGZlQUKhB2PfFXs+/fxA6PhzCBkW1019Sgorg6Uw2dk03Ajt6NceSh
         +oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kinXBvz5+I1FgSK2RxVnBM/4h4YycBTf3sfQytiCbSA=;
        b=Cq5vDh062vGUQNZZ2WvXry6+UrfieLRxs+W3FsB4Qo2J/xI5Z/JYf8ys2o3fcGcvKt
         6gORFRpKauLOSSzdEQygRwh0EoBriyo8qMl9+w6LGp037LsqsZDb2bMpJTF7hHfVOnHs
         zOqFnFkP1+GFfbDJpaoBn7t1lssI5PTDVc//2WGGHCKwBfi13kjVKqNTY9pfTt/UZCpf
         lni7gL3AFcxH6xaAE9HvsGCGpXYTTsyX4i2wDQg0Njr7HeLSIcplLhzyLRyE47v6z2E2
         t8rauqPt4rpZbiD2XSEd9ClFe6KdLPmMj7TUcubjit513vO2Eo5khlSK3LOvUzQQWLNT
         52QQ==
X-Gm-Message-State: AOAM5305Zw+lhEdhwONUojuPYSBWTpEkGt9f0zBYnFDFoFFGzt8lV26G
        1fqhBnLsjLz/p4FUQEARiWmK6w==
X-Google-Smtp-Source: ABdhPJyVPeQ7ShrahAXpJcoWO4VTZySPJoqio9Q2uZh9sFtU3rbW6xzIeLZOkXeBF0Flfj7vAttPig==
X-Received: by 2002:a5d:404e:: with SMTP id w14mr76901144wrp.268.1594623573901;
        Sun, 12 Jul 2020 23:59:33 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 92sm24394143wrr.96.2020.07.12.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:59:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, lee.jones@linaro.org,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH] arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
Date:   Mon, 13 Jul 2020 08:59:31 +0200
Message-Id: <20200713065931.19845-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Khadas MCU node with active FAN thermal nodes for all the
Khadas VIM3 variants.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
---
Hi Kevin,

The bindings has been reviewed and merged by Lee,
could you apply this one via the amlogic tree ?

Thanks,
Neil

 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 1ef1e3672b96..27408c10a811 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -183,6 +183,23 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&cpu_thermal {
+	trips {
+		cpu_active: cpu-active {
+			temperature = <80000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&cpu_active>;
+			cooling-device = <&khadas_mcu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &ext_mdio {
 	external_phy: ethernet-phy@0 {
 		/* Realtek RTL8211F (0x001cc916) */
@@ -222,6 +239,12 @@
 	pinctrl-0 = <&i2c_ao_sck_pins>, <&i2c_ao_sda_pins>;
 	pinctrl-names = "default";
 
+	khadas_mcu: system-controller@18 {
+		compatible = "khadas,mcu";
+		reg = <0x18>;
+		#cooling-cells = <2>;
+	};
+
 	gpio_expander: gpio-controller@20 {
 		compatible = "ti,tca6408";
 		reg = <0x20>;
-- 
2.22.0

