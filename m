Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9F8C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E7424692
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197060;
	bh=VpysHlMNeAQuSTtuAMo5Vv9qefu8VwtHAnO9zZEkQh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qOzsvmr3HkBF+xfynRO01OCA7xMXF9ll+QYxSRUQ80voNwg39su47/cH55kjYut/9
	 8hpH70x3j5VGi41H98QeqtTwrmugSD+vd9lOuBrJ2hv/0ujWjKwl28vxSiOVSvviUR
	 30dV5s08c9L4rQQrxHtlSKl09EiWopQNE9z38PD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406476AbgAPRpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:45:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405892AbgAPRpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:45:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2703924781;
        Thu, 16 Jan 2020 17:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196724;
        bh=VpysHlMNeAQuSTtuAMo5Vv9qefu8VwtHAnO9zZEkQh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fwdIQOE7iJ0tmKPApA3Mrz5PLjlcNN9GaSAzuXIQsg3jxrDVs9phD7G9zUkA4+gTL
         b9rHRE+eKvk4O29+R9021MXj8ClFzvyLk12+q7U8O58KlkfYddWUCHp/p+TYCMLQPj
         pO4wHcGHyogK0mKP0wotKE86vcKQffTTo2U04wUY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 109/174] net: pasemi: fix an use-after-free in pasemi_mac_phy_init()
Date:   Thu, 16 Jan 2020 12:41:46 -0500
Message-Id: <20200116174251.24326-109-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit faf5577f2498cea23011b5c785ef853ded22700b ]

The phy_dn variable is still being used in of_phy_connect() after the
of_node_put() call, which may result in use-after-free.

Fixes: 1dd2d06c0459 ("net: Rework pasemi_mac driver to use of_mdio infrastructure")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pasemi/pasemi_mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index 57a6e6cd74fc..48106953cf64 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1091,7 +1091,6 @@ static int pasemi_mac_phy_init(struct net_device *dev)
 
 	dn = pci_device_to_OF_node(mac->pdev);
 	phy_dn = of_parse_phandle(dn, "phy-handle", 0);
-	of_node_put(phy_dn);
 
 	mac->link = 0;
 	mac->speed = 0;
@@ -1100,6 +1099,7 @@ static int pasemi_mac_phy_init(struct net_device *dev)
 	phydev = of_phy_connect(dev, phy_dn, &pasemi_adjust_link, 0,
 				PHY_INTERFACE_MODE_SGMII);
 
+	of_node_put(phy_dn);
 	if (!phydev) {
 		printk(KERN_ERR "%s: Could not attach to phy\n", dev->name);
 		return -ENODEV;
-- 
2.20.1

