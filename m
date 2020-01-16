Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270D9C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8701208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193297;
	bh=zjDu5LUz1ddhT3rYzGW3C0xYm9fXN5BEwr1kJP1QmIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fqLN8V7ueYMeGG2CIGae4vnepzNuJooWOQYaH71pmhLZhWG6hPPEK5FQ4Re+o4Rxn
	 vG4H+dlRxomZ0fZhvneu+X+VMjfknGk8ujembkM4kzKAWK+Fx950zVpcWaG4303xQG
	 urnMbMRdzZhAypFDrehA4WK5yxfIrZ83NmxEw+mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgAPQsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730135AbgAPQsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:48:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5146A2081E;
        Thu, 16 Jan 2020 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193282;
        bh=zjDu5LUz1ddhT3rYzGW3C0xYm9fXN5BEwr1kJP1QmIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KL2Oaz7P7AVcciWlNjqU2dgt9cU1t9yRonSMf04FYFVN29ARqgMTdgnCEN+l6PpBh
         7eBv1rJNEYHq0/l272hZRMEuOH+JJsmAJiNmXqEE0nlwx0os+9KfKsnLHHKZFbEwru
         GlYZNB/cmJAd3/JanmdfuNwaH3McgAtO4CTf6taY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 065/205] phy: ti: gmii-sel: fix mac tx internal delay for rgmii-rxid
Date:   Thu, 16 Jan 2020 11:40:40 -0500
Message-Id: <20200116164300.6705-65-sashal@kernel.org>
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

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit 316b429459066215abb50060873ec0832efc4044 ]

Now phy-gmii-sel will disable MAC TX internal delay for PHY interface mode
"rgmii-rxid" which is incorrect.
Hence, fix it by enabling MAC TX internal delay in the case of "rgmii-rxid"
mode.

Fixes: 92b58b34741f ("phy: ti: introduce phy-gmii-sel driver")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/ti/phy-gmii-sel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index a52c5bb35033..a28bd15297f5 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -69,11 +69,11 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
 		break;
 
 	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
 		gmii_sel_mode = AM33XX_GMII_SEL_MODE_RGMII;
 		break;
 
 	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		gmii_sel_mode = AM33XX_GMII_SEL_MODE_RGMII;
 		rgmii_id = 1;
-- 
2.20.1

