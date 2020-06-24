Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682FAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415A120738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HbBo8+WP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404888AbgFXQPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404802AbgFXQPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:15:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2AC061795
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:15:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so2843129wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kinXBvz5+I1FgSK2RxVnBM/4h4YycBTf3sfQytiCbSA=;
        b=HbBo8+WPRj3gAUYINsoDzCjuSTiw+4IVXg1BUTCPeS9//rIx0Msd7C2/3IOEqhT2au
         ifH40qsXdeHZFBuxYayakoHeI5GVZtrXYa4z/w6+0z4jER+c72ovBtthOxjKcI41NM67
         YXA/sWFk3I3nvVOvAOmNu0p9vJXZsy+n6tDOMAWADhcErgHqJsG6kn/gtiN8Efait3Vu
         g7U8caQMJnfPSx32TxlICATow4MuWMRnhUBnVT4P0Qt7NW+LmYXoK2t0ILvx+H877gGQ
         k9atIi2siVCtlFJt9Qsxt86a9HGAidyo95/yFVpj4YC7TNm3Lvqbki1DKAzL5+qtILlf
         3PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kinXBvz5+I1FgSK2RxVnBM/4h4YycBTf3sfQytiCbSA=;
        b=J/imafKDbdPW8qgefcUBmGmM5kgMg1fBgEzPhmzEAmr+nLA0uQcpYPTy7tstq88UMx
         lBeJ4mNimIiDchWlTkCWqwDpEwQnzFWclA3SjHSvnPvI3vIy4eGj8g1nXLuWOXWEw1dQ
         CZs0G37+GBDlaYxULoQVsTkcJGnVj4JSCGffZtf5yhtVBVp/GKGpWSB/n+JCTVD3Rb+W
         Rv0Z5UpLAvJppgplDX5L/JOKB61t5cmaDr+SJrOSYaKMa3MQLJf8+2nlesTMpgpALJ/W
         ykUDCiCcKN+ss+AYob6+MXcw7JLlUl6ccG9ZXIcDJd8yoYEt7robTYLV8UZz5Tivde3g
         j+3Q==
X-Gm-Message-State: AOAM531sczia6Xd5tUplantL1A0ny8wjgvhlwUQtQTDXD4teSFxGHl9G
        gcw6N3PrNCOTLHCOYB12ic+FUg==
X-Google-Smtp-Source: ABdhPJzU5QZYipbkQZi8xo157t2PrVSjzPMHytPFcg1TfZKTGu677lOERbPf8aPK6zEzeiz5pYn3xQ==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr5463690wrq.38.1593015335565;
        Wed, 24 Jun 2020 09:15:35 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:89ac:d9e8:f44c:b137])
        by smtp.gmail.com with ESMTPSA id t15sm8716207wmj.14.2020.06.24.09.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 09:15:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, lee.jones@linaro.org,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v5 2/2] arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
Date:   Wed, 24 Jun 2020 18:15:28 +0200
Message-Id: <20200624161528.12664-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200624161528.12664-1-narmstrong@baylibre.com>
References: <20200624161528.12664-1-narmstrong@baylibre.com>
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

