Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF04C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E5A20776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448423;
	bh=8oCVtA1Uh8PomkTqvsJrxXra4H3hrCNP2B1TVALoCX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W/mPhebiuBf2Y6kZ8VgS6cmQ8K1AZeTsysggP+0SBBokG/R8VZWDWVXtf+dsv52VN
	 QS3RFh6hPq+F7jobNxGA9eh1JvS31lTkDYe7M+poTEJRL7FlnuOsCjlfolxpDg6uCA
	 M8ViGo9J2G8ub9Jl8xhW7qgeP1qoZzr4bBU3pBhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgFRBK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgFRBKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:10:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2D8820B1F;
        Thu, 18 Jun 2020 01:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442619;
        bh=8oCVtA1Uh8PomkTqvsJrxXra4H3hrCNP2B1TVALoCX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwtGDn+Ub/RRdxdstms2d25KrTlaYIGb16Wov65AWK8qAF4xo7b4cHN0oroGC+Veo
         m8pedUAhCtzjTWKY/5c/uTf8KXuLbhqUrr29J4kfpJkJBkt3X8PajEHTD/EzWkChd2
         6qTJuctCoceGDPDhsZSaNaG5IG39Vu794ZdvkZTk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 099/388] net: dsa: lantiq_gswip: fix and improve the unsupported interface error
Date:   Wed, 17 Jun 2020 21:03:16 -0400
Message-Id: <20200618010805.600873-99-sashal@kernel.org>
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

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 4d3da2d8d91f66988a829a18a0ce59945e8ae4fb ]

While trying to use the lantiq_gswip driver on one of my boards I made
a mistake when specifying the phy-mode (because the out-of-tree driver
wants phy-mode "gmii" or "mii" for the internal PHYs). In this case the
following error is printed multiple times:
  Unsupported interface: 3

While it gives at least a hint at what may be wrong it is not very user
friendly. Print the human readable phy-mode and also which port is
configured incorrectly (this hardware supports ports 0..6) to improve
the cases where someone made a mistake.

Fixes: 14fceff4771e51 ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/lantiq_gswip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index cf6fa8fede33..521ebc072903 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1452,7 +1452,8 @@ static void gswip_phylink_validate(struct dsa_switch *ds, int port,
 
 unsupported:
 	bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
-	dev_err(ds->dev, "Unsupported interface: %d\n", state->interface);
+	dev_err(ds->dev, "Unsupported interface '%s' for port %d\n",
+		phy_modes(state->interface), port);
 	return;
 }
 
-- 
2.25.1

