Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB67C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EC72076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wHdLPElF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgCZQJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:09:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36407 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgCZQJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:09:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so8498065wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZI4mFYIeUBqyaD+rgbp/dHgudUJiutQ+jywlmvsJi4=;
        b=wHdLPElFbWZX4QzH1H99ZzwKFnHC8E+AE/ASH6YVsojyJt+o9b2frATNFHTv5wWxiY
         svFX3mxxPsXUCxQOiIOhNSFwU1euEqEmQP/tN9msQ/0diAtr2aPEenOzeeOU69qqnYlD
         60BD+1FC/gwXeBM2bIX2LSxcnMVm6LCT+fMFNQu4Fm/aaUBwks2FZeEZS3qNmL9l0ihH
         FX0s6PgP6fMY9AXJN5NfVXYLhx+P14L5IcNUbpvnH0oWNkHpZEdiPiQqfU8B7AYuRXsu
         uur6JlE0s19UUy6x2o8EZBRfLLlZ7DuxRxbmdekEh4WoEf4Sng1lNX0FxlbiBs+a9bga
         ULHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZI4mFYIeUBqyaD+rgbp/dHgudUJiutQ+jywlmvsJi4=;
        b=GfRSAAKIyVf8oUWLa5OTHUwQ//VUqUDketbvoFQYPQbuV0Iq3lDuCDBek2g0TR8zf+
         0vcbVuKGe/e4xKBll4YCXO/ElPe0HBmDnJdFptHNNziAvi/8LUPZP2/Hfgr2qSBb28Js
         zzGSTl5daQybyoWXjjySr6H5R7DMz/gh5VgYchU+uJNSch9nUydVl8721xI88gFh0ZnT
         LNwLUpxMVDAT4vWKMm91rusSUUxrqmG9oJhvmuqfCuo2HJi076SJO3HMj+8esPov/zHF
         7ZGwvyEgzbeWArc3vMyUWmLM2VYDLFobcLyCaYm76V4ObIccxCnGZbg1OfShLwR7bD59
         95og==
X-Gm-Message-State: ANhLgQ37eh5/cDBlGQOeoT/OqoKaK62Y2EWBdpUnWjyEH1BuWQ0N/Sdw
        cLi1qA+B+Nn1RM5MWY/af6CxQQ==
X-Google-Smtp-Source: ADFU+vviie4DwJ//1lgb8NoEiaThjzKQPQnFgaGF/UDsdQxDgsRx38hfv7RxV8qwxxrIMh0gu4KH7w==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr9738134wrx.382.1585238943970;
        Thu, 26 Mar 2020 09:09:03 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id z188sm4093511wme.46.2020.03.26.09.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 09:09:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] arm64: dts: meson-g12-common: fix dwc2 clock names
Date:   Thu, 26 Mar 2020 17:08:57 +0100
Message-Id: <20200326160857.11929-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200326160857.11929-1-narmstrong@baylibre.com>
References: <20200326160857.11929-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct dwc2 clock name.

Fixes: 9baf7d6be730 ("arm64: dts: meson: g12a: Add G12A USB nodes")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 0882ea215b88..c0aef7d69117 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2319,7 +2319,7 @@
 				reg = <0x0 0xff400000 0x0 0x40000>;
 				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clkc CLKID_USB1_DDR_BRIDGE>;
-				clock-names = "ddr";
+				clock-names = "otg";
 				phys = <&usb2_phy1>;
 				phy-names = "usb2-phy";
 				dr_mode = "peripheral";
-- 
2.22.0

