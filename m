Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706A5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504D62074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kynetics-com.20150623.gappssmtp.com header.i=@kynetics-com.20150623.gappssmtp.com header.b="Yz1AY4Xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbgFONFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbgFONE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:04:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B41C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:04:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q11so17069691wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGnsrUoVOZBXJ5xWuUjcUkSKUeGXoNVTCOwqDvT4FJM=;
        b=Yz1AY4Xm2PX4fmylnCSynNbDi5nrFVCSdQsIH2aiqiDYSkgiZnecyZpZwQNZpksdV2
         c7VBDnDUAteERJ7oS6HTSrHQ2GYtuDYSPprHk0TkMEHCkEPid0EUk36Py9M38A1g/SWd
         9Aj4d62t2zAtaiVvKqWef28MHtUF3BNC7Mk/fFXRezJ3WBiriFz6+YPH5E54D5CXzJa+
         DVFXVBmy+swiz9FwBEtPz3ZT3ZpZMysJ5X46nLC2y/ChxSHt8s8FN82Zfms0T0A9yF2T
         a4b/CKxLv+OtVwNo9RUIqbIZg4jWxP6gLlyv+gdU6a/QH2CZFtQgpchIk+fv36QUJV3X
         38NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGnsrUoVOZBXJ5xWuUjcUkSKUeGXoNVTCOwqDvT4FJM=;
        b=VGAuVhB7Hc3qMpIAOOeHbIlU6C26f+x37M/p/svOg5OC8lidpILRcNq0dKKETCeena
         2osK0y0CZl4glwTiruCbZ40Pj+RI44jha6NU/eQy2h5pHDQ99/AQV2HdAS4Peb+J6MDj
         naLilr88T+Qr1kAKJPt8zK8t72Mp8XT5crocDYapQfecnpZI2qwHGtGIURqK7kTyY/bL
         bzFrqIDvA8BtOyzhiROQ+pY7rkhhFl4xIHnYnlByRXh1oaSWwvAP3gT75thZIp69onvt
         TSUPZYq53afe4W49s2Fq9wvh9HF0+kfeJwR/fZj0sM6Lcpw+HDCBjFIJETR7Lbmx2OpB
         ALAA==
X-Gm-Message-State: AOAM532pvbH0qGOdMt2si9gh7/J/1PTIxIh6q8pOEGG/482VkIV2bNCD
        j7P5sdlYcKn5entS/piLKuIfVw==
X-Google-Smtp-Source: ABdhPJyCbA4P7k40uO6mt2bOu07HU/fYBKq+e7S7CG+VE5FlaW3M581dKgwaQOXyEbfX2cDE+gWybA==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr28032503wru.268.1592226294967;
        Mon, 15 Jun 2020 06:04:54 -0700 (PDT)
Received: from localhost.lan (mob-37-176-61-186.net.vodafone.it. [37.176.61.186])
        by smtp.gmail.com with ESMTPSA id s132sm23900345wmf.12.2020.06.15.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 06:04:54 -0700 (PDT)
From:   Diego Rondini <diego.rondini@kynetics.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Diego Rondini <diego.rondini@kynetics.com>
Subject: [PATCH v2 2/2] ARM: dts: orange-pi-zero-plus2: add leds configuration
Date:   Mon, 15 Jun 2020 15:02:25 +0200
Message-Id: <20200615130223.34464-2-diego.rondini@kynetics.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615130223.34464-1-diego.rondini@kynetics.com>
References: <20200615130223.34464-1-diego.rondini@kynetics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pwr and status leds configuration and turn on pwr led by default for Orange
Pi Zero Plus 2 (both H3 and H5 variants).

Signed-off-by: Diego Rondini <diego.rondini@kynetics.com>
---
v2:
- sorted node alphabetically
- fixed underscore in led names
- removed extra empty line
---
 .../arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts | 15 +++++++++++++++
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts   | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
index cbe32b975c5fe..251bbab7d7073 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
@@ -70,6 +70,21 @@ hdmi_con_in: endpoint {
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		pwr {
+			label = "orangepi:green:pwr";
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		status {
+			label = "orangepi:red:status";
+			gpios = <&pio 0 17 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	reg_vcc3v3: vcc3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index e67733d133bb4..de19e68eb84e0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -30,6 +30,21 @@ hdmi_con_in: endpoint {
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		pwr {
+			label = "orangepi:green:pwr";
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		status {
+			label = "orangepi:red:status";
+			gpios = <&pio 0 17 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	reg_vcc3v3: vcc3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3";
-- 
2.26.2

