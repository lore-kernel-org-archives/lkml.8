Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B299C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3934822C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBEQod69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgHCVAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:00:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52497 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729227AbgHCVA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NiZB22SeLbsfRSVDlKOFqbTnwVzNTGOJ5/PiHpTfDck=;
        b=BBEQod693V6/iIAsBG6b8+SMvjAMMcKrDYcNwcJD/MsJIyA8vtpOgZXVkMWlHXjN+Ctcin
        SAD4Fl3LdevrxIVR3Mh8Jn5Ai5z+UVrgxPOGhUt2VkRXWtZMbxgWj7hA5KB2JtKlcsQ65L
        7jbv4X0a9JJD2WuGmG6/FUBUy3js/IY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-En-XlaaTNPaOMoe7MTWE6Q-1; Mon, 03 Aug 2020 17:00:25 -0400
X-MC-Unique: En-XlaaTNPaOMoe7MTWE6Q-1
Received: by mail-qv1-f70.google.com with SMTP id k17so13051942qvj.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NiZB22SeLbsfRSVDlKOFqbTnwVzNTGOJ5/PiHpTfDck=;
        b=S/M0CwsTY1YPvMtXNpHDabJ7abJQXjiuPnW5C8jCXM6OtB08BKisJf71pAo+CKuF6L
         e5vpk/3asvRemx5nZTRwW/nLOWueb1aRSZGbkKEE5wP2HbkK5JVRf5AM0KkOTNoztno7
         s+l6c1gJVEVMdk47Ytp3BMR0wEiDWhvNNiVGpIZxxrYlfqWBYiDwygnP7h3mLiAzQUIt
         d+zZIVPaxtss9rPSzVDHuCyOj8RdIryBphOXyxXWQVKe9zqFGxRL4/EpSM5n7UBaLqYK
         OU9B5hd/A6jJHLXAfwOTttA8V2+UhwThcDujh5nWuj/1jlwCoPvmwW4AH2ZJWzbYNjMq
         5P5A==
X-Gm-Message-State: AOAM5306DzF6aKd5UaUdgmpS9w+KWajKpFU8pqhyMcNlV5fxMAGy03+v
        fhKbkprg0gTrZYh96GtbMQq2aAlSScyHvX9nqs7QiOoeOQgqk8BJyFqz9291tIl+fGFhDECycfH
        bjwH4C+MWRcvVYLZ0hUjNSNg4
X-Received: by 2002:ac8:5143:: with SMTP id h3mr18404670qtn.229.1596488424439;
        Mon, 03 Aug 2020 14:00:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpo0f24LeUjpc3FWqSxgI10kipRuf37ecjGkYkh3fCSeCIKIolBKdEfCyIApYIsbUD/tDaLg==
X-Received: by 2002:ac8:5143:: with SMTP id h3mr18404641qtn.229.1596488424194;
        Mon, 03 Aug 2020 14:00:24 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id h55sm24470268qte.16.2020.08.03.14.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:00:23 -0700 (PDT)
Date:   Mon, 3 Aug 2020 17:00:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 22/24] vdpa_sim: fix endian-ness of config space
Message-ID: <20200803205814.540410-23-mst@redhat.com>
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

VDPA sim accesses config space as native endian - this is
wrong since it's a modern device and actually uses LE.

It only supports modern guests so we could punt and
just force LE, but let's use the full virtio APIs since people
tend to copy/paste code, and this is not data path anyway.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index a9bc5e0fb353..fa05e065ff69 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -24,6 +24,7 @@
 #include <linux/etherdevice.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
+#include <linux/virtio_byteorder.h>
 #include <linux/vhost_iotlb.h>
 #include <uapi/linux/virtio_config.h>
 #include <uapi/linux/virtio_net.h>
@@ -72,6 +73,23 @@ struct vdpasim {
 	u64 features;
 };
 
+/* TODO: cross-endian support */
+static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
+{
+	return virtio_legacy_is_little_endian() ||
+		(vdpasim->features & (1ULL << VIRTIO_F_VERSION_1));
+}
+
+static inline u16 vdpasim16_to_cpu(struct vdpasim *vdpasim, __virtio16 val)
+{
+	return __virtio16_to_cpu(vdpasim_is_little_endian(vdpasim), val);
+}
+
+static inline __virtio16 cpu_to_vdpasim16(struct vdpasim *vdpasim, u16 val)
+{
+	return __cpu_to_virtio16(vdpasim_is_little_endian(vdpasim), val);
+}
+
 static struct vdpasim *vdpasim_dev;
 
 static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
@@ -306,7 +324,6 @@ static const struct vdpa_config_ops vdpasim_net_config_ops;
 
 static struct vdpasim *vdpasim_create(void)
 {
-	struct virtio_net_config *config;
 	struct vdpasim *vdpasim;
 	struct device *dev;
 	int ret = -ENOMEM;
@@ -331,10 +348,7 @@ static struct vdpasim *vdpasim_create(void)
 	if (!vdpasim->buffer)
 		goto err_iommu;
 
-	config = &vdpasim->config;
-	config->mtu = 1500;
-	config->status = VIRTIO_NET_S_LINK_UP;
-	eth_random_addr(config->mac);
+	eth_random_addr(vdpasim->config.mac);
 
 	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
 	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
@@ -448,6 +462,7 @@ static u64 vdpasim_get_features(struct vdpa_device *vdpa)
 static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+	struct virtio_net_config *config = &vdpasim->config;
 
 	/* DMA mapping must be done by driver */
 	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
@@ -455,6 +470,12 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 
 	vdpasim->features = features & vdpasim_features;
 
+	/* We only know whether guest is using the legacy interface here, so
+	 * that's the earliest we can set config fields.
+	 */
+
+	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
+	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
 	return 0;
 }
 
-- 
MST

