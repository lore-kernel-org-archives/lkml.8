Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D556C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A3B206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2QS9qKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgG1MB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgG1MBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:01:06 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA72C061794;
        Tue, 28 Jul 2020 05:01:01 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g19so6554517ejc.9;
        Tue, 28 Jul 2020 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IyAadO7Kj4svE/f2q3Z4e23jYOH8YNibv5HEpOFyPnU=;
        b=I2QS9qKSrAv3mifGQ4wDSuFxwmoGabSN9zc2D6U8ipjMW8pAvawisbMDf992Dp3fj4
         PE92oW2HDLEjuw47a45YPMdMWbMtA3p7gVxhIZ1KTK4dEDA4YP35J1XVBe+HZK42hSI2
         SOISi6OaPdc1ucnxypDto+Z1uipb1LTEfThL+6MptOLKYFo+yRW5sJfQ9/ib+gMaWlCj
         9V/z20HrF/HjvVgGx0TBgbohIovFDG6CBHCJ3Y7QZnRLcD2SRX91tOAPi7iBwACfOR9k
         VZuTlk19NnN59ASY0cJGB2CaosmPI0SnIWhxDoiTn4lHe8U/moQC65zznGndXOVxtjgv
         w1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IyAadO7Kj4svE/f2q3Z4e23jYOH8YNibv5HEpOFyPnU=;
        b=c2QzhUyPZhEs4FnYOf2XZG5mZxEPq5533G1o0LFeJ4xqywnJy242UPfNosR9cG96XQ
         C5Vh7jFhHsw4ZEQJrwxeo0ooiMo1R0gI4gMzQoYvVj1GtQLPuZh7XHiwIvN725Q/O6sV
         D8kCBaj6jV6QYSFjWmC2bv3Ejsn+4YhoNH/4ZK9wA2PE4v3k3iAHposOryS10Ly4D35J
         rf7IllWS0e44XxlAdp9xXDfS1sZpdaIrVPL4qPSbh9Q9hbURgMJTbqAAkXSzWRirsV1A
         fHZ+UD3YzSERocO8+I6YJAmTxIZc4EcWFGvrFwkOm9jG7hqX5jXvfnEhoVygh5xpONXC
         sKZA==
X-Gm-Message-State: AOAM531FVU8VByXTtZBeVmN3450S36icqUBk6FA4xNgnY/o+3HZ2oLPn
        L/is6JyNCjQGF4IrrV0srgYUkqS2Pfw=
X-Google-Smtp-Source: ABdhPJxDxLMtuTnk7fCzsV123GpwYSjEN50J+/erJ7uTMKcF56ukg6ZW2Gb2Jjw05WkykaiKDXOLBg==
X-Received: by 2002:a17:906:69d3:: with SMTP id g19mr26323947ejs.402.1595937660155;
        Tue, 28 Jul 2020 05:01:00 -0700 (PDT)
Received: from localhost.localdomain (abad207.neoplus.adsl.tpnet.pl. [83.6.167.207])
        by smtp.googlemail.com with ESMTPSA id m20sm9066959ejk.90.2020.07.28.05.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 05:00:59 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     konradybcio@gmail.com
Cc:     lauren.kelly@msn.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 3/9] arm64: dts: qcom: talkman: Add Synaptics RMI4 touchscreen
Date:   Tue, 28 Jul 2020 14:00:42 +0200
Message-Id: <20200728120049.90632-4-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728120049.90632-1-konradybcio@gmail.com>
References: <20200728120049.90632-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds touchscreen capabilities to the Lumia 950.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../dts/qcom/msm8992-msft-lumia-talkman.dts   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-msft-lumia-talkman.dts b/arch/arm64/boot/dts/qcom/msm8992-msft-lumia-talkman.dts
index 3cc01f02219d..c337a86a5c77 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-msft-lumia-talkman.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-msft-lumia-talkman.dts
@@ -32,6 +32,34 @@ chosen {
 	};
 };
 
+&blsp_i2c1 {
+	status = "okay";
+
+	rmi4-i2c-dev@4b {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x4b>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <77 IRQ_TYPE_EDGE_FALLING>;
+
+		rmi4-f01@1 {
+			reg = <0x01>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f12@12 {
+			reg = <0x12>;
+			syna,sensor-type = <1>;
+			syna,clip-x-low = <0>;
+			syna,clip-x-high = <1440>;
+			syna,clip-y-low = <0>;
+			syna,clip-y-high = <2560>;
+		};
+	};
+};
+
 &sdhc_1 {
 	status = "okay";
 
-- 
2.27.0

