Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E92C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4DAC2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohlUBDD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgEHTKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 15:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727051AbgEHTKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 15:10:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455A9C061A0C;
        Fri,  8 May 2020 12:10:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so11807021wma.4;
        Fri, 08 May 2020 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omKZX10MZ7E8BREXjY7fVemXhJgx1E+OkiXELv9J4Oc=;
        b=ohlUBDD9WPMvEY8r2SP/T4+rUpwNUpbbIhyvu/4ATwmSWBEt522AHcdQNwLDpYgARK
         86WmbwW2incMQ1c6Sgc3cJri9Y4G2mQEsVdkxdC7dnuWGgOOkjWzt5n9Lxh96KweAnGZ
         av4iBGdazIFC+WX/a1Dxx3TnSQheR3+lljhEMBbtRuADGyhq8+30uk/v+jYR/1L8Cbxm
         AybJTjW8wiC1dVqUpPCjBdU6+yExSNGkDH1ENZyXb0fVGRdTHmn9WCBOm1iCAf7MVj+1
         h23W48JyUAAZ892OO3I+Z+VRqA/lnjPnLPfc+4GCe1hwXNFdQAVQDbo6rDyuKpcrH3AP
         qfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omKZX10MZ7E8BREXjY7fVemXhJgx1E+OkiXELv9J4Oc=;
        b=siGKoa/jS9YvTpofI1MxXmQTBqOC5XpP5AXM7j7dxZKonNOCcGWHEPJ4ymk2rpwGMQ
         P4OGWM5nEQUOyMNzSCyrpnlhcjcE7IJjojt9ulnx/S8Fbb/rK0aFipKHyu00mOhjEESI
         50BrDfxwezI6XBgG9dAjwb5Q+HUZxjejMkzfZSPZfd98FkPuylSGGwFP3mIoh+aHEt6E
         bzv7K0HFA1MVFpl2suJMlw4CMC8vQUkE9xa+D3kpHR1gsA5enAA5cNRUwKScxGW/W5bq
         wM/r/COWURt+HIupg2IO4e6IlO5+G5S8Hf5gLz2elxG5fsR2/SZen8QOAvC84jeeM59u
         K4eA==
X-Gm-Message-State: AGi0PuYLVis9Mo+V/vjnDBH6dwzh27d+mC+CxxmKdYRPR5Mr5MnnJznu
        0uVULNfHksfF9BpQjydhgFU=
X-Google-Smtp-Source: APiQypL5pOsX7sGxTrPsfJmqtLHlTiOGtTR8MmJH1hNB/UDH8xoxnGgNUsCnE5s0GcqJSt3Opn/qAA==
X-Received: by 2002:a1c:ab45:: with SMTP id u66mr17237438wme.152.1588965049864;
        Fri, 08 May 2020 12:10:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:29ef:df7c:92a1:e024])
        by smtp.gmail.com with ESMTPSA id 5sm14074670wmz.16.2020.05.08.12.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 12:10:49 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>
Subject: [PATCH 2/2] arm64: dts: allwinner: h6: Enable CPU opp tables for Tanix TX6
Date:   Fri,  8 May 2020 21:10:35 +0200
Message-Id: <20200508191035.24276-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508191035.24276-1-peron.clem@gmail.com>
References: <20200508191035.24276-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU opp tables for Tanix TX6.

Also add the fixed regulator that provided vdd-cpu-gpu required for
CPU opp tables.

This voltage has been found using a voltmeter and could be wrong.

Tested-by: Jernej Škrabec <jernej.skrabec@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index 83e6cb0e59ce..be81330db14f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -4,6 +4,7 @@
 /dts-v1/;
 
 #include "sun50i-h6.dtsi"
+#include "sun50i-h6-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -37,6 +38,17 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	reg_vdd_cpu_gpu: vdd-cpu-gpu {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-cpu-gpu";
+		regulator-min-microvolt = <1135000>;
+		regulator-max-microvolt = <1135000>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpu_gpu>;
 };
 
 &de {
@@ -56,6 +68,7 @@
 };
 
 &gpu {
+	mali-supply = <&reg_vdd_cpu_gpu>;
 	status = "okay";
 };
 
-- 
2.20.1

