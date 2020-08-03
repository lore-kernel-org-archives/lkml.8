Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4421AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C0222CAD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAVlGCbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgHCVAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:00:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21263 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgHCVAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8bq9rXUCTGSN68YwCNXz85TMhgq9vmhl8kPAax2zSMY=;
        b=RAVlGCbwzWbyFKoRLPiD55BcASXFMhKGxOV3clH8k25xCxgW1hnYLNycC5VgaMXxX4zyH2
        wAcUazLry4AsiOcJI3fwzA5/C8BAS5SdaIUR3VwXfVoTiErwhedEpUFk77t0J2cWtFZjNS
        IuPN1wlsNUA4iDOJO/7GVT5JQb2mOdg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6--z94eScROcqfYDOPoVhAuA-1; Mon, 03 Aug 2020 17:00:10 -0400
X-MC-Unique: -z94eScROcqfYDOPoVhAuA-1
Received: by mail-qv1-f70.google.com with SMTP id k17so13051138qvj.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8bq9rXUCTGSN68YwCNXz85TMhgq9vmhl8kPAax2zSMY=;
        b=MERFu3V+afu1bOfu7pO0BbLcQTiW6R8Cm+c1bUvP9dh0hTjSV587eavksfT6vthSZO
         IvME+XkGDIsTdy8Pv0qLsfS7SAE6BJjgoM6hPhr8Di/gJHJo5SONO+Va0krocXj5FPDe
         bNWzIA17m+sMOq+dNXvKQFNEZ4yvN2GJLG4GKBIVe72RQH2i7Ydhh6fLZkPkE799DwKN
         E8zNIAAusqu6GKDRBDZIaWLzCaULN9CbqBzpJ71ahXPU9RPN/MXDsl7UOVmYLKoZGsq9
         cF5NSU+ReJtZ+l4arwx2JqVsx/CJwQgVFCEmPkEMqDmUlsI66p48HjW4VCWEc2WvDHC5
         0w/w==
X-Gm-Message-State: AOAM531CSxzRY9P+XZDtelu//O7OeFXBpun+Gqk8VSf2fwcnLwMekBSc
        1VFK4iheIJPQPPRI00AGTTASqMCAtzbfDP0Mh+cS11c/OpGC0RQpOi0TxepJg7KRkX+SUC9dlSs
        E5LuRROFqLoQPXjYlWfWryFNU
X-Received: by 2002:a05:620a:1034:: with SMTP id a20mr18018695qkk.88.1596488406605;
        Mon, 03 Aug 2020 14:00:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ4xACpDy2QuhLtURPr5OaRyOxNfQsRP3NRt54g2pzfNFf4aofKomQafv01c0VtrayvMamMQ==
X-Received: by 2002:a05:620a:1034:: with SMTP id a20mr18018682qkk.88.1596488406387;
        Mon, 03 Aug 2020 14:00:06 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id m15sm22165480qta.6.2020.08.03.14.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:00:05 -0700 (PDT)
Date:   Mon, 3 Aug 2020 17:00:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 18/24] mlxbf-tmfifo: sparse tags for config access
Message-ID: <20200803205814.540410-19-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
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

