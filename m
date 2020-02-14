Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23E1C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A5024686
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696362;
	bh=dL1C9ZtwKKPWFltFPjdkV6dCvn5rHMctGRPlSveN5sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F1iOCo/9/3iNMKeEpmApbEl3HpZ893CNg1FdhclHsn84+panqGcEpWyXBq9JPXIkJ
	 DWPHGnITxxQMePJ99XXvyV740bppGc9WLMV80ScFCfDhXLCawDhglqk9EwKQ7rwO6j
	 HnDdkfAicIPNbVj4B7EI5200JOoMDMIxq9jMY83w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390285AbgBNQGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:06:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389722AbgBNQFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:05:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE47A24686;
        Fri, 14 Feb 2020 16:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696318;
        bh=dL1C9ZtwKKPWFltFPjdkV6dCvn5rHMctGRPlSveN5sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GiRUiWTvdHIVk9wNQEPYEtVR+GT18osv1dYFFjYxl/N6kdOSXDy+fzv+evkX4fX4f
         0pWIV5jrNtOzJiZ5ELTObq71eZGBzOsyNFir4AUZ6gZXmiMldBQGb+Ze4MVQbEZQjR
         VZFqfD7I+KXRQiDF0RCb6+LbhnekuGp/D2wmATsM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 159/459] arm64: dts: allwinner: H6: Add PMU mode
Date:   Fri, 14 Feb 2020 10:56:49 -0500
Message-Id: <20200214160149.11681-159-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit 7aa9b9eb7d6a8fde7acbe0446444f7e3fae1fe3b ]

Add the Performance Monitoring Unit (PMU) device tree node to the H6
.dtsi, which tells DT users which interrupts are triggered by PMU
overflow events on each core. The numbers come from the manual and have
been checked in U-Boot and with perf in Linux.

Tested with perf record and taskset on a Pine H64.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 0d5ea19336a19..d192538916724 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -70,6 +70,16 @@
 		clock-output-names = "ext_osc32k";
 	};
 
+	pmu {
+		compatible = "arm,cortex-a53-pmu",
+			     "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
-- 
2.20.1

