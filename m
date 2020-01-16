Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37CEC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DE2214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197830;
	bh=VVYd60GeUMbZa4auO/I+egFzytr/8s7JdM602idEoxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H9Y71owj5US4DYT+LSPaLaj9Hqtmk8pIlwXkl/BfkHB3cNrTkt6IIcOAbqO5iCBq8
	 g0Ezh4kzSThTj9K4MpRQumXzLZQBcmJRlthXHBfZ8sZqdN9u+1ZQo+FqdwZeUL0+5r
	 Y1zGua1UHOyeWvjtwsvkUYx/MiNdqIUHVPGT2oJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393669AbgAPRko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:40:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393526AbgAPRjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:39:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A845246FC;
        Thu, 16 Jan 2020 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196385;
        bh=VVYd60GeUMbZa4auO/I+egFzytr/8s7JdM602idEoxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a9Eov1UsFwZbZlakxlCt1HvzxKMUHSgbPP/bIzGqQ7lmprNEisMbcCtLI/c6kqin3
         VQlIe52j6Em9zbczg+cIWlqQ+8hQQty0HBysFLSiyFgJy8/NA8Ii/mL36zfXs+uPmx
         irwPHiwIkLFQSVUWquCtnAv7YJvUVUi0j1NgAfhU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 167/251] net: pasemi: fix an use-after-free in pasemi_mac_phy_init()
Date:   Thu, 16 Jan 2020 12:35:16 -0500
Message-Id: <20200116173641.22137-127-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
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
index 2f4a837f0d6a..dcd56ac68748 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1053,7 +1053,6 @@ static int pasemi_mac_phy_init(struct net_device *dev)
 
 	dn = pci_device_to_OF_node(mac->pdev);
 	phy_dn = of_parse_phandle(dn, "phy-handle", 0);
-	of_node_put(phy_dn);
 
 	mac->link = 0;
 	mac->speed = 0;
@@ -1062,6 +1061,7 @@ static int pasemi_mac_phy_init(struct net_device *dev)
 	phydev = of_phy_connect(dev, phy_dn, &pasemi_adjust_link, 0,
 				PHY_INTERFACE_MODE_SGMII);
 
+	of_node_put(phy_dn);
 	if (!phydev) {
 		printk(KERN_ERR "%s: Could not attach to phy\n", dev->name);
 		return -ENODEV;
-- 
2.20.1

