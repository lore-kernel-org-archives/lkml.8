Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79642C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F8F206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JhJWP2KI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgGOIev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbgGOIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:34:50 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01668C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:34:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b9so2098811plx.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5iXaht479GnGhX17VzhQEzhFfkqxgmW23gJMSjYcgI=;
        b=JhJWP2KIMyTazKOBVKdxv6a942aDAALi0JdTWyEIrAkKg26chQuO5fK00XKgqYkLjw
         lYkqvr9fFxnBIFNxlS7iUs2dGXWXeVZml2+4oRfgIVZGPtZ0XBKueuHg/7nkbkiBzAWg
         aZTOEDyv+dc7OG7QWqDfXQ1bfhC/pt4e9Aa20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5iXaht479GnGhX17VzhQEzhFfkqxgmW23gJMSjYcgI=;
        b=LS6xcNaCfYmM0s4Ul39MW97FQPlUmTudlvYCZbBsspp6khYZ7L327ZuvRAAdDTbvhx
         wMjns/Yh80ynuoWiA40Dg1vT0TsUMvmvWTJEOS4U2vpAmp1qjP1QKcHRhDYiTWvJ0WZ4
         mXu7n5wg5USR6Z55dWxOVI58OjxjHQ/adqI+PAw3cGcRN9y4QW5o5uczMyBbWupAQHIB
         r/zryRUM+l+j80IEmf0Q8V9+x6oLSjWb2xJb+HGQD5XDoVole81ntHbYuAZgoQRAI5jD
         4z+TNt2vi3gvmNOdeMvZjqIhYgGeFFeT5GjIom1AlsEtuSKh/LIfBNHAi6KEs0YAQhfK
         gfIg==
X-Gm-Message-State: AOAM533yPI74lWijPqBrxifiTBwPQDcdGSr38wr6YymrNqSFkiT26K2i
        pbOmX+F5Rx2Arnih94T5AvUMfg==
X-Google-Smtp-Source: ABdhPJwUM/KOTmuZSRAHhXmTz7Hqdz2ADBYxx5P0O5G43ml9Ecief/OST/FVbAgERz6lKiYBLLVTaA==
X-Received: by 2002:a17:902:b113:: with SMTP id q19mr7393133plr.170.1594802089528;
        Wed, 15 Jul 2020 01:34:49 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9887:56a8:c916:cfdb])
        by smtp.gmail.com with ESMTPSA id m92sm1467584pje.13.2020.07.15.01.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:34:48 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 2/7] arm64: dts: rk3399pro: vmarc-som: Fix sorting nodes, properties
Date:   Wed, 15 Jul 2020 14:04:13 +0530
Message-Id: <20200715083418.112003-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715083418.112003-1-jagan@amarulasolutions.com>
References: <20200715083418.112003-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix node, properties sorting on RockPI N10 board dts(i) files.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v6:
- spilt of previous version Trivial patch

 .../dts/rockchip/rk3399pro-rock-pi-n10.dts    |  2 +-
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 35 +++++++++----------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts b/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
index a1783e7f769a..539f4005386d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
@@ -8,8 +8,8 @@
 /dts-v1/;
 #include "rk3399.dtsi"
 #include "rk3399-opp.dtsi"
-#include "rk3399pro-vmarc-som.dtsi"
 #include <arm/rockchip-radxa-dalang-carrier.dtsi>
+#include "rk3399pro-vmarc-som.dtsi"
 
 / {
 	model = "Radxa ROCK Pi N10";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index e11538171e67..121a430d6a70 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -76,8 +76,8 @@ &gmac {
 
 &i2c0 {
 	clock-frequency = <400000>;
-	i2c-scl-rising-time-ns = <180>;
 	i2c-scl-falling-time-ns = <30>;
+	i2c-scl-rising-time-ns = <180>;
 	status = "okay";
 
 	rk809: pmic@20 {
@@ -323,8 +323,22 @@ hym8563: hym8563@51 {
 &io_domains {
 	status = "okay";
 	bt656-supply = <&vcca_1v8>;
-	sdmmc-supply = <&vccio_sd>;
 	gpio1830-supply = <&vccio_3v0>;
+	sdmmc-supply = <&vccio_sd>;
+};
+
+&pinctrl {
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <4 RK_PD6 0 &pcfg_pull_up>;
+		};
+	};
+
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <1 RK_PC2 0 &pcfg_pull_up>;
+		};
+	};
 };
 
 &pmu_io_domains {
@@ -341,22 +355,7 @@ &sdhci {
 };
 
 &tsadc {
-	status = "okay";
 	rockchip,hw-tshut-mode = <1>;
 	rockchip,hw-tshut-polarity = <1>;
-};
-
-&pinctrl {
-	hym8563 {
-		hym8563_int: hym8563-int {
-			rockchip,pins = <4 RK_PD6 0 &pcfg_pull_up>;
-		};
-	};
-
-	pmic {
-		pmic_int_l: pmic-int-l {
-			rockchip,pins =
-				<1 RK_PC2 0 &pcfg_pull_up>;
-		};
-	};
+	status = "okay";
 };
-- 
2.25.1

