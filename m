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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2EBC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865C6206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALM3XPSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgDTNAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729824AbgDTNAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:00:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36790C061A0F;
        Mon, 20 Apr 2020 06:00:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k13so10834648wrw.7;
        Mon, 20 Apr 2020 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGJgY52VtWHQubwdBfphQwyESnYnG9XPXa7p4J9NSzM=;
        b=ALM3XPShYXYfs9OQG5uTSuWv5rP6BcYP+yJY6yZ2eF/LtJ4dRg1ZdO0Lw6694HSTYi
         ZX69aeAK2wWfCapedHfDKkx+C8NUndd2BHXzLZj32tB1vxHBUC6pFzG5YHRSDlQkb1L0
         QqP3jfV+gvxRkuW1GctEISBnbXG72HwcXqlpb8JhpjtPNr1CZDOOi4JTDPFnEpCy0D3Q
         KghHrzwJjGBXRjc5W05tYulwVdf14RS5Ud9tgIrpEPXE31FQccrdzSc0jXBbfign7JqE
         RTKfZOng3Y3HDFNhTtV6g78N5Hby+YnH+RNI4R64TQM8HLsqOPA9xQ8e9aXnFlGsRFba
         i68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGJgY52VtWHQubwdBfphQwyESnYnG9XPXa7p4J9NSzM=;
        b=bN3TX1bYGs/bN8PSEWoI4qC+Xm4rtrA1AZ/EQWuRi51lDu+oi+ZPyayhmRgpQE07mZ
         ktpIH3CpRzNAmzjxjmtcxuwPLmsEQw1Qx1UUVJEKs5SJaXuV2dl87bq9il8aaOM98a2p
         S1i6jAaJUeyhzDNPRjik5L1NQH+9OtnO/tqtVX4MRY52+7j/4H/fcDiymyXkyR/w0gVd
         UgGn6tDQ/uXyhD7hx4KkPXfrfW18HuX4g7P9lnzHLkwheZ8T9608Et3+0gBiwWtGINm0
         jrFMBt629uxaKAuuepvOomhDpWrj3speCk8W3y6FFWklb+fYbPMabVbh6hXdVcKd20rR
         F8hg==
X-Gm-Message-State: AGi0PuaZG22jwHmXBXe+9m8OGTxz0n2pfNsQrOEBtf/Qhnkj6IgDgEa8
        n4KzAH2g4WPUL2F9k+XJ9nE=
X-Google-Smtp-Source: APiQypKarzo/roM3OnXspVyqy1L0l7XhAIOi6FGXUHQZz+AxpTJnFh7NPjV2F5qKg2QEJX+7BPv+4Q==
X-Received: by 2002:adf:f342:: with SMTP id e2mr17743221wrp.146.1587387634804;
        Mon, 20 Apr 2020 06:00:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id e11sm1081680wrn.87.2020.04.20.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:00:33 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 9/9] arm64: dts: allwinner: h6: Enable CPU opp tables for Pine H64
Date:   Mon, 20 Apr 2020 15:00:21 +0200
Message-Id: <20200420130021.3841-10-peron.clem@gmail.com>
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

Enable CPU and GPU opp tables for Pine H64.

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
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 63a785b534e1..af85b2074867 100644
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
@@ -238,7 +243,8 @@
 			reg_dcdca: dcdca {
 				regulator-always-on;
 				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-max-microvolt = <1160000>;
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

