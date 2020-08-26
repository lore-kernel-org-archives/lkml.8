Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9294C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E51C20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598443484;
	bh=bagVmKbsKAl//B1ZYj3lLiy78iYpzZFKgKvgMeb7XwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pQv2WXsTxP6mcnqVdtXRw9CccLYrQm/SMgogla24dB4d5tdEUqazaOEXe8rDWVtcE
	 Y+MbQ4QVIltpFiAP76XibMO/qzTQ1tdLW8NL3v3VokMSMCHqqCPAeeTCtKttZbP3SE
	 yL0oyvKMvu/746jvKszE8N8DdrWRLEZbnlAEAkvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgHZMEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbgHZMDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:03:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2D0F20786;
        Wed, 26 Aug 2020 12:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598443400;
        bh=bagVmKbsKAl//B1ZYj3lLiy78iYpzZFKgKvgMeb7XwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EaCZ4WZ1EdByYAYPwivPaC1wvdlzTxVXQ3bCaTJiALDaiFkYYVSWo4NuFL1A3c7b9
         UYj8MA8HUoe3kFTZOO+N+0Qz0w+Sk13ZmJ4H3lDg25WmVlPJ+Wc3Ac8AqcVBl63ayH
         ge9i1EXWHvKRaU+gJkMPO53O014Nkmja139f94KY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shay Agroskin <shayagr@amazon.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.8 10/16] net: ena: Make missed_tx stat incremental
Date:   Wed, 26 Aug 2020 14:02:47 +0200
Message-Id: <20200826114911.730686894@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826114911.216745274@linuxfoundation.org>
References: <20200826114911.216745274@linuxfoundation.org>
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
@@ -3609,7 +3609,7 @@ static int check_missing_comp_in_tx_queu
 	}
 
 	u64_stats_update_begin(&tx_ring->syncp);
-	tx_ring->tx_stats.missed_tx = missed_tx;
+	tx_ring->tx_stats.missed_tx += missed_tx;
 	u64_stats_update_end(&tx_ring->syncp);
 
 	return rc;
@@ -4537,6 +4537,9 @@ static void ena_keep_alive_wd(void *adap
 	tx_drops = ((u64)desc->tx_drops_high << 32) | desc->tx_drops_low;
 
 	u64_stats_update_begin(&adapter->syncp);
+	/* These stats are accumulated by the device, so the counters indicate
+	 * all drops since last reset.
+	 */
 	adapter->dev_stats.rx_drops = rx_drops;
 	adapter->dev_stats.tx_drops = tx_drops;
 	u64_stats_update_end(&adapter->syncp);


