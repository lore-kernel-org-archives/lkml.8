Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0C4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BED320729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgU7RBhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHJNP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbgHJNPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597065353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SkccwtZwot+cQicoGLcB8HlwMrsRMKWiGoSDkAQlLl4=;
        b=RgU7RBhDVhD/F/0E3DPBFFUBjH6V6uTaWak9UgW+ldZlke36/VyzOs75ThUGMbAFnJynfj
        Gg1iBkxon5kb6kedGekEZ3/dge548tT4Yyq7KfTRwtd084CMe/sBDYTbjdi0L/6pFwIWnK
        jiMcTHqGeTH/glED3wvL+0J5FKFDbWU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-SpFgGFgOMv-wN2VxXNNYzA-1; Mon, 10 Aug 2020 09:15:52 -0400
X-MC-Unique: SpFgGFgOMv-wN2VxXNNYzA-1
Received: by mail-wr1-f70.google.com with SMTP id w1so4235618wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 06:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SkccwtZwot+cQicoGLcB8HlwMrsRMKWiGoSDkAQlLl4=;
        b=Lv5EzcJIykGhNsIk6qKrqTjYPHE3o4MlRLI5jWuHBep2tyOWt7sUn73mkXrjaXEu3h
         Xqb5rfdZO4whiYE48C2bP4S0aaI0uRmp81UmOc4Aq4dM4fgiKPA7WHxm79bImpIcPUyR
         uBZT06y2nJIBiUXW1sfs0CVZvk/pktoaiT6dWY7N7oJGJr2WL2+wMHysOz4w43cDuA0c
         5VUrraN8iERU8EY9wRv+lPpLuegKOwdGgnztz4iqzYCWxHYUWj9F3fgjVZYDoT193657
         Ca7xXQn5qp6HzMAHqVsiTvuYi6A+Etws4aDsyI4ca5pkS6yimA+e1rZLtpKz40C+W5A1
         zLeg==
X-Gm-Message-State: AOAM532WqoEVMSF1vL45S47T9pFKDCJCP+iInJMsZn4gMBq5qBMabGcV
        o/Tx3k0CmzQuNAubJ1aLpdw/RXF+WoDolFADwcrq+bAT9RNbflhnwOz1xdluRhl1Oj2s+HBD9mN
        Cb3PNgS91IYU2Vk7sVrzJ9aAQ
X-Received: by 2002:a1c:6087:: with SMTP id u129mr24584908wmb.157.1597065350491;
        Mon, 10 Aug 2020 06:15:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJHvW56HaHPIOjJ1zmGR1ZtqZ1Qm7WDWul/CFEd2atwUm51JZJIT272Ywlsls9/8VFgLcuMA==
X-Received: by 2002:a1c:6087:: with SMTP id u129mr24584894wmb.157.1597065350280;
        Mon, 10 Aug 2020 06:15:50 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id y145sm22255849wmd.48.2020.08.10.06.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 06:15:49 -0700 (PDT)
Date:   Mon, 10 Aug 2020 09:15:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH] vdpa/mlx5: fix up endian-ness for mtu
Message-ID: <20200810131516.1563803-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VDPA mlx5 accesses config space as native endian - this is
wrong since it's a modern device and actually uses LE.

It only supports modern guests so we could punt and
just force LE, but let's use the full virtio APIs since people
tend to copy/paste code, and this is not data path anyway.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index c6b9ec47e51d..9df69d5efe8c 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -137,6 +137,7 @@ struct mlx5_vdpa_net {
 	struct mlx5_fc *rx_counter;
 	struct mlx5_flow_handle *rx_rule;
 	bool setup;
+	u16 mtu;
 };
 
 static void free_resources(struct mlx5_vdpa_net *ndev);
@@ -1506,6 +1507,13 @@ static void teardown_virtqueues(struct mlx5_vdpa_net *ndev)
 	}
 }
 
+/* TODO: cross-endian support */
+static inline bool mlx5_vdpa_is_little_endian(struct mlx5_vdpa_dev *mvdev)
+{
+	return virtio_legacy_is_little_endian() ||
+		(mvdev->actual_features & (1ULL << VIRTIO_F_VERSION_1));
+}
+
 static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
@@ -1519,6 +1527,8 @@ static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
 		return err;
 
 	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
+	ndev->config.mtu = __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev),
+					     ndev->mtu);
 	return err;
 }
 
@@ -1925,7 +1935,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
 	init_mvqs(ndev);
 	mutex_init(&ndev->reslock);
 	config = &ndev->config;
-	err = mlx5_query_nic_vport_mtu(mdev, &config->mtu);
+	err = mlx5_query_nic_vport_mtu(mdev, &ndev->mtu);
 	if (err)
 		goto err_mtu;
 
-- 
MST

