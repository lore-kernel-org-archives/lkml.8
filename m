Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452B5C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129F020659
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425393;
	bh=t3RTH/1EKJs2kaKk4nsQZy3sCwlomYb2ILJy2SmbQ94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zjCQPEhqN1aZ5qE+iNPlhrn83W+H3JC0x7NEfBycMrzfmZune8P8Uw3pW458fmoN1
	 8E/mtsvezytzM12GpMCCt0UIxoFU3R7M0enADCx7CcMvcd/05LVHaYlaxA2Cldc/mJ
	 N/WpzedCqiYEHnO1ocPo0Zzf4uMlW95dbZ2VMyQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgBWCgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:36:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgBWCWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:22:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA2220707;
        Sun, 23 Feb 2020 02:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424522;
        bh=t3RTH/1EKJs2kaKk4nsQZy3sCwlomYb2ILJy2SmbQ94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vjd4M+BpePBdt20ntiZbuCZB2R22kYdgjIGP481hU2XPQYi/mgQK3k2DHRz8IPRF6
         xblGs6geIIiaY+bjWPGOgfxaHCaCT3kwg/Oz0vCRmWRIY7SQksCzxC9Ecc/n18Kokx
         XCsP0PipeYVZFaKhO0Gvcp+vfZ7ngIswR9owIc6E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sameeh Jubran <sameehj@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 35/58] net: ena: rss: fix failure to get indirection table
Date:   Sat, 22 Feb 2020 21:20:56 -0500
Message-Id: <20200223022119.707-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022119.707-1-sashal@kernel.org>
References: <20200223022119.707-1-sashal@kernel.org>
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
index 8b56383b64aea..8be9df885bf4f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -648,7 +648,21 @@ static int ena_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
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

