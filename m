Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A160CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F1F20775
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658981;
	bh=oQoHniCdWbuIkY9elck1nIUM6K/E1dlJcbZqRgeQhHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RaGZMIigolSNfVsfAL8j2rJS7CvfZ8BjiCYVqyuwcCB+5xL+IU+Lw/ZfIfEbZVG1O
	 PfsjN4T3xaRx+yq7Df9uOhz5J9Qqyyy96SuQyYutCdKgbZIkcv61GzVjq1WvboDwEm
	 1X0yPY6YMZTva9S3Czbwg9EUJqaoOQ76IHWaICzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbgFHX3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbgFHXXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:23:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CD37208FE;
        Mon,  8 Jun 2020 23:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658627;
        bh=oQoHniCdWbuIkY9elck1nIUM6K/E1dlJcbZqRgeQhHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTuEG3Gf/GK3AB0KFNnHgLMxqIT7j+ckuEyT1fAsza52di3pcCIVNiZPK6xVgdmcZ
         bRwLYQ8EmlKRn3sykckcP29uVuTskMm0TQZ/ryauBX+Vr38TOnPF7Z13fS9V4QlXI2
         PWbcvBo/Ax9FkaYdVPYOtPR29SCyQPnmxfTPMACw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 051/106] net: lpc-enet: fix error return code in lpc_mii_init()
Date:   Mon,  8 Jun 2020 19:21:43 -0400
Message-Id: <20200608232238.3368589-51-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 88ec7cb22ddde725ed4ce15991f0bd9dd817fd85 ]

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: b7370112f519 ("lpc32xx: Added ethernet driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/nxp/lpc_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index 41d30f55c946..6bd6c261f2ba 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -845,7 +845,8 @@ static int lpc_mii_init(struct netdata_local *pldat)
 	if (mdiobus_register(pldat->mii_bus))
 		goto err_out_unregister_bus;
 
-	if (lpc_mii_probe(pldat->ndev) != 0)
+	err = lpc_mii_probe(pldat->ndev);
+	if (err)
 		goto err_out_unregister_bus;
 
 	return 0;
-- 
2.25.1

