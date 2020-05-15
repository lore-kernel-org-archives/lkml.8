Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6420C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0EDC20657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QDWBz3RU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgEOH02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726434AbgEOH02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:26:28 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21405C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:26:28 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id g20so606672qvb.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQ+8bQqVXCGgiMZpHhx8CRsJZ+7vvYouTuTdyPbncmE=;
        b=QDWBz3RUFZANTCfesmQRxLfudLR6lDXvkwQiP0JZK/Zi3SINJJlPUbU6EqOQgQFhj3
         jneZ5wcaAmgNP6xRm91oVntIzCcCm4+IDgxkpG7k2AMTSmKapOyCRKa6SzRWtAkIlknt
         3Vjoy1l/UAQSqOIQpSYl083UGeHjb01hQBypU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQ+8bQqVXCGgiMZpHhx8CRsJZ+7vvYouTuTdyPbncmE=;
        b=sYKSwqgzDtNOV5Fecwnjz8UGBWHK1V3dj5e1WZBVfaQ//HiG9AH8atkucSKZI57O2v
         xiwtiyrNbjFUVyHb28qWQX6RM61D5eafkS7oa6l/8vVaiU7UJyvDzLmTOz+7q5A3PQ7P
         8JAwlHwzJAbu6h2KFBTzq3/2xpIWe22kvSfA3I2bub24H6Vdu3UltZCIUCGfPbBxZ7J4
         Og7h0doTP0vrmYSxXEs+ruDAmfRs29PBsDaemvZHQ0R0eYxuHUqwaC4q3bhoK368pwsn
         tSWXn5MF93xqXNbuSvNI05bZaO60Tb0WwZ2djtBRoIhjefs8nTj/6niEOKUJkewqAne9
         EA6g==
X-Gm-Message-State: AOAM530r+AcgRHjqQFZY1LtSvucvvDtzVV6+Ur2GWLrPCcjui20q6wGz
        yXnzmZGs6MuvN9joW6FdFiRPOVbK+57bb/ih2fmu3T1Yz5U=
X-Google-Smtp-Source: ABdhPJx1EFKHl7a6Wvqqoe4z/fgmS4Q3vrumNb01ocuJbWu2dJGymSisslGXpi2Jk+BTqytlgb0JT5aqQU+B+OWZaAw=
X-Received: by 2002:ad4:580b:: with SMTP id dd11mr2192873qvb.145.1589527587111;
 Fri, 15 May 2020 00:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200311112004.47138-1-stevensd@chromium.org> <20200311112004.47138-5-stevensd@chromium.org>
 <20200513123326-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200513123326-mutt-send-email-mst@kernel.org>
From:   David Stevens <stevensd@chromium.org>
Date:   Fri, 15 May 2020 16:26:15 +0900
Message-ID: <CAD=HUj5qcMLw__LfJizR6nzCR9Qmu21Sjk3i0j_8+=rxt1Hk=w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/virtio: Support virtgpu exported resources
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jason Wang <jasowang@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +     if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_UUID)) {
> > +             vgdev->has_resource_assign_uuid = true;
> > +     }
>
>
> Just a question: this relies on DMA bufs so I assume it is
> not really assumed to work when DMA API is bypassed, right?
> Rather than worry what does it mean, how about just
> disabling  this feature without PLATFORM_DMA for now?

By PLATFORM_DMA, do you mean CONFIG_DMA_SHARED_BUFFER? Virtio-gpu
depends on DRM, which selects that feature. So I think DMA bufs should
always be available when virtio-gpu is present.

-David
