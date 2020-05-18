Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C45BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7726207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824468;
	bh=n7nRvTCn9YchxNsik27yMI+NE74Rkr4uORdvsNKGRXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CV+F/O1x1XoS7njdHaFd6/eqVg4oSHElobiU9qh1bIpixXkvibDfy2QvFzR9hwWmF
	 6F24UwUTC+XOyuXMfUeA9GlDQCjge/GGZGp6yuRLmeG8IZho+IXos1yWwZ0rg/Rmib
	 tIN+X5O/eJLCMabu1epviV9DDbcI5I8fOfK3kZ0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbgERRy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731293AbgERRyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:54:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A61E820826;
        Mon, 18 May 2020 17:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824463;
        bh=n7nRvTCn9YchxNsik27yMI+NE74Rkr4uORdvsNKGRXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wF/v9juL5GWThdsYluY/aG22RsI7xGzIN1QjBJhe1swEj+rNDvqsFMOTpAqIV+js4
         VZ2gup8DnaNhctZmvaVR3U15VVVO7rkAEHiZkVT0MwfQdZRWElzGXZfeE0OV0xxqfP
         Q5Vk7w9F/HfxjoAADTVDsf9wFUO2673V4Cb12RRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 021/147] net: phy: fix aneg restart in phy_ethtool_set_eee
Date:   Mon, 18 May 2020 19:35:44 +0200
Message-Id: <20200518173516.450714019@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 9de5d235b60a7cdfcdd5461e70c5663e713fde87 ]

phy_restart_aneg() enables aneg in the PHY. That's not what we want
if phydev->autoneg is disabled. In this case still update EEE
advertisement register, but don't enable aneg and don't trigger an
aneg restart.

Fixes: f75abeb8338e ("net: phy: restart phy autonegotiation after EEE advertisment change")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1160,9 +1160,11 @@ int phy_ethtool_set_eee(struct phy_devic
 		/* Restart autonegotiation so the new modes get sent to the
 		 * link partner.
 		 */
-		ret = phy_restart_aneg(phydev);
-		if (ret < 0)
-			return ret;
+		if (phydev->autoneg == AUTONEG_ENABLE) {
+			ret = phy_restart_aneg(phydev);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	return 0;


