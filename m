Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42288C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031F9206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m4U6w8Hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgFIBZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgFIBZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 21:25:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F14EC03E97C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 18:25:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h95so636616pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 18:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COw8MsymzwRUQaCcvby30uu+ORzSh+2s4CK8yqEnGk0=;
        b=m4U6w8Hj6efLuU2XJFCP8IPM+30vKQRX8BKy4OU/D+DUTmyH9XKbfEELFpSz42f7a/
         a3V6e3lrKLFyYc13GVhfa4CdVD7sYJf2xvK5y5RWC823y9VUiUO/9hdCrABpETL9VLNp
         ypI6smgxA7gnRqgf3Gf8k99kM728ZEUHZIKPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COw8MsymzwRUQaCcvby30uu+ORzSh+2s4CK8yqEnGk0=;
        b=LmtRqgBzaoSwbZDcgor5GOlnSO22Q2bmD9tpn0oidVkL0kPNVR4nQ+s4FhUO6Z9eXL
         gb4GpZ5v+Ep9ZFrM/cPF+KidAaNo+pskW5Nj8ln1YaO3ItHHuDgooUqpbR7Yz6dK4k2+
         DNcMsPvUSMBk1D1zb1bNuX4H8EymQANQeKqa4c6vfzVmAVM5E/4lCNqsp862LrcxIbeJ
         h/WFJrwEmvQ15Zkqwrj76zNAbw4C17zD+Sev+Nk6IYlhX6MnTsxESht7bzDCEI9PDaKV
         D02WZHV6pBVSqLdSzV2YzVp2ybN3xsASPPynfH2KFbLMm4X983ZmrUO/MTaEDJgU9V3X
         5jJg==
X-Gm-Message-State: AOAM531mbBzBUdNkBwHKt9L4m5zSOZN80PK01l7aFTX6j6I2n87EOaMO
        WGdXEaTPkICa0Gxac4OtsixMlg==
X-Google-Smtp-Source: ABdhPJxxp3CZRZ++LaDq5ouPDTw2c1q5JXibsFXECAvthEk/ewMP/5LQ+XhXru1zBYVm40/rZfIFZw==
X-Received: by 2002:a17:902:9043:: with SMTP id w3mr1170254plz.250.1591665946907;
        Mon, 08 Jun 2020 18:25:46 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:30f2:7a9c:387e:6c7])
        by smtp.gmail.com with ESMTPSA id z23sm6716617pga.86.2020.06.08.18.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 18:25:46 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
To:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Stevens <stevensd@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        virtio-dev@lists.oasis-open.org
Subject: [PATCH v5 0/3] Support virtio cross-device resources
Date:   Tue,  9 Jun 2020 10:25:15 +0900
Message-Id: <20200609012518.198908-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements the current proposal for virtio cross-device
resource sharing [1]. It will be used to import virtio resources into
the virtio-video driver currently under discussion [2]. The patch
under consideration to add support in the virtio-video driver is [3].
It uses the APIs from v3 of this series, but the changes to update it
are relatively minor.

This patchset adds a new flavor of dma-bufs that supports querying the
underlying virtio object UUID, as well as adding support for exporting
resources from virtgpu.

[1] https://markmail.org/thread/2ypjt5cfeu3m6lxu
[2] https://markmail.org/thread/p5d3k566srtdtute
[3] https://markmail.org/thread/j4xlqaaim266qpks

v4 -> v5 changes:
 - Remove virtio_dma_buf_export_info.

David Stevens (3):
  virtio: add dma-buf support for exported objects
  virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
  drm/virtio: Support virtgpu exported resources

 drivers/gpu/drm/virtio/virtgpu_drv.c   |  3 +
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 20 ++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   |  4 ++
 drivers/gpu/drm/virtio/virtgpu_prime.c | 96 +++++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 55 +++++++++++++++
 drivers/virtio/Makefile                |  2 +-
 drivers/virtio/virtio.c                |  6 ++
 drivers/virtio/virtio_dma_buf.c        | 82 ++++++++++++++++++++++
 include/linux/virtio.h                 |  1 +
 include/linux/virtio_dma_buf.h         | 37 ++++++++++
 include/uapi/linux/virtio_gpu.h        | 19 +++++
 11 files changed, 321 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_dma_buf.c
 create mode 100644 include/linux/virtio_dma_buf.h

-- 
2.27.0.278.ge193c7cf3a9-goog

