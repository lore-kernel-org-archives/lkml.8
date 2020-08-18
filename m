Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A4BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDB220658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jBhQriRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHRHNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHRHNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:13:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D89AC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 00:13:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t10so8784411plz.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 00:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BgH1OQJe0vDcind90faXlTgA3YjOyLHfHtqyBUp1Czc=;
        b=jBhQriRwN1E1G4yJ7yJ5QVDbR3yI60qfxFdNsiw1JCtEbsa6GBtVj3rXYqfrkw1aRi
         BBFDqgJ42hRBKauGzagAsCP9lo2zL3e6eFXcUOdjV3WZq3DzR1tibyoqkNwHzvl0SAos
         v5Yv2iK3XSVROgT7Y2Z9jT9El0Eh8HaHTb83E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BgH1OQJe0vDcind90faXlTgA3YjOyLHfHtqyBUp1Czc=;
        b=OpnjEWQMADjVE+pZ7ERiLRUCXNs6VTr1HBlQOTpd7fj2DohAcv+Z9BUpDxmmlszFNj
         R0JTq1rok6RI4XcDbmfUDEXbP1huH4dDjL2BcqEhR1Fptkf7UfGrOLDoucJaxW/TeLQI
         8ktNf5YonjUkq6r8L0uBOkloJWr2yAizySrg8V1AV/mNcJtA/pWQAQurZAXnDtNxT8Qf
         EK8BUcKFsTWyM08NxwhB2NL8u6fc9S5TlpNxMX9VBMPh0JMCeA5m1TDbWyOz81blzkVb
         2XEJO533d8XGa+QkM36I9H0ghfQqRispT3pqFkRLG2/KnTJac417qM1lEGCxMlvm5PF4
         KcgA==
X-Gm-Message-State: AOAM53156lkmyIw7TzoCNO+m2LtJdsGmceXtVz2wV7WThaZYuXl2p5F9
        UKkQT+R9r4EuuVgSJQ/ldv/GWQ==
X-Google-Smtp-Source: ABdhPJxuueydVbd6bk9DsX+V9TjGBCXpTewyWvogJZRb7m1T+Taz+F9x0MJK+8gr+vU6zEAzQBkJ7Q==
X-Received: by 2002:a17:90b:1c06:: with SMTP id oc6mr14823420pjb.182.1597734829705;
        Tue, 18 Aug 2020 00:13:49 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f693:9fff:fef4:a930])
        by smtp.gmail.com with ESMTPSA id g33sm15709005pgg.46.2020.08.18.00.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 00:13:49 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Stevens <stevensd@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        virtio-dev@lists.oasis-open.org
Subject: [PATCH v7 0/3] Support virtio cross-device resources
Date:   Tue, 18 Aug 2020 16:13:40 +0900
Message-Id: <20200818071343.3461203-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
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

v6 -> v7 changes:
 - Fix most strict checkpatch comments

David Stevens (3):
  virtio: add dma-buf support for exported objects
  virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
  drm/virtio: Support virtgpu exported resources

 drivers/gpu/drm/virtio/virtgpu_drv.c   |  3 +
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 21 ++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   |  4 ++
 drivers/gpu/drm/virtio/virtgpu_prime.c | 96 +++++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 55 +++++++++++++++
 drivers/virtio/Makefile                |  2 +-
 drivers/virtio/virtio.c                |  6 ++
 drivers/virtio/virtio_dma_buf.c        | 85 +++++++++++++++++++++++
 include/linux/virtio.h                 |  1 +
 include/linux/virtio_dma_buf.h         | 37 ++++++++++
 include/uapi/linux/virtio_gpu.h        | 19 +++++
 11 files changed, 325 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_dma_buf.c
 create mode 100644 include/linux/virtio_dma_buf.h

-- 
2.28.0.220.ged08abb693-goog

