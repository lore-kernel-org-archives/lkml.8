Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870E1C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E13220873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588254746;
	bh=tIxpfOA4unSyFcuBwL1ysoSVx3S9UkoYppubKOKbt1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X6/TLi8ULY98ZD/vhIVY+xKVEeOyRw8lLVPwTe0dFxoeR7HjmnPfSQzVR/bYgjQ9l
	 bPtL82ssWo0Yu65E6QflwuiijG9hf4sg+JYSmICaCTpLAmtIGoimdUI9Q/LOw2fQWI
	 AYdxzu28LiKtiUv3rcGA0cHXWzH+YE2fU/KtCDi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgD3NwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbgD3NwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:52:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C26124953;
        Thu, 30 Apr 2020 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254719;
        bh=tIxpfOA4unSyFcuBwL1ysoSVx3S9UkoYppubKOKbt1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RH0gfHAbf0QqUx0z5Q/ZyyXf7JqZmeWfuo07S/AwN0bsUg5d/foiCYjIzdv1S33fV
         qI+mnQM6dIGsLGZ20XlyG8go506+e9pPi4WQdIlhLsj+OF2SphZoNXNffeoXVdKXUl
         +JZvClv8X8iDAVqGPy4CaSUXGC/944SgR5pqCshE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 67/79] net: phy: bcm84881: clear settings on link down
Date:   Thu, 30 Apr 2020 09:50:31 -0400
Message-Id: <20200430135043.19851-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 796a8fa28980050bf1995617f0876484f3dc1026 ]

Clear the link partner advertisement, speed, duplex and pause when
the link goes down, as other phylib drivers do.  This avoids the
stale link partner, speed and duplex settings being reported via
ethtool.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/bcm84881.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
index 14d55a77eb28a..1260115829283 100644
--- a/drivers/net/phy/bcm84881.c
+++ b/drivers/net/phy/bcm84881.c
@@ -174,9 +174,6 @@ static int bcm84881_read_status(struct phy_device *phydev)
 	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete)
 		phydev->link = false;
 
-	if (!phydev->link)
-		return 0;
-
 	linkmode_zero(phydev->lp_advertising);
 	phydev->speed = SPEED_UNKNOWN;
 	phydev->duplex = DUPLEX_UNKNOWN;
@@ -184,6 +181,9 @@ static int bcm84881_read_status(struct phy_device *phydev)
 	phydev->asym_pause = 0;
 	phydev->mdix = 0;
 
+	if (!phydev->link)
+		return 0;
+
 	if (phydev->autoneg_complete) {
 		val = genphy_c45_read_lpa(phydev);
 		if (val < 0)
-- 
2.20.1

