Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31E3C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5DA2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nb0J2Xyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSIIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:08:17 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40280 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBSIIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:08:16 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so2204815pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 00:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eDEEn06gGe3wz7Pt5Sy7Iqux/1AIKbtlqlkTn71Oy4k=;
        b=Nb0J2Xyp5yfAHRANQeHIM9Bhe1mDPndS/8VRCMtVIO7WP2mPoXO7nq0sWc55gXRTfK
         faA/psEl79dEmvXeFu/v0EqEL7MiOU0dNsB+D97gDKuHmJhxcDJ4lXeJb/HjVRFWehHy
         ADEkYgAsVtcvH2QNrCYYERUN/CgxqKAr88vWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eDEEn06gGe3wz7Pt5Sy7Iqux/1AIKbtlqlkTn71Oy4k=;
        b=BT0n1GmSBkg6fMYh5e3I66acezeIDDN1zYxyuRgoGVHQL6GoQYGWpqNGlxFtd/JNvA
         7vCQyc9hfhilZE55jnNdVe+leWIToG6vUtZsHCxxPpIF8MnEFO9HMdGLkOuc18WRutDa
         IRVLXUkFMA0JNuXf04Gbkn/cXrlX5zhXHd0SnTG/MyD/pTOfxFxOFWH2VJzO8q2kwEML
         0u9Iq1VpdGIqsBqL+mXfqt7Rh31eomyVT0ZtYSMb3tcvkZ90h8WDOE/0tfS7F3Hf+8PF
         KX1jABMM8aLmBjf5+jLo47rHPVp7cbi7pKqt5O04nOywSOLvC1v/YZzS04vHYmCepG1Y
         jUhQ==
X-Gm-Message-State: APjAAAXSBeR4speRKd2Dn9AyVSJr33Q0S2AFVUA5euh8fBn873J2vv6z
        PUjf9+fsTHaMAJixv26BaPySXA==
X-Google-Smtp-Source: APXvYqzOZKpamAABfdMJ/fDZQ0VlsPGfT9UmaFnev4sLY13+z4pxoduWq15xXgZAbVThF3gN2BNn5g==
X-Received: by 2002:a17:902:7406:: with SMTP id g6mr25130286pll.103.1582099696282;
        Wed, 19 Feb 2020 00:08:16 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1f16:51f4:8631:68b2])
        by smtp.gmail.com with ESMTPSA id ci5sm1484267pjb.5.2020.02.19.00.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 00:08:15 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
To:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        David Stevens <stevensd@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        virtio-dev@lists.oasis-open.org
Subject: [PATCH 0/2] Support virtio cross-device resources
Date:   Wed, 19 Feb 2020 17:06:35 +0900
Message-Id: <20200219080637.61312-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements the current proposal for virtio cross-device
resource sharing [1], with minor changes based on recent comments (i.e.
renumbering the new virtio gpu command and adding a feature flag).

The patchset adds a new flavor of dma-bufs that supports querying the
underlying virtio object UUID, as well as adding support for exporting
resources from virtgpu. It is expected that this will be used to import
virtgpu resources into the virtio-video driver currently under
discussion [2].

[1] https://markmail.org/thread/jsaoqy7phrqdcpqu
[2] https://markmail.org/thread/p5d3k566srtdtute

David Stevens (2):
  virtio: add dma-buf support for exported objects
  drm/virtio: Support virtgpu exported resources

 drivers/gpu/drm/virtio/virtgpu_drv.c   |   3 +
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  21 +++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   |   4 +
 drivers/gpu/drm/virtio/virtgpu_prime.c | 109 ++++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c    |  58 +++++++++++++
 drivers/virtio/Makefile                |   2 +-
 drivers/virtio/virtio.c                |   6 ++
 drivers/virtio/virtio_dma_buf.c        |  97 ++++++++++++++++++++++
 include/linux/virtio.h                 |   1 +
 include/linux/virtio_dma_buf.h         |  62 ++++++++++++++
 include/uapi/linux/virtio_gpu.h        |  19 +++++
 11 files changed, 378 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_dma_buf.c
 create mode 100644 include/linux/virtio_dma_buf.h

-- 
2.25.0.265.gbab2e86ba0-goog

