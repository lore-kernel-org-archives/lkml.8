Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0205EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D2724125
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858871;
	bh=Qu2WPU/MJSApFl5cud7d6Hx3nAmc8qWUvlthHgq02yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2UvnNjEmd4UgaLkazMUqfyXGrWPKIyqaGQ0i4I0E2vLJSsJCxCl6UDxgu7ZIZLYOG
	 6wge2ouTso3lwFCWUgvAefT+yUTjjxvek0+7OrCSj9IkQC5QvjZktrUeMt0g5E5rEW
	 JA+F5Ta/SzjdMlcNI276by8bn/e6oNFzk8Wrm/wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbgAXJlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732762AbgAXJlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:41:08 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 820B82070A;
        Fri, 24 Jan 2020 09:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858868;
        bh=Qu2WPU/MJSApFl5cud7d6Hx3nAmc8qWUvlthHgq02yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wV0mgYBFbXflG7IgEoC5/1GAVuvTsmSIMrjVUI1O9QnhPiiE3pgnYdFHqh4nEYPxO
         n/JQKGXYtmfCH2KrNJ8ezt7NH4D4ipQyfnI5KXH2mz/qOOGYvXHy2sr779Kv4w4vC1
         fXDuKbdx7imilEoiJ1YkKziVxqjRGdzuH9n98AQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 069/102] dpaa_eth: perform DMA unmapping before read
Date:   Fri, 24 Jan 2020 10:31:10 +0100
Message-Id: <20200124092817.006147633@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@nxp.com>

[ Upstream commit c70fd3182caef014e6c628b412f81aa57a3ef9e4 ]

DMA unmapping is required before accessing the HW provided timestamping
information.

Fixes: 4664856e9ca2 ("dpaa_eth: add support for hardware timestamping")
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 32 ++++++++++---------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index b4b82b9c5cd6d..54ffc9d3b0a9b 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1620,18 +1620,6 @@ static struct sk_buff *dpaa_cleanup_tx_fd(const struct dpaa_priv *priv,
 	skbh = (struct sk_buff **)phys_to_virt(addr);
 	skb = *skbh;
 
-	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
-		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
-
-		if (!fman_port_get_tstamp(priv->mac_dev->port[TX], (void *)skbh,
-					  &ns)) {
-			shhwtstamps.hwtstamp = ns_to_ktime(ns);
-			skb_tstamp_tx(skb, &shhwtstamps);
-		} else {
-			dev_warn(dev, "fman_port_get_tstamp failed!\n");
-		}
-	}
-
 	if (unlikely(qm_fd_get_format(fd) == qm_fd_sg)) {
 		nr_frags = skb_shinfo(skb)->nr_frags;
 		dma_unmap_single(dev, addr,
@@ -1654,14 +1642,28 @@ static struct sk_buff *dpaa_cleanup_tx_fd(const struct dpaa_priv *priv,
 			dma_unmap_page(dev, qm_sg_addr(&sgt[i]),
 				       qm_sg_entry_get_len(&sgt[i]), dma_dir);
 		}
-
-		/* Free the page frag that we allocated on Tx */
-		skb_free_frag(phys_to_virt(addr));
 	} else {
 		dma_unmap_single(dev, addr,
 				 skb_tail_pointer(skb) - (u8 *)skbh, dma_dir);
 	}
 
+	/* DMA unmapping is required before accessing the HW provided info */
+	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
+		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
+
+		if (!fman_port_get_tstamp(priv->mac_dev->port[TX], (void *)skbh,
+					  &ns)) {
+			shhwtstamps.hwtstamp = ns_to_ktime(ns);
+			skb_tstamp_tx(skb, &shhwtstamps);
+		} else {
+			dev_warn(dev, "fman_port_get_tstamp failed!\n");
+		}
+	}
+
+	if (qm_fd_get_format(fd) == qm_fd_sg)
+		/* Free the page frag that we allocated on Tx */
+		skb_free_frag(phys_to_virt(addr));
+
 	return skb;
 }
 
-- 
2.20.1



