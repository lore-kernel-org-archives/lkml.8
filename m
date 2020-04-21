Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C07C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67BFC2071C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2P4upNIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgDUIBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgDUIBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:01:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1169FC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:01:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so15368374wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=itZ8nYpO9rVwAB+XOSiZ1Zaz+WlUMeN8KYJbRrgai8w=;
        b=2P4upNIcIwgvXsINcNwMKuLoNxfbr7DA+Jnu8ANYIWyy5/smGGvO2txOPebp357SyM
         9xtX+ZfPGfwrIPzvc5j36V2tN3+T1D+q3dwpBGFE7VWJMfZzVUcqeB+umjUadUUjSCq4
         dATQNiLI4T751oM+fcu4U/Y5XgsSygl4fgAYRVtuCQrFEXrvrVqsI9pgHO4pzjVa1d2T
         x/g46FT49QfIbn30BHst4ECbSzYAcH8x1/3QHciYWeaJJLSUi9kpiF14nf+kIFgFYPdr
         z7RlPTlHlYTEHzsbmqAs+tXOYt5s2M3tLDtDiyBpBUbkaQQNjDkzXMclSxyyLuFi0kbu
         iiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=itZ8nYpO9rVwAB+XOSiZ1Zaz+WlUMeN8KYJbRrgai8w=;
        b=GV4jYwoYDUx+sYXp0/pB8dyVI5N22xYaQ2q1W5HKqFDJyVDDhc4Z1Ly6DgXCIK+KrQ
         DKfn85Meg7E6hlwIO1nWSDsqw0hqD3LqH7Te7lIGwtbW4E1meq8D4je3nR/Utfs1swMB
         3cXVp160lkngQqK3wXARajHRzGrHMEUsADbrtpi4GIhC2fAaXeroaZtlPmKLjkYys9N2
         1P46OeInt5jggwgIHMjw7eWwlom53PHx3j8IdXNMHLN+RhcO9SeTrFBVDD42uImOxH62
         K/xpt5cA4QiwMrKtvFU0cY0+iHfurtWRe60tEYoTgQokFD/bv7Qy5MH0j9Zz/17M9jBz
         jWhg==
X-Gm-Message-State: AGi0PuaPZLtQMdvUUXks88CVYtobpa87LBNd6NadErVLnVvSeWM/P3Hp
        nNK0KyJAg8Zp7ZmT5Y7ctuXeYA==
X-Google-Smtp-Source: APiQypJ7I94NWf5qVdER06WU1+s/LCyUTU03msM+BLEEdT8t06/AWQHMkHiC71sCWlgXL4pKvRiNdw==
X-Received: by 2002:adf:db41:: with SMTP id f1mr21790458wrj.13.1587456078705;
        Tue, 21 Apr 2020 01:01:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id x132sm2561552wmg.33.2020.04.21.01.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 01:01:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     nick@khadas.com, art@khadas.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 8/8] arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
Date:   Tue, 21 Apr 2020 10:01:02 +0200
Message-Id: <20200421080102.22796-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200421080102.22796-1-narmstrong@baylibre.com>
References: <20200421080102.22796-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Khadas MCU node with active FAN thermal nodes for all the
Khadas VIM3 variants.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 094ecf2222bb..3325e54ea690 100644
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

