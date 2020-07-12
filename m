Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0083C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 14:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B52E20702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 14:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5iUHvHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgGLOzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 10:55:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24368 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728786AbgGLOzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 10:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594565710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=6nL6kDn6HMgn8sx0okC7YwBl7oR6NlWE67Kvx5ek+uw=;
        b=L5iUHvHZkEmm3XkDGmT/MosaEz+JZHEEuNR9XSqwUbJj4Am3IysCi0OwTGfnKGSNQ8tRaH
        AhdwkuDAPIt/DXqOhXdINucUvF1DBH5DulZ8FpFzApu8mQSbGXjmwQjpXJGCykUcOQbQnT
        WIBiSEtI5T3XEi0deZ1FhP1W0D+3VNs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-qs8nO6YROOC9HP6wxRuhaQ-1; Sun, 12 Jul 2020 10:55:09 -0400
X-MC-Unique: qs8nO6YROOC9HP6wxRuhaQ-1
Received: by mail-wr1-f69.google.com with SMTP id j16so14206083wrw.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 07:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6nL6kDn6HMgn8sx0okC7YwBl7oR6NlWE67Kvx5ek+uw=;
        b=kPHCz2K902IuBrvT+BOGZjjLahaXu47Q5X1goqSxCudn4jfv9CXqe1BX4mmfIJ/b4e
         4kwKiKyeus5esWLag4xu/AkP/eSVufDwzVLCcmiQ3YEKTZTP6KzWEpYlEKUtCmcq/V5/
         14qZCRAVx0OPnit0UY8AZV+c8H9/6uS7+Bo2WdL79x04kJCtVSucZvHzePnHdDP6Cqjr
         tB3fL2Ag7eREYJlBuL96K/gkIeavckPSSymQGYrAzKrF32AcSZugCmoiU8Bi4wdNZKsy
         KI1yfJE/JUqMBGK2iBIpKgk3eEIqJo6Xb5cttbCfGlSk0aWCJWCMLDMbc/p4dPbxRHgt
         SBOw==
X-Gm-Message-State: AOAM532ZWljixD5Bnn1ljT5ApmRg/LtsCrrLpDT6r0CsspIDWtpYxOul
        hbBbyz2o02fyXj9Y7BGPK6T1mIYZD6QbYENJVH7C6eVEeZaVynvN2+5ZJSYj9ypM0YyuO54+Igh
        1FABuUrhLCd/9jLEvg8wDC98O
X-Received: by 2002:a05:600c:2dc1:: with SMTP id e1mr13878936wmh.108.1594565707260;
        Sun, 12 Jul 2020 07:55:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwk680C1Rkd/fNGPOmQc3S/qzMmIRqDIOQYMsKgiZpDsxSuaZsrQGI5EyVxtpuoVK3n/aNrsg==
X-Received: by 2002:a05:600c:2dc1:: with SMTP id e1mr13878912wmh.108.1594565706989;
        Sun, 12 Jul 2020 07:55:06 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id u186sm19324768wmu.10.2020.07.12.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 07:55:06 -0700 (PDT)
Date:   Sun, 12 Jul 2020 10:55:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     netdev@vger.kernel.org, dwoods@mellanox.com, lsun@mellanox.com
Cc:     Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH] mlxbf-tmfifo: endian-ness wrappers for config access
Message-ID: <20200712102743-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
While working out some endian-ness issues with virtio,
I noticed that the following driver:

drivers/platform/mellanox/mlxbf-tmfifo.c

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

Would appreciate acks from relevant maintainers.
I also note that the console config field seems to be unused.
Would appreciate a confirmation.
Thanks!

--

mlxbf-tmfifo: endian-ness wrappers for config access

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

-->

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 5739a9669b29..b1484206429f 100644
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
+#defined MLXBF_TMFIFO_LITTLE_ENDIAN (virtio_legacy_is_little_endian() ||
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

