Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ACCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC312072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159124;
	bh=TG+9HF2alshZxc1Ns252ZMmuUWyXitjY2aWNEIsHztk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mMPTs3qR/MBWdlguh4YtxP/jBzkLk3lyz2XSdBwbfmvviUZkvNjwMlkeE7tQOVJZ1
	 YqZTuoAx3DO945WuiFrQfpmZP3R8HFRfH+7mOc3fhF/fqceaDDSGOPyVQcHEdJNoau
	 HtnsFZ/6Fpq4dGmEWBRfEYpay9XAHOSQU5UfXcFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgEVOwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731106AbgEVOvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:51:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D61C420756;
        Fri, 22 May 2020 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159108;
        bh=TG+9HF2alshZxc1Ns252ZMmuUWyXitjY2aWNEIsHztk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBSzucjXk27k1m3R4A0O/mTVkpVCANEnbUY16a9hDAAZg3vpww9pQxEypbftFSwv4
         EXQwqULkQuuZnWqf6PwV5LlbRCiQ/1MpXAWTY8/s7WHddIRARNbRX0hePeNMjvx7Gu
         SrCUTSVulrOKsAaJPihYQ3fRb2AUwY/5eN/uYmo8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 05/13] net: microchip: encx24j600: add missed kthread_stop
Date:   Fri, 22 May 2020 10:51:34 -0400
Message-Id: <20200522145142.435086-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145142.435086-1-sashal@kernel.org>
References: <20200522145142.435086-1-sashal@kernel.org>
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

