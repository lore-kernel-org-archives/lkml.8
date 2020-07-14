Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C611CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A338F21D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VW8YqNJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgGNJPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:15:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27189 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725833AbgGNJPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594718138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=BB6C118E6FKCuoIP8Fo6w/ofvx92N5UxmamVVKOIZos=;
        b=VW8YqNJTi9tdtJIEQs4XEqaHtohpYKySk/p9i+/qefpPjhPInPOuDQJooGCJJ0Rxvm44OZ
        gaCgsDPIwQDcUCwE11Fp+p8/Csazz1TKi+hnKu9bOxBy16Pslv3lT6imqB0oQ/IoAhDiF2
        wjIGPsbe4kmNCsb9nbhO0JpRL4omaus=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-HVSZeXqeOVyo8p7tIqyhpA-1; Tue, 14 Jul 2020 05:15:37 -0400
X-MC-Unique: HVSZeXqeOVyo8p7tIqyhpA-1
Received: by mail-wr1-f72.google.com with SMTP id f5so20756848wrv.22
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BB6C118E6FKCuoIP8Fo6w/ofvx92N5UxmamVVKOIZos=;
        b=ov+cNwgZ8KdhB8s3AWoCwYwCRQl8KjIyq4gFQYcwSgM9d96X0Ar39Dz5DTDko4CNGy
         j48hO9LMkqi2w2KxHxuLiBHxbhqsMQafJaLFZW2eo4SfnUi9kDC96Mc/Yp67C/0OvdLq
         VXBD1xcU6QCp8VtXpBIwwMPVPggknlIqYCWHeOSOOeo4kgFrU7fWbRZJBIXf6K9THuym
         YNpAkQsKBNH40uKwsTSojDJpS+ExPb4Rl62MB7MZLgnmsIuxhzDFD5or2+cvqxX3t2gi
         mT6tn3h35M8qF3Q50czH1o8mPjYMHq5+2TPWz2Y/uoZhRkK13r/rSu2NciTl16LDrEz7
         nOjw==
X-Gm-Message-State: AOAM530JRa/zidBl0tWhk4VZUs67u0quhScxR6++hxms4WXC1wTfM4Lv
        qHaTNNIxP5SKiF2XDyPW0GEUBExGf8OtPZDktOeI24a+tNBqS7hbcTyJIjd5nHh0BHNvJPgI8Uk
        wa669OOz9sW/zg3RQTY7liml0
X-Received: by 2002:adf:e811:: with SMTP id o17mr4266149wrm.53.1594718135510;
        Tue, 14 Jul 2020 02:15:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeKZgByjmVhF/PTpTluD+IrVT89wwyMV+zgZu5u4ujDA6DCalTXuAtsUr/hXwsVCu55MF2ug==
X-Received: by 2002:adf:e811:: with SMTP id o17mr4266134wrm.53.1594718135306;
        Tue, 14 Jul 2020 02:15:35 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
        by smtp.gmail.com with ESMTPSA id q7sm29165152wra.56.2020.07.14.02.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 02:15:34 -0700 (PDT)
Date:   Tue, 14 Jul 2020 05:15:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2] mlxbf-tmfifo: use wrappers for config access
Message-ID: <20200714091133.788853-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mlxbf-tmfifo.c

seems to access virtio net config directly.
E.g.:

                        if (ntohs(hdr.len) > config->mtu +
                            MLXBF_TMFIFO_NET_L2_OVERHEAD)
                                return;

This is not incorrect in that the specific device is at the
moment always legacy (no virtio 1).

However this throws up sparse warnings as the structure
is shared with modern devices which need the tagging for
correct virtio 1 endian-ness.

Using correct conversions will also allow virtio 1 support
in this driver down the road.

I'd like to merge the following patch. It's on top of
a branch config-endian in my tree which includes
the endian-ness tagging.

Would appreciate acks on merging it through my tree from relevant maintainers.
I also note that the console config field seems to be unused.
Would appreciate a confirmation.
Thanks!

---

Changes from v1:
	bugfixes

 drivers/platform/mellanox/mlxbf-tmfifo.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 5739a9669b29..3a93081eee97 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -608,6 +608,7 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
 {
 	struct mlxbf_tmfifo *fifo = vring->fifo;
 	struct virtio_net_config *config;
+	struct virtio_device *vdev;
 	struct mlxbf_tmfifo_msg_hdr hdr;
 	int vdev_id, hdr_len;
 
@@ -625,7 +626,8 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
 			vdev_id = VIRTIO_ID_NET;
 			hdr_len = sizeof(struct virtio_net_hdr);
 			config = &fifo->vdev[vdev_id]->config.net;
-			if (ntohs(hdr.len) > config->mtu +
+			vdev = &fifo->vdev[vdev_id]->vdev;
+			if (ntohs(hdr.len) > virtio16_to_cpu(vdev, config->mtu) +
 			    MLXBF_TMFIFO_NET_L2_OVERHEAD)
 				return;
 		} else {
@@ -1231,8 +1233,14 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
 
 	/* Create the network vdev. */
 	memset(&net_config, 0, sizeof(net_config));
-	net_config.mtu = ETH_DATA_LEN;
-	net_config.status = VIRTIO_NET_S_LINK_UP;
+
+#define MLXBF_TMFIFO_LITTLE_ENDIAN (virtio_legacy_is_little_endian() || \
+			(MLXBF_TMFIFO_NET_FEATURES & (1ULL << VIRTIO_F_VERSION_1)))
+
+	net_config.mtu = __cpu_to_virtio16(MLXBF_TMFIFO_LITTLE_ENDIAN,
+					   ETH_DATA_LEN);
+	net_config.status = __cpu_to_virtio16(MLXBF_TMFIFO_LITTLE_ENDIAN,
+					      VIRTIO_NET_S_LINK_UP);
 	mlxbf_tmfifo_get_cfg_mac(net_config.mac);
 	rc = mlxbf_tmfifo_create_vdev(dev, fifo, VIRTIO_ID_NET,
 				      MLXBF_TMFIFO_NET_FEATURES, &net_config,
-- 
MST

