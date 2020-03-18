Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05987C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06BB20775
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565289;
	bh=r6mZS/jQtNDV6rtNX/kWpwXuUMyanIzXgkJvrL6OGnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D7DC58bt3qRE6binXpTod6p3Y1XmhtqjmT5nunhxdsCJt+U5UGVraDiMZhAh8i966
	 zaxokU2PwwCM9bYSFIzrlz8jbeCYe8eY04aj7kXVZzT20ZMQxsNLq6ZYwl5/GbuURn
	 jx7/g8gzsdXkDJa5Upd5gDTly9zjDmAJHxmgNaPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgCRVB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbgCRU4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:56:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE78220B1F;
        Wed, 18 Mar 2020 20:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564973;
        bh=r6mZS/jQtNDV6rtNX/kWpwXuUMyanIzXgkJvrL6OGnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enBtNEgrmY82E4FwgyjbT+2JEYG/EzH7x3vokeaq7ZtNvcDXopqgzlvEney1eBcTr
         /ET4/POGbhmGkrnaUdwDi/VnwMN1ICLDh+CMR1hK76KcdchC5+pP4Qf991t5VYQ4Ni
         rnQvnlNXVmUDcYxPy40RFVk82UA0Cd7Sn9MkpcNE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dajun Jin <adajunjin@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/28] drivers/of/of_mdio.c:fix of_mdiobus_register()
Date:   Wed, 18 Mar 2020 16:55:42 -0400
Message-Id: <20200318205555.17447-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205555.17447-1-sashal@kernel.org>
References: <20200318205555.17447-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dajun Jin <adajunjin@gmail.com>

[ Upstream commit 209c65b61d94344522c41a83cd6ce51aac5fd0a4 ]

When registers a phy_device successful, should terminate the loop
or the phy_device would be registered in other addr. If there are
multiple PHYs without reg properties, it will go wrong.

Signed-off-by: Dajun Jin <adajunjin@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/of_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index fe26697d3bd72..69da2f6896dae 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -259,6 +259,7 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 				rc = of_mdiobus_register_phy(mdio, child, addr);
 				if (rc && rc != -ENODEV)
 					goto unregister;
+				break;
 			}
 		}
 	}
-- 
2.20.1

