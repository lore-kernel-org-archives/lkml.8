Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F7FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA44320B80
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581665;
	bh=jLox+8Gi6bC9/N3l0vacC+fK6yX3qEtgPqcMiIXdWZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SwkjyrN+2wp3n1oP0jNN6suKaGu3Zj4/VpTtWZt7J1RNJ3Jn04jLrox73Z5vRwo77
	 zdCB9XR+VLXizOj54d0zwanLhNuWzR21/dxDm3tssneR6v7Zy9fJIx/V1jSgBvtr0O
	 nGHKHl8hNfs1lue5MG1OEyaD4W7sPya9gnudl/6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404188AbgFSPZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393151AbgFSPXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:23:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA05721548;
        Fri, 19 Jun 2020 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580193;
        bh=jLox+8Gi6bC9/N3l0vacC+fK6yX3qEtgPqcMiIXdWZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6CuFU5v15VcNJhc0V8PZ6RutrMtC4hXdLBVAp2hFvmJm6VJcqqqhJ6gy6LWkZOVq
         yUPkK/9+R+rV4Wrqph9g5VLwR+jWopWBcXATtxCY+P4nV8nVJhV/jJni8NOs9B6jK7
         0B3Rdbkyoi3NYoEzdzjSXPtMy+3SiFqN13ZRZmhI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 158/376] dsa: sja1105: dynamically allocate stats structure
Date:   Fri, 19 Jun 2020 16:31:16 +0200
Message-Id: <20200619141717.801475448@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit ae1804de93f6f1626906567ae7deec8e0111259d ]

The addition of sja1105_port_status_ether structure into the
statistics causes the frame size to go over the warning limit:

drivers/net/dsa/sja1105/sja1105_ethtool.c:421:6: error: stack frame size of 1104 bytes in function 'sja1105_get_ethtool_stats' [-Werror,-Wframe-larger-than=]

Use dynamic allocation to avoid this.

Fixes: 336aa67bd027 ("net: dsa: sja1105: show more ethtool statistics counters for P/Q/R/S")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/sja1105/sja1105_ethtool.c | 144 +++++++++++-----------
 1 file changed, 74 insertions(+), 70 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_ethtool.c b/drivers/net/dsa/sja1105/sja1105_ethtool.c
index d742ffcbfce9..709f035055c5 100644
--- a/drivers/net/dsa/sja1105/sja1105_ethtool.c
+++ b/drivers/net/dsa/sja1105/sja1105_ethtool.c
@@ -421,92 +421,96 @@ static char sja1105pqrs_extra_port_stats[][ETH_GSTRING_LEN] = {
 void sja1105_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data)
 {
 	struct sja1105_private *priv = ds->priv;
-	struct sja1105_port_status status;
+	struct sja1105_port_status *status;
 	int rc, i, k = 0;
 
-	memset(&status, 0, sizeof(status));
+	status = kzalloc(sizeof(*status), GFP_KERNEL);
+	if (!status)
+		goto out;
 
-	rc = sja1105_port_status_get(priv, &status, port);
+	rc = sja1105_port_status_get(priv, status, port);
 	if (rc < 0) {
 		dev_err(ds->dev, "Failed to read port %d counters: %d\n",
 			port, rc);
-		return;
+		goto out;
 	}
 	memset(data, 0, ARRAY_SIZE(sja1105_port_stats) * sizeof(u64));
-	data[k++] = status.mac.n_runt;
-	data[k++] = status.mac.n_soferr;
-	data[k++] = status.mac.n_alignerr;
-	data[k++] = status.mac.n_miierr;
-	data[k++] = status.mac.typeerr;
-	data[k++] = status.mac.sizeerr;
-	data[k++] = status.mac.tctimeout;
-	data[k++] = status.mac.priorerr;
-	data[k++] = status.mac.nomaster;
-	data[k++] = status.mac.memov;
-	data[k++] = status.mac.memerr;
-	data[k++] = status.mac.invtyp;
-	data[k++] = status.mac.intcyov;
-	data[k++] = status.mac.domerr;
-	data[k++] = status.mac.pcfbagdrop;
-	data[k++] = status.mac.spcprior;
-	data[k++] = status.mac.ageprior;
-	data[k++] = status.mac.portdrop;
-	data[k++] = status.mac.lendrop;
-	data[k++] = status.mac.bagdrop;
-	data[k++] = status.mac.policeerr;
-	data[k++] = status.mac.drpnona664err;
-	data[k++] = status.mac.spcerr;
-	data[k++] = status.mac.agedrp;
-	data[k++] = status.hl1.n_n664err;
-	data[k++] = status.hl1.n_vlanerr;
-	data[k++] = status.hl1.n_unreleased;
-	data[k++] = status.hl1.n_sizeerr;
-	data[k++] = status.hl1.n_crcerr;
-	data[k++] = status.hl1.n_vlnotfound;
-	data[k++] = status.hl1.n_ctpolerr;
-	data[k++] = status.hl1.n_polerr;
-	data[k++] = status.hl1.n_rxfrm;
-	data[k++] = status.hl1.n_rxbyte;
-	data[k++] = status.hl1.n_txfrm;
-	data[k++] = status.hl1.n_txbyte;
-	data[k++] = status.hl2.n_qfull;
-	data[k++] = status.hl2.n_part_drop;
-	data[k++] = status.hl2.n_egr_disabled;
-	data[k++] = status.hl2.n_not_reach;
+	data[k++] = status->mac.n_runt;
+	data[k++] = status->mac.n_soferr;
+	data[k++] = status->mac.n_alignerr;
+	data[k++] = status->mac.n_miierr;
+	data[k++] = status->mac.typeerr;
+	data[k++] = status->mac.sizeerr;
+	data[k++] = status->mac.tctimeout;
+	data[k++] = status->mac.priorerr;
+	data[k++] = status->mac.nomaster;
+	data[k++] = status->mac.memov;
+	data[k++] = status->mac.memerr;
+	data[k++] = status->mac.invtyp;
+	data[k++] = status->mac.intcyov;
+	data[k++] = status->mac.domerr;
+	data[k++] = status->mac.pcfbagdrop;
+	data[k++] = status->mac.spcprior;
+	data[k++] = status->mac.ageprior;
+	data[k++] = status->mac.portdrop;
+	data[k++] = status->mac.lendrop;
+	data[k++] = status->mac.bagdrop;
+	data[k++] = status->mac.policeerr;
+	data[k++] = status->mac.drpnona664err;
+	data[k++] = status->mac.spcerr;
+	data[k++] = status->mac.agedrp;
+	data[k++] = status->hl1.n_n664err;
+	data[k++] = status->hl1.n_vlanerr;
+	data[k++] = status->hl1.n_unreleased;
+	data[k++] = status->hl1.n_sizeerr;
+	data[k++] = status->hl1.n_crcerr;
+	data[k++] = status->hl1.n_vlnotfound;
+	data[k++] = status->hl1.n_ctpolerr;
+	data[k++] = status->hl1.n_polerr;
+	data[k++] = status->hl1.n_rxfrm;
+	data[k++] = status->hl1.n_rxbyte;
+	data[k++] = status->hl1.n_txfrm;
+	data[k++] = status->hl1.n_txbyte;
+	data[k++] = status->hl2.n_qfull;
+	data[k++] = status->hl2.n_part_drop;
+	data[k++] = status->hl2.n_egr_disabled;
+	data[k++] = status->hl2.n_not_reach;
 
 	if (priv->info->device_id == SJA1105E_DEVICE_ID ||
 	    priv->info->device_id == SJA1105T_DEVICE_ID)
-		return;
+		goto out;;
 
 	memset(data + k, 0, ARRAY_SIZE(sja1105pqrs_extra_port_stats) *
 			sizeof(u64));
 	for (i = 0; i < 8; i++) {
-		data[k++] = status.hl2.qlevel_hwm[i];
-		data[k++] = status.hl2.qlevel[i];
+		data[k++] = status->hl2.qlevel_hwm[i];
+		data[k++] = status->hl2.qlevel[i];
 	}
-	data[k++] = status.ether.n_drops_nolearn;
-	data[k++] = status.ether.n_drops_noroute;
-	data[k++] = status.ether.n_drops_ill_dtag;
-	data[k++] = status.ether.n_drops_dtag;
-	data[k++] = status.ether.n_drops_sotag;
-	data[k++] = status.ether.n_drops_sitag;
-	data[k++] = status.ether.n_drops_utag;
-	data[k++] = status.ether.n_tx_bytes_1024_2047;
-	data[k++] = status.ether.n_tx_bytes_512_1023;
-	data[k++] = status.ether.n_tx_bytes_256_511;
-	data[k++] = status.ether.n_tx_bytes_128_255;
-	data[k++] = status.ether.n_tx_bytes_65_127;
-	data[k++] = status.ether.n_tx_bytes_64;
-	data[k++] = status.ether.n_tx_mcast;
-	data[k++] = status.ether.n_tx_bcast;
-	data[k++] = status.ether.n_rx_bytes_1024_2047;
-	data[k++] = status.ether.n_rx_bytes_512_1023;
-	data[k++] = status.ether.n_rx_bytes_256_511;
-	data[k++] = status.ether.n_rx_bytes_128_255;
-	data[k++] = status.ether.n_rx_bytes_65_127;
-	data[k++] = status.ether.n_rx_bytes_64;
-	data[k++] = status.ether.n_rx_mcast;
-	data[k++] = status.ether.n_rx_bcast;
+	data[k++] = status->ether.n_drops_nolearn;
+	data[k++] = status->ether.n_drops_noroute;
+	data[k++] = status->ether.n_drops_ill_dtag;
+	data[k++] = status->ether.n_drops_dtag;
+	data[k++] = status->ether.n_drops_sotag;
+	data[k++] = status->ether.n_drops_sitag;
+	data[k++] = status->ether.n_drops_utag;
+	data[k++] = status->ether.n_tx_bytes_1024_2047;
+	data[k++] = status->ether.n_tx_bytes_512_1023;
+	data[k++] = status->ether.n_tx_bytes_256_511;
+	data[k++] = status->ether.n_tx_bytes_128_255;
+	data[k++] = status->ether.n_tx_bytes_65_127;
+	data[k++] = status->ether.n_tx_bytes_64;
+	data[k++] = status->ether.n_tx_mcast;
+	data[k++] = status->ether.n_tx_bcast;
+	data[k++] = status->ether.n_rx_bytes_1024_2047;
+	data[k++] = status->ether.n_rx_bytes_512_1023;
+	data[k++] = status->ether.n_rx_bytes_256_511;
+	data[k++] = status->ether.n_rx_bytes_128_255;
+	data[k++] = status->ether.n_rx_bytes_65_127;
+	data[k++] = status->ether.n_rx_bytes_64;
+	data[k++] = status->ether.n_rx_mcast;
+	data[k++] = status->ether.n_rx_bcast;
+out:
+	kfree(status);
 }
 
 void sja1105_get_strings(struct dsa_switch *ds, int port,
-- 
2.25.1



