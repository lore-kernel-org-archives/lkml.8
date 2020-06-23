Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74130C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DCD520781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947733;
	bh=g8N5YsB2wRO78MxTIYoOpkUVW6ucTYCxpFn8Ycm0xqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NISAn7TU4VBGVN9BS+16TgvQUQIHs/EXq59wA7nTTvp6/8bfXdxfVLnMuZnagazmU
	 6VVgukh7m43wHojueUFfrNAM+6jgFU2LYFihOGuMVjm3KN8ZEl0XwuURtpIJh++mba
	 Y8/Be0TOaWpHv9gvDLjGs90aky6sIGnWdEfaAE/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393581AbgFWV2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389101AbgFWUPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:15:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68F52080C;
        Tue, 23 Jun 2020 20:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943339;
        bh=g8N5YsB2wRO78MxTIYoOpkUVW6ucTYCxpFn8Ycm0xqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICQho6reEr/Lg/npZuDxyw1/cANZz36MRzgI1dsoiPyr8zA87QkjwmCSCQ3O6aaLa
         5Y0l38wkqPmP/unNQ3wu7VmCSnk3jFfzeWsJnPbmqFkEDYgXaM3eNkoBfUHasy0NjS
         509rQHJloW9otPXy3aqlXiCX+MkgaekGlNDSH2b8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 336/477] net: dp83867: Fix OF_MDIO config check
Date:   Tue, 23 Jun 2020 21:55:33 +0200
Message-Id: <20200623195423.423284308@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>

[ Upstream commit 506de00677b84dfc6718cbbd3495b1d90df5d098 ]

When CONFIG_OF_MDIO is set to be a module the code block is not
compiled. Use the IS_ENABLED macro that checks for both built in as
well as module.

Fixes: 2a10154abcb75 ("net: phy: dp83867: Add TI dp83867 phy")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83867.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index b55e3c0403edd..ddac79960ea71 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -488,7 +488,7 @@ static int dp83867_verify_rgmii_cfg(struct phy_device *phydev)
 	return 0;
 }
 
-#ifdef CONFIG_OF_MDIO
+#if IS_ENABLED(CONFIG_OF_MDIO)
 static int dp83867_of_init(struct phy_device *phydev)
 {
 	struct dp83867_private *dp83867 = phydev->priv;
-- 
2.25.1



