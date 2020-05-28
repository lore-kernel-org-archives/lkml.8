Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AF7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872C721702
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667103;
	bh=8bC9I4a/4Z40qQbMuok38AUGb7l9vCZ1XVVilCGKiE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fOf4OJDw9v6h/xgE8tc3TdV1eR1o/gn5GqYA22ZEGEaE42Wg7a1lNIzsxW/ArIX9Q
	 5Ga+pJklHZoktqvkUyed88jBKWvpV3aRygwrVUiKF+Opf/Zt4xkE0YD+8upQC6Qghc
	 odejrab0sjPGAOKp6UICnWPFjVzHGkTMSSds8io8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389223AbgE1L6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389008AbgE1L5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:57:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 560E921582;
        Thu, 28 May 2020 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590667044;
        bh=8bC9I4a/4Z40qQbMuok38AUGb7l9vCZ1XVVilCGKiE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8BqOMOXMs0A1Z8OUe1QoLOL4BeUtCNnAs74PGrilYAZlDDYfJ6HAntEMSzXZ186i
         wiEu8MdZ8WmeZ0DqfjQdV3wrpgKvY+V+7PDSj84IDN60fyRCMUXrEbroiP5V+kejtg
         BvoKOb9YAprLnI0OcW+lY1QajWxWwmsSVt/G1UGc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 26/26] net: smsc911x: Fix runtime PM imbalance on error
Date:   Thu, 28 May 2020 07:56:54 -0400
Message-Id: <20200528115654.1406165-26-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115654.1406165-1-sashal@kernel.org>
References: <20200528115654.1406165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 539d39ad0c61b35f69565a037d7586deaf6d6166 ]

Remove runtime PM usage counter decrement when the
increment function has not been called to keep the
counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/smsc/smsc911x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 38068fc34141..c7bdada4d1b9 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2502,20 +2502,20 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 
 	retval = smsc911x_init(dev);
 	if (retval < 0)
-		goto out_disable_resources;
+		goto out_init_fail;
 
 	netif_carrier_off(dev);
 
 	retval = smsc911x_mii_init(pdev, dev);
 	if (retval) {
 		SMSC_WARN(pdata, probe, "Error %i initialising mii", retval);
-		goto out_disable_resources;
+		goto out_init_fail;
 	}
 
 	retval = register_netdev(dev);
 	if (retval) {
 		SMSC_WARN(pdata, probe, "Error %i registering device", retval);
-		goto out_disable_resources;
+		goto out_init_fail;
 	} else {
 		SMSC_TRACE(pdata, probe,
 			   "Network interface: \"%s\"", dev->name);
@@ -2556,9 +2556,10 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 
 	return 0;
 
-out_disable_resources:
+out_init_fail:
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+out_disable_resources:
 	(void)smsc911x_disable_resources(pdev);
 out_enable_resources_fail:
 	smsc911x_free_resources(pdev);
-- 
2.25.1

