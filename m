Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6C3C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C5B20747
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQk1tBzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgDTNA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729390AbgDTNAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:00:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795C5C061A10;
        Mon, 20 Apr 2020 06:00:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so10920516wmc.0;
        Mon, 20 Apr 2020 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ETKn5k65i8M5k8rygdWEKhtzpcpoZWZs8fff2gycZGA=;
        b=LQk1tBzN2LE1TUTnMmo9+vKVOb0sjwhPUhcBE+5JyXh4lbqAB4OeZnyGjVeAQCVLcx
         zfLPoz+cQOLbQrja6EbVn0PUVxvLVLIt5IelawvQXutLYqdG/Yto1hFyBypwhhO7Chky
         oJk+nd7w3D9EnVWa7pbyD3wMpk0uqe/lFtImOy6tcPnFhsKF1hVZ4JbKtLdkcwNnlc6q
         fExU1fAA4CKtj0aD5prBkdgpmfUhpAgLYAkk9CvmzeChkf3LT8G2YLbWOWsEV71yYJ0K
         syovj2jlIk3EtJh8IBaK+zXSIjoJaFv2MHZkHcsrL4iBPqIqJ24lCSn5sI4gBVu8iCVS
         jaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETKn5k65i8M5k8rygdWEKhtzpcpoZWZs8fff2gycZGA=;
        b=Mk4ILHn6g4TR1igfur0b9tpdITMoJhaBSwy8UFM5DQdO/FXrIuXbbIK0+8DnW9MACg
         sDe9AyFd2MN57aGIJtZaIHJ7njATK1LJIBCdJdoBEWkyoRehUmCFHWnj4R7uLxqfdOvj
         INY0JV3SQeMHh8EKi5HKH4mV51KfYTH0tAa7sb5yxcFyoD5hE594Z2zToUftSF0l4IyZ
         Gm2FpFDMT1X/mIUPNHfHAo3cn+RWqYshXcPkSOKhhuulWl7587gNOf2u0Z1yPrTeC4wg
         l2pDcgCDF0+TWgud9VgrrGa0nZ5uvaijnm+15ce06yC1UHq9oQ50PJXyqnsDFFp14zD7
         erfA==
X-Gm-Message-State: AGi0PuazbmbD1dm2HwDqY3LABUgFh5mObGs8qf4QMDczOoLSBxYVbfaz
        w/gz88Slb8MIg7mpPQcCxdo=
X-Google-Smtp-Source: APiQypKiqBVB/X6OED7sVzobaA2CI10ThKFaGr1tgPAoCEcP9piYQe9S9tYLgk1XBCiUBmTT6lbHtg==
X-Received: by 2002:a05:600c:28e:: with SMTP id 14mr8029958wmk.79.1587387630041;
        Mon, 20 Apr 2020 06:00:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id e11sm1081680wrn.87.2020.04.20.06.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:00:29 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 5/9] arm64: dts: allwinner: h6: Enable CPU opp tables for Beelink GS1
Date:   Mon, 20 Apr 2020 15:00:17 +0200
Message-Id: <20200420130021.3841-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420130021.3841-1-peron.clem@gmail.com>
References: <20200420130021.3841-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU opp tables for Beelink GS1.

This needs to change the CPU regulator max voltage to fit
the OPP table.

Also add the ramp-delay information to avoid any out of spec
running as the regulator is slower at reaching the voltage
requested compare to the PLL reaching the frequency.

There is no such information for AXP805 but similar PMIC (AXP813)
has a DVM (Dynamic Voltage scaling Management) ramp rate equal
to 2500uV/us.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 8f09d209359b..3f7ceeb1a767 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -4,6 +4,7 @@
 /dts-v1/;
 
 #include "sun50i-h6.dtsi"
+#include "sun50i-h6-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -77,6 +78,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &de {
 	status = "okay";
 };
@@ -234,7 +239,8 @@
 			reg_dcdca: dcdca {
 				regulator-always-on;
 				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-max-microvolt = <1160000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -242,6 +248,7 @@
 				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-gpu";
 			};
 
-- 
2.20.1

