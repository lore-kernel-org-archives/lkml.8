Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E39C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1866820776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448758;
	bh=inQ6fBwnGkvWMuEiTQOAKZvZoNCHTgESJuWH3PswLnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=igZerLcwawZRIEpfJMCnUYKV+AaQBYvGbsKNgTuQ+l4gQ60CWwnApcccnbVkTHZcF
	 uqfTJ/HT4qNfPaNu7G7KBbUAq7gvJKY1Pj+o3BSti7bgA6oHwcTCX6c2CFf1v9Lj5K
	 isM/X7FeD7ArV2lbCF/6a+Yy/8YgHyGamLKdcCPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgFRBIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbgFRBIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:08:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 239E321D6C;
        Thu, 18 Jun 2020 01:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442510;
        bh=inQ6fBwnGkvWMuEiTQOAKZvZoNCHTgESJuWH3PswLnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zfrjFbVBXXqui+DQ5iCJJui2Ol2tPlzgau1de2gov4xympUJ8oxoJ/LmV0/hq2yRQ
         uXpqUgIMJ5xnulfx8TzSNY7vLjEJVmhyiLohuHSW7W4gzhK+v0vSRIF+P//VL0fJG/
         hHUCdHrMzLp8o3mLoAhDPGiUnczbYD7gy42X4MFY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick Delaunay <patrick.delaunay@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 018/388] ARM: dts: stm32: Add missing ethernet PHY reset on AV96
Date:   Wed, 17 Jun 2020 21:01:55 -0400
Message-Id: <20200618010805.600873-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marex@denx.de>

[ Upstream commit 010ca9fe500bfe365860b50220ff80541c18f0e1 ]

Add PHY reset GPIO on AV96 ethernet PHY.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Patrick Delaunay <patrick.delaunay@st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
To: linux-arm-kernel@lists.infradead.org
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32mp157a-avenger96.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157a-avenger96.dts b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
index 425175f7d83c..081037b510bc 100644
--- a/arch/arm/boot/dts/stm32mp157a-avenger96.dts
+++ b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
@@ -92,6 +92,9 @@ mdio0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "snps,dwmac-mdio";
+		reset-gpios = <&gpioz 2 GPIO_ACTIVE_LOW>;
+		reset-delay-us = <1000>;
+
 		phy0: ethernet-phy@7 {
 			reg = <7>;
 		};
-- 
2.25.1

