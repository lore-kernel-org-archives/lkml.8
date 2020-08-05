Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C326BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8912173E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QP8yJgvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgHET3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:29:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45007 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728560AbgHERKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E6FiLGXEyromLE+NGBVYxEgCEa70YCiNICtsxGYJF7c=;
        b=QP8yJgvdDNr2BbylYdG1PVtVCpuYa0Q+HFe5SOoF094poxjRxn9b1O+c8FYHGS743Zdy9+
        uJjaQO1aecXSb81dLVhuy0x1Q2aTO4SQTIFF1vE2Rv5LhJxCdBQ6jbBuaNfBJlivQ+Y4qg
        luX2IAfuaAR2q/6azNSeOsuPW7l6EpM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-3CmHU3QjNGKFRaAaLM5rrw-1; Wed, 05 Aug 2020 09:44:10 -0400
X-MC-Unique: 3CmHU3QjNGKFRaAaLM5rrw-1
Received: by mail-wr1-f72.google.com with SMTP id r29so9279407wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E6FiLGXEyromLE+NGBVYxEgCEa70YCiNICtsxGYJF7c=;
        b=B94py169xq8f7CSho4eiLR0uO3FXr1TDClH4Qbj0ezxaKsWodqeahkYb65d4q6FHT/
         4JtGYjZUDhsITwA+dZ76J6k13ttH72jOwxlcIifvz3P/O6tQr9/DMX3XmymxeGIg82pC
         SnwMOHuBT32z22d+p5Va4FePf/InA7BbaasO/8M8qjA7BG6i+6NgNLytEHFDKR0/Si8E
         k3YwitxtRWVUrdKER8UAe7z8CuWu5XLjXMilw3U59jTsyKcfBqaThhfxnV5hCb9IsFda
         SErKyGB+V2+IZFUwdhCxDLVE8UqyG+JKPeoGS32g+Hjw/4GNeIfBxvRFB53CLuSHEQsc
         Ha1Q==
X-Gm-Message-State: AOAM531cQ0qCNHn4Xd6sBAuetXcOHx3uL1QhR6m3N+b4szeBV4FaizUV
        2jP3y4UqjvkgpKZV9SILPH1Hi1czPa/x2zA6Ht4LSO7SXo5MigeLe/5+J97jgbI2HZxkwpsuOvZ
        FCWhktqh/HOmX4m8A6+yu592P
X-Received: by 2002:adf:ec04:: with SMTP id x4mr2747071wrn.28.1596635048493;
        Wed, 05 Aug 2020 06:44:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQI4FlgMw3rbHxklSaF89feIW66tgc8CCicGOY4FAHT13RLsJQet+pRNk6EzHyh659HRSHmQ==
X-Received: by 2002:adf:ec04:: with SMTP id x4mr2747025wrn.28.1596635047405;
        Wed, 05 Aug 2020 06:44:07 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id t13sm2717293wru.65.2020.08.05.06.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:06 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 18/38] mlxbf-tmfifo: sparse tags for config access
Message-ID: <20200805134226.1106164-19-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mlxbf-tmfifo accesses config space using native types -
which works for it since the legacy virtio native types.

This will break if it ever needs to support modern virtio,
so with new tags previously introduced for virtio net config,
sparse now warns for this in drivers.

Since this is a legacy only device, fix it up using
virtio_legacy_is_little_endian for now.

No functional changes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 5739a9669b29..bbc4e71a16ff 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -625,7 +625,10 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
 			vdev_id = VIRTIO_ID_NET;
 			hdr_len = sizeof(struct virtio_net_hdr);
 			config = &fifo->vdev[vdev_id]->config.net;
-			if (ntohs(hdr.len) > config->mtu +
+			/* A legacy-only interface for now. */
+			if (ntohs(hdr.len) >
+			    __virtio16_to_cpu(virtio_legacy_is_little_endian(),
+					      config->mtu) +
 			    MLXBF_TMFIFO_NET_L2_OVERHEAD)
 				return;
 		} else {
@@ -1231,8 +1234,12 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
 
 	/* Create the network vdev. */
 	memset(&net_config, 0, sizeof(net_config));
-	net_config.mtu = ETH_DATA_LEN;
-	net_config.status = VIRTIO_NET_S_LINK_UP;
+
+	/* A legacy-only interface for now. */
+	net_config.mtu = __cpu_to_virtio16(virtio_legacy_is_little_endian(),
+					   ETH_DATA_LEN);
+	net_config.status = __cpu_to_virtio16(virtio_legacy_is_little_endian(),
+					      VIRTIO_NET_S_LINK_UP);
 	mlxbf_tmfifo_get_cfg_mac(net_config.mac);
 	rc = mlxbf_tmfifo_create_vdev(dev, fifo, VIRTIO_ID_NET,
 				      MLXBF_TMFIFO_NET_FEATURES, &net_config,
-- 
MST

