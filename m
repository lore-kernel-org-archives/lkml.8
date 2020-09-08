Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300C0C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF6F2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592800;
	bh=z65jUTjMim3bra8SfcrvPj1oYBeAfZCmk/MkBq0obTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cszM5unKKtroQ3pt/osvKDwlvqu2i2sWK5bwGkSzZ33hGHnMfeup8hs89WOe11v5Z
	 eZrSsYJ+AtEcr4jzpV/rVNaCl4elusy6omiDetnmCCzKKv2T1Ndvyo2zDtrx/zN/vu
	 GB2TiUAE+izf9P0YyGUxleM6tCm6zT2Yl4XS4Fzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbgIHTT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730887AbgIHQCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:02:36 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E93623DC3;
        Tue,  8 Sep 2020 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579461;
        bh=z65jUTjMim3bra8SfcrvPj1oYBeAfZCmk/MkBq0obTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yTs5h6aosYH4uyCGL+GqsJZhw2SVSzeYmbeKEy6EA+4NThY/vX+Xp/9gXkj1YOUg9
         MPlrfR0k0DXlgbAX67R5Q2K2fHoA1scpWRO+AKyXVvOu0AkDJ6bVLo7u44Wu3udx0H
         Iy7L5Vamu9RuNdHeUftpWObkEWCdr7cIFxlXeVhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 088/186] net: ethernet: ti: am65-cpsw: fix rmii 100Mbit link mode
Date:   Tue,  8 Sep 2020 17:23:50 +0200
Message-Id: <20200908152245.910885103@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit c2f89219f559502c9292d79f695bab9dcec532d1 ]

In RMII link mode it's required to set bit 15 IFCTL_A in MAC_SL MAC_CONTROL
register to enable support for 100Mbit link speed.

Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 88832277edd5a..c7c9980e02604 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -172,6 +172,8 @@ void am65_cpsw_nuss_adjust_link(struct net_device *ndev)
 		if (phy->speed == 10 && phy_interface_is_rgmii(phy))
 			/* Can be used with in band mode only */
 			mac_control |= CPSW_SL_CTL_EXT_EN;
+		if (phy->speed == 100 && phy->interface == PHY_INTERFACE_MODE_RMII)
+			mac_control |= CPSW_SL_CTL_IFCTL_A;
 		if (phy->duplex)
 			mac_control |= CPSW_SL_CTL_FULLDUPLEX;
 
-- 
2.25.1



