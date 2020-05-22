Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33295C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC99205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159402;
	bh=LYsmdb3OWWZD4PMnWEwIB2JWOQxhVKRsoVTtMfqM48k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MZX3zXGn7ok4cEF54kzlmlurBNXZYPdqUtO1DES09XZVe4wSx7F61gWHzwBoU9Lsq
	 TAZsLiJ1xUyW2J/3GCDjzssSXiKrMKA0m9kjI5WyWP6Z0jMyHD9x6VxqXyQX08K0S8
	 OhQ66TDxWcdXBTkn+J8V4yT7pviV1UnlMQAFEEIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbgEVO4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:56:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730853AbgEVOu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:50:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32820221FF;
        Fri, 22 May 2020 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159055;
        bh=LYsmdb3OWWZD4PMnWEwIB2JWOQxhVKRsoVTtMfqM48k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3Nybx98xPustP/NRaefId/vavZ5PGgDwOSVVYGxboANMXnwitjYzZk7v9byK/EM2
         VCC5N0ym7YEqtE0JmBPiXR3Mi/ptb9fuGYY3oAnRxePlnj0khGzPGfOweg+/el/OwT
         ypGbq/uju2ReSuKeCJfsPKoUYai4p/OK8CGVZdAY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 09/32] net: microchip: encx24j600: add missed kthread_stop
Date:   Fri, 22 May 2020 10:50:21 -0400
Message-Id: <20200522145044.434677-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145044.434677-1-sashal@kernel.org>
References: <20200522145044.434677-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit ff8ce319e9c25e920d994cc35236f0bb32dfc8f3 ]

This driver calls kthread_run() in probe, but forgets to call
kthread_stop() in probe failure and remove.
Add the missed kthread_stop() to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/encx24j600.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/encx24j600.c b/drivers/net/ethernet/microchip/encx24j600.c
index 52c41d11f565..c3a6edc0ddf6 100644
--- a/drivers/net/ethernet/microchip/encx24j600.c
+++ b/drivers/net/ethernet/microchip/encx24j600.c
@@ -1070,7 +1070,7 @@ static int encx24j600_spi_probe(struct spi_device *spi)
 	if (unlikely(ret)) {
 		netif_err(priv, probe, ndev, "Error %d initializing card encx24j600 card\n",
 			  ret);
-		goto out_free;
+		goto out_stop;
 	}
 
 	eidled = encx24j600_read_reg(priv, EIDLED);
@@ -1088,6 +1088,8 @@ static int encx24j600_spi_probe(struct spi_device *spi)
 
 out_unregister:
 	unregister_netdev(priv->ndev);
+out_stop:
+	kthread_stop(priv->kworker_task);
 out_free:
 	free_netdev(ndev);
 
@@ -1100,6 +1102,7 @@ static int encx24j600_spi_remove(struct spi_device *spi)
 	struct encx24j600_priv *priv = dev_get_drvdata(&spi->dev);
 
 	unregister_netdev(priv->ndev);
+	kthread_stop(priv->kworker_task);
 
 	free_netdev(priv->ndev);
 
-- 
2.25.1

