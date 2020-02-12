Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6044BC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FDC20714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bw4Q030w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgBLITK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:19:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60704 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728287AbgBLITK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581495549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EoDtK+hRJA9oLfg2EbJN/Grnn0SbIx7vrfQip2G4KnY=;
        b=bw4Q030wwjkAPODS/D8hlugvKFRpSw4GD8PMqh4m7Sn9KOpvmW9acKes84xEE/M2aHEiAv
        gKWkQtQ4FL5CYh+MWM2OZNVEC28f00LjmsZw85eOAdH4c39uoQkomyFDZpSYA480c3S7/x
        8fkTyyUksn9lgYXDVwlo/9yVRiGZjx0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-UEv4Cx2IPriwFyM1Ps2M_g-1; Wed, 12 Feb 2020 03:19:03 -0500
X-MC-Unique: UEv4Cx2IPriwFyM1Ps2M_g-1
Received: by mail-qt1-f199.google.com with SMTP id n4so775614qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EoDtK+hRJA9oLfg2EbJN/Grnn0SbIx7vrfQip2G4KnY=;
        b=dwGxXLoCNBLbrZDKhJYsSlDuXrtwGAQhHL/cedGGu6tA+INt1sEFI9nkqO7EJDp0dN
         BfGFLIVr66XhMxyH7ZLMsOsRY8Jlt+CylyIqejTEExc07e5sH4ei1c9rfstt8wJWyMQT
         u+AKLyLSLRAY2YDD4wRg1eiRrKLWb12+z6YzjxYdazdvk0HmiTmCRkc4CDFeAwMdR65w
         2fQt7eySPGXa/4Xa9DbK2SEqH7J3xkwSrcJb7HX+FDsPC8fjx7d90Uwh9uBY+MNl29Yb
         zR+Z1WaKHwXfVIXn3u9Z/8a51qRYtp8RHp4hWQGFyZFGxSi8tq4jOpDEInla4BNYuWue
         Fnow==
X-Gm-Message-State: APjAAAXyy6KCs6GlCnbzdTL/O4Q8+7t9yB9/Ro0l75PqX9mFGauxS9JW
        ZOPuRSzdW6IwaNUecitwFSXndIZtuz6SczoXwr905sGXiV+LL2rA1BBaE4JBMouQX5QpFXqSbge
        Wgl1/hTWlmVqmLyrsWIpXa0bq
X-Received: by 2002:ae9:eb4b:: with SMTP id b72mr5998864qkg.316.1581495543146;
        Wed, 12 Feb 2020 00:19:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwTyMar0/OsjMBaqlOf+gA2ZS0CQ7snrBolXpR8Rj24500NDWQIaqutLJBRjx+fU7ShGzK/6w==
X-Received: by 2002:ae9:eb4b:: with SMTP id b72mr5998856qkg.316.1581495542934;
        Wed, 12 Feb 2020 00:19:02 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id d197sm3455610qkc.16.2020.02.12.00.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 00:19:02 -0800 (PST)
Date:   Wed, 12 Feb 2020 03:18:57 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Zha Bin <zhabin@linux.alibaba.com>,
        virtio-dev@lists.oasis-open.org, slp@redhat.com,
        jing2.liu@linux.intel.com, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, chao.p.peng@linux.intel.com,
        gerry@linux.alibaba.com
Subject: Re: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
Message-ID: <20200212024158-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
 <20200211062205-mutt-send-email-mst@kernel.org>
 <ef613d3a-0372-64f3-7644-2e88cc9d4355@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef613d3a-0372-64f3-7644-2e88cc9d4355@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 11:39:54AM +0800, Jason Wang wrote:
> 
> On 2020/2/11 下午7:33, Michael S. Tsirkin wrote:
> > On Mon, Feb 10, 2020 at 05:05:17PM +0800, Zha Bin wrote:
> > > From: Liu Jiang<gerry@linux.alibaba.com>
> > > 
> > > The standard virtio-mmio devices use notification register to signal
> > > backend. This will cause vmexits and slow down the performance when we
> > > passthrough the virtio-mmio devices to guest virtual machines.
> > > We proposed to update virtio over MMIO spec to add the per-queue
> > > notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the VMM to
> > > configure notify location for each queue.
> > > 
> > > [1]https://lkml.org/lkml/2020/1/21/31
> > > 
> > > Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
> > > Co-developed-by: Zha Bin<zhabin@linux.alibaba.com>
> > > Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
> > > Co-developed-by: Jing Liu<jing2.liu@linux.intel.com>
> > > Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
> > > Co-developed-by: Chao Peng<chao.p.peng@linux.intel.com>
> > > Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
> > Hmm. Any way to make this static so we don't need
> > base and multiplier?
> 
> 
> E.g page per vq?
> 
> Thanks

Problem is, is page size well defined enough?
Are there cases where guest and host page sizes differ?
I suspect there might be.

But I also think this whole patch is unproven. Is someone actually
working on QEMU code to support pass-trough of virtio-pci
as virtio-mmio for nested guests? What's the performance
gain like?

-- 
MST

