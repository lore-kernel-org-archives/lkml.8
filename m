Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D25EC5ACBF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE0520736
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326062;
	bh=c89utpjyJCM1WC9RrJfhwK+FgjmLnvI7luTATiwF9VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z0PSAuRM2xJtiUhb1+wbx1EQGcWYWtYyqEfdygg+5v8Eod6QfpmN8bgKbiLzddzFJ
	 sYh6hsybS+onIxXOa+DFfS/hVadg4SGKnwTnKuEdktV+sQiHa8V+bblsxYO7sOk4A+
	 4vn+FkdShrPJPdIoV06E6CJojGNsq3vv5XtiWCok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgCPCeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbgCPCeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:34:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E92820754;
        Mon, 16 Mar 2020 02:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326057;
        bh=c89utpjyJCM1WC9RrJfhwK+FgjmLnvI7luTATiwF9VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1mwb3GOq16Hjo2WrxgWSeB9gBnmvWq7mWPC0NgUOWI15USmapXNrxJZgTPU8UMPFF
         HceVuMd9Iq8G0V90yH4SNnWsmlI32gAOFTlzvxeaeJbz2FvMyWIgRzFo0ORcLMHnh9
         xn3b+x+SbXLBvUuPhf/lwbTf7Zzr4eRrdOrFZDW8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 05/35] phy: ti: gmii-sel: fix set of copy-paste errors
Date:   Sun, 15 Mar 2020 22:33:41 -0400
Message-Id: <20200316023411.1263-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023411.1263-1-sashal@kernel.org>
References: <20200316023411.1263-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit eefed634eb61e4094b9fb8183cb8d43b26838517 ]

- under PHY_INTERFACE_MODE_MII the 'mode' func parameter is assigned
instead of 'gmii_sel_mode' and it's working only because the default value
'gmii_sel_mode' is set to 0.

- console outputs use 'rgmii_id' and 'mode' values to print PHY mode
instead of using 'submode' value which is representing PHY interface mode
now.

This patch fixes above two cases.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/ti/phy-gmii-sel.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index a28bd15297f53..e998e9cd8d1f8 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -80,20 +80,19 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
 		break;
 
 	case PHY_INTERFACE_MODE_MII:
-		mode = AM33XX_GMII_SEL_MODE_MII;
+		gmii_sel_mode = AM33XX_GMII_SEL_MODE_MII;
 		break;
 
 	default:
-		dev_warn(dev,
-			 "port%u: unsupported mode: \"%s\". Defaulting to MII.\n",
-			 if_phy->id, phy_modes(rgmii_id));
+		dev_warn(dev, "port%u: unsupported mode: \"%s\"\n",
+			 if_phy->id, phy_modes(submode));
 		return -EINVAL;
 	}
 
 	if_phy->phy_if_mode = submode;
 
 	dev_dbg(dev, "%s id:%u mode:%u rgmii_id:%d rmii_clk_ext:%d\n",
-		__func__, if_phy->id, mode, rgmii_id,
+		__func__, if_phy->id, submode, rgmii_id,
 		if_phy->rmii_clock_external);
 
 	regfield = if_phy->fields[PHY_GMII_SEL_PORT_MODE];
-- 
2.20.1

