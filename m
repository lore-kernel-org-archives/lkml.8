Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E474C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E06F206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199696;
	bh=UvvU2ACvuYDR0k0CFkDRQnXCIO/igM/KM/2IdQE1i8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=swk9bjhqn+mto/mMZJ59c+C5eR/fh9vNmlnQMsr5oqaFHfl5U0EMvKgmVqVltk5Hn
	 HFS6gEl+7RqdV0Abnnj/kL/bwQKJ5mJomMLYeRA9kAvRAkMfSmvvaLrVU+cHH7/kXQ
	 Lkxjzl186Cgqsu0tOD13Z0VkFnuexx1cKpVOVciY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436799AbgAPSey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:34:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbgAPRYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE12224684;
        Thu, 16 Jan 2020 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195473;
        bh=UvvU2ACvuYDR0k0CFkDRQnXCIO/igM/KM/2IdQE1i8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtrupOC15eWroqE8Gz4QSAL5gbfI8ogpc1G2NToM9ow2/F0XgH7TApXU/FPg2h7Kr
         aCPCK4+7NGxC3R4z802LHK7OyK9xD28ssjuUQktCKjvzqJhUJ7ZHwggclxNMIHBIWO
         dq9u29cWahlRy+kt4hdHcblgAad1L1C7ZYQFueDQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 079/371] ARM: dts: lpc32xx: phy3250: fix SD card regulator voltage
Date:   Thu, 16 Jan 2020 12:19:11 -0500
Message-Id: <20200116172403.18149-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Zapolskiy <vz@mleia.com>

[ Upstream commit dc141b99fc36cf910a1d8d5ee30f43f2442fd1bd ]

The fixed voltage regulator on Phytec phyCORE-LPC3250 board, which
supplies SD/MMC card's power, has a constant output voltage level
of either 3.15V or 3.3V, the actual value depends on JP4 position,
the power rail is referenced as VCC_SDIO in the board hardware manual.

Fixes: d06670e96267 ("arm: dts: phy3250: add SD fixed regulator")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/lpc3250-phy3250.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/lpc3250-phy3250.dts b/arch/arm/boot/dts/lpc3250-phy3250.dts
index b7bd3a110a8d..dd0bdf765599 100644
--- a/arch/arm/boot/dts/lpc3250-phy3250.dts
+++ b/arch/arm/boot/dts/lpc3250-phy3250.dts
@@ -49,8 +49,8 @@
 		sd_reg: regulator@2 {
 			compatible = "regulator-fixed";
 			regulator-name = "sd_reg";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
 			gpio = <&gpio 5 5 0>;
 			enable-active-high;
 		};
-- 
2.20.1

