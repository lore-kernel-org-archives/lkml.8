Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D532C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339DE2051A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586647979;
	bh=6zXeoIfrsYRRSY4bSjH13CfgkYQwnWYqWQUm4Aw2Y/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tlBybeER3/1lkDdsdMUCYScrvDj7x+3wJQIpHd8WJ8G8/HOSBzjxwpC/ANiAXDwxe
	 epaXdMYXad4wWTRN4xXn9PI2GtbVdVShyZIIAMucO/mcCxShSzU44SX4IE3wAkdmU9
	 ByccdO8CGtc9NIHtzrb6/fGfxsTGXkbzyhVRTOng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgDKXc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgDKXJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:09:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97DA82173E;
        Sat, 11 Apr 2020 23:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646596;
        bh=6zXeoIfrsYRRSY4bSjH13CfgkYQwnWYqWQUm4Aw2Y/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npX+bOBmOTqCB8co3rzALVWqqLFwdoW8nuaKjoMbqi+4rra0Du9PX28+UFYBv2Xhi
         sc/L/vd2m4/kCYrDW7EQ08UyvJeagke2bfKBuqDgUYDCDL+JKPN6QzZYb91eGhVAXl
         ZYRFmchkAEXvYjN2epD7KfNGA/H+yJZXggFLEqao=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 010/108] net: phy: mscc: accept all RGMII species in vsc85xx_mac_if_set
Date:   Sat, 11 Apr 2020 19:08:05 -0400
Message-Id: <20200411230943.24951-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230943.24951-1-sashal@kernel.org>
References: <20200411230943.24951-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit da206d65f2b293274f8082a26da4e43a1610da54 ]

The helper for configuring the pinout of the MII side of the PHY should
do so irrespective of whether RGMII delays are used or not. So accept
the ID, TXID and RXID variants as well, not just the no-delay RGMII
variant.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mscc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 2339b9381d216..05d7c5cd9a308 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -816,6 +816,9 @@ static int vsc85xx_mac_if_set(struct phy_device *phydev,
 	reg_val = phy_read(phydev, MSCC_PHY_EXT_PHY_CNTL_1);
 	reg_val &= ~(MAC_IF_SELECTION_MASK);
 	switch (interface) {
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII:
 		reg_val |= (MAC_IF_SELECTION_RGMII << MAC_IF_SELECTION_POS);
 		break;
-- 
2.20.1

