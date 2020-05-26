Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D925DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45192088E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K3VhsR5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388804AbgEZK72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388680AbgEZK71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:59:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53AAC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:59:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j21so9922083pgb.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Ou0qlu1mCa7PnwmjPJaB3DW9DwrRU3q8YGJo9GcDus=;
        b=K3VhsR5LEfuu1zhCWSX8ZDiZ3ZxIlG7BA/03u2JIL4mG0pKb21JzuhyouVbtkkWOxd
         zJS6OCY+FQ6P+e3aeiFTRfUQmzH3/gsnFD50DgO5tGr1qoja2y1HvgRC2Pw7TqGI63LP
         4TJzSsDw/kvWPaVNrvmgbUvep6sybaicYksX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Ou0qlu1mCa7PnwmjPJaB3DW9DwrRU3q8YGJo9GcDus=;
        b=JGVsY/Xw6TiO+yXZPQ2uMyJhqxfW24paY0s0LVbxEEaKwWLmjuEdyTg70kKOqlhr8V
         b0EvtL/bxv9JP/gZ4LCQibQiVp5wPr/VJ6IA14+id6SHwgFO4SROvtIhZbciY58or7J4
         QjLwsgmAnLgsY9B/0AmeighqZDxSX0CK5KvgFrQnyi0oG6GhcbDnH9On3NngTs9IhLyp
         6EaND7YL5b7S/m//jYEVXkZBTAH3JgegkQn3TE1TPjHEOCFqtzlaWA0UxrhgCKogX3YF
         22nH76O0AtChsRHzwKRGhJe6jP4rAW1YVKzauMZovqG18QFEE5gi9b7uIqPyP/KxYgst
         rdQA==
X-Gm-Message-State: AOAM533FDO8FCOnRFud++TuDaAcwEtSn2+y9srPBhLkov5DtJZT5LapD
        uP5QfV/m2eFnFpDCP760GLvzLw==
X-Google-Smtp-Source: ABdhPJxwt+9IRBaAm+bRoOfanDBMpGRNfprsaYldgxiuYvSUYxg+AZzdBZXgODn2wqRHGF504ZOpYQ==
X-Received: by 2002:a63:2246:: with SMTP id t6mr502754pgm.211.1590490766229;
        Tue, 26 May 2020 03:59:26 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:30f2:7a9c:387e:6c7])
        by smtp.gmail.com with ESMTPSA id x13sm14637864pjr.20.2020.05.26.03.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 03:59:25 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
To:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Stevens <stevensd@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        virtio-dev@lists.oasis-open.org
Subject: [PATCH v4 0/3] Support virtio cross-device resources
Date:   Tue, 26 May 2020 19:58:08 +0900
Message-Id: <20200526105811.30784-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
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

v3 -> v4 changes:
 - Replace dma-buf hooks with virtio dma-buf from v1.
 - Remove virtio_attach callback, as the work that had been done
   in that callback is now done on dma-buf export. The documented
   requirement that get_uuid only be called on attached virtio
   dma-bufs is also removed.
 - Rebase and add call to virtio_gpu_notify for ASSIGN_UUID.

David Stevens (3):
  virtio: add dma-buf support for exported objects
  virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
  drm/virtio: Support virtgpu exported resources

 drivers/gpu/drm/virtio/virtgpu_drv.c   |  3 +
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 20 ++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   |  4 ++
 drivers/gpu/drm/virtio/virtgpu_prime.c | 98 +++++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 55 +++++++++++++++
 drivers/virtio/Makefile                |  2 +-
 drivers/virtio/virtio.c                |  6 ++
 drivers/virtio/virtio_dma_buf.c        | 91 ++++++++++++++++++++++++
 include/linux/virtio.h                 |  1 +
 include/linux/virtio_dma_buf.h         | 58 +++++++++++++++
 include/uapi/linux/virtio_gpu.h        | 19 +++++
 11 files changed, 353 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_dma_buf.c
 create mode 100644 include/linux/virtio_dma_buf.h

-- 
2.27.0.rc0.183.gde8f92d652-goog

