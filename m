Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8BCC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FB0208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fBOA7Z4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgCKLUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:20:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36042 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgCKLUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:20:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id i13so1155318pfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KxW/JHv7DCd6LJdHZguy7LpVn/rmry23ZMXy1XI084k=;
        b=fBOA7Z4/VSkvDegFBNVqp2pLUAlgBxRv5RhOTNT8p2xHiAPXkjWsHMTxUl1BPV00zJ
         vMY5dhyEKkfjXmFfYLzpD5a73p+KDdMSaC4nhV9dQ1R32BqiNxXeCSXBpA7Ii2Wer4pC
         VDfF4BA+tuEYJwFmE32LvvNq/AN2GVAmGN3hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KxW/JHv7DCd6LJdHZguy7LpVn/rmry23ZMXy1XI084k=;
        b=V63AFGj7hKySR3UVWdCj1zReqEG6MRdDXyMM4xt1aTftSMb/gBTfojseKbuFZTS+t1
         S5dECt9+5mLE4RMuTPOQu+TI6uqEdi5jwTvJFvINfju0uJYmrS+QgwrnvXBxnbUQPrLu
         pkW3k6sE++sMuGup9AGQIhbddWd3hzwtJgjMGLqvmjUO087iBiucEM0hd/YT838lP5kR
         OdukMPRXTStEO3sKno9UuRhGMR0rDzPzhqtWJY/2uE5gdX1taD0dWvuw8Hd60PsA8dRO
         GFlZVrl8sQXJFzMtr8Fqiu85zihKnUNzjQsod4knny9QOM2udt2R/LzmLxQ6iVgZiT6m
         X9rg==
X-Gm-Message-State: ANhLgQ0VEEv2CA0mk2ySa/OakGJkGcS9GQJTJBZtUpqXpmaY1SCl6Kkl
        F8HlEiyR2ZO5tqADzfiNNd9syg==
X-Google-Smtp-Source: ADFU+vvUUJsm4mKY+53aHHx0GkxoPfHJ2XfB3hmp2HvE1iN3ACnAA15TuK1aSNIfg+893OuM9NF9eQ==
X-Received: by 2002:a63:4d6:: with SMTP id 205mr2392870pge.10.1583925617855;
        Wed, 11 Mar 2020 04:20:17 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:30f2:7a9c:387e:6c7])
        by smtp.gmail.com with ESMTPSA id e12sm35842384pff.168.2020.03.11.04.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 04:20:17 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
To:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Stevens <stevensd@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        virtio-dev@lists.oasis-open.org
Subject: [PATCH v3 0/4] Support virtio cross-device resources
Date:   Wed, 11 Mar 2020 20:20:00 +0900
Message-Id: <20200311112004.47138-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements the current proposal for virtio cross-device
resource sharing [1], with minor changes based on recent comments. It
is expected that this will be used to import virtio resources into the
virtio-video driver currently under discussion [2].

This patchset adds a new hook to dma-buf, for querying the dma-buf's
underlying virtio UUID. This hook is then plumbed through DRM PRIME
buffers, and finally implemented in virtgpu.

[1] https://markmail.org/thread/jsaoqy7phrqdcpqu
[2] https://markmail.org/thread/p5d3k566srtdtute

v2 -> v3 changes:
 - Remove ifdefs.
 - Simplify virtgpu_gem_prime_export as it can only be called once.
 - Use virtio_gpu_vbuffer's objs field instead of abusing data_buf.

David Stevens (4):
  dma-buf: add support for virtio exported objects
  drm/prime: add support for virtio exported objects
  virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
  drm/virtio: Support virtgpu exported resources

 drivers/dma-buf/dma-buf.c              | 12 ++++++
 drivers/gpu/drm/drm_prime.c            | 23 +++++++++++
 drivers/gpu/drm/virtio/virtgpu_drv.c   |  3 ++
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 18 +++++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   |  4 ++
 drivers/gpu/drm/virtio/virtgpu_prime.c | 41 +++++++++++++++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 55 ++++++++++++++++++++++++++
 include/drm/drm_drv.h                  | 10 +++++
 include/linux/dma-buf.h                | 18 +++++++++
 include/uapi/linux/virtio_gpu.h        | 19 +++++++++
 10 files changed, 200 insertions(+), 3 deletions(-)

-- 
2.25.1.481.gfbce0eb801-goog

