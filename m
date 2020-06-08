Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03395C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3212076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbwZExKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgFHJnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:43:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59648 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728745AbgFHJnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591609413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U5U6dQ9lCe7itmDsGxNs3cBdub7pl5VNIW2XNh4JFS0=;
        b=gbwZExKEyBWI2JSJdcxn0UBh1+iK9moq+tAJySJd5owC8U5r5sETBzzrHyWZdCLYLZQWWN
        1LRWMqZHH0ZdY9422EGqJH/3mtASHcnNDta4mHgNJ3mMqf45Ij48fsQo3FIqlH+jODYaCd
        DBWKz9rXZLie12bs7DIyfk3VlBGUJvk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-yiegwLabOKWkn_kv8RuloQ-1; Mon, 08 Jun 2020 05:43:32 -0400
X-MC-Unique: yiegwLabOKWkn_kv8RuloQ-1
Received: by mail-wm1-f72.google.com with SMTP id j128so5025028wmj.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 02:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U5U6dQ9lCe7itmDsGxNs3cBdub7pl5VNIW2XNh4JFS0=;
        b=iniO0BZr+xZGjl7NK4tQ6vNFw3K3lOnYZzu/Exs5djsIqepLpG4uUSsm565+jQ3kEE
         0T0NROVtR/UqJWDD1U67IkjSiSwQGYsZXI3yU7QguMqaVFtmDmh8ATLnDOj7uGwgeUQG
         EWm7HafKbDotrUDzyErGRy4yyFi0xN6Kib022Iv3ZHy2SwKarXW3QTxudg1uA2MUZzgy
         aUtYBBq1nxXVWUMpXmmgF3EO2SEnRnh7IowrPog64RDMiPxsOV4qkBmrlRZCPob7CxOm
         3HJwAET0/SE9XL2pn5ijKqdJzKeH1Knu5IKCv6OXArm+K29LHTPVx0dCGAUow8hJBSwi
         DRJA==
X-Gm-Message-State: AOAM532tJohCwokkIvjnNeEVbpzMkgxADqem4kUxKG0dvKWlQorA82WQ
        uZcZpLDQ/BDnKK7QFM5CcICAtECaWXQLDd/Ju5pc2q8ITnp/eFzUyWyXFTp+Af/Q2l57fOrfk45
        qRog4ZMgnKKwaS8aB3CBiNAgo
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr15017563wmc.1.1591609411311;
        Mon, 08 Jun 2020 02:43:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9ub5wP+xupLuBkOQ4No1b88FQ9dkWFcatrNsLpDTfEgifdZsj9YIaaEa0/E6d/CL6f3lWtw==
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr15017554wmc.1.1591609411160;
        Mon, 08 Jun 2020 02:43:31 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id u9sm18951734wme.16.2020.06.08.02.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 02:43:30 -0700 (PDT)
Date:   Mon, 8 Jun 2020 05:43:27 -0400
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
Message-ID: <20200608054234-mutt-send-email-mst@kernel.org>
References: <20200311112004.47138-1-stevensd@chromium.org>
 <20200311112004.47138-5-stevensd@chromium.org>
 <20200513123326-mutt-send-email-mst@kernel.org>
 <CAD=HUj5qcMLw__LfJizR6nzCR9Qmu21Sjk3i0j_8+=rxt1Hk=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=HUj5qcMLw__LfJizR6nzCR9Qmu21Sjk3i0j_8+=rxt1Hk=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 04:26:15PM +0900, David Stevens wrote:
> > > +     if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_UUID)) {
> > > +             vgdev->has_resource_assign_uuid = true;
> > > +     }
> >
> >
> > Just a question: this relies on DMA bufs so I assume it is
> > not really assumed to work when DMA API is bypassed, right?
> > Rather than worry what does it mean, how about just
> > disabling  this feature without PLATFORM_DMA for now?
> 
> By PLATFORM_DMA, do you mean CONFIG_DMA_SHARED_BUFFER?

Sorry, no. I mean VIRTIO_F_IOMMU_PLATFORM which in the
future will be renamed to VIRTIO_F_PLATFORM_ACCESS.


> Virtio-gpu
> depends on DRM, which selects that feature. So I think DMA bufs should
> always be available when virtio-gpu is present.
> 
> -David

