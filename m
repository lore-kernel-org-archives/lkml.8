Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550A7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D2F720760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9YycLBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgFJGVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:21:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41277 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725988AbgFJGVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591770080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uc/octOGcZckR4WPK7Q59lSObyrfP0K8f0dnKbVCbdY=;
        b=M9YycLBqwJCuEeq6WDyU7g1eENOapJ45XG0LZax+WbyrApnj2V3GpBCg1NdnapZXvwoVwj
        HDQc9FsfnQRxT/+uuwhnPlWJK2L4WhM5s14oppMaYAKbWxx19t5fzMTcR2mCEkTgNQgDVW
        I3TAINql+SvJ/TFFtRsmrVmvaiGsp3M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-LjiKIw32OIKnEnZVeuwlLA-1; Wed, 10 Jun 2020 02:21:18 -0400
X-MC-Unique: LjiKIw32OIKnEnZVeuwlLA-1
Received: by mail-wm1-f72.google.com with SMTP id 14so118421wmi.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 23:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uc/octOGcZckR4WPK7Q59lSObyrfP0K8f0dnKbVCbdY=;
        b=ZR58+Lnllz6/R3Qe2/a+/CJBpO4yjrC5eoQRZLETkILPPpJgom0Wm4zJ6zeWNWy/Uv
         r8WLJvfc67hbOob4pnON3lVTeDE6scqp66Wzo6+qlnGeCbMP0mJnFkyUsnXKnxE7PWbQ
         3E55fMAd9i22JH0Omr7vVNXmu4wDnRz37fdozCAQ9cRnL86GD+9XDHV2s2jw8GC46J38
         y0DguORxaIPKzKSPitZg8iiW2mN6P+etf8/F7kYP4g7poweRkfkWqIEJLQIyk3Dat3eu
         232L+68Rzkt2xf9LdT/9BwX3I+sBwn9hK0i+OIZxee3Gv6p3b4vDa+GbtyorNbedgrEJ
         e15A==
X-Gm-Message-State: AOAM532es0SAiFOq0tX9QVLA/YtQ04S7WjfTgm3zsxb3P5LMT4vUNbRD
        9eNHIpAm28sEGZSzeoGUHhCF1viO+vhdx5STzKyjNieVpUILKHbA4FylZrzLY/Dq/8yfJZdUI+C
        CjIALGk64dK3mZPazisyDfJXz
X-Received: by 2002:a5d:6751:: with SMTP id l17mr1821671wrw.179.1591770077597;
        Tue, 09 Jun 2020 23:21:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHqdcIuVzuBGZWdx6m8Gbz3kMm+7V/vk3O+qedxAg4WyGtib2ogQ4mFQ1rkbXMLTyCZzbW6Q==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr1821589wrw.179.1591770076461;
        Tue, 09 Jun 2020 23:21:16 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id d9sm6516480wre.28.2020.06.09.23.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 23:21:16 -0700 (PDT)
Date:   Wed, 10 Jun 2020 02:21:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH RESEND V2] vdpa: introduce virtio pci driver
Message-ID: <20200610022030-mutt-send-email-mst@kernel.org>
References: <20200610054951.16197-1-jasowang@redhat.com>
 <20200610020728-mutt-send-email-mst@kernel.org>
 <0964bd2d-8329-a091-41ed-a9b912ec4283@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0964bd2d-8329-a091-41ed-a9b912ec4283@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 02:16:26PM +0800, Jason Wang wrote:
> 
> On 2020/6/10 下午2:07, Michael S. Tsirkin wrote:
> > On Wed, Jun 10, 2020 at 01:49:51PM +0800, Jason Wang wrote:
> > > This patch introduce a vDPA driver for virtio-pci device. It bridges
> > > the virtio-pci control command to the vDPA bus. This will be used for
> > > developing new features for both software vDPA framework and hardware
> > > vDPA feature.
> > > 
> > > Compared to vdpa_sim, it has several advantages:
> > > 
> > > - it's a real device driver which allow us to play with real hardware
> > >    features
> > > - type independent instead of networking specific
> > > 
> > > Note that since virtio specification does not support get/restore
> > > virtqueue state. So we can not use this driver for VM. This can be
> > > addressed by extending the virtio specification.
> > > 
> > > Consider the driver is mainly for testing and development for vDPA
> > > features, it can only be bound via dynamic ids to make sure it's not
> > > conflict with the drivers like virtio-pci or IFCVF.
> > > 
> > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > error: sha1 information is lacking or useless (drivers/vdpa/Kconfig).
> > 
> > which tree is this on top of?
> 
> 
> Your vhost.git vhost branch, HEAD is bbea3bcfd1d6 vdpa: fix typos in the
> comments for __vdpa_alloc_device()
> 
> Do I need to use other branch?
> 
> Thanks

No it's ok, I am just wondering why doesn't it apply then.

> 
> > 

