Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96748C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DDC2075D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXM7FVPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgHET07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:26:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51468 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728640AbgHERNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HGH8uN/cNB2/6WI5Jdaw/ORCmqNBtzwnAZDFmfA6T4k=;
        b=VXM7FVPMxmCI285L/PcZqkRdE6DskdD35RjopDLv/GQWm2hf6XvA7PEIc98mDVOXnQ/oAg
        hrlx0GjSWgNJnHvX1eQ70XvMbkGFYFus9piDzD/kmmA9MvXgGbJR9PoBy6VOif9LcTHrAP
        pECIacZFAD2DWlXx2uqQc3n7XcYa9Wk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-tbJDOK7UPuOShBCFkj6Nmg-1; Wed, 05 Aug 2020 09:44:19 -0400
X-MC-Unique: tbJDOK7UPuOShBCFkj6Nmg-1
Received: by mail-wr1-f72.google.com with SMTP id b8so3980965wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HGH8uN/cNB2/6WI5Jdaw/ORCmqNBtzwnAZDFmfA6T4k=;
        b=I3clkaDDvAVQvwFHb2tZ8EdoN2sH6BOcflAG0douaNgn6QeqgTq3SUoU19m8X0w67O
         mWr3HQbtlJSk5Jh4N+TdvVd1aR9JEWyXcgh6FbWa2x259zyb1pc07vF0yXSBGDNSTyGi
         7rC7TlVSdzKoN3rfkGA4f5cunvfOUqJK1/sBOMP/TU0uVa5IB2wPRo0ISI3XlOR0glCK
         LuvCfIAqb93j8jM9eLxRuqA4KQH+uS2ddpH96pSqjMITZFXfdX6QrbhLG8mnWZmyHTUk
         6SudgdU+GU8LV0Y2XNdjMB9qAQ9ZlY2AuD2QC3zq/oBRfWKnt89HdZ6sWvIHPzHbSQac
         D1Qw==
X-Gm-Message-State: AOAM532fVFCjN3e3jk2De6ewxFdJ51ZRbI2QWs2NJAnwIpUrsL85Dhl1
        rR4i2Ewa/0eiaRpoBn1/q0EnuxT7PgZzroVmS76SM/DmjpdDuRRUz5k13tfzSI6Ky4XYR1QEnPM
        vXihYiG/JEfY8fq+owxsGBeXv
X-Received: by 2002:a1c:a513:: with SMTP id o19mr3312342wme.119.1596635057957;
        Wed, 05 Aug 2020 06:44:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyC4k9IinKSvhYB2iv/paIM/IOHx4dnXSDebtCSSPL0wngI27bkfM89iBZEVeTyNvldrdyFDQ==
X-Received: by 2002:a1c:a513:: with SMTP id o19mr3312320wme.119.1596635057717;
        Wed, 05 Aug 2020 06:44:17 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id g25sm2755239wmh.35.2020.08.05.06.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:17 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 22/38] vdpa_sim: fix endian-ness of config space
Message-ID: <20200805134226.1106164-23-mst@redhat.com>
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

VDPA sim accesses config space as native endian - this is
wrong since it's a modern device and actually uses LE.

It only supports modern guests so we could punt and
just force LE, but let's use the full virtio APIs since people
tend to copy/paste code, and this is not data path anyway.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 33 +++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index a9bc5e0fb353..b7d5727fde4c 100644
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
@@ -455,6 +470,14 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 
 	vdpasim->features = features & vdpasim_features;
 
+	/* We generally only know whether guest is using the legacy interface
+	 * here, so generally that's the earliest we can set config fields.
+	 * Note: We actually require VIRTIO_F_ACCESS_PLATFORM above which
+	 * implies VIRTIO_F_VERSION_1, but let's not try to be clever here.
+	 */
+
+	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
+	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
 	return 0;
 }
 
-- 
MST

