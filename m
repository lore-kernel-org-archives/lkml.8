Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D09AC35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4644520659
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425096;
	bh=KDYByohL7ndprh8WUuHDrdvmdYbSJj3I7Ol3IM04Fjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MQD1iBhGYrsVMG3QnNLjYRS1HGXVziE7WfX0rECGZAZIwcgbpg7v0LAO5ohySNXTU
	 J8Y7/+nnUr/62yfb9TYOr1QbrexRBL2asuw9xoKZg9sM776dYRojiNj9HDEqWxCsLt
	 qD/OfMdbMl4HeySoquNhQBA3RQVulDr9FwLaSARQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgBWCbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:31:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgBWCXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:23:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F0A420702;
        Sun, 23 Feb 2020 02:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424601;
        bh=KDYByohL7ndprh8WUuHDrdvmdYbSJj3I7Ol3IM04Fjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BsjZYw+MN2Xi2zEallaXUwq6emsshBQdlhzvIQCjoq3OXgnRfrT3lCM0qBzx+EjVB
         iwUIJYJebSyoadFZ+TBm+v3FoCgDgJ0suJLMrKb4jCCzwPq7k7uIj0E/FO2uMOIPxK
         t3SH88nXW0R5xriO/D0lfPqekt3/ucjiPn8K2XNs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sameeh Jubran <sameehj@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 38/50] net: ena: ethtool: use correct value for crc32 hash
Date:   Sat, 22 Feb 2020 21:22:23 -0500
Message-Id: <20200223022235.1404-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022235.1404-1-sashal@kernel.org>
References: <20200223022235.1404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sameeh Jubran <sameehj@amazon.com>

[ Upstream commit 886d2089276e40d460731765083a741c5c762461 ]

Up till kernel 4.11 there was no enum defined for crc32 hash in ethtool,
thus the xor enum was used for supporting crc32.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index 446873bed382b..b0151139abb18 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -693,7 +693,7 @@ static int ena_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
 		func = ETH_RSS_HASH_TOP;
 		break;
 	case ENA_ADMIN_CRC32:
-		func = ETH_RSS_HASH_XOR;
+		func = ETH_RSS_HASH_CRC32;
 		break;
 	default:
 		netif_err(adapter, drv, netdev,
@@ -739,7 +739,7 @@ static int ena_set_rxfh(struct net_device *netdev, const u32 *indir,
 	case ETH_RSS_HASH_TOP:
 		func = ENA_ADMIN_TOEPLITZ;
 		break;
-	case ETH_RSS_HASH_XOR:
+	case ETH_RSS_HASH_CRC32:
 		func = ENA_ADMIN_CRC32;
 		break;
 	default:
-- 
2.20.1

