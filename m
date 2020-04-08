Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B477FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8786120780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YR7kjZED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgDHNK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:10:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56115 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgDHNKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:10:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id e26so5071453wmk.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyBGvPhV7TUH86tokQz7uJLxAaD+h2U61M1YV5bgXQs=;
        b=YR7kjZEDp8Dclxy+3WQjIozJps5zrdc4+YpZUIpjxeZLzDHIU344sV0qjc6I5pl5HS
         dkdFmg3wIS2EartLPHjLFXqCuhZ7hLhu5zLUe8eT5OY1hQwcQho3Koo5VZdAdUPC42D8
         BKEx2Ih8T9FQYlyYAbVNl4Q0K2CSJOrmYNWBuf3g+UVZaVMPh+uQ39NATJlcMFPmbevA
         9TFyoOZMfgAqk3zRxULaqOIu8HaSJY4k6FSeWBM6Bh1xa914KMROhcZ3qitfgcZl2t9x
         LGvT4y1l3mXC3aoE3JyNrZVS+HkWqZVomzaWEs9F3CR1owCjmrGC8D0k1Y/fbqypS7pA
         GzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyBGvPhV7TUH86tokQz7uJLxAaD+h2U61M1YV5bgXQs=;
        b=rQHW5BrzD6u/yVk9FS54YrnpR3a8x+2BfdKarB5O5wscuPmvp8/ZSkZQJoswvjye8H
         ipuVmHcmO41pE9YaYwZoubKF+buTG0xWmi+h+y9WbD4z29jD0BYP72V6+zpKmVYmRPjs
         CXXnZQXRpEfc3mYvRAnL+E0+zKolQ35iNmsiSDfzJSAFSwdPPZvKUk0R7XYwvHMS5VMV
         3FyRo7IT5lXACSksnmF8vOz4pm6bd3Novn944F2q/tGh+bhswnxik7DWWNTh985qnFud
         gq5Bc2oLgx3ehkakT2mN6uD6tL8wdtdCjmam7dS3G+UaGma7dZ6cuQu13Z1Nlj0RsGGE
         lOmg==
X-Gm-Message-State: AGi0PuY3sRaR2sIEWtFqT+pX7FXmf89KgnDYkrmrhxXCjEO7wWEchMpV
        291dvm0QcWE2rYjsg/MAUwHJsQ==
X-Google-Smtp-Source: APiQypJNeoXs5y2t1gLKM6gDJw9wo7P2PspFCxzFWP5VVAB+XA/VWx9wysS6dw5QBKvX78ZXyqHxXQ==
X-Received: by 2002:a1c:2c85:: with SMTP id s127mr4663898wms.18.1586351451594;
        Wed, 08 Apr 2020 06:10:51 -0700 (PDT)
Received: from localhost.localdomain ([37.120.50.78])
        by smtp.gmail.com with ESMTPSA id f4sm18428044wrp.80.2020.04.08.06.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 06:10:51 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, Anson.Huang@nxp.com, olof@lixom.net,
        leonard.crestez@nxp.com, geert+renesas@glider.be,
        marcin.juszkiewicz@linaro.org, valentin.schneider@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v4 4/6] arm64: dts: sdm845-db845c: Add pm_8998 gpio names
Date:   Wed,  8 Apr 2020 15:09:57 +0200
Message-Id: <20200408130959.2717409-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408130959.2717409-1-robert.foss@linaro.org>
References: <20200408130959.2717409-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pm_8998 GPIO trace names. These names are defined in
the 96boards db845c mezzanine schematic.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
 - Move gpio-names to previous reference to pm8998_gpio label

 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 8644a2f6095a..5cd06ab97b9a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -412,6 +412,34 @@ &pcie1_phy {
 };
 
 &pm8998_gpio {
+	gpio-line-names =
+		"NC",
+		"NC",
+		"WLAN_SW_CTRL",
+		"NC",
+		"PM_GPIO5_BLUE_BT_LED",
+		"VOL_UP_N",
+		"NC",
+		"ADC_IN1",
+		"PM_GPIO9_YEL_WIFI_LED",
+		"CAM0_AVDD_EN",
+		"NC",
+		"CAM0_DVDD_EN",
+		"PM_GPIO13_GREEN_U4_LED",
+		"DIV_CLK2",
+		"NC",
+		"NC",
+		"NC",
+		"SMB_STAT",
+		"NC",
+		"NC",
+		"ADC_IN2",
+		"OPTION1",
+		"WCSS_PWR_REQ",
+		"PM845_GPIO24",
+		"OPTION2",
+		"PM845_SLB";
+
 	vol_up_pin_a: vol-up-active {
 		pins = "gpio6";
 		function = "normal";
-- 
2.25.1

