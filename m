Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BBCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291D320678
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220706;
	bh=bglMOhpW0akwAO+UKsVyPEKX3a4ppREXxXPwjhFHAw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DhyQJ93lR/KL5riHQsrqrVSogiKFL4yAopOWbb17m6A5EJd4zzhkWb9vClpMGa2Oi
	 vQgIh7pQYN8JMN2+TkiWSAgs/Lb9x2UAp6l9zdU8v/oWIK16lIkCV99++dl3mURM09
	 Wn93gsWuNVRTNedK3zVP2KM5fnaags+FGsRORWf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgA1OLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:11:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgA1OLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:11:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4959E24685;
        Tue, 28 Jan 2020 14:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220699;
        bh=bglMOhpW0akwAO+UKsVyPEKX3a4ppREXxXPwjhFHAw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=frmn8J2D3e8YSTKtf4SuDTCbs8t1nFn9MEGzUdYXHMO9u6PrjjTNUNX/YUMRnas9F
         YdDmf6zdb1lhz4FFotUh8UX/Q92qTSf3QnqSvGTinMCB1wicXD4khKJ/ui0AsjiL31
         zaCmYy3os2wsDWzlUZwwsRKA5bUAGojINgtTQO+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 110/183] net: pasemi: fix an use-after-free in pasemi_mac_phy_init()
Date:   Tue, 28 Jan 2020 15:05:29 +0100
Message-Id: <20200128135840.905748645@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 57a6e6cd74fc3..48106953cf64b 100644
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



