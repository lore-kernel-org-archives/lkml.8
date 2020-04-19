Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE01C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EDE21D94
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRpYW7GI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgDSNu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:50:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0207C061A0C;
        Sun, 19 Apr 2020 06:50:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so7494984wrw.7;
        Sun, 19 Apr 2020 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+OjEGx56p5nShQkF9i2bVGbxPWUEyMjxVk1NXXnab4=;
        b=IRpYW7GI7OPPAPHhvhb/srgP8tmGqqnNd0SkG/k3XrSQB5A0dXikTzXCxcUr4+nj5k
         uonLZsT1rYp80VIudZ3+PFaMZZF1zxtCrF0bkCElVGoxHV44376LXWHaQiaceF9ZLd9O
         h6HxM2vE6MG4+nIQOYbELFLfgy0J4dzaSslzfR5kuHoYT+jR7FYlsHWKJ4vY0gR39E7A
         LrKxwHYJyILfq0r7Kjtzv/G4JNJ+F7iv2N64KKMjTIdsrveEwrpa9x30JsZmlrfiW9CS
         a85dIZTF3yeiPouFbP+bqK1DE2qjjUHNd3vSLG2m57ySJbDuNrtRc2Q8Lkgz5cBmWY6c
         4Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+OjEGx56p5nShQkF9i2bVGbxPWUEyMjxVk1NXXnab4=;
        b=TVKVHkB/o0zh0HTDOC+MWwMj1N7z42Y+0pgKk6uccB3VLvRde2Sow5yNjJ9ttq/kG5
         KnpanHtrEeOugTAOgRA6b7JSUcy48I7dgkrPeEfWabP6TRxAAYW7olPnncwjb+tZxb0K
         bR+ttGSH1LZ2MukgBG9iMtwQj/Ox+jINw5Tm6JA/qw/yewsBaLiyUXN0jQ6siMgczADo
         S8TQZLX7NKR0+vfxIu6sn818x2+MnC1WqPgmlBVgMpAFozsfVpCvyo8fRA6ImJ1eGk+x
         /SCXuls3/9ex5rQoewN93mqYUl2aGHCoLQOXaBt5F9heF2Dw5hsjEl7CQH/69f9UE0M7
         A6Xg==
X-Gm-Message-State: AGi0PuZ54S5+AemQfxVdHZw5WP9k/++aC0gE7MT2U8MFrFc2eselBWuq
        B7EN7+/GMGyxJA4WRCdbaVE2Mx18MI5Yng==
X-Google-Smtp-Source: APiQypL5C06Bf6yVWNwxLLJrMfFXFPzgVn6j2eawN9bgs0TIdNfqR+FQtHny+5CKgOHVnG93TVnL1g==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr13528540wrw.318.1587304221588;
        Sun, 19 Apr 2020 06:50:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id z8sm20183940wrr.40.2020.04.19.06.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 06:50:20 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 7/7] arm64: dts: allwinner: h6: Enable CPU and GPU opp tables for Pine H64
Date:   Sun, 19 Apr 2020 15:50:11 +0200
Message-Id: <20200419135011.18010-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419135011.18010-1-peron.clem@gmail.com>
References: <20200419135011.18010-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU and GPU opp tables for Pine H64.

Also add the ramp-delay information to avoid any out of spec
running as the regulator is slower at reaching the voltage
requested compare to the PLL reaching the frequency.

There is no such information for AXP805 but similar PMIC (AXP813)
has a DVM (Dynamic Voltage scaling Management) ramp rate equal
to 2500uV/us.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 63a785b534e1..60fd33f657dc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -4,6 +4,7 @@
 /dts-v1/;
 
 #include "sun50i-h6.dtsi"
+#include "sun50i-h6-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -80,6 +81,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &de {
 	status = "okay";
 };
@@ -239,6 +244,7 @@
 				regulator-always-on;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -246,6 +252,7 @@
 				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-gpu";
 			};
 
-- 
2.20.1

