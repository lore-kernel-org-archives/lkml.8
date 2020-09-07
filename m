Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E17C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BB32177B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599495209;
	bh=INsnJaELqRYsET4RRsxOzKJWpIsKuNPsUd4VuZL+kig=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BiCpmrPykc8N3NOKwjx5gLVw/YfQ1gU28Nb8LJ11YR45SIzgiBGRsSBdNPPCBfUX1
	 zOjWU1bKTgti+QpAqVHoNU4SYFomBxNKSdWdHQn0kUQgrro5+H0iY3CPzaKkYULCUM
	 mdwFIC10dry/aTOYALltRKVBjL9SMr9WvEGDKCuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbgIGQNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730386AbgIGQNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:14 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A703206E6;
        Mon,  7 Sep 2020 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495193;
        bh=INsnJaELqRYsET4RRsxOzKJWpIsKuNPsUd4VuZL+kig=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Z/xvc2E0pU0W7wifdwH6nXDDK8ZLaQVF/rtfD7l3/YbRIIv4MmQjtHbOq1pzT0vxg
         S3VFMWnUnNWGIJsMdsvlMyL81ZbDWE+ONNyxX1HXCnqttgNUzDX9gpj/uNgNXc3yOf
         0I/Ce/wW1oqj/gjsaKhJcOpIpkjvCoHujfUXs1Xk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 11/25] ARM: dts: s5pv210: add RTC 32 KHz clock in Aries family
Date:   Mon,  7 Sep 2020 18:11:27 +0200
Message-Id: <20200907161141.31034-12-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S3C RTC requires 32768 Hz clock as input which is provided by PMIC.
However there is no such clock provider but rather a regulator driver
which registers the clock as a regulator.  This is an old driver which
will not be updated so add a workaround - a fixed-clock to fill missing
clock phandle reference in S3C RTC.

This fixes dtbs_check warnings:

  rtc@e2800000: clocks: [[2, 145]] is too short
  rtc@e2800000: clock-names: ['rtc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 6ba23562da46..86c3b26fd21e 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -47,6 +47,13 @@
 		};
 	};
 
+	pmic_ap_clk: clock-0 {
+		/* Workaround for missing clock on PMIC */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
 	bt_codec: bt_sco {
 		compatible = "linux,bt-sco";
 		#sound-dai-cells = <0>;
@@ -825,6 +832,11 @@
 	samsung,pwm-outputs = <1>;
 };
 
+&rtc {
+	clocks = <&clocks CLK_RTC>, <&pmic_ap_clk>;
+	clock-names = "rtc", "rtc_src";
+};
+
 &sdhci1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.17.1

