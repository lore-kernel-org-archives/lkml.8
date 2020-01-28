Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9828C47409
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B687924686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222551;
	bh=TMN4/N4RIpBH1B2XMbJ2DUp+20SeSXafMDJmtucLaCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OKyZoxfnOuvIvUWBvD4YCEi6QJw1iISYuxzhHSQYgct8xSlpmDpQjNYhJCNwwzRSH
	 gUjo1/qUGilKIuV28mDUyOe82HplTitk9VhBLxAU8r+ZD0ad6jFfTYQlTgxV11t84I
	 1FeO8asTIpgWU4KD9eGMO1QfPvkmX6UVBM0SuKLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgA1OM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:12:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgA1OMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:12:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC642468D;
        Tue, 28 Jan 2020 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220771;
        bh=TMN4/N4RIpBH1B2XMbJ2DUp+20SeSXafMDJmtucLaCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Axn9VMpZXYhyrJKrCRNdf+xH38TQtAMWtk44USRAQxwE0fWfNqIKtU8GPRjuRrUHC
         WRl/BiCluh2qNCuWpybaH3hFrdcW6qfqxS3f9yX3CjIrM652SdJLiLXhItT7RTlaWP
         AfSgAyVlIZYV+5gs+Du4JyZ6mVsrX7gXbPqQh8hI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 140/183] net: hisilicon: Fix signedness bug in hix5hd2_dev_probe()
Date:   Tue, 28 Jan 2020 15:05:59 +0100
Message-Id: <20200128135843.733493252@linuxfoundation.org>
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
index e51892d518ff3..761c80eb8a68f 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -951,7 +951,7 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
 		goto err_free_mdio;
 
 	priv->phy_mode = of_get_phy_mode(node);
-	if (priv->phy_mode < 0) {
+	if ((int)priv->phy_mode < 0) {
 		netdev_err(ndev, "not find phy-mode\n");
 		ret = -EINVAL;
 		goto err_mdiobus;
-- 
2.20.1



