Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C346DC35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9089D21D56
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424673;
	bh=S4vrg1/zaqFXyVY5Ql5HZjhFTzrByVeZUSGQmM+NizU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XgfJJlIsI2m5zYw26PF68Eccnwx0lwIyt8wMQ+NKI//rn7wKdBYhibJQldlSGyJl4
	 WV/4cDWp3PRySzbPQ4fk0m9m9hi7XtXggncqcMpIqJ8kkXNHV8ZHXIpZPzLEncSGUg
	 iOuUgWALOASbKtvt25YWgVVEIPx8twVlUwl8rVQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgBWCYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:24:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbgBWCY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:24:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65F072465D;
        Sun, 23 Feb 2020 02:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424668;
        bh=S4vrg1/zaqFXyVY5Ql5HZjhFTzrByVeZUSGQmM+NizU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wrm7Bvt/ndqhN/FedSGPccy49FAw4VS6g8oUyCK/bhKvHPtz/95y2tqUYcnYzTU98
         B8wKhJiubOq3XWcQUSfibSh346L10jjFfOk6iADb/kD3NN6azgT84nIQgS1wci3rWE
         u1uLeRrbEqMeHAHZIaErWkvcqCJcXuUMAt+dNNrs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sameeh Jubran <sameehj@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 13/21] net: ena: rss: fix failure to get indirection table
Date:   Sat, 22 Feb 2020 21:24:03 -0500
Message-Id: <20200223022411.2159-13-sashal@kernel.org>
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

From: Sameeh Jubran <sameehj@amazon.com>

[ Upstream commit 0c8923c0a64fb5d14bebb9a9065d2dc25ac5e600 ]

On old hardware, getting / setting the hash function is not supported while
gettting / setting the indirection table is.

This commit enables us to still show the indirection table on older
hardwares by setting the hash function and key to NULL.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index c58ad61909519..7ca7bade1c090 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -660,7 +660,21 @@ static int ena_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
 	if (rc)
 		return rc;
 
+	/* We call this function in order to check if the device
+	 * supports getting/setting the hash function.
+	 */
 	rc = ena_com_get_hash_function(adapter->ena_dev, &ena_func, key);
+
+	if (rc) {
+		if (rc == -EOPNOTSUPP) {
+			key = NULL;
+			hfunc = NULL;
+			rc = 0;
+		}
+
+		return rc;
+	}
+
 	if (rc)
 		return rc;
 
-- 
2.20.1

