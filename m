Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACACC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6F6207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199945;
	bh=eIAApzGvKPVosDKptbudnKgGTlK2ZkjJDYSiHbW84mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LBg6gd1bqbVUG3Lo5FskueARYmmwg4nZtvYqxeFhluu4xyjA+3Yd2bPMSZpvz/Bq1
	 hyLGuFO09b+pQN2PY6WOlI8iMj3V+FziQyuwDXxUFfzC339/yp8sOHU+xyVIhuOV7U
	 MARUXr0W7Ux/P2dAqutMdp4oSVkL+8mtucrhefN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407190AbgAPSjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:39:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390449AbgAPRMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:12:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9624024692;
        Thu, 16 Jan 2020 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194739;
        bh=eIAApzGvKPVosDKptbudnKgGTlK2ZkjJDYSiHbW84mA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcUlBYpGzAc2DoFTjoZh1bVCJljc3Utb8A7uQP14hWA+snC0FCEXLWNfiIODkzWZf
         i6GeU4jE5uBHd3cjFkOp9CpluhH4C1d//H+Pj/K6g6QYhD1EAKxBtorhdF3tEddmrB
         QE4CB86lkpEbIz5b8w5a+xPqPGbkk/4OqcSJXHPc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 570/671] net: nixge: Fix a signedness bug in nixge_probe()
Date:   Thu, 16 Jan 2020 12:03:28 -0500
Message-Id: <20200116170509.12787-307-sashal@kernel.org>
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

[ Upstream commit 1a4b62a0b8a3b81eca24366f63e214a7144b9f02 ]

The "priv->phy_mode" is an enum and in this context GCC will treat it
as an unsigned int so it can never be less than zero.

Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ni/nixge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 76efed058f33..a791d7932b0e 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1233,7 +1233,7 @@ static int nixge_probe(struct platform_device *pdev)
 	}
 
 	priv->phy_mode = of_get_phy_mode(pdev->dev.of_node);
-	if (priv->phy_mode < 0) {
+	if ((int)priv->phy_mode < 0) {
 		netdev_err(ndev, "not find \"phy-mode\" property\n");
 		err = -EINVAL;
 		goto unregister_mdio;
-- 
2.20.1

