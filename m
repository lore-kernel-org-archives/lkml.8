Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7250C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5A32067C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcro/mrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHUWvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgHUWvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 18:51:11 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436EAC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 15:51:11 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s16so2382106qtn.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 15:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6ZztkKitApUlwV+ZX0Zt+Hf87PA0Zib6OW8N+QCBqM=;
        b=dcro/mrEGFp2nLXCD4ox6HKQkFBTr/8RKDRxQYJ7gMFpIv0vYubXMZbe+BlFWh4YWH
         NOKgqOcElmHokhlCQ5TvCJs73/IT8dLZ5XpDreQ+I9rPzm9aNaZ+DN6sxqHeeQYJC0gp
         UXdsP8x7yxYn+motOonBAWWu/O8YLTHhfvjU39vDd5R3Vu68sllTJvhlFx1DehJZgJfK
         xo29Zr0Wq6QFuUSALkdsGMqxjSR+w7G/ZjJputBSXQm5uSkZY1UKYSqQbimkdaMJpFX3
         KXVWB00Jysfv6Y+japygpqwozv35cK2QwSwPrk4XfP+Vfuw5MAJMqv4LmrAzuTI61CRT
         Ykmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6ZztkKitApUlwV+ZX0Zt+Hf87PA0Zib6OW8N+QCBqM=;
        b=IisfCHLX1JMVFasXUhJTVVPINZSMLwU4Q4y5F3FE//5bIo34i8v+ZzEnkJDgStfpfu
         nJ7pAzDGJ63+U36lcB+y2jdWd6bIlf/2hdvwJsumtzYkkW1eAJHUQoCVPaAON2ihlyem
         Ou8BEF/IWqyxdDfCOuT5ixeZCKWSgjYYB5y7RSuvZv1akFu3bkrCjL+pDnDoqdklX20C
         2ydNm6rSSBMNwtbUNYl2jawuyFFUWNWo43yRVtEmk7gvbXhMWZPW3OZ9Tc9vDVDryc4l
         DuK918/OfAxCxIrWpQX/MPx4KdqE5Vqzb7j34MnnDd8o7/IWfvPROHFjpd8Foyh+TqcH
         oLAQ==
X-Gm-Message-State: AOAM533yygp7HHgh/LY0skflv+K3aJ/ZqWe43JtGQBIoen2MVnhycIyL
        FaigX4XepcYFynqT2ss+54o=
X-Google-Smtp-Source: ABdhPJxdxS/JxHTibt9uGmlF1XjwT6ZAbA+EmmReynT0Zhv+da9t0oBhGD9valDYDz1kkvoZeeUvMg==
X-Received: by 2002:ac8:14a:: with SMTP id f10mr4828355qtg.232.1598050270120;
        Fri, 21 Aug 2020 15:51:10 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id o17sm3367235qtr.13.2020.08.21.15.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 15:51:09 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <eli@mellanox.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] vdpa/mlx5: Avoid warnings about shifts on 32-bit platforms
Date:   Fri, 21 Aug 2020 15:50:19 -0700
Message-Id: <20200821225018.940798-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns several times when building for 32-bit ARM along the lines
of:

drivers/vdpa/mlx5/net/mlx5_vnet.c:1462:31: warning: shift count >= width
of type [-Wshift-count-overflow]
                ndev->mvdev.mlx_features |= BIT(VIRTIO_F_VERSION_1);
                                            ^~~~~~~~~~~~~~~~~~~~~~~

This is related to the BIT macro, which uses an unsigned long literal,
which is 32-bit on ARM so having a shift equal to or larger than 32 will
cause this warning, such as the above, where VIRTIO_F_VERSION_1 is 32.
To avoid this, use BIT_ULL, which will be an unsigned long long. This
matches the size of the features field throughout this driver, which is
u64 so there should be no functional change.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Link: https://github.com/ClangBuiltLinux/linux/issues/1140
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 50 +++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 9df69d5efe8c..70676a6d1691 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -16,19 +16,19 @@
 #define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
 
 #define VALID_FEATURES_MASK                                                                        \
-	(BIT(VIRTIO_NET_F_CSUM) | BIT(VIRTIO_NET_F_GUEST_CSUM) |                                   \
-	 BIT(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT(VIRTIO_NET_F_MTU) | BIT(VIRTIO_NET_F_MAC) |   \
-	 BIT(VIRTIO_NET_F_GUEST_TSO4) | BIT(VIRTIO_NET_F_GUEST_TSO6) |                             \
-	 BIT(VIRTIO_NET_F_GUEST_ECN) | BIT(VIRTIO_NET_F_GUEST_UFO) | BIT(VIRTIO_NET_F_HOST_TSO4) | \
-	 BIT(VIRTIO_NET_F_HOST_TSO6) | BIT(VIRTIO_NET_F_HOST_ECN) | BIT(VIRTIO_NET_F_HOST_UFO) |   \
-	 BIT(VIRTIO_NET_F_MRG_RXBUF) | BIT(VIRTIO_NET_F_STATUS) | BIT(VIRTIO_NET_F_CTRL_VQ) |      \
-	 BIT(VIRTIO_NET_F_CTRL_RX) | BIT(VIRTIO_NET_F_CTRL_VLAN) |                                 \
-	 BIT(VIRTIO_NET_F_CTRL_RX_EXTRA) | BIT(VIRTIO_NET_F_GUEST_ANNOUNCE) |                      \
-	 BIT(VIRTIO_NET_F_MQ) | BIT(VIRTIO_NET_F_CTRL_MAC_ADDR) | BIT(VIRTIO_NET_F_HASH_REPORT) |  \
-	 BIT(VIRTIO_NET_F_RSS) | BIT(VIRTIO_NET_F_RSC_EXT) | BIT(VIRTIO_NET_F_STANDBY) |           \
-	 BIT(VIRTIO_NET_F_SPEED_DUPLEX) | BIT(VIRTIO_F_NOTIFY_ON_EMPTY) |                          \
-	 BIT(VIRTIO_F_ANY_LAYOUT) | BIT(VIRTIO_F_VERSION_1) | BIT(VIRTIO_F_ACCESS_PLATFORM) |      \
-	 BIT(VIRTIO_F_RING_PACKED) | BIT(VIRTIO_F_ORDER_PLATFORM) | BIT(VIRTIO_F_SR_IOV))
+	(BIT_ULL(VIRTIO_NET_F_CSUM) | BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |                                   \
+	 BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT_ULL(VIRTIO_NET_F_MTU) | BIT_ULL(VIRTIO_NET_F_MAC) |   \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) | BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |                             \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_ECN) | BIT_ULL(VIRTIO_NET_F_GUEST_UFO) | BIT_ULL(VIRTIO_NET_F_HOST_TSO4) | \
+	 BIT_ULL(VIRTIO_NET_F_HOST_TSO6) | BIT_ULL(VIRTIO_NET_F_HOST_ECN) | BIT_ULL(VIRTIO_NET_F_HOST_UFO) |   \
+	 BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) | BIT_ULL(VIRTIO_NET_F_STATUS) | BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |      \
+	 BIT_ULL(VIRTIO_NET_F_CTRL_RX) | BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |                                 \
+	 BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) | BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) |                      \
+	 BIT_ULL(VIRTIO_NET_F_MQ) | BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) | BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |  \
+	 BIT_ULL(VIRTIO_NET_F_RSS) | BIT_ULL(VIRTIO_NET_F_RSC_EXT) | BIT_ULL(VIRTIO_NET_F_STANDBY) |           \
+	 BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX) | BIT_ULL(VIRTIO_F_NOTIFY_ON_EMPTY) |                          \
+	 BIT_ULL(VIRTIO_F_ANY_LAYOUT) | BIT_ULL(VIRTIO_F_VERSION_1) | BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |      \
+	 BIT_ULL(VIRTIO_F_RING_PACKED) | BIT_ULL(VIRTIO_F_ORDER_PLATFORM) | BIT_ULL(VIRTIO_F_SR_IOV))
 
 #define VALID_STATUS_MASK                                                                          \
 	(VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK |        \
@@ -149,7 +149,7 @@ static bool mlx5_vdpa_debug;
 
 #define MLX5_LOG_VIO_FLAG(_feature)                                                                \
 	do {                                                                                       \
-		if (features & BIT(_feature))                                                      \
+		if (features & BIT_ULL(_feature))                                                  \
 			mlx5_vdpa_info(mvdev, "%s\n", #_feature);                                  \
 	} while (0)
 
@@ -750,10 +750,10 @@ static bool vq_is_tx(u16 idx)
 
 static u16 get_features_12_3(u64 features)
 {
-	return (!!(features & BIT(VIRTIO_NET_F_HOST_TSO4)) << 9) |
-	       (!!(features & BIT(VIRTIO_NET_F_HOST_TSO6)) << 8) |
-	       (!!(features & BIT(VIRTIO_NET_F_CSUM)) << 7) |
-	       (!!(features & BIT(VIRTIO_NET_F_GUEST_CSUM)) << 6);
+	return (!!(features & BIT_ULL(VIRTIO_NET_F_HOST_TSO4)) << 9) |
+	       (!!(features & BIT_ULL(VIRTIO_NET_F_HOST_TSO6)) << 8) |
+	       (!!(features & BIT_ULL(VIRTIO_NET_F_CSUM)) << 7) |
+	       (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_CSUM)) << 6);
 }
 
 static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
@@ -1439,13 +1439,13 @@ static u64 mlx_to_vritio_features(u16 dev_features)
 	u64 result = 0;
 
 	if (dev_features & MLX5_VIRTIO_NET_F_GUEST_CSUM)
-		result |= BIT(VIRTIO_NET_F_GUEST_CSUM);
+		result |= BIT_ULL(VIRTIO_NET_F_GUEST_CSUM);
 	if (dev_features & MLX5_VIRTIO_NET_F_CSUM)
-		result |= BIT(VIRTIO_NET_F_CSUM);
+		result |= BIT_ULL(VIRTIO_NET_F_CSUM);
 	if (dev_features & MLX5_VIRTIO_NET_F_HOST_TSO6)
-		result |= BIT(VIRTIO_NET_F_HOST_TSO6);
+		result |= BIT_ULL(VIRTIO_NET_F_HOST_TSO6);
 	if (dev_features & MLX5_VIRTIO_NET_F_HOST_TSO4)
-		result |= BIT(VIRTIO_NET_F_HOST_TSO4);
+		result |= BIT_ULL(VIRTIO_NET_F_HOST_TSO4);
 
 	return result;
 }
@@ -1459,15 +1459,15 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
 	dev_features = MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, device_features_bits_mask);
 	ndev->mvdev.mlx_features = mlx_to_vritio_features(dev_features);
 	if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
-		ndev->mvdev.mlx_features |= BIT(VIRTIO_F_VERSION_1);
-	ndev->mvdev.mlx_features |= BIT(VIRTIO_F_ACCESS_PLATFORM);
+		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_VERSION_1);
+	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
 	print_features(mvdev, ndev->mvdev.mlx_features, false);
 	return ndev->mvdev.mlx_features;
 }
 
 static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
 {
-	if (!(features & BIT(VIRTIO_F_ACCESS_PLATFORM)))
+	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
 		return -EOPNOTSUPP;
 
 	return 0;

base-commit: 8a7c3213db068135e816a6a517157de6443290d6
-- 
2.28.0

