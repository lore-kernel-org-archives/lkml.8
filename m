Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F99C4332E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07ED220409
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565424;
	bh=AY71obNf1Q6UB9Va0NbDL8+4U8PXAhRAQSmgjRWd5Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FpBtzfu/zf2IErxxSlJ83lEs3JAj6dToJTuQ6C4SYIhogd4HINRIaGU7a+qyrj1cz
	 ncLJgpSOExsMEPXF0dXR5TKS/JRU5w4TQPvQl+xLvYArAssOBBjmPi+Jtk6YsM783x
	 5WkOPPB0THJVQeJWrU9eCDe3XiB3eh+lTtkZhROE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgCRVDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbgCRUzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:55:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F6E208FE;
        Wed, 18 Mar 2020 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564931;
        bh=AY71obNf1Q6UB9Va0NbDL8+4U8PXAhRAQSmgjRWd5Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFXNo9P6vjXyLGSgHUphKBjLgt718EYSNX8DOxfqR6gFLWbv+57gjlB5CBRTCXF2f
         DZW76Q2le2SlQuk/TzWXRR6LW4U/84bmKpXFyTMR0nWwEyTmxzJvL4dHG1Zf9p0m8/
         KS25nAujEWxfZqU9s9VXThQUseZLI+Roi+26saYk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dajun Jin <adajunjin@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/37] drivers/of/of_mdio.c:fix of_mdiobus_register()
Date:   Wed, 18 Mar 2020 16:54:50 -0400
Message-Id: <20200318205509.17053-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205509.17053-1-sashal@kernel.org>
References: <20200318205509.17053-1-sashal@kernel.org>
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
index 7d2bc22680d90..af7572fe090fd 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -270,6 +270,7 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 				rc = of_mdiobus_register_phy(mdio, child, addr);
 				if (rc && rc != -ENODEV)
 					goto unregister;
+				break;
 			}
 		}
 	}
-- 
2.20.1

