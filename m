Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1A9C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA242075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859697;
	bh=h1XxfQffSdng9jG/pVznLTCz6+7NXwQpLZd95y/eJKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Ke9Y77lmRwOC0Jtmil2UbhRyJjCvDDCikWPlWvzQxeESegGQ7ZM4WEkRrpMJwBFk
	 DYhm8vnqLBOQEqt6mTiZwSmaC03rdnOvBQ5EjAytim1M8VFjAkAyIDGKBKfYV1Ike8
	 5ek6suilMEN5yaQ1psz7JGjRgZsarT3gtSF/0SkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbgG0OVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731728AbgG0OVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:21:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E13B52070A;
        Mon, 27 Jul 2020 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859690;
        bh=h1XxfQffSdng9jG/pVznLTCz6+7NXwQpLZd95y/eJKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xlyW9E9XeVtcupysc2rmkd+8IaqufcTz3QDNvx3+1hTpkSWoyN/GZtoRj8/rHePvG
         uMGv5QcN9tVKqthSvhRRmKhiqEQi5TGf6A65W/tbHAD+OckgFqyt3RjnXQN0/5v/HP
         wcPAdDBF15xZ7b5sIaX5H8f1vfPzFpsmS9hKbP5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Jian <liujian56@huawei.com>,
        Madalin Bucur <madalin.bucur@oss.nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 068/179] dpaa_eth: Fix one possible memleak in dpaa_eth_probe
Date:   Mon, 27 Jul 2020 16:04:03 +0200
Message-Id: <20200727134935.981834348@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Jian <liujian56@huawei.com>

[ Upstream commit 6790711f8ac5faabc43237c0d05d93db431a1ecc ]

When dma_coerce_mask_and_coherent() fails, the alloced netdev need to be freed.

Fixes: 060ad66f9795 ("dpaa_eth: change DMA device")
Signed-off-by: Liu Jian <liujian56@huawei.com>
Acked-by: Madalin Bucur <madalin.bucur@oss.nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 6bfa7575af942..5f82c1f32f09b 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2938,7 +2938,7 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 						   DMA_BIT_MASK(40));
 	if (err) {
 		netdev_err(net_dev, "dma_coerce_mask_and_coherent() failed\n");
-		return err;
+		goto free_netdev;
 	}
 
 	/* If fsl_fm_max_frm is set to a higher value than the all-common 1500,
-- 
2.25.1



