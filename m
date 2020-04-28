Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E96C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794D820B80
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098806;
	bh=VCzq+jLQXYilQpSP9NHKJeyHC1337mr9NgytlMARjMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xcvtuu7CWzzYQiFcyPycD0GKfWMks/cWTFoamQvDYorMIf38a+ZaeaDE94P4OpW0p
	 Z9jhLrfHO99J2DD4x5/J+wrvPW1uLwkwEOFME/RQQ9kbsjX5vyH5SObN5fm2tuqAzx
	 OLYl63dIW6+OB74AbVAhSHIWl2D9VtJOHyeXUqvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgD1SdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729930AbgD1SdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:33:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A9720B80;
        Tue, 28 Apr 2020 18:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098800;
        bh=VCzq+jLQXYilQpSP9NHKJeyHC1337mr9NgytlMARjMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ry3TXMhnFZyZgXe0eLimR5oQDGNNiNesNmSUULPKlEKvQ+arbP7kPj35iW/MBVTRC
         we/Xozobm+rRpDAwC3FLaQiSSqAHV2z7VMb/FwXvyU5G/kMzxoQth4eoxw984oLh8b
         M5gpAiEIIALn9znYF9ghZYbeX8k9bqnxitJS/XMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 058/131] net: bcmgenet: correct per TX/RX ring statistics
Date:   Tue, 28 Apr 2020 20:24:30 +0200
Message-Id: <20200428182232.275798781@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
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
@@ -998,6 +998,8 @@ static void bcmgenet_get_ethtool_stats(s
 	if (netif_running(dev))
 		bcmgenet_update_mib_counters(priv);
 
+	dev->netdev_ops->ndo_get_stats(dev);
+
 	for (i = 0; i < BCMGENET_STATS_LEN; i++) {
 		const struct bcmgenet_stats *s;
 		char *p;
@@ -3211,6 +3213,7 @@ static struct net_device_stats *bcmgenet
 	dev->stats.rx_packets = rx_packets;
 	dev->stats.rx_errors = rx_errors;
 	dev->stats.rx_missed_errors = rx_errors;
+	dev->stats.rx_dropped = rx_dropped;
 	return &dev->stats;
 }
 


