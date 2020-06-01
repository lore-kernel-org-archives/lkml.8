Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1466C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A857D20679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037586;
	bh=VMPVLPjD0+WHhRDFJyg3MGAJZ62iSw/QNHYKSyeBzd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JF2KEUpZ2dhiJuy2F4DpamBXTROkvXD3WmuL2/mUS67Eoh4pjtrHkZIi4CAH4iptQ
	 pkCqPV3FmNmjrQIHnWpjN/a8Id+6+F5ebEe7XtdgDV2SsrF9GIxlUERfB+PYxuhP6i
	 6M9sfPUDcSUKIzrRuVO92KIEkShdKoD14GAZNrh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgFASxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbgFASDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:03:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F22A12065C;
        Mon,  1 Jun 2020 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034588;
        bh=VMPVLPjD0+WHhRDFJyg3MGAJZ62iSw/QNHYKSyeBzd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TxDm0lj80eTGj6QlZEnWI4pjh8Zg2jOCLjBhBMbrjU/ungltDmNA48U24tvvmEHUG
         +bkSlYFdanuKHN1HlhzBSsuSqWRVYykZDJaQNhJol+CmhEmYzA4DgQf3YvitJSFVwv
         W4g4rABeyRHiEMYpxvm0oTZqMUm6YacwnQKBdkWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/95] arm64: dts: rockchip: fix status for &gmac2phy in rk3328-evb.dts
Date:   Mon,  1 Jun 2020 19:53:20 +0200
Message-Id: <20200601174024.145540194@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
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
index 212dd8159da9..d89f3451ace5 100644
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



