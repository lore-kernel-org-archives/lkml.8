Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D08C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CDC2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658710;
	bh=0zVJ/Ihx2f+pOTg2iHIGJB0ULCfxHT62X11wq5VVDKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jr4HZ0KaofPX86Hzq7NyVYX9wk0fXONDFCCWpSs/SxILgyojnigoFQ/GD4RyxtveB
	 vqBmORbAyk8sBSNjCmk6aVAagJcQg/WiA7uGyEtM1gtW3gqsNJp2xrGtxWsL0GRqmW
	 mb0U+7EeNr1Giv2b88JJCSs81GxQ0l7Slm3is4pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbgFHXZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728524AbgFHXUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:20:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426CD2083E;
        Mon,  8 Jun 2020 23:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658403;
        bh=0zVJ/Ihx2f+pOTg2iHIGJB0ULCfxHT62X11wq5VVDKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/CrQ68ziPGUem7vaad+A24pSBe7zw3sTeB/Qy9nvmqhZbxJzNoO5B6jCYdFXLawu
         qvJ+WK8ORWTd+moWyVJ0noweDaYGbH9VpK8PN6P35xlB1pXApNpBuWrhL2pI8cpkgP
         DgMBSVS7x2UIGTkYzmY1mCPzL6QXHUyGGA+0DYJM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 058/175] net: vmxnet3: fix possible buffer overflow caused by bad DMA value in vmxnet3_get_rss()
Date:   Mon,  8 Jun 2020 19:16:51 -0400
Message-Id: <20200608231848.3366970-58-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 3e1c6846b9e108740ef8a37be80314053f5dd52a ]

The value adapter->rss_conf is stored in DMA memory, and it is assigned
to rssConf, so rssConf->indTableSize can be modified at anytime by
malicious hardware. Because rssConf->indTableSize is assigned to n,
buffer overflow may occur when the code "rssConf->indTable[n]" is
executed.

To fix this possible bug, n is checked after being used.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vmxnet3/vmxnet3_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
index 0a38c76688ab..5e2571d23ab9 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -702,6 +702,8 @@ vmxnet3_get_rss(struct net_device *netdev, u32 *p, u8 *key, u8 *hfunc)
 		*hfunc = ETH_RSS_HASH_TOP;
 	if (!p)
 		return 0;
+	if (n > UPT1_RSS_MAX_IND_TABLE_SIZE)
+		return 0;
 	while (n--)
 		p[n] = rssConf->indTable[n];
 	return 0;
-- 
2.25.1

