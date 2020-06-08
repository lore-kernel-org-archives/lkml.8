Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFCAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C1E2078D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8+gs2el"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbgFHPRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:17:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55680 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728591AbgFHPR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591629447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hGKEH1dhLlDad944CTVO7vApiXCC7og9k/LEAwnlxtw=;
        b=A8+gs2el5RBoxqjjoc5bsJNPcn+wbSVtitbFs+5czDHk2bhCJA1o7BfrADa2YU3Z2qkzIu
        8aYUIX1ttaQe87sJARGk8hVLidyj983HAzxuMKB06k/L1i6csTJ92MgD3izOVteq6RBjwb
        H3pf4b1jJPvS6TLNLFflT5GgI5x9Re8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-XWoblf8NNfmnGtO4N4aFpQ-1; Mon, 08 Jun 2020 11:17:23 -0400
X-MC-Unique: XWoblf8NNfmnGtO4N4aFpQ-1
Received: by mail-wm1-f70.google.com with SMTP id g84so5370278wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hGKEH1dhLlDad944CTVO7vApiXCC7og9k/LEAwnlxtw=;
        b=nLLI6niTxwDnNMHmp5zGjkOEVe0pEKNjXyi0jwNbr3t/F1lvhf4wUu1bBkYV9iDd+M
         TwOEx2tDXbjuv3U4a1leVJPyGuPRnHylbM/i4onW7YNEvikUVdVXCuP2QEjZZDEqOsd7
         0vE1e9e667Jz6gF6zBC1vplbsSZb58HdBv87vyYprvtcDA6dUjGZjj34O5mMfyeIbc5e
         fMKQFfv2V3UeOaiiwkVHKEoP6m+QFvI/YzDz/BdmpR7mBFXIqyShIZ47jfYKxf2LGZCE
         EfNQr4pAcINF5CX+rRacL9AUlDL2QGbRUyWjsZdWOqC/fB72zzqOwOj/GGj6P7GXNwt7
         xq0g==
X-Gm-Message-State: AOAM5313safmoNUi6122Q0gOlkveKGSCf946jb3JMWx2zxJKLXd9HTCR
        maMfgG7O2puminqSwZVZMBaaqgBedsW/uFiD3BK5LTVRzYFcExSX1LuaIJl446SU2Nfv+DxTqSb
        ObSvBqgM0HMj0rn4KFhQHz63K
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr25340211wrs.313.1591629442406;
        Mon, 08 Jun 2020 08:17:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXf+wDGo8rFUPMEZIpkA8dnO+aIv3ypXkkQNVdstQgDrqG+2iMjbON1WrY0DIT27qSEK9x+g==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr25340181wrs.313.1591629442198;
        Mon, 08 Jun 2020 08:17:22 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id h29sm24085wrc.78.2020.06.08.08.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:17:21 -0700 (PDT)
Date:   Mon, 8 Jun 2020 11:17:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Stevens <stevensd@chromium.org>
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
Subject: Re: [PATCH v3 4/4] drm/virtio: Support virtgpu exported resources
Message-ID: <20200608111647-mutt-send-email-mst@kernel.org>
References: <20200311112004.47138-1-stevensd@chromium.org>
 <20200311112004.47138-5-stevensd@chromium.org>
 <20200513123326-mutt-send-email-mst@kernel.org>
 <CAD=HUj5qcMLw__LfJizR6nzCR9Qmu21Sjk3i0j_8+=rxt1Hk=w@mail.gmail.com>
 <20200608054234-mutt-send-email-mst@kernel.org>
 <CAD=HUj6kF2JFyC9c0CY5_f-cv6r97501Z2f8D9x0VhQpRen+bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=HUj6kF2JFyC9c0CY5_f-cv6r97501Z2f8D9x0VhQpRen+bw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 07:36:55PM +0900, David Stevens wrote:
> On Mon, Jun 8, 2020 at 6:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, May 15, 2020 at 04:26:15PM +0900, David Stevens wrote:
> > > > > +     if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_UUID)) {
> > > > > +             vgdev->has_resource_assign_uuid = true;
> > > > > +     }
> > > >
> > > >
> > > > Just a question: this relies on DMA bufs so I assume it is
> > > > not really assumed to work when DMA API is bypassed, right?
> > > > Rather than worry what does it mean, how about just
> > > > disabling  this feature without PLATFORM_DMA for now?
> > >
> > > By PLATFORM_DMA, do you mean CONFIG_DMA_SHARED_BUFFER?
> >
> > Sorry, no. I mean VIRTIO_F_IOMMU_PLATFORM which in the
> > future will be renamed to VIRTIO_F_PLATFORM_ACCESS.
> 
> Shouldn't things work independent of whether or not that feature is
> set? If a virtio driver properly uses the dma_buf APIs (which virtgpu
> seems to), then that should take care of any mapping/synchronization
> related to VIRTIO_F_IOMMU_PLATFORM. If anything, the case where
> VIRTIO_F_IOMMU_PLATFORM isn't set is easier, since then we know that
> the "the device has same access [sic] to memory addresses supplied to
> it as the driver has", according to the specification.
> 
> -David

I don't know much about drm so I can't tell, I was hoping Gerd can
explain.

-- 
MST

