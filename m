Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAA0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA5020748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3TDcLBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgIDGhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDGhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:37:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E738C061251
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 23:37:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e33so3844028pgm.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 23:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WyTTIBrYfLhw1AE2OmxNbGkbFO4+PPEQia9DHNRklGE=;
        b=I3TDcLBfqvBB36KQuNi8T/eLNAHfsM44T0RM5Ps8hN+KwYWP2rU+S4nHkAPYdOuZfR
         ibV7+QBaEV/UQMYgzQCZQx7mdmC5AaSnY6486ZnKsr2MIh+UyeIpI1IAIcRu7AZC94uD
         WKRo89ykg3IOqPlpMSsk6ijFeGPKD1B8H8choJUUfmOt5Fd5ACBB0G8/i8VFlBDBTL3J
         93UysHDs7pDcgPMdXWRSGnWQUsSzd4YZD7rxYvYY6V4oltd12aUmJH/zBw937wBOfM4l
         7uNmNPBIpVinLOL5KEk+I3Uv2m2UCtV0yDj4ITXagzZEJPQR0pwzei8nx00q8cCBWh5O
         b5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WyTTIBrYfLhw1AE2OmxNbGkbFO4+PPEQia9DHNRklGE=;
        b=VOWQeGf0rIk2Avggbgxigbt/sbxCI2cEY4Cdi8N+hAhMFDmDZHcdco3thQqsORZauy
         CvOlEItl+qr+mhITjrab16L+5dFs/51oXj1izIatYMPPcL9Q7qtEBWIgnjJDaixe/vjP
         DEh0MG8PzU7pLul8jyJDX/zWD27ZFAKW9yfubGdnFsqX+twCPZhvIANjHpMZSrYtoei7
         nshIxL+1Be59qhlVv14fwD7EfQT4HMDivcPmqV4Z4AnRoML1hShCrIGo+RmlTu+49vpJ
         VaOugonLa+QGXjLxps9wtwGPY8rS6aki/83AdiLdiw2MHqziZ5m5zEnTo5wqftc6U7qI
         XflQ==
X-Gm-Message-State: AOAM533uVgXEALncuzMVNL54rwEcJCQwFh8LATWXefp+Rv4Zq3WAL+PM
        YRpYt+/4cSFLUnPp8URXXlvB
X-Google-Smtp-Source: ABdhPJyr/Rcw0/Ofy5B3RUU31rbUyIK5BClaFYjL1wRSSPZEYJEQAHaBCNFPsLT0P1X0RV4OwH1XQQ==
X-Received: by 2002:a63:da15:: with SMTP id c21mr6188721pgh.207.1599201420889;
        Thu, 03 Sep 2020 23:37:00 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 143sm5315040pfc.66.2020.09.03.23.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 23:37:00 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/6] arm64: dts: qcom: qrb5165-rb5: Add onboard LED support
Date:   Fri,  4 Sep 2020 12:06:35 +0530
Message-Id: <20200904063637.28632-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904063637.28632-1-manivannan.sadhasivam@linaro.org>
References: <20200904063637.28632-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only User4, WLAN and BT LEDs are added for now. These GPIOs are coming
from PM8150. Rest are coming from LPG block which is not supported yet!

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index f201e064b3e7..312316e23298 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -32,6 +32,32 @@
 		regulator-always-on;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		user4 {
+			label = "green:user4";
+			gpios = <&pm8150_gpios 10 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "panic-indicator";
+			default-state = "off";
+		};
+
+		wlan {
+			label = "yellow:wlan";
+			gpios = <&pm8150_gpios 9 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		bt {
+			label = "blue:bt";
+			gpios = <&pm8150_gpios 7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "bluetooth-power";
+			default-state = "off";
+		};
+
+	};
+
 	vbat: vbat-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "VBAT";
-- 
2.17.1

