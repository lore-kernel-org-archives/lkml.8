Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADD5C761A0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 20:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A088120726
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 20:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfX3pzUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgBPUV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 15:21:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41717 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgBPUV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 15:21:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so7911210pgf.8;
        Sun, 16 Feb 2020 12:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z3zfUADPk/oUyuzJ7VgI1Juwrp+2x57KXXaZ+inluLQ=;
        b=FfX3pzUBHrAj8jkxvad38rERLbzrfN6+fcK0HplUj8CLnl7DtX87kPUDbcoasbyS82
         pQ9uEpb/xIrz/MpMfylFu9z6L8g6whgnCiUxq23GL/a6EihKQsLBTMhTmqA3SR80+h3C
         TOvZGwwM3Ko2e3npVE/d9dI4cNkAaL7Qxbt8OrLFDQIX/f+OmLSd0W5/RWKSV4VcC9Wv
         vXPCJGyEPhvzo8tY6cuI+5EwhTPJxkYVb0HlES2oO/AUQ9Y5ytzRHlLfZX8frnnwgg1N
         gYKdezI67yJAV59FQoRuM3NVQtL6Fp6/jKR2Wuin3KONqeeE4YATVM6KqbQBaSRCOdJQ
         hb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z3zfUADPk/oUyuzJ7VgI1Juwrp+2x57KXXaZ+inluLQ=;
        b=XA8ipsank3fZA1zpRZIOjy//fBpAOsU3fg/woqj1FIxWoVFGuXh4hg11FftQFzTtYa
         uRLq8LDN8rpIhJi8Xm3w/XGJhBTg13Z28j9j+lrCqWlmUcLED6+hazU/A/ZqTRF4thEm
         HiTkD/K8psitlN1eL8BtZzKMLMKMb1W3hyaKRKiHflYPfkYwE43mdYmWMftF2uHkmUN8
         DVA6Eqj1KtluwYAkrEhPATmGjFk/7DU3bUdhNhrit4gv6AHeHUjy/DDSG4oEz7p3UFLG
         Cw175o+n2unw+rrIUWqPxTDCpFttNoxHI8lS/yWNzznwCqytYgtavOVZqpCraUZxeAg4
         2jvg==
X-Gm-Message-State: APjAAAVhZst2VugebkT4xsWE5sR/uEegtRU58D1LI0XscGge45H7Xde6
        sDw4h6e5DMg87AfR314mT88=
X-Google-Smtp-Source: APXvYqyt1ki5Ed6SRzWgLcOn7teb9PcdZLafsaTmcNNnAg3NTxCIsHfcmSjKmDh3o1T8Dzjfc5dRxA==
X-Received: by 2002:a63:9dcd:: with SMTP id i196mr14159101pgd.93.1581884485869;
        Sun, 16 Feb 2020 12:21:25 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.127])
        by smtp.gmail.com with ESMTPSA id l69sm14424750pgd.1.2020.02.16.12.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 12:21:25 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] arm64: dts: amlogic: odroid-n2: set usb-pwr-en regulator always on
Date:   Sun, 16 Feb 2020 20:21:01 +0000
Message-Id: <20200216202101.2810-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb-pwr-en regulator is getting disable after booting, setting
regulator-alway-on help enable the regulator after booting.

[   31.766097] USB_PWR_EN: disabling

Fixes: c35f6dc5c377 (arm64: dts: meson: Add minimal support for Odroid-N2)
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Patch generated on top of my earier patch.
[0] https://patchwork.kernel.org/patch/11384531/
[1] https://patchwork.kernel.org/patch/11384533/

Before
[root@alarm ~]# cat /sys/kernel/debug/regulator/regulator_summary | grep USB
       USB_PWR_EN                 0    1      0 unknown  5000mV     0mA  5000mV  5000mV
After
[root@alarm ~]# cat /sys/kernel/debug/regulator/regulator_summary | grep USB
       USB_PWR_EN                 1    1      0 unknown  5000mV     0mA  5000mV  5000mV
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 23eddff85fe5..938a9e15adfc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -177,6 +177,7 @@ usb_pwr_en: regulator-usb_pwr_en {
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc_5v>;
+		regulator-always-on;
 
 		/* Connected to the microUSB port power enable */
 		gpio = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
-- 
2.25.0

