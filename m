Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAA4C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CEF2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586954398;
	bh=RcHhJ91AHTGJVw8sl+DGn5fvCtyzvZPESe/szQp5q28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YZOgtrKr+j0nopUuQ5YuhiGuc3APawMFdl9qxqWupvIfY8JU9HJPuikAyiA6lT0nX
	 IwD2Pu4At+w1Q+ItJmwvc+kyLxUpHbguf2PrpY3aPMmSoUcBxmGclIpYrjIGGt9npG
	 dtXhVWmlvBqmXkkwDIRr3ngbU5Kn8e1YpXnGHqms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369947AbgDOMjz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897552AbgDOLoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:44:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C104F20936;
        Wed, 15 Apr 2020 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951040;
        bh=RcHhJ91AHTGJVw8sl+DGn5fvCtyzvZPESe/szQp5q28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1HYrom2SdV4pKeZ7LVIe2Pc4FkPSFEBOisgJBNotz0Gx3DIO6H740UDaUkoay0EG
         lePOTIFjwDBJs/UR24V19MQkwEedhmawSK0qNMJEcHioOk16pH70feTxujec1NpbzW
         Abx6XH/Gxw5pbbxQCCJQs72YQFStqmAO6d2NrjH8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 076/106] net: phy: micrel: kszphy_resume(): add delay after genphy_resume() before accessing PHY registers
Date:   Wed, 15 Apr 2020 07:41:56 -0400
Message-Id: <20200415114226.13103-76-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 6110dff776f7fa65c35850ef65b41d3b39e2fac2 ]

After the power-down bit is cleared, the chip internally triggers a
global reset. According to the KSZ9031 documentation, we have to wait at
least 1ms for the reset to finish.

If the chip is accessed during reset, read will return 0xffff, while
write will be ignored. Depending on the system performance and MDIO bus
speed, we may or may not run in to this issue.

This bug was discovered on an iMX6QP system with KSZ9031 PHY and
attached PHY interrupt line. If IRQ was used, the link status update was
lost. In polling mode, the link status update was always correct.

The investigation showed, that during a read-modify-write access, the
read returned 0xffff (while the chip was still in reset) and
corresponding write hit the chip _after_ reset and triggered (due to the
0xffff) another reset in an undocumented bit (register 0x1f, bit 1),
resulting in the next write being lost due to the new reset cycle.

This patch fixes the issue by adding a 1...2 ms sleep after the
genphy_resume().

Fixes: 836384d2501d ("net: phy: micrel: Add specific suspend")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/micrel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 63dedec0433de..51b64f0877172 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -25,6 +25,7 @@
 #include <linux/micrel_phy.h>
 #include <linux/of.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 
 /* Operation Mode Strap Override */
 #define MII_KSZPHY_OMSO				0x16
@@ -902,6 +903,12 @@ static int kszphy_resume(struct phy_device *phydev)
 
 	genphy_resume(phydev);
 
+	/* After switching from power-down to normal mode, an internal global
+	 * reset is automatically generated. Wait a minimum of 1 ms before
+	 * read/write access to the PHY registers.
+	 */
+	usleep_range(1000, 2000);
+
 	ret = kszphy_config_reset(phydev);
 	if (ret)
 		return ret;
-- 
2.20.1

