Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5CBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B51207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV90BGj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgFIJxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:53:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44915 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727098AbgFIJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591696387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oMvGLtRSljs2Zi0kyxH/VTEK52jN8HKOE/cbjLGX1jw=;
        b=LV90BGj2rDt2UuftrXRQAfhVE7EZPtm/TAHHFgNcVsvI5U9pahThki7xTg0/FBaHFGjBXM
        OqIeEjslfjcOoRRiVKrF8okV0Zk6EzW9iwWPn/+rXPzWeil/4kz9S7O/NuD8N1r78/wVIK
        PxLYTO++isJZ7K+N4+UP4IeOpoa/f/g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-LkkoZ1MvNvO1HDYk_6sCFw-1; Tue, 09 Jun 2020 05:53:03 -0400
X-MC-Unique: LkkoZ1MvNvO1HDYk_6sCFw-1
Received: by mail-wr1-f70.google.com with SMTP id w4so8412191wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 02:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oMvGLtRSljs2Zi0kyxH/VTEK52jN8HKOE/cbjLGX1jw=;
        b=fIntI1E6hjhaHXz/wQrvT3/OXMunjXW40pA57DqlQ5+JbUJZJ9q1ZsUnvViNDopmFq
         wEI6vbKsT1+RRH1JYzNb1JguunjOcf2lcyPbEV0DmUODa9ab/9DXM3juxeuVL+/z7gzZ
         17rNl9xDk2RJseU14ZsQQs9SDQl/Bi3GPk2KxwetMW/59ErkIUEwAVXBaZb14gh1FOb6
         HD6Q1ji3Ow/jF/9DLp/qrrtdrteVgNBGj14jtUel3vEVeoTppkKKJswV7v7xnzBPqgWZ
         ts3Q6dNZocq4f6FiG5SznSrGB4QCgiaUxg7qXBWfbB2YVl9NN/5H7A/C5FYG0wDyZorK
         A+IA==
X-Gm-Message-State: AOAM533gG/xB/mZqdBC/xw1o0y1o1zX+OgRS24gfKS75kMpOXLiDo3O/
        0sUzLvK0yBiYSwBNxHbZ9XTzNFZNEiDB6slFrx7BrtjYbrfhe685AHJPm//jFfehoHlWsGv/q6D
        6YKRtWZN7CqcKPWo3I0z47FOm
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr3491098wrx.61.1591696382276;
        Tue, 09 Jun 2020 02:53:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTG/Rft+RF7BlhKs9JeSNR5jpou7mamttZASGBrZIBust8+KQxMGXJalHNlqYd1izJlcOHBg==
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr3491075wrx.61.1591696382101;
        Tue, 09 Jun 2020 02:53:02 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id 67sm2834452wrk.49.2020.06.09.02.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 02:53:01 -0700 (PDT)
Date:   Tue, 9 Jun 2020 05:52:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com
Subject: Re: [PATCH v5 0/3] Support virtio cross-device resources
Message-ID: <20200609055021-mutt-send-email-mst@kernel.org>
References: <20200609012518.198908-1-stevensd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609012518.198908-1-stevensd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 10:25:15AM +0900, David Stevens wrote:
> This patchset implements the current proposal for virtio cross-device
> resource sharing [1]. It will be used to import virtio resources into
> the virtio-video driver currently under discussion [2]. The patch
> under consideration to add support in the virtio-video driver is [3].
> It uses the APIs from v3 of this series, but the changes to update it
> are relatively minor.
> 
> This patchset adds a new flavor of dma-bufs that supports querying the
> underlying virtio object UUID, as well as adding support for exporting
> resources from virtgpu.

Gerd, David, if possible, please test this in configuration with
virtual VTD enabled but with iommu_platform=off
to make sure we didn't break this config.


Besides that, for virtio parts:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> [1] https://markmail.org/thread/2ypjt5cfeu3m6lxu
> [2] https://markmail.org/thread/p5d3k566srtdtute
> [3] https://markmail.org/thread/j4xlqaaim266qpks
> 
> v4 -> v5 changes:
>  - Remove virtio_dma_buf_export_info.
> 
> David Stevens (3):
>   virtio: add dma-buf support for exported objects
>   virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
>   drm/virtio: Support virtgpu exported resources
> 
>  drivers/gpu/drm/virtio/virtgpu_drv.c   |  3 +
>  drivers/gpu/drm/virtio/virtgpu_drv.h   | 20 ++++++
>  drivers/gpu/drm/virtio/virtgpu_kms.c   |  4 ++
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 96 +++++++++++++++++++++++++-
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 55 +++++++++++++++
>  drivers/virtio/Makefile                |  2 +-
>  drivers/virtio/virtio.c                |  6 ++
>  drivers/virtio/virtio_dma_buf.c        | 82 ++++++++++++++++++++++
>  include/linux/virtio.h                 |  1 +
>  include/linux/virtio_dma_buf.h         | 37 ++++++++++
>  include/uapi/linux/virtio_gpu.h        | 19 +++++
>  11 files changed, 321 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/virtio/virtio_dma_buf.c
>  create mode 100644 include/linux/virtio_dma_buf.h
> 
> -- 
> 2.27.0.278.ge193c7cf3a9-goog

