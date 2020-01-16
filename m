Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6ADC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF80217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194549;
	bh=1T5KwfbabrYdOeYJjrtT5zwNBpknelGGKcWhllIA+YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hCmzM55CF3z3FSH73/eWYd1wiF5E5kdkMlsPzer0yu3hk4kaJZJ9Yfk3CL7TfAsRE
	 DydmVfETAoO1W8Hqvy6hl4q9lz9GeGqtBCelUHQxguYsRdeoommHKE6HuzPQ7DC9eZ
	 +7/JASamL8SquIMMUPIfbfYEUqL9HXIgNtOb4eBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbgAPRJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:09:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389585AbgAPRJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:09:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C28722464;
        Thu, 16 Jan 2020 17:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194543;
        bh=1T5KwfbabrYdOeYJjrtT5zwNBpknelGGKcWhllIA+YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PBpvXm0En7Almk3jSLqWQH+YKvKCuRX/V6nsxa9SCoiwLBUHWUQKYMZhfOBF7TJ3J
         ZDPtFD3PeMLOugytanQIXSh9Nhlg4x5oEktxSR2NI7QgqJqbrwQ3UM567PxT66ao8Z
         JSv2fKeufOs9KP0UaXwD3TeNNqe82CnE0pycpqFY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 429/671] arm64: dts: allwinner: h6: Pine H64: Add interrupt line for RTC
Date:   Thu, 16 Jan 2020 12:01:07 -0500
Message-Id: <20200116170509.12787-166-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 0bb9d1876c0605815ea0452f68cb819a775a75f9 ]

The external PCF8563 RTC chip's interrupt line is connected to the NMI
line on the SoC.

Add the interrupt line to the device tree.

Fixes: 17ebc33afc35 ("arm64: allwinner: h6: add PCF8563 RTC on Pine H64 board")
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 48daec7f78ba..6c3a47d90c79 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -176,6 +176,8 @@
 	pcf8563: rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		#clock-cells = <0>;
 	};
 };
-- 
2.20.1

