Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2019FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0EF1207D0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035290;
	bh=rqrGl13jobhYXcTJKyrzebOW90O43LvkFl6zGUpmsIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zi/g9E8LcIrrR3dRxcUVzOWavupBKohLM0fyRXYMr+lwTuCRJSJb5deioohwjb/ZG
	 jdViLfQLVsuBkHiTYAa4tiGOaGq6A3z8D1ziFwoOnBP4A2DZjwLF0iUJOyYeCwPWJ0
	 COT2AC0m9BiZsmqSqSHdM+6+3KZwA/S7Ym+RjHGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgFASOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731490AbgFASOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:14:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF53C2065C;
        Mon,  1 Jun 2020 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035278;
        bh=rqrGl13jobhYXcTJKyrzebOW90O43LvkFl6zGUpmsIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEfGvCMPm4F1hoe/ZBxZ8gJ04389gXUMtXJJLrPCEt0PiL/TTtkclPxctBA4F1925
         Bb37fMj6Ms2tkZ0O1V6oO3jtghWKrNmwvYnxGYJBNQGVAxEW+GBfkMEqLsNaQ5Q90r
         ypeRpt/ZEFZ5Ech3oO6VkofFzVfHCJAVMhGc+q54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 047/177] arm64: dts: rockchip: fix status for &gmac2phy in rk3328-evb.dts
Date:   Mon,  1 Jun 2020 19:53:05 +0200
Message-Id: <20200601174052.963037618@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



