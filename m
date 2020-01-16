Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A25CC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBE42192A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193123;
	bh=LloDcqJ/iXMkz8+ZcJPLrEce9JsPdxR77CwK+93jPBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nMsqpu/aJfjyeJtMakIj5FS5sDvGuJksFVVRGC3Ix1a/bMmS7NDzw8WB1vtekTzoj
	 NcoDnrm2RoqUdSJB7IAWZWU/IUQRrzXdgfUm8hxhG0SxXB7ujJEPK8rVKrZIvdAylW
	 SDJgwrCkvNolZDtro9koNHWLK3pIlKVC4TZIDVJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgAPQpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:45:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729164AbgAPQpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:45:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66CD224653;
        Thu, 16 Jan 2020 16:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193119;
        bh=LloDcqJ/iXMkz8+ZcJPLrEce9JsPdxR77CwK+93jPBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=raA5DK4TneVwg31n/l8EU8B9Z1Zk0Hj+XsPGhqlYgGrIYJlPW3j1i6lNqAMqw084x
         F3S/2mazvu43uD6eK/dZ7qBJTf48DoY5rM0iURyIK741HknzErpAoiNzRkLsxlfGMD
         LOTggkC20EbF2zSF/kNjCz1lslY6lqofU266uKG8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Manasa Mudireddy <manasa.mudireddy@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 028/205] net: phy: broadcom: Fix RGMII delays configuration for BCM54210E
Date:   Thu, 16 Jan 2020 11:40:03 -0500
Message-Id: <20200116164300.6705-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit fea7fda7f50a6059220f83251e70709e45cc8040 ]

Commit 0fc9ae107669 ("net: phy: broadcom: add support for
BCM54210E") added support for BCM54210E but also unconditionally cleared
the RXC to RXD skew and the TXD to TXC skew, thus only making
PHY_INTERFACE_MODE_RGMII a possible configuration. Use
bcm54xx_config_clock_delay() which correctly sets the registers
depending on the 4 possible PHY interface values that exist for RGMII.

Fixes: 0fc9ae107669 ("net: phy: broadcom: add support for BCM54210E")
Reported-by: Manasa Mudireddy <manasa.mudireddy@broadcom.com>
Reported-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/broadcom.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 937d0059e8ac..5e956089bf52 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -26,18 +26,13 @@ MODULE_DESCRIPTION("Broadcom PHY driver");
 MODULE_AUTHOR("Maciej W. Rozycki");
 MODULE_LICENSE("GPL");
 
+static int bcm54xx_config_clock_delay(struct phy_device *phydev);
+
 static int bcm54210e_config_init(struct phy_device *phydev)
 {
 	int val;
 
-	val = bcm54xx_auxctl_read(phydev, MII_BCM54XX_AUXCTL_SHDWSEL_MISC);
-	val &= ~MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN;
-	val |= MII_BCM54XX_AUXCTL_MISC_WREN;
-	bcm54xx_auxctl_write(phydev, MII_BCM54XX_AUXCTL_SHDWSEL_MISC, val);
-
-	val = bcm_phy_read_shadow(phydev, BCM54810_SHD_CLK_CTL);
-	val &= ~BCM54810_SHD_CLK_CTL_GTXCLK_EN;
-	bcm_phy_write_shadow(phydev, BCM54810_SHD_CLK_CTL, val);
+	bcm54xx_config_clock_delay(phydev);
 
 	if (phydev->dev_flags & PHY_BRCM_EN_MASTER_MODE) {
 		val = phy_read(phydev, MII_CTRL1000);
-- 
2.20.1

