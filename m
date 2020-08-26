Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C96C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168F720838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598443667;
	bh=RhiLupqRQVXojRdaOn/M2DAmZX/fy/Bizh/vLiZGe4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rXYICmAJK1q8xIT7Cd+y6+IfXZhjrJPKl1Lp/C281DJRqWhYI4egfMXn/gfWjcXgu
	 TgP7PHgbs1s2anujJxMw/KZ9xxSn/RkTOa3LHu9vfZQkYcxMvMpFXkjrZWnvvLEt0F
	 aaCDtDDRuAUmGpfLyD0U+qOMoLQX2aQMVwkw/DEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgHZMHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbgHZMCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:02:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF682087C;
        Wed, 26 Aug 2020 12:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598443357;
        bh=RhiLupqRQVXojRdaOn/M2DAmZX/fy/Bizh/vLiZGe4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dzcq7B6WabdzpAOqsUcs6YA5jVEy+50jE1gZ77AdTdxIW84SRkb5szrXV86V/wLLI
         ghwsreY+mh6xwr1CGdx9Cij4ZpFuGpqYtNmDQTXiEuhG/nl3f4HA0H+wWixKSnAG+Q
         NOxZG0f9y/UTuZ88M1oedS394wQYccz9X0iJFlzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shay Agroskin <shayagr@amazon.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 10/15] net: ena: Make missed_tx stat incremental
Date:   Wed, 26 Aug 2020 14:02:38 +0200
Message-Id: <20200826114849.800823726@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826114849.295321031@linuxfoundation.org>
References: <20200826114849.295321031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shay Agroskin <shayagr@amazon.com>

[ Upstream commit ccd143e5150f24b9ba15145c7221b61dd9e41021 ]

Most statistics in ena driver are incremented, meaning that a stat's
value is a sum of all increases done to it since driver/queue
initialization.

This patch makes all statistics this way, effectively making missed_tx
statistic incremental.
Also added a comment regarding rx_drops and tx_drops to make it
clearer how these counters are calculated.

Fixes: 11095fdb712b ("net: ena: add statistics for missed tx packets")
Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3594,7 +3594,7 @@ static int check_missing_comp_in_tx_queu
 	}
 
 	u64_stats_update_begin(&tx_ring->syncp);
-	tx_ring->tx_stats.missed_tx = missed_tx;
+	tx_ring->tx_stats.missed_tx += missed_tx;
 	u64_stats_update_end(&tx_ring->syncp);
 
 	return rc;
@@ -4519,6 +4519,9 @@ static void ena_keep_alive_wd(void *adap
 	rx_drops = ((u64)desc->rx_drops_high << 32) | desc->rx_drops_low;
 
 	u64_stats_update_begin(&adapter->syncp);
+	/* These stats are accumulated by the device, so the counters indicate
+	 * all drops since last reset.
+	 */
 	adapter->dev_stats.rx_drops = rx_drops;
 	u64_stats_update_end(&adapter->syncp);
 }


