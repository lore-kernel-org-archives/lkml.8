Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21164C433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED29A206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595001681;
	bh=N+frjeuLN/SOI5k+ZS13xE98hyoDAZmLGor2nqjZ138=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qvXK2K15b2Uo+UardXAUcNShSBy3CtWGHkceY3poUDbcisF2reYUmo7QHYs9LdMeW
	 emlbusgE8uObVC+zQyaSblqf9BXj2sZUgqO+OWl8lPFm0TEsYnEFQ7d2B89lliT8Zg
	 gEWrQSN1d3vQrWGxzU76eQyKv1xIk38TFk5IRcyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgGQQA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgGQQA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:00:58 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F9862076D;
        Fri, 17 Jul 2020 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595001658;
        bh=N+frjeuLN/SOI5k+ZS13xE98hyoDAZmLGor2nqjZ138=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmfnsO+r1r9lb0a6GFXSpvAz5gK3sHoUaE+eEsEGEHv9dM/vcwhgnKTU6kjenlETN
         mT1RT7ewzQrUw9woDy8G92bLZ89DHyhO92LLQ6YzpBxUhD5t2qMHbMuTmpK35bHbIh
         IoRgmDjmshEED0u4yVFYMWzuaoZFqQBiAdYq5bnI=
Received: by wens.tw (Postfix, from userid 1000)
        id 36E3A5FD80; Sat, 18 Jul 2020 00:00:55 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] arm64: dts: allwinner: h5: Add clock to CPU cores
Date:   Sat, 18 Jul 2020 00:00:49 +0800
Message-Id: <20200717160053.31191-5-wens@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717160053.31191-1-wens@kernel.org>
References: <20200717160053.31191-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The ARM CPU cores are fed by the CPU clock from the CCU. Add a
reference to the clock for each CPU core, along with the clock
transition latency.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 4462a68c0681..09523f6011c5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -13,6 +13,8 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			reg = <0>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu1: cpu@1 {
@@ -20,6 +22,8 @@ cpu1: cpu@1 {
 			device_type = "cpu";
 			reg = <1>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu2: cpu@2 {
@@ -27,6 +31,8 @@ cpu2: cpu@2 {
 			device_type = "cpu";
 			reg = <2>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu3: cpu@3 {
@@ -34,6 +40,8 @@ cpu3: cpu@3 {
 			device_type = "cpu";
 			reg = <3>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 	};
 
-- 
2.27.0

