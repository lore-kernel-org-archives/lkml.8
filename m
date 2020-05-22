Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD80AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9106A205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159400;
	bh=rqrGl13jobhYXcTJKyrzebOW90O43LvkFl6zGUpmsIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xASECtF2VFSs5cREHQylyZaHOjxtsZEdUvMHZV3vf7/07s4EYrM9ICGnEYcFau287
	 w3NienVCSmJUFJ4cpEFka7ac1o3be3jdycAkTVyeE0r66uqvdsAepmLwq6QpSgW/kq
	 Na7N/kZqICHEDX4+IlA+jAri4pJ8q8aG+PSwahZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgEVOu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730822AbgEVOut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:50:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDB822254;
        Fri, 22 May 2020 14:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159049;
        bh=rqrGl13jobhYXcTJKyrzebOW90O43LvkFl6zGUpmsIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIsWp/lw135yrmzpeS/YU+0FqDKZcLbYxUIeHOwfCLtvALFGs+Xblay17aE660nLm
         u145BoZzTfpx+yu3gJNrZRVsFS59ShHYX4k5GenpTENn39vTiZk0YF1BRb75JkFTtk
         PXM82OSvvea/IoquMBGIVExvSwRt4g/TpkMebng4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 03/32] arm64: dts: rockchip: fix status for &gmac2phy in rk3328-evb.dts
Date:   Fri, 22 May 2020 10:50:15 -0400
Message-Id: <20200522145044.434677-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145044.434677-1-sashal@kernel.org>
References: <20200522145044.434677-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit c617ed88502d0b05149e7f32f3b3fd8a0663f7e2 ]

The status was removed of the '&gmac2phy' node with the apply
of a patch long time ago, so fix status for '&gmac2phy'
in 'rk3328-evb.dts'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/20200425122345.12902-2-jbx6244@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index 6abc6f4a86cf..05265b38cc02 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -86,7 +86,7 @@
 	assigned-clock-rate = <50000000>;
 	assigned-clocks = <&cru SCLK_MAC2PHY>;
 	assigned-clock-parents = <&cru SCLK_MAC2PHY_SRC>;
-
+	status = "okay";
 };
 
 &i2c1 {
-- 
2.25.1

