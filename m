Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A893BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB2124681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221390;
	bh=I9QF16T1RB8KtQQlUk02ivaRSDOJiMRfX7DO32BOe1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OalRKSgWa/u7WFl3t8/vYt8DZNtfMLHF8a96nFt08k3n/hRVjuCyfn6ul1WNVGa0x
	 WGMSozsE7dcSDrp6c1DirJjRr1lOQZZSTlcg8cSJDqScmG70X0y0Gf3/eMNAGgpEas
	 QqQ1zH3RA+Uxx2l8kFJTpoWq8uqGQnFucQ4bee9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbgA1OXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:23:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731940AbgA1OXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:23:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67B172468D;
        Tue, 28 Jan 2020 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221385;
        bh=I9QF16T1RB8KtQQlUk02ivaRSDOJiMRfX7DO32BOe1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vW64iHrYpK+Pr/yks9sBWtVQ24E4KHgPfxSqAatF5WtORW/xgNxjkf5Rq0vSF/CNp
         aSmCTc+fIVSDP94/c3f+6oaERd3loLY0atHSOBLONx3/XEylLZwXbfLVeOX67N3k6b
         mGTD0Cssb8a420PglVX6jL0hiTrZ8krYPNl2HQjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 204/271] net: broadcom/bcmsysport: Fix signedness in bcm_sysport_probe()
Date:   Tue, 28 Jan 2020 15:05:53 +0100
Message-Id: <20200128135907.745239721@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 25a584955f020d6ec499c513923fb220f3112d2b ]

The "priv->phy_interface" variable is an enum and in this context GCC
will treat it as unsigned so the error handling will never be
triggered.

Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 95874c10c23b6..e3b41af65d188 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1773,7 +1773,7 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 
 	priv->phy_interface = of_get_phy_mode(dn);
 	/* Default to GMII interface mode */
-	if (priv->phy_interface < 0)
+	if ((int)priv->phy_interface < 0)
 		priv->phy_interface = PHY_INTERFACE_MODE_GMII;
 
 	/* In the case of a fixed PHY, the DT node associated
-- 
2.20.1



