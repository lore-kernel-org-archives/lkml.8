Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC7AC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E768212CC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en6Vh+d1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgDJCcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 22:32:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40156 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgDJCcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 22:32:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id 198so381031lfo.7;
        Thu, 09 Apr 2020 19:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VWKi6VRDm5SDW3y0ubYhqiYe82Hc9AZr1BHz5r8B5mA=;
        b=en6Vh+d1e9XamkEvUkTUxnRAjg7pJmsXs+ztaaiCVXZKTn2sWLWn3wbRwuHlScA4Xr
         5IR8v6yHAfPI1rNoQWJxBEMG1b8kbkww0ReDLl0pLCfeEll4PTAfkM0h/9MMXqBJkHe9
         WuOmXBqjU26af2jNTRQapA/oLaONrsXCBEVZLHszv1v6fKunB+x8TLi0P95+UtBbI86K
         k+88BzWoDE00vPJ6eHl2cSO0fxdoditbmVrI5thrjtomwzJxtvGvPGmRqCI+o69yEzQ+
         TNmINHtsWsXi4McxM1Pt3fg94tHWj9nlc45iWoHycm1nvCT1WNVecvA1EqTrheV9Shnf
         nFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWKi6VRDm5SDW3y0ubYhqiYe82Hc9AZr1BHz5r8B5mA=;
        b=RIWeaVgpexRB2pxcRU40j7vov/gP/hHvKUFFtW401DdN2e+sN09+Kq+5gYNCtat69u
         iVTNp72ij+xr6jsmVLpRq9IFt5oHnfIdcU4abYCImSZRmRPmCqDfPtFqFw3kTWYVzLG0
         e8/FMYJ8Na8YMw0NfzT5swmX8/ZNUqlFw7GJfpkfQ/4QV+yW4oNESJN1X1qlbVFBPt/0
         vDsMf+F3UB8vDiQgVkOXWmQr0Gx/WrCypbOrig1xOxR0DhEhxHm3MYNjwmBqzIHuWZaQ
         xBZ12Q2yzrpLvIaoDMX4jn4jWKXGYSVyIeF5QcJnzMTJ0MY4brUX8bQztl/d/tt6UsS0
         Cteg==
X-Gm-Message-State: AGi0PubBwUPbOVzm0BQyS+cw6gSxpEE6Q1qLG6MaaVdDU28h+hJxCbVi
        Cpm0o5/EryGFThJM/QYWCo8P8I5gP+ay6w==
X-Google-Smtp-Source: APiQypKHmu6pb2IVpV0u1Uuc4X5XVu8meQGR4TaY71qteOknvUfldY2eA2qlks7OFDj/XazjtchAcg==
X-Received: by 2002:a05:6512:3135:: with SMTP id p21mr1274558lfd.36.1586485967642;
        Thu, 09 Apr 2020 19:32:47 -0700 (PDT)
Received: from localhost ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id u7sm433361lfu.3.2020.04.09.19.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 19:32:47 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Daniele Debernardi <drebrez@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 4/6] ARM: dts: qcom: msm8974-klte: Add sdhci1 node
Date:   Fri, 10 Apr 2020 05:32:01 +0300
Message-Id: <20200410023203.192048-5-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200410023203.192048-1-iskren.chernev@gmail.com>
References: <20200410023203.192048-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Debernardi <drebrez@gmail.com>

This introduces the eMMC sdhci node and its pinctrl state

Signed-off-by: Daniele Debernardi <drebrez@gmail.com>
---
 .../boot/dts/qcom-msm8974-samsung-klte.dts    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
index 21335999a024..de0bf6b7e732 100644
--- a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
@@ -153,6 +153,9 @@ l19 {
 					l20 {
 						regulator-min-microvolt = <2950000>;
 						regulator-max-microvolt = <2950000>;
+
+						regulator-allow-set-load;
+						regulator-system-load = <200000>;
 					};
 
 					l21 {
@@ -232,6 +235,35 @@ volume-up {
 			debounce-interval = <15>;
 		};
 	};
+
+	pinctrl@fd510000 {
+		sdhc1_pin_a: sdhc1-pin-active {
+			clk {
+				pins = "sdc1_clk";
+				drive-strength = <4>;
+				bias-disable;
+			};
+
+			cmd-data {
+				pins = "sdc1_cmd", "sdc1_data";
+				drive-strength = <4>;
+				bias-pull-up;
+			};
+		};
+	};
+
+	sdhci@f9824900 {
+		status = "ok";
+
+		vmmc-supply = <&pma8084_l20>;
+		vqmmc-supply = <&pma8084_s4>;
+
+		bus-width = <8>;
+		non-removable;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdhc1_pin_a>;
+	};
 };
 
 &spmi_bus {
-- 
2.26.0

