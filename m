Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0CBC35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A0624650
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424669;
	bh=mG6NqNXNbj04E/zezRXFj4wxhEeaoA8AmqYdR2+zFMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fPXyehLMN1hsHV70CWvWRqTl3AbODsWBzd3tbBHqryyRo8Zi56GbqKmkLYUjNMKtd
	 ci/DEkSA8NSgtH9jWBs0kCK+erP9RzFhPPOlqMAw8nnZ8hvH2lFloEi3I+o4/cSBz9
	 k3y1KxeyOgyjL4G1nmcTnqTsgJLcPVD5cjHvogpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgBWCY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:24:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbgBWCY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:24:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC2520707;
        Sun, 23 Feb 2020 02:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424665;
        bh=mG6NqNXNbj04E/zezRXFj4wxhEeaoA8AmqYdR2+zFMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xkTxpx6Fjbr4oCbz+LA6E+OopSPalEQbVf4kPvXpIljvVANpF9cf5CMIt9jxeZ+Sd
         gnW6/T63UVe7QHiLvqn3A5Bs0vxVEauCxXAX+YpDQTGNVXwttPH9+sg7YbisV+2ysZ
         6LzBxQh4tvH9Z7FvRoc8Fnoz7qt+mAgV+GpOF/j0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arthur Kiyanovski <akiyano@amazon.com>,
        Ezequiel Lara Gomez <ezegomez@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 11/21] net: ena: add missing ethtool TX timestamping indication
Date:   Sat, 22 Feb 2020 21:24:01 -0500
Message-Id: <20200223022411.2159-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022411.2159-1-sashal@kernel.org>
References: <20200223022411.2159-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit cf6d17fde93bdda23c9b02dd5906a12bf8c55209 ]

Current implementation of the driver calls skb_tx_timestamp()to add a
software tx timestamp to the skb, however the software-transmit capability
is not reported in ethtool -T.

This commit updates the ethtool structure to report the software-transmit
capability in ethtool -T using the standard ethtool_op_get_ts_info().
This function reports all software timestamping capabilities (tx and rx),
as well as setting phc_index = -1. phc_index is the index of the PTP
hardware clock device that will be used for hardware timestamps. Since we
don't have such a device in ENA, using the default -1 value is the correct
setting.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Ezequiel Lara Gomez <ezegomez@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index a2f02c23fe141..c58ad61909519 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -816,6 +816,7 @@ static const struct ethtool_ops ena_ethtool_ops = {
 	.get_channels		= ena_get_channels,
 	.get_tunable		= ena_get_tunable,
 	.set_tunable		= ena_set_tunable,
+	.get_ts_info            = ethtool_op_get_ts_info,
 };
 
 void ena_set_ethtool_ops(struct net_device *netdev)
-- 
2.20.1

