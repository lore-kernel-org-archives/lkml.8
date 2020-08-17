Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C25C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6FE204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690736;
	bh=11TQG3Ov6Oau5HVpZcE9BPBg2ylugEwIixlNmsWPxMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m+iGMeTqWbgdRe+t/7fYhknv/8RlMxPzxywJVtcRADCE8rTaOJIDQQAiVZvADMrnf
	 aElZyieWIPlqLObdnJLm9mbxTUGurSLorUV+Cuu5gzOn6Rh4a/ip+FUtu6fGo864nK
	 VH5f29wzOgfaXCqpbFKS2OIOOA4Nih3UH9X5YXVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391800AbgHQS64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387681AbgHQPtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:49:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB81020855;
        Mon, 17 Aug 2020 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679357;
        bh=11TQG3Ov6Oau5HVpZcE9BPBg2ylugEwIixlNmsWPxMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AlquORPRpdmunFGh3iyKYV6mwwh41dh7L75k7HqU5jfxyGw8C/Vt+w/rpJXVAjFKm
         XEOFSHHtQGJ+X6kN/Ax7sTQf6CNtsnFvfG6X9nLfGYtzCPkxNhxvwaL6Pgc0N8KM32
         iU3gdZQXFMvM4Jx89YA++0hZ/TeEd79JYTAJCU0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 156/393] dpaa2-eth: fix condition for number of buffer acquire retries
Date:   Mon, 17 Aug 2020 17:13:26 +0200
Message-Id: <20200817143827.183301761@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit 0e5ad75b02d9341eb9ca22627247f9a02cc20d6f ]

We should keep retrying to acquire buffers through the software portals
as long as the function returns -EBUSY and the number of retries is
__below__ DPAA2_ETH_SWP_BUSY_RETRIES.

Fixes: ef17bd7cc0c8 ("dpaa2-eth: Avoid unbounded while loops")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index b7031f8562e04..665ec7269c603 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1054,7 +1054,7 @@ static void drain_bufs(struct dpaa2_eth_priv *priv, int count)
 					       buf_array, count);
 		if (ret < 0) {
 			if (ret == -EBUSY &&
-			    retries++ >= DPAA2_ETH_SWP_BUSY_RETRIES)
+			    retries++ < DPAA2_ETH_SWP_BUSY_RETRIES)
 				continue;
 			netdev_err(priv->net_dev, "dpaa2_io_service_acquire() failed\n");
 			return;
-- 
2.25.1



