Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA534C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6EE20658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759454;
	bh=r6mZS/jQtNDV6rtNX/kWpwXuUMyanIzXgkJvrL6OGnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ecoXKx0gdTDGBwn5wQu2dQWteaCt6E1SDywbS7imi2rqkIFrhNPxEp8kWchphs1Iu
	 oW3ksfqKr5RNxO8fiVI6lW377fTFf9N16lrPTSk+h2rHRmG7YkiWKnoa70TNQxMrvf
	 164LbFrS/WJChJjG0zMyCGxhUOhaXJiRLVzLsvsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389708AbgDAQoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389690AbgDAQoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:44:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B812063A;
        Wed,  1 Apr 2020 16:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759450;
        bh=r6mZS/jQtNDV6rtNX/kWpwXuUMyanIzXgkJvrL6OGnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+pEHltABp/5rhQSoPF4Jm0K82zau8x97cwof1cGXf9LXjrA0KsYt8tvqo9Pvq7+Z
         eu0770LA3Y0CaE5z/ZjZO1ZQWkXcqyZRp0rCyY7GR+ObA9PNKj86tSABKzarwo8bkh
         gTN57Zd/INGCzR7HXGaEVpbcEFhH/EYaHQbaLQtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dajun Jin <adajunjin@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 076/148] drivers/of/of_mdio.c:fix of_mdiobus_register()
Date:   Wed,  1 Apr 2020 18:17:48 +0200
Message-Id: <20200401161600.621429294@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



