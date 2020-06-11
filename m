Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F04C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA371206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jvxxdLqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgFKCGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFKCGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:06:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6345AC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 19:06:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d10so1841918pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 19:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Y4ynudYVEOF2bwcSaKUAcBc0jJC1pTFViDYeCyBDLg=;
        b=jvxxdLqpo+0mRShkaVWeuKTjdbq2SY5zHyPUmlP9mEguLJSjmHKBHGLHY/cTzOCXlH
         eB3qRpNpvIRDJNO6JSxhOVYAWeI1bubmvS8iGittDjXx1zJkHd9kKOYlFpBODIyQu0vG
         bsc7fBBrlfcKF/fevWNzdttAJeifoXfQhjkps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Y4ynudYVEOF2bwcSaKUAcBc0jJC1pTFViDYeCyBDLg=;
        b=hkSESyMcbjmHrNxxqD6myiM1HjouP1SloKcTD7FfFom3lzDD8I8KqQ/VaHb3Ln8XFs
         3IXftrvStEnRuOlbhMvwnGRMErw/RMijhJqxrgquUQ47fGx2kSIhMZ6zkay0yEYynCGQ
         rfVNJFVyeZxfcv+L8PnTMl4fdTJMg1aJOCAhuBSkQgFbpsHhDFZJXGgdWUnN6ZCKHUkh
         +ToJBOtjmvMbsbevEZ8WeaAaoONGFDIXCS1/Z37pGO44HKfpwLbvMm8iEehu+jHh8EEB
         xLkngtw5NovEu8Qn0xA7L3lzXGV0Iiw7kEMZi7Ugs1TxU4Q/5ewJDaK240qumwctx0oy
         QObA==
X-Gm-Message-State: AOAM530LcU5n3SSnN801puC70YNfNsi8x3ZTr4GUbi8REtWXtLrEZU7S
        OZGD2hJJLo2174I7hhPvmcMm2w==
X-Google-Smtp-Source: ABdhPJxLvo0RCihK079Elloiqp25pBxh1dZDJDeBEoYZ+9fEvWiGN7wubOfZ1xMsnxVkw0tD3DWWMQ==
X-Received: by 2002:a62:1c46:: with SMTP id c67mr5101876pfc.170.1591841207862;
        Wed, 10 Jun 2020 19:06:47 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id u14sm1291983pfk.211.2020.06.10.19.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 19:06:47 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     heiko@sntech.de, linux-rockchip@lists.infradead.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org, mka@chromium.org,
        dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: rockchip: Add marvell BT irq config
Date:   Wed, 10 Jun 2020 19:06:42 -0700
Message-Id: <20200610190622.1.I66864be898aa835ccb66b6cd5220d0b082338a81@changeid>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Veyron Jaq and Mighty both use the Marvel 8897 WiFi+BT chip. Add wakeup
and pinctrl block to devicetree so the btmrvl driver can correctly
configure the wakeup interrupt.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
The Veyron Mighty Chromebook (rk3288 based board) is missing the wake
configuration for Bluetooth. Without this change, the wake irq was not
configurable and wake on Bluetooth was broken.

I verified this change with additional changes in the Bluetooth driver
(the series is at https://patchwork.kernel.org/cover/11599101/). The
driver changes are not necessary for this dts change and shouldn't block
it.


 arch/arm/boot/dts/rk3288-veyron-jaq.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index 171ba6185b6d39..976c0c17a71199 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -51,6 +51,21 @@ &sdmmc {
 			&sdmmc_bus4>;
 };
 
+&sdio0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	btmrvl: btmrvl@2 {
+		compatible = "marvell,sd8897-bt";
+		reg = <2>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PD7 IRQ_TYPE_LEVEL_LOW>;
+		marvell,wakeup-pin = /bits/ 16 <13>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l>;
+	};
+};
+
 &vcc_5v {
 	enable-active-high;
 	gpio = <&gpio7 RK_PC5 GPIO_ACTIVE_HIGH>;
-- 
2.27.0.278.ge193c7cf3a9-goog

