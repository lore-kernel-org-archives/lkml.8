Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F27EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 211F62080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087664;
	bh=lgSRBSo9kz+j9MyJenmkufp/zityPquo/vzYct1svQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u103JXCoqi9OeFcIwr8TQb4CsaJW6vjpSLWwSivxMR6Gn4ldeS1eyPdG70vf3VtXZ
	 4m5apfm6htCn3YZhU+7L2L1RpAc+JDNW45LijmX1BOA6hzZojTG+X3Vkqtl7yi1E0I
	 m/8MRjHh7xagt0pTPmvU8mVWinNFNDGF2o7mUdeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgHJTL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgHJTLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:11:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D68521775;
        Mon, 10 Aug 2020 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086668;
        bh=lgSRBSo9kz+j9MyJenmkufp/zityPquo/vzYct1svQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDd3unqGtQ50eNd7bvIzKfImYKdViNTfKE3kk+DHBZDP/+6fPZReBLyGVnNNwF6Ey
         wHJIw8nDbs4cgqG7onNyfeKAzEXGUVcDfYRgJc67zCyhFD2MVQ5gKsDZy25tBIC5Mu
         vPEgf/vyY36aFJLeEUdHPpvVxsdpdeLUppRR/0S0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 29/60] net: phy: mscc: restore the base page in vsc8514/8584_config_init
Date:   Mon, 10 Aug 2020 15:09:57 -0400
Message-Id: <20200810191028.3793884-29-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191028.3793884-1-sashal@kernel.org>
References: <20200810191028.3793884-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 6119dda34e5d0821959e37641b287576826b6378 ]

In the vsc8584_config_init and vsc8514_config_init, the base page is set
to 'GPIO', configuration is done, and the page is never explicitly
restored to the standard page. No bug was triggered as it turns out
helpers called in those config_init functions do modify the base page,
and set it back to standard. But that is dangerous and any modification
to those functions would introduce bugs. This patch fixes this, to
improve maintenance, by restoring the base page to 'standard' once
'GPIO' accesses are completed.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mscc/mscc_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 485a4f8a6a9a6..95bd2d277ba42 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -1413,6 +1413,11 @@ static int vsc8584_config_init(struct phy_device *phydev)
 	if (ret)
 		goto err;
 
+	ret = phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS,
+			     MSCC_PHY_PAGE_STANDARD);
+	if (ret)
+		goto err;
+
 	if (!phy_interface_is_rgmii(phydev)) {
 		val = PROC_CMD_MCB_ACCESS_MAC_CONF | PROC_CMD_RST_CONF_PORT |
 			PROC_CMD_READ_MOD_WRITE_PORT;
@@ -1799,7 +1804,11 @@ static int vsc8514_config_init(struct phy_device *phydev)
 	val &= ~MAC_CFG_MASK;
 	val |= MAC_CFG_QSGMII;
 	ret = phy_base_write(phydev, MSCC_PHY_MAC_CFG_FASTLINK, val);
+	if (ret)
+		goto err;
 
+	ret = phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS,
+			     MSCC_PHY_PAGE_STANDARD);
 	if (ret)
 		goto err;
 
-- 
2.25.1

