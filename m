Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDD1C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE8824693
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221303;
	bh=Sfmb2ZdL6ft6NwPcDPR+ZaOaJpdV1GTSVQsBMSNrpCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AxElalvm3RBQhaNnCwIN/C9I/xTay+E4NGOv0SQ0dfbftCsY8SzNfT6QwkbZLgicL
	 Y3AjcO0PCOugzTmpcjX6pQcH1qD5tDjOsdZb+NFugdnxVsx/adTJ62JF49+m0JNajr
	 7xGdDkFTiuOf/pXmRWYBhIOv/+zIvZXyNX6QJX1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgA1OVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731342AbgA1OVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:21:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D7B124698;
        Tue, 28 Jan 2020 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221298;
        bh=Sfmb2ZdL6ft6NwPcDPR+ZaOaJpdV1GTSVQsBMSNrpCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZM/RK3bQBvzhps2avMxtnbLv+TrCZB/ufuLLYSlqboJo8ItFqw5EW0LuQhl4l/cjn
         LeaFTfmgeT4VQGGyAscOKpLQPRm1vUjcwoNA6ES3/qWiluDyVdh5tDYLxI5sMEiKNC
         dhWZ/8webtVTZ/PDWfJoZIPR+9RPFzTmJARcRB9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 168/271] net: pasemi: fix an use-after-free in pasemi_mac_phy_init()
Date:   Tue, 28 Jan 2020 15:05:17 +0100
Message-Id: <20200128135905.085190126@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
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
index 2f4a837f0d6ad..dcd56ac687482 100644
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



