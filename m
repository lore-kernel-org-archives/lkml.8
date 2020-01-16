Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE4CC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698EA20730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194188;
	bh=hvOdQB70oGW+4a2MHmKuuy0kxWnbE2x6B9yaIRDsp8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NVFEEATOqhJPZ4oZ3mYdU5OZEs2DAJ99w2Sq8NDFAGBsvKHZqC9RwJRvA53x1ADGZ
	 vSzT4H30cHpbfQu7hLAagUsFa9RHIFe1uwfavP7pVk4jVOzDkv/+4SHGqRUq7tKA51
	 XZXNQ7H34vsaRcscnfhbIql1PTvV7ztrZFaleiMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbgAPRDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:03:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388549AbgAPRDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:03:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 463FC2081E;
        Thu, 16 Jan 2020 17:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194184;
        bh=hvOdQB70oGW+4a2MHmKuuy0kxWnbE2x6B9yaIRDsp8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hXqJfpznLtDTyZ01bR0X8dUC7qzKYHF1wS/PU1B/PdrwnzQWo+83RhXU+yXGVXL+8
         +2pyAAp/oRLzImjzTcmvLo5lIzCVxVcr8owQU38Du0JpT4u8vs/ejqwd6GT6Qrh+tW
         sd2PBPj7cdwGTIbsE6S5OAYxrgOc5zak5Pq7y4aY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 257/671] ARM: dts: sun8i: a33: Reintroduce default pinctrl muxing
Date:   Thu, 16 Jan 2020 11:52:46 -0500
Message-Id: <20200116165940.10720-140-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

[ Upstream commit fa44328f4eb0b762a1fcb148809068e9646e7156 ]

Commit d02752149759 ("ARM: dts: sun8i-a23-a33: Move NAND controller device
node to sort by address") moved the NAND controller node around, but
dropped the default muxing in the process.

Reintroduce it.

Fixes: d02752149759 ("ARM: dts: sun8i-a23-a33: Move NAND controller device node to sort by address")
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index a272a69519a2..1efad1a6bcfd 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -163,6 +163,8 @@
 			clock-names = "ahb", "mod";
 			resets = <&ccu RST_BUS_NAND>;
 			reset-names = "ahb";
+			pinctrl-names = "default";
+			pinctrl-0 = <&nand_pins &nand_pins_cs0 &nand_pins_rb0>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.20.1

