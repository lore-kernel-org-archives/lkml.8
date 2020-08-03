Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCCEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BDC5207FB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="albycSFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgHCOTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgHCOTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:19:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C24C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 07:18:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d190so14466736wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/qA8gSb5L1aedrAB+cnwrMt5FiS/mFTvYHuJN7H++M=;
        b=albycSFNZC8kfgH16k++F8/X0yCQh2L6nvlv0z/riHZdTBBLoXZIgUNGEJQJQXAWvP
         tpnajBTPb2Hx4MZG3B3ErbNiHPfmd8VavN/W+lWdxErdIktJY8VNRRsCcl1xDan0/98r
         lBLcz6Pr6HXl6waYqdbPaDrg+d64cAULpiD6puY9fAzRH1NgTNfQx/0fCYDGp/ncaEVe
         vTl+aMq27RjcFqaC7O0WV9P2RiNQp+RQFbK+y9VDuiBRY+h+NpniwBnXMZYrdAq+6mEs
         hDSXC1AvyoajqVcJDGSBjXwxJxLJ5F5zyyydA8w4XPdouOKsowFQMhW6SYqEqIJMfr0N
         4MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/qA8gSb5L1aedrAB+cnwrMt5FiS/mFTvYHuJN7H++M=;
        b=MNlKKK2g8ufvb9ax7343sv1AE5/HURe7J4NfYPlqh6A4cRcTqEG8ZTssnFIG1oBEek
         3NA5onqIqRs+IsE5GFBdUs/A6+vqpr+FQS9QHY7XCXYlIk064VCvnZ+SfV0/DQ0GYk4+
         1O30z+QOLKH0Gknr9EMkHeutvFoOjQ2Y14vXlZnx9HO2zVc4D0zJAUMSRpJKGP+GburO
         dCUtObldBgYSP/N+YGdK7CKZQq1AmcuMzxYb7P8Untgsy2sEh5agcDA02GFdYyIi8xng
         81PWiFiBdocyPFFM+cAsck5SgeUywvpD4yVRvQqwCCRi2JHTG6O2gySzS3aO0FaoVudH
         qt+w==
X-Gm-Message-State: AOAM5333V29s0dYnJATffLSCGp2Mu8d7hcc5QZhjXCDIvFm5y6pasapK
        PrDi2Xi++vDuDVwycasj9sZGqw==
X-Google-Smtp-Source: ABdhPJzbV6bSqxztQ0RcDqfomj9eHW6XIBQxGt/q6sEjUvi4WKNFFkRXdU/aVORDBtacwX1oL8hqYQ==
X-Received: by 2002:a1c:e382:: with SMTP id a124mr235177wmh.11.1596464338292;
        Mon, 03 Aug 2020 07:18:58 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t202sm24870600wmt.20.2020.08.03.07.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 07:18:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: vim3: correct led polarity
Date:   Mon,  3 Aug 2020 16:18:50 +0200
Message-Id: <20200803141850.172704-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LEDs on the vim3 are active when the gpio is high, not low.

Fixes: c6d29c66e582 ("arm64: dts: meson-g12b-khadas-vim3: add initial device-tree")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 4510a63b0006..9e2995dc144b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -70,13 +70,13 @@ leds {
 
 		led-white {
 			label = "vim3:white:sys";
-			gpios = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		led-red {
 			label = "vim3:red";
-			gpios = <&gpio_expander 5 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio_expander 5 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
-- 
2.25.4

