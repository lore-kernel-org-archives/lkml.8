Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05FEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFEC214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865617;
	bh=ajMoI1rRS1dhfGS4GJMcyEeeC49VpvBGmLonN1/VUdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x48uRA/qWKo62Eovf2mFMSC/yzwbWxZPkDZUwl7NnhJ1xQR4a3p4zad2av1wjKLka
	 GfdlRjrYCYrLJAHe6jvGT8fnqWNfiNsrgFWy+NeGWCfU6UhtV9D/aIXmiwu7FRp/q7
	 39lr4cr/s4HHelEqu5RZsaVZSuJ8nLQMnCPSbMHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404614AbgAXLdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:33:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404595AbgAXLde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:33:34 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52020214AF;
        Fri, 24 Jan 2020 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865613;
        bh=ajMoI1rRS1dhfGS4GJMcyEeeC49VpvBGmLonN1/VUdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYBInmrxY/x0FTh5mhiaV5v8B/Kw2Lz81NMjmVZXzR0B7eGttFKujVu3IOjgtjFJw
         +0yB7BuFpmopy29xG86ujYWZnPkSvqcZtq1h/YJqq31RvK6gHxIi6s6VlbJAUzj64N
         qIPotRLBRYxEOKrqNZlL2umCrWjLcawyOUv8uRuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 576/639] net: hisilicon: Fix signedness bug in hix5hd2_dev_probe()
Date:   Fri, 24 Jan 2020 10:32:26 +0100
Message-Id: <20200124093201.604948176@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 002dfe8085255b7bf1e0758c3d195c5412d35be9 ]

The "priv->phy_mode" variable is an enum and in this context GCC will
treat it as unsigned to the error handling will never trigger.

Fixes: 57c5bc9ad7d7 ("net: hisilicon: add hix5hd2 mac driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index 471805ea363b6..b63871ef8a403 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -1201,7 +1201,7 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
 		goto err_free_mdio;
 
 	priv->phy_mode = of_get_phy_mode(node);
-	if (priv->phy_mode < 0) {
+	if ((int)priv->phy_mode < 0) {
 		netdev_err(ndev, "not find phy-mode\n");
 		ret = -EINVAL;
 		goto err_mdiobus;
-- 
2.20.1



