Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39000C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DA62085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099212;
	bh=oQzH92Nu3rnEIWIs/DPXqzVb2aXpghGfFLFQYUmobTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fVR9l5XKMxJHFrlp+s723BEpNjvFzgUbEzhsVBw7QLRA0IZaSrhz8aQD83rXQ317a
	 GxHdyRVvyc62d+puhPsP8a+eyS+fEhKTgx4TgA9dL+j4AQtJH7NtyU6xpThcMMdxpC
	 ksS1WagsECoXsAiOWomdrkWzZqjUYKT19Sgd16fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbgD1SkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbgD1SkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:40:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77A1920575;
        Tue, 28 Apr 2020 18:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099204;
        bh=oQzH92Nu3rnEIWIs/DPXqzVb2aXpghGfFLFQYUmobTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lw6Kx6JgFMgrP9HCIciZu89Sz4ZrL95//fU7jmy+dgzCotq4cioiWjY6v6Sdkb6Tl
         TuNsmZioYpr091gfMzXBJZ/xmtQ4cs8JbuzITNtXFF2Iey1DQln/3GvLQsHNcH6v5X
         nyE34t08tEZYnp7ignXWsOz4XQy4I94NBNVQZ6Pc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 063/168] net: bcmgenet: correct per TX/RX ring statistics
Date:   Tue, 28 Apr 2020 20:23:57 +0200
Message-Id: <20200428182239.895987908@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit a6d0b83f25073bdf08b8547aeff961a62c6ab229 ]

The change to track net_device_stats per ring to better support SMP
missed updating the rx_dropped member.

The ndo_get_stats method is also needed to combine the results for
ethtool statistics (-S) before filling in the ethtool structure.

Fixes: 37a30b435b92 ("net: bcmgenet: Track per TX/RX rings statistics")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -995,6 +995,8 @@ static void bcmgenet_get_ethtool_stats(s
 	if (netif_running(dev))
 		bcmgenet_update_mib_counters(priv);
 
+	dev->netdev_ops->ndo_get_stats(dev);
+
 	for (i = 0; i < BCMGENET_STATS_LEN; i++) {
 		const struct bcmgenet_stats *s;
 		char *p;
@@ -3204,6 +3206,7 @@ static struct net_device_stats *bcmgenet
 	dev->stats.rx_packets = rx_packets;
 	dev->stats.rx_errors = rx_errors;
 	dev->stats.rx_missed_errors = rx_errors;
+	dev->stats.rx_dropped = rx_dropped;
 	return &dev->stats;
 }
 


