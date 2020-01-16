Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31430C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F178720663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201065;
	bh=lT54Jz6IqVbTJB6ip1Ulj506NaKlg1yFZwr6emZ4Zaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BMsNr61WfITGiYVROuZVbh0z6gh5W4uNoHNMYuYdmx9gsnB/QZk9C1s25RmXbTFki
	 9DqRZ95aeFXpSYqFmKF6aDRPX+CNROQlo+dqWNAKl0JwszGHP1QEiZlZzm4ktP2bxJ
	 eqaWauow3rWpWbWefHLBVOoK6sRIA6ErjIWBMQ1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbgAPRG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:06:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388981AbgAPRGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D7C52081E;
        Thu, 16 Jan 2020 17:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194406;
        bh=lT54Jz6IqVbTJB6ip1Ulj506NaKlg1yFZwr6emZ4Zaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IfOYVdBmcQJMFTKp4If34hwhBPLk8zlJq4Put5iMb8rPtKteBNs3s+IsoRVM+/l26
         bzha4ob3UiMdqYRrueWeybvAxC1VYiFMQJTdJfDbXyMGD3NyBnrTlBlrfiTorpPhQf
         lLy+NNay2lbAs19BKPkMQ1+KwlX32MrrB3Dazrkc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sameeh Jubran <sameehj@amazon.com>,
        Saeed Bshara <saeedb@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 330/671] net: ena: fix swapped parameters when calling ena_com_indirect_table_fill_entry
Date:   Thu, 16 Jan 2020 11:59:28 -0500
Message-Id: <20200116170509.12787-67-sashal@kernel.org>
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

From: Sameeh Jubran <sameehj@amazon.com>

[ Upstream commit 3c6eeff295f01bdf1c6c3addcb0a04c0c6c029e9 ]

second parameter should be the index of the table rather than the value.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Saeed Bshara <saeedb@amazon.com>
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index 521607bc4393..eb9e07fa427e 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -695,8 +695,8 @@ static int ena_set_rxfh(struct net_device *netdev, const u32 *indir,
 	if (indir) {
 		for (i = 0; i < ENA_RX_RSS_TABLE_SIZE; i++) {
 			rc = ena_com_indirect_table_fill_entry(ena_dev,
-							       ENA_IO_RXQ_IDX(indir[i]),
-							       i);
+							       i,
+							       ENA_IO_RXQ_IDX(indir[i]));
 			if (unlikely(rc)) {
 				netif_err(adapter, drv, netdev,
 					  "Cannot fill indirect table (index is too large)\n");
-- 
2.20.1

