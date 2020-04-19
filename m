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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B27EC54FC9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A41122202
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgiAOtVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgDSNuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:50:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E633C061A0F;
        Sun, 19 Apr 2020 06:50:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k13so7494833wrw.7;
        Sun, 19 Apr 2020 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ETKn5k65i8M5k8rygdWEKhtzpcpoZWZs8fff2gycZGA=;
        b=rgiAOtVHPa1zatADZlRO24mQNsXNHAxivgbcNTmfXyMdlQ00fNv5bV2ehm35jthzEd
         SHRg+OIOz8myxhPDfKFajej7usenM4P77EfYLjTHYIh2iReXohgKdygH7wlVm8CNbUgn
         Dj7E30PjybDOCviu7E4b3UULqkNMDR9dg0OiUD6oIffo1aM+ErVh0tWaNbPvDnTFYBv1
         h0mkU4eqJx9bXaye4UHAqNcGvtK6R1shtJXYc2pZRZidniA5x4aiLnAQSjtc8VWLqp/3
         G3NCXt1DApoMVjycr451L2mq5Soxch09ZvQbJncV3Y1PoMGlUmLxrW3uFjaL35v8uMA+
         QFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETKn5k65i8M5k8rygdWEKhtzpcpoZWZs8fff2gycZGA=;
        b=hx7LW5GOEcYgpx4RG6K1v4AtGzaTmRseVcatq2t1tgaK4UNiMtw6YrBzfgECj0znZT
         1UnyOusL8h3tjNphllxpIQBqpXY+Y1AAPfRxLf9N48nioH6tXb6NIMGTjzScvvVayyT2
         pgguoIrTu6oxmOoWWkFkPXG0h8wTjk6vBjbdBwbFYnZxBVkPJYxPUhJWtHi1bE2kwqyv
         yUgS0GCcNMUX24aGnj3SL9sIkT83qDdZycRFZClgG6OCE8IbHcYTVPBol7edi2Lq4u6L
         ksicb1/AVS1+6DKxMWAOAQPnpdLPGJMo95LlbnNYXwisKEu4e7QsxpKgH1F8iZ2dNHR0
         GwCQ==
X-Gm-Message-State: AGi0PuY1/cTaFrYMXTcL+mxDTUDPgoHoU4l9A7EsQCkcroS+dOL/d8wF
        4q0W/YeUkIl0L8Acr3U93zc=
X-Google-Smtp-Source: APiQypLWb6JaBbHbIaPvq6jUnkWNI1T6T4GUXsqZp3+S35yKOvv/C3kGsMefXplJu6vKaunuodoaTw==
X-Received: by 2002:a5d:4248:: with SMTP id s8mr13483030wrr.216.1587304217237;
        Sun, 19 Apr 2020 06:50:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id z8sm20183940wrr.40.2020.04.19.06.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 06:50:16 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 3/7] arm64: dts: allwinner: h6: Enable CPU opp tables for Beelink GS1
Date:   Sun, 19 Apr 2020 15:50:07 +0200
Message-Id: <20200419135011.18010-4-peron.clem@gmail.com>
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

