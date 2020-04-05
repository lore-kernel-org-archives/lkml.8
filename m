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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A939C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03526206B8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV2G48ZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgDERgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:36:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38194 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgDERgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:36:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id f20so4293494wmh.3;
        Sun, 05 Apr 2020 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFAsHjVU6b7NNT38u9ettTWIqYB/IZzmmPnlZ2m+olc=;
        b=qV2G48ZU/GRR8qj7behLADB0E7+tqrPv8+OwH+8pHoxRPWrQ9PmnUWvRFN2jwqUrsT
         /l51yPoc58h9fkQT7tNQBwrRxIc8X/ZrggXtI+eDQwDHHNaIvUCX9c9Nt3kS25EX3tZ0
         uTUTCVVVYxZWKcSVpNANAZcTIoVAxcRiUe3qr7wP+RCGv57Rz4Cy0hU4sH4oNfgJCdiP
         7Z9fntAo/NmcvGQn8P+5TxKWScrUEKWrDfT4LldHQimFx/rgttHkJJMzQIqxeP1WVy2V
         RDZPOvYLkq36AhLzTtRj9LkKF3ApIHrdY7z8bxyEo/8y9mBO6hocPJVorWvQhStNCAX1
         JnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFAsHjVU6b7NNT38u9ettTWIqYB/IZzmmPnlZ2m+olc=;
        b=mgGmijkO3FZHJn1lOQcUAtptRrBUVHeT6yKSvqkNIrW0khokJ4QsLa3DkJVWB6cXvi
         pvpGKNA4fKWTpP8TxkDxB/Xy5HeEAchlDMFUxAER5bqmDi6/sJNK20rvV9F+MBMPECqq
         GzUbhetPZH5xnkLvWrEcRpNj+JRkBD1dajW5p3hdGcM4OXY2wrL4ou1VBtyV0OctqjU6
         ag1JntFEtdkUjgyEDysMyaoU0lU72C5E3yNOVECxKexsXqz/CXkW35EnReov9WLNWBHA
         bGS6866+VRJ3CuvBjVPLoX2BL5vBuTLXMwl5jtnUSTwuNVv5yHJxzmu8OWkBtu1gSO1+
         YARg==
X-Gm-Message-State: AGi0PuaXsCLTQrta64XFGoRVdpTNFCFkFa58vKFuMOtgNu32SB0YbXh4
        8x2eIHuUuK/RyQWJXIL0LVQ=
X-Google-Smtp-Source: APiQypJPysQWZFaE8PWMr/LYe7GjHyFAHhd6zdO721IN0w1NByz1NXKmyFHLoD2vVuEXGbGbRHX6kQ==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr697924wme.75.1586108171751;
        Sun, 05 Apr 2020 10:36:11 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id s13sm6031669wrw.20.2020.04.05.10.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 10:36:10 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 6/7] arm64: dts: allwinner: h6: Enable CPU and GPU opp tables for Beelink GS1
Date:   Sun,  5 Apr 2020 19:36:00 +0200
Message-Id: <20200405173601.24331-7-peron.clem@gmail.com>
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

Enable CPU and GPU opp tables for Beelink GS1.

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
 .../arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index df6d872c34e2..d76a0dd75222 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -4,6 +4,8 @@
 /dts-v1/;
 
 #include "sun50i-h6.dtsi"
+#include "sun50i-h6-cpu-opp.dtsi"
+#include "sun50i-h6-gpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -70,6 +72,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &de {
 	status = "okay";
 };
@@ -227,7 +233,8 @@
 			reg_dcdca: dcdca {
 				regulator-always-on;
 				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-max-microvolt = <1160000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -235,6 +242,7 @@
 				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-gpu";
 			};
 
-- 
2.20.1

