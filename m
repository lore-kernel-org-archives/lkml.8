Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FD7C433EC
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC15206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V6eXBTMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgGOIe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbgGOIey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:34:54 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF13C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:34:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x8so2088856plm.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YgB0N9dRcA9w6WXseVOOZfeq0/D4u3nNZYgCsL9uaRw=;
        b=V6eXBTMb1oMmkAgTEHHnyyDfZF9VapwcfOnuzC5FnKWSmcfLUDEbTrNQKhfI+sXwBh
         qEDph4vNKY4+RmTwKIPyo2OYCjSG3Ekp1cC8j18AWmwZCDZ2iLeB881Va+NIWvqoJ8Tj
         7voMtlY0djIQm9XoneunlcMwxu0kt6hrh77zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YgB0N9dRcA9w6WXseVOOZfeq0/D4u3nNZYgCsL9uaRw=;
        b=bWfpA+q06W2sN8ns+8nVswzbOfuedrgbwoKcjWRsFcxWZfiEKhqwIDSr5BQKNOBI6m
         Euo7sRvoxXTh55SAr+one5CylKoVqA/S9YAYl87YpRAJV7agqQNvSjZyvhCLeWxPd+k+
         QdurdIUto88w35Kklw4VVLKwzAQ9Y5Ap6YBstFU9iLfInJZWRU7jGIzTAXExY//Kvt+8
         pwAyUuBviDucgdclkeQfguXcbiyreKjCIl5siX7iqczha/hPzaBDYpBn0TE+zk+TLJGZ
         hh5CE/0IrXzMGobfJ6kWua8DuUCupgljl/aKmS/kRJ0DIXSqiHB3FwN1WMyMK5LO1ZyV
         cQag==
X-Gm-Message-State: AOAM531jbRzKY3EJhwAFeJgcPvfxpbUIExnLhFV2wZbsDSgnALZSNDL1
        Fv44fSP15k1/++KXv3gD3Ox1VA==
X-Google-Smtp-Source: ABdhPJy/1St0AM52RbZ1D2GNO3p7hMgJK4ErEOABtcyvh5WcN2PObiswr/7zW2yu+DCXFJ9PZZAJJQ==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr8358830pjx.169.1594802094012;
        Wed, 15 Jul 2020 01:34:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9887:56a8:c916:cfdb])
        by smtp.gmail.com with ESMTPSA id m92sm1467584pje.13.2020.07.15.01.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:34:53 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 3/7] arm64: dts: rk3399pro: vmarc-som: Move supply regulators into Carrier
Date:   Wed, 15 Jul 2020 14:04:14 +0530
Message-Id: <20200715083418.112003-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715083418.112003-1-jagan@amarulasolutions.com>
References: <20200715083418.112003-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supply regulators are common across different variants of vmarc SOM's
since the Type C power controller IC is part of the carrier board.

So, move the supply regulators into carrier board dtsi.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v6:
- spilt of previous version Trivial patch

 .../dts/rockchip-radxa-dalang-carrier.dtsi    | 19 +++++++++++++++++++
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 19 -------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
index 176b53b8e41a..00b200a62263 100644
--- a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
+++ b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
@@ -11,6 +11,25 @@ / {
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
+
+	vcc12v_dcin: vcc12v-dcin-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
 };
 
 &gmac {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index 121a430d6a70..d8fa8127d9dc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -18,25 +18,6 @@ clkin_gmac: external-gmac-clock {
 		clock-output-names = "clkin_gmac";
 		#clock-cells = <0>;
 	};
-
-	vcc12v_dcin: vcc12v-dcin-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc12v_dcin";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
-	};
-
-	vcc5v0_sys: vcc5v0-sys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc12v_dcin>;
-	};
 };
 
 &cpu_l0 {
-- 
2.25.1

