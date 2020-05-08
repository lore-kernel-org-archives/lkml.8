Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F74C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0078B206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943796;
	bh=nV7fD41rUmsPpGuN2qof41eLAsCjL89uYzewhWVLa4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wunMadbGr+peFvTMMmoQhYaMj3EaA9KT6iH3hOQLVfxgFn0LCfIDOTSOmHypt0Hi9
	 W+RxzbdujBVeACUvCLEdKdnd8vLvC46ajMVytWgNhe97m2lWN5CH2egvArBXA/MKhT
	 fk6T8MmTsxQgLDMkONxjsAFwqDpXINuaKQeH9C1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgEHNQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbgEHMpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:45:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39210208D6;
        Fri,  8 May 2020 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941902;
        bh=nV7fD41rUmsPpGuN2qof41eLAsCjL89uYzewhWVLa4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0bwPHqCm/c78hpKrzUmbmQiGM8BR+dFEkXlm0xSYfLY/CAaZ2XAAllOSxD1T/ZJ2
         VozvRhzS+2k9kYigNEPTR9ggWRqYFVEHN31bTL8fN1FZ4MnSjR4hnN88kqzhxCgs74
         pIdLxf+8v+/gdPad09A7uJTTGcWJL2FoVg0GCGpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erez Shitrit <erezsh@mellanox.com>,
        Eugenia Emantayev <eugenia@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 217/312] net/mlx4_en: Process all completions in RX rings after port goes up
Date:   Fri,  8 May 2020 14:33:28 +0200
Message-Id: <20200508123139.720650050@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erez Shitrit <erezsh@mellanox.com>

commit 8d59de8f7bb3db296331c665779c653b0c8d13ba upstream.

Currently there is a race between incoming traffic and
initialization flow. HW is able to receive the packets
after INIT_PORT is done and unicast steering is configured.
Before we set priv->port_up NAPI is not scheduled and
receive queues become full. Therefore we never get
new interrupts about the completions.
This issue could happen if running heavy traffic during
bringing port up.
The resolution is to schedule NAPI once port_up is set.
If receive queues were full this will process all cqes
and release them.

Fixes: c27a02cd94d6 ("mlx4_en: Add driver for Mellanox ConnectX 10GbE NIC")
Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Signed-off-by: Eugenia Emantayev <eugenia@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -1720,6 +1720,13 @@ int mlx4_en_start_port(struct net_device
 		vxlan_get_rx_port(dev);
 #endif
 	priv->port_up = true;
+
+	/* Process all completions if exist to prevent
+	 * the queues freezing if they are full
+	 */
+	for (i = 0; i < priv->rx_ring_num; i++)
+		napi_schedule(&priv->rx_cq[i]->napi);
+
 	netif_tx_start_all_queues(dev);
 	netif_device_attach(dev);
 


