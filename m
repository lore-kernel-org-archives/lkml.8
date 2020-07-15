Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4E3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B05520657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsSRX7de"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbgGON6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:58:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21866 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727822AbgGON6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594821494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lNYAB5WtdpHZtbrXZUY3IMkmV+ZQSuZpS3mId26/pIw=;
        b=hsSRX7deygPFlhMM3/yvqUAXnoWU9xkuSD7yXYpV0xpvErcqlmqdIqvehkRyIX4MnmJIF6
        wLLgw1aB73wd8cAmkudi+0r9wMN/jOEfZ5NYhu7Xk99eQoxhIchqU5obgOhgcYuKAU/zcJ
        98JJns2p6hVrubdZLdbKblPGaxItpFA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-O_RPBkzFPFGhh9FzPvxrmQ-1; Wed, 15 Jul 2020 09:58:13 -0400
X-MC-Unique: O_RPBkzFPFGhh9FzPvxrmQ-1
Received: by mail-wr1-f69.google.com with SMTP id j16so1424403wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 06:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lNYAB5WtdpHZtbrXZUY3IMkmV+ZQSuZpS3mId26/pIw=;
        b=IzPq56VRXe1jLA/F353306D1MtfMyAwOHUbI7Pkqv8P78kMeuZWW5slxQCA7Slnh9W
         tfzXkDjkme/QTDECv009Ar3rdx90YNy4iE9gNKIkLArmGVyvyVlFjgEI4MxqJgBOJaCD
         rTTK11UxZ/z1prLOPenxfbH3pqGkTJBiqB0iRuCqIwJWB6wLuHv3dkHP6cxbOihXdOC2
         xqBHMAKaQN5NxA7XPc0kOnYlajK413OXF5/sQmnfz94xPDzMq/QcbAGfWXhM+43C24G2
         u5lHlZ6pBDXocDqx9gECyDLAJebs0J8op9ZGArqnlg6UEIr91zemaru1Zhkfou9dKvD2
         zHqA==
X-Gm-Message-State: AOAM531yO/TngLEj5fgxYfR3OYDoBiW9v2xioPC2dXMTbh0mYnbOuuZq
        BR9rAmppqt/3YwtSwqZGZmww8v2bOMcOAubTzBEwAHI4aibTWbUfoXWY/Ug6bShz+KOpyxYNNj4
        xbFwkd/hXUJmG4nG0FHog2Oy8
X-Received: by 2002:adf:b608:: with SMTP id f8mr12310158wre.363.1594821491433;
        Wed, 15 Jul 2020 06:58:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyENFqiva68rgsrhrT1+9cBPKB/7ZYwnr1uTs81wgO+SSDgSYBiKi/nQWV/DVHlvr0G2ndfSA==
X-Received: by 2002:adf:b608:: with SMTP id f8mr12310142wre.363.1594821491254;
        Wed, 15 Jul 2020 06:58:11 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
        by smtp.gmail.com with ESMTPSA id a15sm3956429wrh.54.2020.07.15.06.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 06:58:10 -0700 (PDT)
Date:   Wed, 15 Jul 2020 09:58:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH RFC don't apply] vdpa_sim: endian-ness for config space
Message-ID: <20200715135540.22832-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VDPA sim stores config space as native endian, but that
is wrong: modern guests expect LE.
I coded up the following to fix it up, but it is wrong too:
vdpasim_create is called before guest features are known.

So what should we do? New ioctl to specify the interface used?
More ideas?

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index a9bc5e0fb353..cc754ae0ec15 100644
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
@@ -332,8 +350,8 @@ static struct vdpasim *vdpasim_create(void)
 		goto err_iommu;
 
 	config = &vdpasim->config;
-	config->mtu = 1500;
-	config->status = VIRTIO_NET_S_LINK_UP;
+	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
+	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
 	eth_random_addr(config->mac);
 
 	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
-- 
MST

