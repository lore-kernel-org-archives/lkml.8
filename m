Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A96C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376DF2081E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200020;
	bh=v3FcY8PQf8rf8lrSuh8yn3I1G69/fKrawZrx+yER9fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gIISGObXqW69KIG2fRbft++Rc/1fkWkdRQ50h7qNAe1VyILg8gdqd2DLWGIiClU2z
	 gVJdKQuAFp+lYyPrRNgB+GMZidgXzQUa1yusVBqFiZwxjdXjkhQiw8bsMyMaEeq+tz
	 R/JQR59h8dvNtByxZKOlgBDgEWb8VVvnJq1xcoRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436935AbgAPSkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390400AbgAPRMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:12:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E80E24692;
        Thu, 16 Jan 2020 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194730;
        bh=v3FcY8PQf8rf8lrSuh8yn3I1G69/fKrawZrx+yER9fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wcsug/D15oZfTVw22gmYOvZ7vmAUaLgsGkvWoEd+Yv1O22R1QN+lKvplGJkIFV1G8
         qZDP7382vw+3M/Oci3vuVryXnk9y1DSUYO6jy2S0aYK9UfYjOQJttDAuoxpZtqk6ca
         3yWiEK7aBhq2rg3qXqNDBk0n18kvlyMi9hf56v58=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 563/671] net: hisilicon: Fix signedness bug in hix5hd2_dev_probe()
Date:   Thu, 16 Jan 2020 12:03:21 -0500
Message-Id: <20200116170509.12787-300-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 471805ea363b..b63871ef8a40 100644
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

