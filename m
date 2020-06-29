Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A16C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973292063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593456154;
	bh=nkXVUsdToHyNieb+U/6qjEft4C6WlZi7raDmgvDcMO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fE+WjLd/4gUqAH3QF5V5wCtJBntGCYsKIgICDteRDBDFLViZvTSvVIHa9lQFw7QP5
	 ZtQMluGbxgaddeVgsO4/Ww/2U4biwQRbUl2hRIDxIxhBFGD+C8EeajM9eUGG5Z2jmk
	 ccl1GyO3/Ogi8Ja2taPtqOyh0Cqmp7vmMBKOJk1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgF2Smc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbgF2Sl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECFD124050;
        Mon, 29 Jun 2020 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443925;
        bh=nkXVUsdToHyNieb+U/6qjEft4C6WlZi7raDmgvDcMO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZSbTpfQ6whzHdgPRdLDv17mix5yhEUz83j4EGTIk9jcg2PlEuHLfEwWJfObPLNnIJ
         rSDLQ/MTUF+TSuS9A4vi+bR9L1mWaR013jLDZHVvd+GS9MndvXmg8w87iSJzxSHIrm
         7HCKTt/erpZ9MKh0mYpotHRquumKMgeYV7lt/Ij8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 026/265] net: phy: Check harder for errors in get_phy_id()
Date:   Mon, 29 Jun 2020 11:14:19 -0400
Message-Id: <20200629151818.2493727-27-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit b2ffc75e2e990b09903f9d15ccd53bc5f3a4217c ]

Commit 02a6efcab675 ("net: phy: allow scanning busses with missing
phys") added a special condition to return -ENODEV in case -ENODEV or
-EIO was returned from the first read of the MII_PHYSID1 register.

In case the MDIO bus data line pull-up is not strong enough, the MDIO
bus controller will not flag this as a read error. This can happen when
a pluggable daughter card is not connected and weak internal pull-ups
are used (since that is the only option, otherwise the pins are
floating).

The second read of MII_PHYSID2 will be correctly flagged an error
though, but now we will return -EIO which will be treated as a hard
error, thus preventing MDIO bus scanning loops to continue succesfully.

Apply the same logic to both register reads, thus allowing the scanning
logic to proceed.

Fixes: 02a6efcab675 ("net: phy: allow scanning busses with missing phys")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 697c74deb222b..0881b4b923632 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -798,8 +798,10 @@ static int get_phy_id(struct mii_bus *bus, int addr, u32 *phy_id,
 
 	/* Grab the bits from PHYIR2, and put them in the lower half */
 	phy_reg = mdiobus_read(bus, addr, MII_PHYSID2);
-	if (phy_reg < 0)
-		return -EIO;
+	if (phy_reg < 0) {
+		/* returning -ENODEV doesn't stop bus scanning */
+		return (phy_reg == -EIO || phy_reg == -ENODEV) ? -ENODEV : -EIO;
+	}
 
 	*phy_id |= phy_reg;
 
-- 
2.25.1

