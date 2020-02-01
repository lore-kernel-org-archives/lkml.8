Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01359C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 07:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D684F206D3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 07:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgBAHqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 02:46:47 -0500
Received: from foss.arm.com ([217.140.110.172]:41182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbgBAHqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 02:46:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3F4AFEC;
        Fri, 31 Jan 2020 23:46:38 -0800 (PST)
Received: from u200856.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DC6D3F52E;
        Fri, 31 Jan 2020 23:50:17 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     netdev@vger.kernel.org
Cc:     opendmb@gmail.com, f.fainelli@gmail.com, davem@davemloft.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, wahrenst@gmx.net, andrew@lunn.ch,
        hkallweit1@gmail.com, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 6/6] net: bcmgenet: reduce severity of missing clock warnings
Date:   Sat,  1 Feb 2020 01:46:25 -0600
Message-Id: <20200201074625.8698-7-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201074625.8698-1-jeremy.linton@arm.com>
References: <20200201074625.8698-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one types "failed to get enet clock" or similar into google
there are ~370k hits. The vast majority are people debugging
problems unrelated to this adapter, or bragging about their
rpi's. Given that its not a fatal situation with common DT based
systems, lets reduce the severity so people aren't seeing failure
messages in everyday operation.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index dbf96fc96689..115977e2edef 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3572,7 +3572,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 
 	priv->clk = devm_clk_get(&priv->pdev->dev, "enet");
 	if (IS_ERR(priv->clk)) {
-		dev_warn(&priv->pdev->dev, "failed to get enet clock\n");
+		dev_dbg(&priv->pdev->dev, "failed to get enet clock\n");
 		priv->clk = NULL;
 	}
 
@@ -3588,13 +3588,13 @@ static int bcmgenet_probe(struct platform_device *pdev)
 
 	priv->clk_wol = devm_clk_get(&priv->pdev->dev, "enet-wol");
 	if (IS_ERR(priv->clk_wol)) {
-		dev_warn(&priv->pdev->dev, "failed to get enet-wol clock\n");
+		dev_dbg(&priv->pdev->dev, "failed to get enet-wol clock\n");
 		priv->clk_wol = NULL;
 	}
 
 	priv->clk_eee = devm_clk_get(&priv->pdev->dev, "enet-eee");
 	if (IS_ERR(priv->clk_eee)) {
-		dev_warn(&priv->pdev->dev, "failed to get enet-eee clock\n");
+		dev_dbg(&priv->pdev->dev, "failed to get enet-eee clock\n");
 		priv->clk_eee = NULL;
 	}
 
-- 
2.24.1

