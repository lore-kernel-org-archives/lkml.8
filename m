Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E09C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FBBB20736
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfHuYExQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgDTMrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726726AbgDTMqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:46:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26599C061A0F;
        Mon, 20 Apr 2020 05:46:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j2so11955001wrs.9;
        Mon, 20 Apr 2020 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/ha8QAQ1qR8D+PPkPVAqbB8YM+gWp3JsCHNoS/IoFE=;
        b=VfHuYExQZ97JSY37qYtKiIzXOvUHrwNWaDOzQk27e9rqoAuanaoWWV2xShG3NO1wdN
         7K6HuEEHVzdCEKRVx47481DWd9e2BpWd+B//oXI3k9PFJiVJRBHTmzAPa4q+/mY+ijQ0
         0SEcBPSsbgJYw1kqYpSxXL7adM5iPgrY9LG/4zgjAg12c23/qjBFXOLVfqpR087WVNvz
         uEc6O2r7kbOrir8rgAZvNePdwMjsEDvu3h/B9vmBzEnWpOAQTuhrMCNXbqs10DXauygd
         nN1muoiob6bj3y2t1VyxjXM82llz4lHaVOvCR1AhbaFDWusaoNpgrgZrD9dRcHnVVJqf
         +xKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/ha8QAQ1qR8D+PPkPVAqbB8YM+gWp3JsCHNoS/IoFE=;
        b=HARx07+jsoRVCgI+KYj41+0pGtTw1UEKRgILNO7wQS3ww1fY4b+rvxthEjU34vy1xv
         +/PRw3PcUyTxTdULZRBxOu/GY7HK+BRYK8mSNjsiMF18QIeeLmVwh++J8fpG1x/rm29C
         SYC019YBrsQPgA3n+hFBD3SN0rH96jZfN8NJZIt4DBXNHm10c8ENKtOUxeSeoz+z/375
         gmGGZFP+vgJ3flYGWhvEh/a8CFOVRsgBQzxchKtjP9rI969feazVFB+itiPTIxYaF9Ng
         14bDzAHUooMyO72azyLUVHdFcMPj8IU2Rv8Op1LNNZL6zyKrvfzsxzqd+dG5omIo0ADC
         2OFg==
X-Gm-Message-State: AGi0Puar/51QENYTSxgZxsAukcF2yu4G+eVWWVYkBGpdu+X3OdRhB21J
        cFBDFejcvr/9pBBAqniT/SQ=
X-Google-Smtp-Source: APiQypKnx33o/rJS2SWygWjCaWHRxWvOotCeldokd3D5Mero1E+X+SKoXFMzcdQhRJxrt8mqZeA+8A==
X-Received: by 2002:adf:8162:: with SMTP id 89mr17890205wrm.387.1587386799750;
        Mon, 20 Apr 2020 05:46:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id h17sm1217802wmm.6.2020.04.20.05.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 05:46:39 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 2/2] arm64: dts: allwinner: h6: Add thermal trip points/cooling map
Date:   Mon, 20 Apr 2020 14:46:34 +0200
Message-Id: <20200420124634.32726-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420124634.32726-1-peron.clem@gmail.com>
References: <20200420124634.32726-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

This enables passive cooling by down-regulating CPU voltage
and frequency.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 370e77b86fe1..60da1627772b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -964,6 +964,30 @@
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 0>;
+
+			trips {
+				cpu_alert: cpu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpu-thermal {
-- 
2.20.1

