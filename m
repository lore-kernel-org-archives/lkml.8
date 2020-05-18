Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D79C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B73F20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824225;
	bh=bBVMQUF4qeXU5bRiE5oJQwrq4XxQsC6kpd+/+5KYOCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v1ZmPP1y9tb7gzL9IaCCPOcM0BnXUNRCT9HcLelfxqg/obP2SQi5edOaYHgggEc6i
	 oNnQtycny2r9eeio1sEs4yUVUCQVOmNIjrgqFxblmmkIW0hEhZ9YxW3seSObgB6vIb
	 WEaDWISR48FDoyrqMVlgDH5lsNzyarnTEhMxA1PE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgERRuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730668AbgERRuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:50:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A47320674;
        Mon, 18 May 2020 17:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824219;
        bh=bBVMQUF4qeXU5bRiE5oJQwrq4XxQsC6kpd+/+5KYOCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1MLF3oNas6zsbnUfLJCgORRvneE3bYELL8//0flNFKtFEcgmYk+uzf9HZuaM6ZUfG
         ko3z+3DZWeQwxyHBnyg+tFv2ARkcCH0tc0v6xxWsBp0TLUsFZn5NZPM8ZF7YnpPzpG
         zW+7zcqWeVS11jkrhy8OI4IEoXa26mI4iXsAHVL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 083/114] net: phy: fix aneg restart in phy_ethtool_set_eee
Date:   Mon, 18 May 2020 19:36:55 +0200
Message-Id: <20200518173517.367144093@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 9de5d235b60a7cdfcdd5461e70c5663e713fde87 ]

phy_restart_aneg() enables aneg in the PHY. That's not what we want
if phydev->autoneg is disabled. In this case still update EEE
advertisement register, but don't enable aneg and don't trigger an
aneg restart.

Fixes: f75abeb8338e ("net: phy: restart phy autonegotiation after EEE advertisment change")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1257,9 +1257,11 @@ int phy_ethtool_set_eee(struct phy_devic
 		/* Restart autonegotiation so the new modes get sent to the
 		 * link partner.
 		 */
-		ret = phy_restart_aneg(phydev);
-		if (ret < 0)
-			return ret;
+		if (phydev->autoneg == AUTONEG_ENABLE) {
+			ret = phy_restart_aneg(phydev);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	return 0;


