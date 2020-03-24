Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15497C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A6B2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056640;
	bh=c89utpjyJCM1WC9RrJfhwK+FgjmLnvI7luTATiwF9VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oKc/BTLcDc+YSBRQ1JPPRE+vNpyCTocjD8SN+raADJZylIAlx693uj59SkOgR1Iuh
	 ag0oFXBG5sF1+HZZ5TWYEb5jsOyQHtdUEgWzHhYr2BXTNnbpXL8IEAj/7VBIJxK8tw
	 RFSvHnJgWvh8p9+KW80olDjCqAHB0zi7jshRVvZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgCXNak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbgCXNWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:22:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FEE7206F6;
        Tue, 24 Mar 2020 13:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056163;
        bh=c89utpjyJCM1WC9RrJfhwK+FgjmLnvI7luTATiwF9VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QmJXglC2kf5UO714YI7xs9R2YNwvlnA17oKnwd1MdwylQvK9gK58R16mglxg+2XrG
         5wfktyof977gU2Dgl6PvSlaI3dbctKOkxtbK/DFOimDMUAPR0P2rRTAeHASgnm7r0t
         DSFVGkq/5dIkl0TLY+oKB/cpE3lezqdjGXi/K9Mc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 006/119] phy: ti: gmii-sel: fix set of copy-paste errors
Date:   Tue, 24 Mar 2020 14:09:51 +0100
Message-Id: <20200324130808.639713876@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



