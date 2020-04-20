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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC85C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8C4206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY1IDGUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgDTNAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727887AbgDTNAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:00:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4EBC061A10;
        Mon, 20 Apr 2020 06:00:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i10so12003829wrv.10;
        Mon, 20 Apr 2020 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUA++TEaLcF7xVYj2JPvsFYTdSQV3W9a05Rr324UlUQ=;
        b=KY1IDGUIGtH6/X+S1RScsP53Z7/f03p0pdcXzOXaymcjmhHtHl0DTes5XhUCrLjiCY
         odHgGtVg4tqHRqFkIsVwgHZZ10NuPsTy4DA3FOixDJgPQChCcPcWCrIgJR3CoDuMq7m+
         hFqLYlVYzSaNne7NrOoSPUINJMcU2n2xVyFfVej9CqWbBOsn4+kLf9cX1Gp3fIR7uerx
         C5twxjfUcyt3bkaz1TaSiKjv7xrQFMfDJBK9Hby89viiULpMsfZn0Jz4ryFeTW3zhqM4
         VcZ1kyJn8JnEHbc+NthgUHxPa3gkjw5Hn2PoWSbl5ZM7fd+rl2lgVOubDWLp0XAExLFb
         eejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUA++TEaLcF7xVYj2JPvsFYTdSQV3W9a05Rr324UlUQ=;
        b=rgL6EAnL9U97rewSeASmjG89E/srNfh3GVCIRUvhLdgu59hrpuH4bEcXhZgtgvYIjI
         9NZc+2OAOfbZzMNp68TFJpyXr9/Lfv8TUhRcaHtqUEJEJB04TGI183rLRoJhNnyNuf9l
         5bmFj5hK2BTtwdrdkn9CwqfZ5xSmPTrnF1m9pfsP+kHXmlJ3SLM0BcAQaQLKnj0a4IKP
         Z7FIlyilzzrIj4z4852UPARUfOixd7Jf74Ja/e/RPnrafqa+Fpst56cBFSPX6aB9gPnj
         bnjo6PgBXydmvJQjoocSUzw+sSRTyyIaaWeDvo2z32I6DrWu6uHg+hIMq2SFmEnZMdrD
         f/3Q==
X-Gm-Message-State: AGi0PubXjJOn2Lp4oaJsaWYdAo0Veo4aZe/PZzNR4Qu+DG9Asuc2COxp
        ej20HXN448YkBgIADoT0cbU=
X-Google-Smtp-Source: APiQypIW3pkrHtqWX1Kq1F92o5ySwgRqIUUcD5PL5hrmLpCtgVGKllTp41jF8KU0Fk5d8jdDllv15g==
X-Received: by 2002:adf:dd0c:: with SMTP id a12mr19375810wrm.144.1587387632534;
        Mon, 20 Apr 2020 06:00:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id e11sm1081680wrn.87.2020.04.20.06.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:00:31 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 7/9] arm64: dts: allwinner: h6: Enable CPU opp tables for Tanix TX6
Date:   Mon, 20 Apr 2020 15:00:19 +0200
Message-Id: <20200420130021.3841-8-peron.clem@gmail.com>
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

Enable CPU opp tables for Tanix TX6.

Also add the fixed regulator that provided vdd-cpu-gpu required for
CPU opp tables.

This voltage has been found using a voltmeter and could be wrong.

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

