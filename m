Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F41DC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE5522BEF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260838;
	bh=knls8Ew8m3j5hGzBIv5wkgjdRip61JzpGoILKKsatV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ndRTzaCUZT4zQrDQG9bW0xB+j2kkVhi+jpJhK10KJncsvmAlxo5Gb6jPDQ1ogdFaF
	 znL3U0sX7ZmR8bQflUw3Ko+/onaqhggY/zpeG8F1Np9sOXewqhZ8/x2jC0Nq9jlHwl
	 SkLWqABy+JSNwU2sQ/HNhdm0hphCnNWakRbZnjp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbgGTQAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732389AbgGTQAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:00:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8905F20684;
        Mon, 20 Jul 2020 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260830;
        bh=knls8Ew8m3j5hGzBIv5wkgjdRip61JzpGoILKKsatV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRiaAmG9I4OsfAYvjEUg6pKPhfZssTeFacJnfiO1hKMoChr3sfM7cWimad4Cijzxu
         Gl4BxosBL1WC/lxMi6A7ZfyMeBXxf13FRbhX9+pQ2yoFZzG/ZeFoWoK3saMrXcXy1N
         qnxqWwU01P9LlrU9YuNp6qzv4yxwFidMYBhWmyPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, dillon min <dillon.minfei@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 112/215] ARM: dts: Fix dcan driver probe failed on am437x platform
Date:   Mon, 20 Jul 2020 17:36:34 +0200
Message-Id: <20200720152825.526559142@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

[ Upstream commit 2a4117df9b436a0e4c79d211284ab2097bcd00dc ]

Got following d_can probe errors with kernel 5.8-rc1 on am437x

[   10.730822] CAN device driver interface
Starting Wait for Network to be Configured...
[  OK  ] Reached target Network.
[   10.787363] c_can_platform 481cc000.can: probe failed
[   10.792484] c_can_platform: probe of 481cc000.can failed with error -2
[   10.799457] c_can_platform 481d0000.can: probe failed
[   10.804617] c_can_platform: probe of 481d0000.can failed with error -2

actually, Tony has fixed this issue on am335x with the patch [3]

Since am437x has the same clock structure with am335x
[1][2], so reuse the code from Tony Lindgren's patch [3] to fix it.

[1]: https://www.ti.com/lit/pdf/spruh73 Chapter-23, Figure 23-1. DCAN
     Integration
[2]: https://www.ti.com/lit/pdf/spruhl7 Chapter-25, Figure 25-1. DCAN
     Integration
[3]: commit 516f1117d0fb ("ARM: dts: Configure osc clock for d_can on
     am335x")

Fixes: 1a5cd7c23cc5 ("bus: ti-sysc: Enable all clocks directly during init to read revision")
Signed-off-by: dillon min <dillon.minfei@gmail.com>
[tony@atomide.com: aligned commit message a bit for readability]
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am437x-l4.dtsi | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
index 59770dd3785ee..bbe15775fccd5 100644
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -1576,8 +1576,9 @@ target-module@cc000 {			/* 0x481cc000, ap 50 46.0 */
 			reg-names = "rev";
 			ti,hwmods = "d_can0";
 			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
-			clocks = <&l4ls_clkctrl AM4_L4LS_D_CAN0_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4ls_clkctrl AM4_L4LS_D_CAN0_CLKCTRL 0>,
+			<&dcan0_fck>;
+			clock-names = "fck", "osc";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xcc000 0x2000>;
@@ -1585,6 +1586,8 @@ target-module@cc000 {			/* 0x481cc000, ap 50 46.0 */
 			dcan0: can@0 {
 				compatible = "ti,am4372-d_can", "ti,am3352-d_can";
 				reg = <0x0 0x2000>;
+				clocks = <&dcan0_fck>;
+				clock-names = "fck";
 				syscon-raminit = <&scm_conf 0x644 0>;
 				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
@@ -1597,8 +1600,9 @@ target-module@d0000 {			/* 0x481d0000, ap 52 3a.0 */
 			reg-names = "rev";
 			ti,hwmods = "d_can1";
 			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
-			clocks = <&l4ls_clkctrl AM4_L4LS_D_CAN1_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4ls_clkctrl AM4_L4LS_D_CAN1_CLKCTRL 0>,
+			<&dcan1_fck>;
+			clock-names = "fck", "osc";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xd0000 0x2000>;
@@ -1606,6 +1610,8 @@ target-module@d0000 {			/* 0x481d0000, ap 52 3a.0 */
 			dcan1: can@0 {
 				compatible = "ti,am4372-d_can", "ti,am3352-d_can";
 				reg = <0x0 0x2000>;
+				clocks = <&dcan1_fck>;
+				clock-name = "fck";
 				syscon-raminit = <&scm_conf 0x644 1>;
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
-- 
2.25.1



