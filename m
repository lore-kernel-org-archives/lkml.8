Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9B7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DFB2077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034610;
	bh=TG+9HF2alshZxc1Ns252ZMmuUWyXitjY2aWNEIsHztk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ae8Tu35pufws4HhbL+TQyIdYTkhrnZDzNBrQ6WmRohRLmEOwWoct2fPVhetfabOri
	 sebORO2SGj241H/W4bv7Bsq7mkElqwop0E3HFX7P1X85pPGD3bL4AJLGPKvh6VQRSa
	 T3tfS4UrmIiCFurSiVk5EgJ/tMZgOO/r6F/82Wuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgFASD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730074AbgFASDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:03:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 692D02077D;
        Mon,  1 Jun 2020 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034601;
        bh=TG+9HF2alshZxc1Ns252ZMmuUWyXitjY2aWNEIsHztk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEUCW80m1t+CJ4h3Rp5jpeAQArxSpnp35yvoFjzLlD0ORC7N/BKzIg5eXlw5IasNY
         i6+wWW8WE3oUBLKtzXrNoH15uX+JbzfiQPiUCFKoW30OfitLBbJVVzKurrIsRXiSCw
         hFNt7pR1jnpU31X326ArVD6m2y2n1YXuTdGjtzvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 26/95] net: microchip: encx24j600: add missed kthread_stop
Date:   Mon,  1 Jun 2020 19:53:26 +0200
Message-Id: <20200601174025.043920185@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index f831238d9793..84b6ad76f5bc 100644
--- a/drivers/net/ethernet/microchip/encx24j600.c
+++ b/drivers/net/ethernet/microchip/encx24j600.c
@@ -1075,7 +1075,7 @@ static int encx24j600_spi_probe(struct spi_device *spi)
 	if (unlikely(ret)) {
 		netif_err(priv, probe, ndev, "Error %d initializing card encx24j600 card\n",
 			  ret);
-		goto out_free;
+		goto out_stop;
 	}
 
 	eidled = encx24j600_read_reg(priv, EIDLED);
@@ -1093,6 +1093,8 @@ static int encx24j600_spi_probe(struct spi_device *spi)
 
 out_unregister:
 	unregister_netdev(priv->ndev);
+out_stop:
+	kthread_stop(priv->kworker_task);
 out_free:
 	free_netdev(ndev);
 
@@ -1105,6 +1107,7 @@ static int encx24j600_spi_remove(struct spi_device *spi)
 	struct encx24j600_priv *priv = dev_get_drvdata(&spi->dev);
 
 	unregister_netdev(priv->ndev);
+	kthread_stop(priv->kworker_task);
 
 	free_netdev(priv->ndev);
 
-- 
2.25.1



