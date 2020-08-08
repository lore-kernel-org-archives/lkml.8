Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75B0C433E4
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B4820672
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930378;
	bh=PkKczme5tW5pmLkOMAZI0L7Dfxsl6ApuLO0C0aQmgH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y7v//SJo+AtNk1DkLiZMKAtC+wZwGn47zjUpgAgyEZ/n8I75iXYvnIGxQ/2EQ6nLK
	 QaPC7KbB9xJmDf9cBHhiLkeUXVtB3LB1AbajpQwICj+JjLWa/4dZLJNpRsZ1XzYTYF
	 UEaPMZ+foee4TVgQxlsWYuoBrARGNAGkRfRl4Sbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgHHXqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbgHHXiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:38:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54CD020825;
        Sat,  8 Aug 2020 23:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929903;
        bh=PkKczme5tW5pmLkOMAZI0L7Dfxsl6ApuLO0C0aQmgH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0asBzYcDcPKJ1XcwNEWBgH7bvtXSBwxytS95onbG66uccHC8rsYxpP0t+LgqXhyXR
         YgFCKfRQQWqOgAoX1rD6Aqq4t4wsjwHDho5My4qLhxaP0qHt35l0IAvkUdp1LlWRy9
         0AKmis6WAT6M+QV1VWwmuEHY3ucScnveQJe80dlQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 42/58] arm64: dts: meson: fix mmc0 tuning error on Khadas VIM3
Date:   Sat,  8 Aug 2020 19:37:08 -0400
Message-Id: <20200808233724.3618168-42-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233724.3618168-1-sashal@kernel.org>
References: <20200808233724.3618168-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

[ Upstream commit f1bb924e8f5b50752a80fa5b48c43003680a7b64 ]

Similar to other G12B devices using the W400 dtsi, I see reports of mmc0
tuning errors on VIM3 after a few hours uptime:

[12483.917391] mmc0: tuning execution failed: -5
[30535.551221] mmc0: tuning execution failed: -5
[35359.953671] mmc0: tuning execution failed: -5
[35561.875332] mmc0: tuning execution failed: -5
[61733.348709] mmc0: tuning execution failed: -5

I do not see the same on VIM3L, so remove sd-uhs-sdr50 from the common dtsi
to silence the error, then (re)add it to the VIM3L dts.

Fixes: 4f26cc1c96c9 ("arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi")
Fixes: 700ab8d83927 ("arm64: dts: khadas-vim3: add support for the SM1 based VIM3L")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Link: https://lore.kernel.org/r/20200721015950.11816-1-christianshewitt@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi     | 1 -
 arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 1ef1e3672b967..ff5ba85b7562e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -270,7 +270,6 @@ &sd_emmc_a {
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 
 	non-removable;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index dbbf29a0dbf6d..026b21708b078 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -88,6 +88,10 @@ &pcie {
 	status = "okay";
 };
 
+&sd_emmc_a {
+	sd-uhs-sdr50;
+};
+
 &usb {
 	phys = <&usb2_phy0>, <&usb2_phy1>;
 	phy-names = "usb2-phy0", "usb2-phy1";
-- 
2.25.1

