Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F8FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D638C20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="BbgUsbwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgHXI2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHXI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:28:48 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3620EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 01:28:48 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b2so7277205edw.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 01:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VJdZxE/y/ZWFHMLl1jOIxfMQEHtM7AeHNk1ErzUcyxc=;
        b=BbgUsbwbLVLw2AiTwU/gHmj2IDYL+2kZn5nlxDFnqmrUXbaRroQUVA3s6NGiuwu3qB
         cQiapZjS/llynrOMoBMxUXtBuWmnbTen8LFK4MJ1bBXeSagQENJwyMVL9fjYrwnZa30y
         +foEqC0q8iiq3RKjbOWB+OcT7s3IFSyVHXdjTaxjPm8EOYXMalhtl0kL+qHHl2WPAWh9
         2QP9XXr903CLxVSYQfhe6y/Al2GNQ4U+XCdya6HfnLzUsN3vzw2YZLH5xv6EUBiyp+vh
         NQw/u5xQgIcjK6lOfqA82knVqvZryx2XxlpjT+hqr0oDyqmaf2sY3PSTfT8cu/MSO8RY
         BXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VJdZxE/y/ZWFHMLl1jOIxfMQEHtM7AeHNk1ErzUcyxc=;
        b=fY4Ml8ZztnKYgoPqyvKxyshkpIfB7uLLdiOMWCk5yEwfmvEhv9/38gSUirBASrGnjK
         V2WvjEkqDu6cE7hn7RmpsIq68zDqryIAVOC+3zPAYcKttxcWGaiLJVQichaMVSJ/Hgb2
         W+tOaUHWLgE0CaJA5bGTPb2Tm7K25ScosND5i78AJS1ajBCS31hGOLwMrVdCfQ9wAXxf
         Bu6cHVuhlFwCvEDP3slcXLMHrMGiZD1ZbIAgxMqaTwpnv0T86Qws+wk84aWnoZPJu3af
         ALZY/KO9sN8GzPcRfdPdaV/yKE+X7i24g6/ZFWfaMKaGb/P3fnZqA161Q7QLi4MgIGVm
         KTLQ==
X-Gm-Message-State: AOAM5333u29lYlFMX/6tgvuafB0j6GNBiKKP5KWjE8qqg3vlErMj13fj
        Hi1Em2/2yJDl4z9MyLLEs9cYWOKTKoIj0A==
X-Google-Smtp-Source: ABdhPJxTJYfNQWScPNlLbLAhMRkcA5iR1YwjMiQo2KcF690VugvDAQQ5/Gz3prKZ4xAUH/ZSKl1xjw==
X-Received: by 2002:aa7:c596:: with SMTP id g22mr4362781edq.109.1598257726595;
        Mon, 24 Aug 2020 01:28:46 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a26sm7418266eje.78.2020.08.24.01.28.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 01:28:46 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: zynqmp: Remove undocumented u-boot properties
Date:   Mon, 24 Aug 2020 10:28:45 +0200
Message-Id: <8ba339425b9c9f319bdedce7741367055a30713c.1598257720.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

u-boot, DT properties are not documented anywhere in Linux DT binding
that's why remove them.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 5 -----
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 9868ca15dfc5..c94c3bb67edc 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -10,35 +10,30 @@
 #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
 / {
 	pss_ref_clk: pss_ref_clk {
-		u-boot,dm-pre-reloc;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <33333333>;
 	};
 
 	video_clk: video_clk {
-		u-boot,dm-pre-reloc;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
 	};
 
 	pss_alt_ref_clk: pss_alt_ref_clk {
-		u-boot,dm-pre-reloc;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <0>;
 	};
 
 	gt_crx_ref_clk: gt_crx_ref_clk {
-		u-boot,dm-pre-reloc;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <108000000>;
 	};
 
 	aux_ref_clk: aux_ref_clk {
-		u-boot,dm-pre-reloc;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index d1e9a5eb4f70..6a8ff4bcc09b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -131,7 +131,6 @@ zynqmp_power: zynqmp-power {
 			};
 
 			zynqmp_clk: clock-controller {
-				u-boot,dm-pre-reloc;
 				#clock-cells = <1>;
 				compatible = "xlnx,zynqmp-clk";
 				clocks = <&pss_ref_clk>,
-- 
2.28.0

