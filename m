Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9682C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8DF2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550976;
	bh=W78xDKL9vZeAOmKKhIvU94QXZNobNiSeA2UTlKqPmz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pFrn3rjYyYFGy1aspGiA2DrKDcFMCawF+9unoLeElYx+SmPhwl60Lg2HGBAS9HPxt
	 evacA53Ml+TOuqQiuFVUCtpVW6lD3dZ/hWngqh9Yk817dytMmtIMVJkYmTEKFoiI//
	 jy+bRT/KHev9y4G5eZ4RtxIQx7vbCAjBCZh2dEWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgDVKWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729679AbgDVKTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:19:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 853CA20780;
        Wed, 22 Apr 2020 10:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550766;
        bh=W78xDKL9vZeAOmKKhIvU94QXZNobNiSeA2UTlKqPmz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yU7v2N/iEpmUHXe+5QVIlVPzwbE5p8OZrU0ODiSkC5qoQMkS500+mIwVGmU+DKn1L
         THOHgLEU9qzsHA/NhvA/NJOIdxqlNgFodO6aLZ8M1EX67N/IeejvJ+cHB/ad6oyK8D
         /LSaCK7wwEQOKZq7wk+jR+0HN+RUk/tSHOqlelJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 041/118] arm64: dts: allwinner: a64: Fix display clock register range
Date:   Wed, 22 Apr 2020 11:56:42 +0200
Message-Id: <20200422095038.664279972@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

[ Upstream commit 3e9a1a8b7f811de3eb1445d72f68766b704ad17c ]

Register range of display clocks is 0x10000, as it can be seen from
DE2 documentation.

Fix it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Fixes: 2c796fc8f5dbd ("arm64: dts: allwinner: a64: add necessary device tree nodes for DE2 CCU")
[wens@csie.org: added fixes tag]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index ba41c1b85887a..367699c8c9028 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -227,7 +227,7 @@
 
 			display_clocks: clock@0 {
 				compatible = "allwinner,sun50i-a64-de2-clk";
-				reg = <0x0 0x100000>;
+				reg = <0x0 0x10000>;
 				clocks = <&ccu CLK_BUS_DE>,
 					 <&ccu CLK_DE>;
 				clock-names = "bus",
-- 
2.20.1



