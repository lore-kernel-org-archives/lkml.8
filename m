Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B829C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C722073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199982;
	bh=Jkk9BBeYQ0OeLiIG3SfJOj/YsdJw4csXiPp2Uzx5mcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G98hMXOIqiRr71bkJmgz9Dt+1wDLDelZTMQMNotykC7hHdQ6lbH2FLJ5BK1d+wwVx
	 Cinf5n9UaTcXC0VpmNAhCDoUl10JCjsMNFkgUk2TfKdbYGEKwXuG+0F7RLrHbwFwHn
	 0R9YZ4sBjozrQUe+WCkU33yGABKfPVdMvgNHaa/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407208AbgAPSjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390410AbgAPRMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:12:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A494B24698;
        Thu, 16 Jan 2020 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194732;
        bh=Jkk9BBeYQ0OeLiIG3SfJOj/YsdJw4csXiPp2Uzx5mcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgXVZyjEzVdTCWsK8WZi99dALXIzM4oB/raqCNJhNREjDk+Okkim627hL+Ucyq+V2
         zuUMIaANXg+qz54IQ6M47N9FS6xEfWG4a035r+4U5W6VqVVQsleUMFM6YT+W46omnS
         fFEKPVrWyL1a4/DCwHKItt2nNERrHZaoSrhVpKGE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 565/671] net: netsec: Fix signedness bug in netsec_probe()
Date:   Thu, 16 Jan 2020 12:03:23 -0500
Message-Id: <20200116170509.12787-302-sashal@kernel.org>
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

[ Upstream commit bd55f8ddbc437c225391ca8f487e7ec10243c4cc ]

The "priv->phy_interface" variable is an enum and in this context GCC
will treat it as an unsigned int so the error handling is never
triggered.

Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/socionext/netsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index d9d0d03e4ce7..027367b9cc48 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1604,7 +1604,7 @@ static int netsec_probe(struct platform_device *pdev)
 			   NETIF_MSG_LINK | NETIF_MSG_PROBE;
 
 	priv->phy_interface = device_get_phy_mode(&pdev->dev);
-	if (priv->phy_interface < 0) {
+	if ((int)priv->phy_interface < 0) {
 		dev_err(&pdev->dev, "missing required property 'phy-mode'\n");
 		ret = -ENODEV;
 		goto free_ndev;
-- 
2.20.1

