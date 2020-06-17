Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25511C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045642089D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5U6u+Fw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgFQQs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgFQQsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:19 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDD6C06174E;
        Wed, 17 Jun 2020 09:48:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w16so3130048ejj.5;
        Wed, 17 Jun 2020 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HbW3NKNom8juXI2NoyDjAEEkKyRH9dumXigRxuvNwKY=;
        b=E5U6u+FwDamT/5MzUtw3K/1BEM1ZTiyttyrXEl1+8zSQWpBSc0B5FR4bIUQ1tonPZh
         tQ7Sq8engNniJfbizfbR8YisCx9Ora1eTcK48UUUNsPyrrmYz7ttfMJUyDIqWfREp4x0
         LT8uHcaKqqvZF70IgYU99gHaQCxC2cfAXiDO8ImYxJjaG5GtJKZ3Hfb1Q6NlVdmDbaZ8
         QDB11E5nYjm0cIK1jEV4D3ONYHyoB5X7seBi/J8PU31002wRNLpWLEKw0yPRy0NRsvSu
         nNp3fHo+x13H8YaQjGCkZbkO7eOeT90xaWFXuPE4kus7VDD8rQXbpeNqcWSXDawp1WUA
         c/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbW3NKNom8juXI2NoyDjAEEkKyRH9dumXigRxuvNwKY=;
        b=kvFsVw+nUZj16udHUjUJQcdQj7VVgKeiC/Dx4tpTfwbpC0pqTtsQzlKdgI9cgixF4m
         hcTDujOsGr8ZR2zTHHh3398jsoL9163S0Km7tEnpfdF4JtqgJJqoISOWDDdTg+HHfgvc
         gbZplAPbOegMZSURZSCs6VjEQ0UNoj40S6lM6wjJx2ZquIT65MHr2KvhJnGm7jQvRY7R
         BpZsOX6dD1jbrz8vcmoo0QONxHtuoj58zZzH1C5rWngPJzRHO7RZynidmnAbtl30TXBr
         XXqMhUNvDfMeVTqBpz6Wktw8kzYOjnbM6auXDGaXrlRbkB/fEGq/uHShHmVuJqwiKrkZ
         gF/w==
X-Gm-Message-State: AOAM531KCndBkzLbbE6ecNNpDbwAnfHsmYO44mmNWTfYE4jH8Thdq+eA
        cC+5qZ3ESjSp1+oFpcEKUTS8PJUccNw=
X-Google-Smtp-Source: ABdhPJzPdiDhZzkiIEvfyQqMk9m00A48c6U0WPQZgrYyBMDstasrSBdif/z88ONABd5SplNm1UNgmA==
X-Received: by 2002:a17:907:9484:: with SMTP id dm4mr106072ejc.56.1592412497436;
        Wed, 17 Jun 2020 09:48:17 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id v3sm127124edj.89.2020.06.17.09.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:17 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] arm: dts: owl-s500: Add Clock Management Unit
Date:   Wed, 17 Jun 2020 19:48:02 +0300
Message-Id: <9dba1e4d779be27594859ea71131624bb20b1618.1592407030.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Clock Management Unit for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 1dbe4e8b38ac..5d5ad9db549b 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -5,6 +5,7 @@
  * Copyright (c) 2016-2017 Andreas Färber
  */
 
+#include <dt-bindings/clock/actions,s500-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
 
@@ -70,6 +71,12 @@ hosc: hosc {
 		#clock-cells = <0>;
 	};
 
+	losc: losc {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -169,6 +176,13 @@ uart6: serial@b012c000 {
 			status = "disabled";
 		};
 
+		cmu: clock-controller@b0160000 {
+			compatible = "actions,s500-cmu";
+			reg = <0xb0160000 0x8000>;
+			clocks = <&hosc>, <&losc>;
+			#clock-cells = <1>;
+		};
+
 		timer: timer@b0168000 {
 			compatible = "actions,s500-timer";
 			reg = <0xb0168000 0x8000>;
-- 
2.27.0

