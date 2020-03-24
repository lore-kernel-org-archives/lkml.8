Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976DFC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707DE208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6yjQwiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgCXP66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:58:58 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:40136 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgCXP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:58:56 -0400
Received: by mail-wm1-f53.google.com with SMTP id a81so4012492wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2iXaezRpiAEVsIjtPL66+1WYKKV9JGi2e5gAH5n9n+Q=;
        b=E6yjQwiSqNdVCPE6J/U0KS3W4n/qIziiCmFz1dne8YVjnfuNGsCjGb3cX1KM7rJvQa
         ju+MUHOeaxHWzKoScpBYxtlKy69giccvPYuvtkpvSb/8cFc3oI3H1reZZcmRjq7ena9c
         NfhJ2G+ZwEVEjpPMcBe6xdTz88nkymnq2C1zrvk9KD6eBuzJrVduqsBaUzC9iOs1HJCM
         LZotTcwTPh4/dVWKvtuTcqjCrjPuvd3zjFESxtzU11Mz7Ku2d6l2w6wGpTskxEeQqQk4
         zzxdGSsfLPlrLDkjIvii91NIZ4uNI/7GrQD8E8uqW3P3Xa7+O8ZJzC/iCLj68phQd5pT
         OgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2iXaezRpiAEVsIjtPL66+1WYKKV9JGi2e5gAH5n9n+Q=;
        b=VlcIvQbPL/281BT+zzAVPDj9mf/q9pSAMDDFNtKLZkXWWabDshPgWPkMHaoAErAt5F
         Ek8Ai4Zaa6NMAMeluZ4r7dhXz4tkr9hrHnS0D7nToeSyVxY6oOjKNpKibxBq/sae/tNS
         QR0GyC1aXWem8XTVKS0U45TjYQ0wafgtOIxKFxVsF/fAnCtpCi3X1+dv+Y0XEpFfKHmo
         HEB0yRgA+Bl+IO31aTR1e/zctBkGCKDp3ngQeHy73l1s/UatAGybRVr6y2mR45u12OJ8
         jhdI5NOo5dO7/K7ihbOIID5zU6+ikzuGTlQmMCVyt5Cu6+UyPY1okzfqz94XBHZdmkF8
         kMig==
X-Gm-Message-State: ANhLgQ0ClW+XvQODcfjVKibqoIxw0zZPM+Gbr2wpL+uyO4zcFrzphzom
        Y8uwuZFDZaFsSHPw2IKYfFDuNQ==
X-Google-Smtp-Source: ADFU+vv2xO2E0jEZAUcI/bDEi/RSuQ7wliEymfYmIC7PJzPNbE0/9DBLSwsVtxq4KMF3QxmGKsWJYA==
X-Received: by 2002:a05:600c:48d:: with SMTP id d13mr6078495wme.184.1585065534591;
        Tue, 24 Mar 2020 08:58:54 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:e15d:2127:89a:e5dc])
        by smtp.gmail.com with ESMTPSA id t124sm4993321wmg.13.2020.03.24.08.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 08:58:54 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, olof@lixom.net, Anson.Huang@nxp.com,
        dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [v3 4/6] arm64: dts: sdm845-db845c: Add pm_8998 gpio names
Date:   Tue, 24 Mar 2020 16:58:40 +0100
Message-Id: <20200324155843.10719-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324155843.10719-1-robert.foss@linaro.org>
References: <20200324155843.10719-1-robert.foss@linaro.org>
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
index a6b6837c3d68..efb0086e2aa1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -365,6 +365,34 @@ &mss_pil {
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

