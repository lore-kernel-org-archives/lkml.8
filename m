Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2051AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF13B20DD4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942739;
	bh=joL/9IAFY40Wqexpgd8IxuHmzXpJOJQ1HdE6Mho+sGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LbZQUiyLc7wzOKryf+w8FR/F4YHB094aljR/y2dN0WxLzZSMcxAKWJ++fVYUkH+Wn
	 2DwZZZ4sPx+TWdAIo5Il1735tzCoQ8gyNo0qLxZWALL50Au/F7TGGtAvytHopDdyfr
	 nagX1eVh2hYQCn8nXhjfxX9uLxeUuDGLJLnJwZUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbgFWUFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387753AbgFWUFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:05:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AB9E20DD4;
        Tue, 23 Jun 2020 20:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942731;
        bh=joL/9IAFY40Wqexpgd8IxuHmzXpJOJQ1HdE6Mho+sGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nNuv6ogFZ7kHFNASUOWQ3FZJIQJWPEN+dPYmer+fqGUEVlkny+ItLW3Fa5geOHkUW
         DdpAvl0UTvvAdzvUU91VSJ/Ngknl3HJjglMDHhA3RspzP9ql+AV9SlBAJRBBYmJlF2
         XbTSU+Jg4h5anNkSfZYt5glfTOOKIKHXkRLn1q40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 114/477] arm64: dts: realtek: rtd129x: Fix GIC CPU masks for RTD1293
Date:   Tue, 23 Jun 2020 21:51:51 +0200
Message-Id: <20200623195412.984811431@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

[ Upstream commit 31888c8be1486daf2c34ba6c58129635e49d564a ]

Convert from GIC_CPU_MASK_RAW() to GIC_CPU_MASK_SIMPLE().

In case of RTD1293 adjust the arch timer and VGIC interrupts'
CPU masks to its smaller number of CPUs.

Fixes: cf976f660ee8 ("arm64: dts: realtek: Add RTD1293 and Synology DS418j")
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/realtek/rtd1293.dtsi | 12 ++++++++----
 arch/arm64/boot/dts/realtek/rtd1295.dtsi |  8 ++++----
 arch/arm64/boot/dts/realtek/rtd1296.dtsi |  8 ++++----
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd1293.dtsi b/arch/arm64/boot/dts/realtek/rtd1293.dtsi
index bd4e22723f7b0..2d92b56ac94d6 100644
--- a/arch/arm64/boot/dts/realtek/rtd1293.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1293.dtsi
@@ -36,16 +36,20 @@
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 14
-			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11
-			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10
-			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>;
+			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 };
 
 &arm_pmu {
 	interrupt-affinity = <&cpu0>, <&cpu1>;
 };
+
+&gic {
+	interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+};
diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index 93f0e1d977212..34f6cc6f16fe7 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -61,13 +61,13 @@
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 14
-			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11
-			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10
-			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>;
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/realtek/rtd1296.dtsi b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
index 0f9e59cac086e..fb864a139c97e 100644
--- a/arch/arm64/boot/dts/realtek/rtd1296.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
@@ -50,13 +50,13 @@
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 14
-			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11
-			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10
-			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>;
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 };
 
-- 
2.25.1



