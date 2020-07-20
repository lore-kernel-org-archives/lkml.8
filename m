Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74636C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8EC22C9D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RUqeyyph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgGTLDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgGTLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:03:10 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75903C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:03:10 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o22so9917200pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ag4rQp+sFMdKPCQUR+pc46MOuVsvRvVxw/7NKoWEvi4=;
        b=RUqeyyphYItfAYOEz4jU6KvEZKFYURbhVgzm5CoqlFEkp+DJDzgOeG7DjnT1JYUljg
         xFqMrHue0UG8A49aAaKDaV+FjdmldlcXwBPG3PF5F/l7kDN1jeuGy/+abZKyGaWtNh6v
         ixcO+9ultuo+A8BiAjitPvKh+8uUVGvy6zaBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ag4rQp+sFMdKPCQUR+pc46MOuVsvRvVxw/7NKoWEvi4=;
        b=OsxaUbLCzq3V38bsZU1usdBD9Z3WVyYQAAqeE2HwR/Qr1z0Q0et0yFdsiUtHQzEIPW
         jEMGAy3wBR74HWVxuQf/rC5/vy/iRP2Oy4nZt2KFPfCgUxjIW91gKBX/gJOvkyS9FE2i
         JFdCUsLgkHKi8QEWvkwOhWVYMLDK+oe7NUvIvFZ2iA/zw5xV7yGV7bleFL+TfpLbAllc
         6Iba7yQEZZUoDlEGnYGfSexJ9TLn+FqpkK5VhcfMdkV+7I/BKXv+70qzP9v90DLm5GZe
         AT8x3caOd99/kUtLtsfHdwj5FIpIgem1JH28z2z2QZi1SDKupQ9NFh7E9BEhVFPWQE/M
         m+Gg==
X-Gm-Message-State: AOAM532rDBWlohLXu8YbWbgtGkAGDQpw5oaBxpiSemneaRoPAvW4f98A
        F1RzOjlebpp5QdWYdUQ43THZeA==
X-Google-Smtp-Source: ABdhPJyX6IuKahehCTP5Pk5hKMt3rhOIfMuShwBd/T+H2/oakh8i0vb1wEgVp+Lb30iuSZVg/7fr3w==
X-Received: by 2002:a17:902:aa84:: with SMTP id d4mr17371571plr.208.1595242990019;
        Mon, 20 Jul 2020 04:03:10 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:8c21:db7b:4558:fba3])
        by smtp.gmail.com with ESMTPSA id o10sm11445876pjs.27.2020.07.20.04.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 04:03:09 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/3] ARM: dts: rockchip: Add HDMI out for RockPI N8/N10
Date:   Mon, 20 Jul 2020 16:32:29 +0530
Message-Id: <20200720110230.367985-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720110230.367985-1-jagan@amarulasolutions.com>
References: <20200720110230.367985-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to enable HDMI out for
N10 and N8 combinations SBCs.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vmarc-som.dtsi       | 10 ++++++++++
 .../dts/rockchip-radxa-dalang-carrier.dtsi    | 20 +++++++++++++++++++
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 12 +++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-vmarc-som.dtsi b/arch/arm/boot/dts/rk3288-vmarc-som.dtsi
index abe3c01d13aa..ba2732ec72da 100644
--- a/arch/arm/boot/dts/rk3288-vmarc-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-vmarc-som.dtsi
@@ -38,6 +38,12 @@ &gmac {
 	snps,reset-gpio = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
 };
 
+&hdmi {
+	ddc-i2c-bus = <&i2c5>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_cec_c0>;
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	status = "okay";
@@ -225,6 +231,10 @@ regulator-state-mem {
 	};
 };
 
+&i2c5 {
+	status = "okay";
+};
+
 &io_domains {
 	bb-supply = <&vcc_io>;
 	flash0-supply = <&vccio_flash>;
diff --git a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
index d2b6ead148a2..26b53eac4706 100644
--- a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
+++ b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
@@ -66,6 +66,10 @@ &gmac {
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
 &pwm0 {
 	status = "okay";
 };
@@ -94,3 +98,19 @@ &uart0 {
 &uart2 {
 	status = "okay";
 };
+
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index 111d6cf9a4e6..ebccc4a153a2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -39,6 +39,12 @@ &gmac {
 	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
 };
 
+&hdmi {
+	ddc-i2c-bus = <&i2c3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_cec>;
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	i2c-scl-falling-time-ns = <30>;
@@ -285,6 +291,12 @@ hym8563: hym8563@51 {
 	};
 };
 
+&i2c3 {
+	i2c-scl-rising-time-ns = <450>;
+	i2c-scl-falling-time-ns = <15>;
+	status = "okay";
+};
+
 &io_domains {
 	status = "okay";
 	bt656-supply = <&vcca_1v8>;
-- 
2.25.1

