Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60062C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3780920678
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPds2W0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgDERgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:36:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36807 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgDERgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:36:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id k1so5198206wrm.3;
        Sun, 05 Apr 2020 10:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpDrOVW4CGjRqmVW4DS9/TWcV76xtMAb2kaqMzg2fdg=;
        b=dPds2W0H0HucETftAHC4o51mgBuA3TO0JK1LWeBiPX3R3wHm2V65XnzsC5Q3ArTFPY
         qL87pOuFyVXJ8BSDU5jWFAalVq2uDYgqLdb7ssWe38bn66XzP47XLcym7UPivgj34OiL
         L0Gh1+LtJ0fiWZ8qHsjYmI1X9IL1kOPsFlDOIoSDpM/oZD2wecJjzvRX/KIglJVWJI3a
         AGflKC0YmupGbN2l+QH2tWqxH4YXpyy5ceJDaMbXuDy66FAhOEa5O0GwmrpQXsMMz3pM
         Kyy57Nv7lWHxLKmRSj6TTcOXulAmdGx1XXyX4OgKtwcYNoi0qFoR51Ff/SY5NH+zU0dh
         MTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpDrOVW4CGjRqmVW4DS9/TWcV76xtMAb2kaqMzg2fdg=;
        b=a9XmWsjR7HSQbRziyFxFShw8npZrS5IUYZTPA8/po3Ji8D6XZsvz5MG/hhmRKph4li
         HTIJUV7xyUoF022YpnXkS7YwtbUqZ3VT/HjsBblritmim8xsJnR0/DSOcYSUjf9GsL4n
         lCHRg1nWKWjTO49tzvk58SOD5pxZYwcICiT4g2ehwStyt05/EOgq3W603Cl0vkEQCUgb
         mIhMZORgv+P+2ru5wY/TkRsUvO5ypP45g4huGxPsdJeBZA0rg5UT2Tw8Ehu8VPuW/khg
         wjry3WqfW2OL3DhBMtKUGEgdvX7FUSYHtVKSX0ktSBOpQ8PikDXD6SjOFaMIGxs5fNjE
         EWlg==
X-Gm-Message-State: AGi0PubrepzQQWpEERvHn7WicdXjDSNYXomzWAST5eZOY5J9UCCKuSar
        odvJy6YSUpE8nZINUb+iCBc=
X-Google-Smtp-Source: APiQypIw5vGQ+o0obmPs3lpXvuOamBClwY4w5DsXT20ZYnY09W6mHrbpJWtszqL/S1QlpoqeujVaoQ==
X-Received: by 2002:a5d:4488:: with SMTP id j8mr2584014wrq.170.1586108172846;
        Sun, 05 Apr 2020 10:36:12 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id s13sm6031669wrw.20.2020.04.05.10.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 10:36:12 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 7/7] arm64: dts: allwinner: h6: Enable CPU and GPU opp tables for Orange Pi boards
Date:   Sun,  5 Apr 2020 19:36:01 +0200
Message-Id: <20200405173601.24331-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200405173601.24331-1-peron.clem@gmail.com>
References: <20200405173601.24331-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU and GPU opp tables for Orange Pi boards.

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
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 37f4c57597d4..f3ba500ce4c6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -5,6 +5,8 @@
 /dts-v1/;
 
 #include "sun50i-h6.dtsi"
+#include "sun50i-h6-cpu-opp.dtsi"
+#include "sun50i-h6-gpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -45,6 +47,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -161,7 +167,8 @@
 			reg_dcdca: dcdca {
 				regulator-always-on;
 				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-max-microvolt = <1160000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -169,6 +176,7 @@
 				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-gpu";
 			};
 
-- 
2.20.1

