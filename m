Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D498C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5372071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598946888;
	bh=qD7/UPgLS+Rrz94yhR3MCoXTHn9eezAznYjPVvZKMe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qSl+NkP5yYKBTHc9nk9Sn7mvM7umM186bLOPKCrg2uMAdaKL3FOJ11MRZf7zxJ8eX
	 eMBjTDfQT5806yQs3FqiYe5se0eRxnVeUw9l3hMVi6WINiHjM9aJ4BGVM8fYy+Alze
	 H75Wj9PBt5yDfM0hwoYyjfrLBqkg5JE5sHgL8Qv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgIAHyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgIAHyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:54:45 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F8782071B;
        Tue,  1 Sep 2020 07:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598946884;
        bh=qD7/UPgLS+Rrz94yhR3MCoXTHn9eezAznYjPVvZKMe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbpBgXOXV+Omi6zZUAUs5Iu6j+/HoyVN9aHmOIdq1eq3jpMoFwTJGp9kU3lIB/6nN
         MZTa4YZkneaQm45wLiOjtZYE/NWNkZXIGev/Ap1o6iCf1ei514QW1tRqhMne/gRZPc
         PySovRNPuO+qvhHaDnilcy5s9ys8LFpD6uuPQG7g=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 04/13] ARM: dts: exynos: Correct S3C RTC bindings in SMDK5410
Date:   Tue,  1 Sep 2020 09:54:08 +0200
Message-Id: <20200901075417.22481-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901075417.22481-1-krzk@kernel.org>
References: <20200901075417.22481-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S3C RTC requires 32768 Hz clock as input which is provided by PMIC.
However the PMIC is not described in DTS at all so at least add
a workaround to model its clock with a fixed-clock.  This fixes S3C RTC
and silences dtbs_check warnings like:

  arch/arm/boot/dts/exynos5410-smdk5410.dt.yaml: rtc@101e0000: clocks: [[5, 317]] is too short
  arch/arm/boot/dts/exynos5410-smdk5410.dt.yaml: rtc@101e0000: clock-names: ['rtc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410-smdk5410.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index 5282b5deca86..2a3ade77a2de 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -29,6 +29,13 @@
 		#clock-cells = <0>;
 	};
 
+	pmic_ap_clk: pmic-ap-clk {
+		/* Workaround for missing PMIC and its clock */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
 	firmware@2037000 {
 		compatible = "samsung,secure-firmware";
 		reg = <0x02037000 0x1000>;
@@ -79,6 +86,11 @@
 	};
 };
 
+&rtc {
+	clocks = <&clock CLK_RTC>, <&pmic_ap_clk>;
+	clock-names = "rtc", "rtc_src";
+};
+
 &sromc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&srom_ctl>, <&srom_ebi>;
-- 
2.17.1

