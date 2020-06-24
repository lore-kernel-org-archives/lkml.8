Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6AEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418D220C09
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvE8GkRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbgFXXVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:21:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34993 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728035AbgFXXVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593040884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=HVbEuEGkVIuG5NhNxqmnGS+9NKLEk9a8dY03A8fYLyw=;
        b=QvE8GkRTfZMdmrdAMrMgjbXA7gP2YqsHB2zgWjYszi3jk2e1q4dlTH/xrRqhq8yboekufG
        8ltY3FX8SohPn234Qm7C5UcqZbeezri1spg/SeXPxw+18Iz7hZOtpEWIuCrT+eu1abaUkw
        /592iYkL+rezMxBWu0f2iN8lKYqfhI4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-CyGzLeZPO_qPrbmYp7haCQ-1; Wed, 24 Jun 2020 19:21:22 -0400
X-MC-Unique: CyGzLeZPO_qPrbmYp7haCQ-1
Received: by mail-wm1-f69.google.com with SMTP id s134so4867270wme.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HVbEuEGkVIuG5NhNxqmnGS+9NKLEk9a8dY03A8fYLyw=;
        b=gPdQRPnL9lFtbLTnEcy5LtEaW9mrASGkmQTxHcnp+uFOerxQYkaw+clfKxTjFsq96H
         USnPLgs33bVk1bL+7rFNpHnht7EuLcdYC0wedzDklhaHDr/kp9RuTSY8M3FWd+b9gt8F
         i1PanKmby2CRhtmi0PPPzWixaed3eW8Yr++/ZP0JKNRutrXIhSlaNxiZJIGs1yzcjyHz
         LpEq99hRt7D95T0CcVXsNX6+z42gjOJIthnOZKI/lT7TXQh/yjNYN/nGMvbgGysDqeQM
         13ZKmpOv/QcrFWw/kmWa8CSWZGqfiqp9fnbxXj0hyqAbx0A39p3knVTLKt1MT4uKNPn6
         e9hA==
X-Gm-Message-State: AOAM532FaVcY3hLroLgFYZnibdDyUZDcoqo9Yg5NWWzqckuLnk2weU0o
        vnNyrwRYcsDSFxQZSZ2tyQe7zFboiXkNVVG2RJVk0cueJLB6CjpVVp8U3bQtxliKfnMOjA/E/J0
        rSuLCMC9z2Pjmvb/tlXPOKxVo
X-Received: by 2002:a1c:f203:: with SMTP id s3mr167749wmc.126.1593040881218;
        Wed, 24 Jun 2020 16:21:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyM0cktsDl5CrWaaOPv+1nYAYm4w3v8Sv0284TWIxv5uQ05SVVcH6miZb9gN0YuAb6dFYTBHA==
X-Received: by 2002:a1c:f203:: with SMTP id s3mr167730wmc.126.1593040881042;
        Wed, 24 Jun 2020 16:21:21 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id c25sm9717109wml.46.2020.06.24.16.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 16:21:20 -0700 (PDT)
Date:   Wed, 24 Jun 2020 19:21:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/2] virtio: modernize DMA quirks
Message-ID: <20200624232035.704217-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic names for the quirks to make it clear it is not just about
the IOMMU, it's about DMA access in general.

changes from v1:
	added patch 2

Michael S. Tsirkin (2):
  virtio: VIRTIO_F_IOMMU_PLATFORM -> VIRTIO_F_ACCESS_PLATFORM
  virtio: virtio_has_iommu_quirk -> virtio_has_dma_quirk

 arch/um/drivers/virtio_uml.c            |  2 +-
 drivers/gpu/drm/virtio/virtgpu_object.c |  2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c     |  4 ++--
 drivers/vdpa/ifcvf/ifcvf_base.h         |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c        |  4 ++--
 drivers/vhost/net.c                     |  4 ++--
 drivers/vhost/vdpa.c                    |  2 +-
 drivers/virtio/virtio_balloon.c         |  2 +-
 drivers/virtio/virtio_ring.c            |  4 ++--
 include/linux/virtio_config.h           |  6 +++---
 include/uapi/linux/virtio_config.h      | 10 +++++++---
 tools/virtio/linux/virtio_config.h      |  6 +++---
 12 files changed, 26 insertions(+), 22 deletions(-)

-- 
MST

