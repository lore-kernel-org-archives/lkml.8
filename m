Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4212AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B5F3208B8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658490;
	bh=LuiEROCkKB7x4Xb7YK6DwbYp0sWvzdSAfVc37/OTPnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vdI+LcYaPTsKUkRvJVw5DXXufIgi4SCU4r2uE9i6KUZjDpU97vWdvlvV6ZHjuHGcq
	 ZKjeH1wk49hLgXNziGY4i1MtWJmKglbteArcs/by8ae78ZXTZS/hy6RPdu8LhSTCcz
	 Bn+40ESiZlssGV9QZdAtS1e/d9UFavpLne7+BOkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbgFHXV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729972AbgFHXRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:17:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55CB320885;
        Mon,  8 Jun 2020 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658240;
        bh=LuiEROCkKB7x4Xb7YK6DwbYp0sWvzdSAfVc37/OTPnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hPsDlgddNHeeFacmwgEttrvTkPrbYbJ+/Gdw+ZZ10QFLTXzt8UrpgncqXCreksd39
         NQFyYyEd4hoS5U6YbcSsTcUCL36IcYt1itWUqvQI9Q1ZJQKxVdj2KC8pGsqzj5UHle
         39gQgtgxdJnU1mrr6TFBiT285nMfhNCToI5qt7ZQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 251/606] ARM: dts: rockchip: fix phy nodename for rk3228-evb
Date:   Mon,  8 Jun 2020 19:06:16 -0400
Message-Id: <20200608231211.3363633-251-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 287e0d538fcec2f6e8eb1e565bf0749f3b90186d ]

A test with the command below gives for example this error:

arch/arm/boot/dts/rk3228-evb.dt.yaml: phy@0:
'#phy-cells' is a required property

The phy nodename is normally used by a phy-handle.
This node is however compatible with
"ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22"
which is just been added to 'ethernet-phy.yaml'.
So change nodename to 'ethernet-phy' for which '#phy-cells'
is not a required property

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20200416170321.4216-1-jbx6244@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rk3228-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3228-evb.dts b/arch/arm/boot/dts/rk3228-evb.dts
index 5670b33fd1bd..aed879db6c15 100644
--- a/arch/arm/boot/dts/rk3228-evb.dts
+++ b/arch/arm/boot/dts/rk3228-evb.dts
@@ -46,7 +46,7 @@ mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		phy: phy@0 {
+		phy: ethernet-phy@0 {
 			compatible = "ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
 			clocks = <&cru SCLK_MAC_PHY>;
-- 
2.25.1

