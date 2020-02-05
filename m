Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF38C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 05:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808B421927
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 05:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyoxjiUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgBEFgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 00:36:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55162 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725385AbgBEFgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 00:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580881010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XxLib1DyGWA3n/jl6h9rliqNTP1O1RA9Yuhg5J8jnQ8=;
        b=RyoxjiUwJvI2I4ITkzXMhsmSEXwJbLsSPQTdUyivPjtYuDdowFtD4xLWCT+8/+ktVfcUs6
        qVJYpTtp7Fdg8jAx3DNDhJxmsAqibIGJ/HXKJv3n52Y08GwQL/JShhZ34Mtzj0zf6PnmXc
        KX7MTW9Sek0XnVFXNfNIELIM3yCJJxs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-qJT_nZhSN4-BsKgtWprqNQ-1; Wed, 05 Feb 2020 00:36:48 -0500
X-MC-Unique: qJT_nZhSN4-BsKgtWprqNQ-1
Received: by mail-qv1-f72.google.com with SMTP id z39so826715qve.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 21:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XxLib1DyGWA3n/jl6h9rliqNTP1O1RA9Yuhg5J8jnQ8=;
        b=sOPGjUuvZida4bGyiq1Iq4puWXBD/56Z06322TvCDIAXT/d4Ua/KPa38dR7iQ2UMIc
         HWBUCrWPvNcjitkpMLM+1KY840t0LyZzSzS8yr5Taap8jLGoT+4lJbdE21AgOmXAFRuv
         jlXQAoogofxerSlRTZLeAtfN7gMpbg954/+X94KH2c0QW27yMuzudvW30B4BAEkXXER7
         igLkg0ayEVCktzY/6q42GCPmQ4DqJ5so1Qi0wc6M7XJxdXRTJV1xaucGIHa4T6a4De9S
         jJpEfJU4j30jvBLV9+pyBe30rV/+9eBgQMER5VhAQ4sxFJ2bCBkXBGiPT0gCp0j0dMKi
         Ttaw==
X-Gm-Message-State: APjAAAW2IrfZwpt/10puRnr1pXjqRKBKt1z/4jQMKFyBGdrdXm0u0bNz
        WtMKyMWJLBGA8QXtiXPMxfOWhczAlTFZbtIbPTkVzcG2upZw9eQIWAGC8zaWQzqyM+96ijSjzIp
        phcUc3CirRW7JbdLfxXuV8WLm
X-Received: by 2002:ac8:6f09:: with SMTP id g9mr32149790qtv.275.1580881008081;
        Tue, 04 Feb 2020 21:36:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqw0rRf19uckjRT2XyuOTvPcwwSVFIB7TnwPqwZmh7xwjP4vvHrAEcKTKEeGxk7l0EPBEm80AA==
X-Received: by 2002:ac8:4e43:: with SMTP id e3mr32421061qtw.129.1580880686259;
        Tue, 04 Feb 2020 21:31:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id y145sm12328322qkb.87.2020.02.04.21.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 21:31:25 -0800 (PST)
Date:   Wed, 5 Feb 2020 00:31:18 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, shahafs@mellanox.com, jgg@mellanox.com,
        rob.miller@broadcom.com, haotian.wang@sifive.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        rdunlap@infradead.org, hch@infradead.org, jiri@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com,
        maxime.coquelin@redhat.com, lingshan.zhu@intel.com,
        dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Message-ID: <20200205003048-mutt-send-email-mst@kernel.org>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
 <20200204005306-mutt-send-email-mst@kernel.org>
 <cf485e7f-46e3-20d3-8452-e3058b885d0a@redhat.com>
 <20200205020555.GA369236@___>
 <798e5644-ca28-ee46-c953-688af9bccd3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <798e5644-ca28-ee46-c953-688af9bccd3b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 11:12:21AM +0800, Jason Wang wrote:
> 
> On 2020/2/5 上午10:05, Tiwei Bie wrote:
> > On Tue, Feb 04, 2020 at 02:46:16PM +0800, Jason Wang wrote:
> > > On 2020/2/4 下午2:01, Michael S. Tsirkin wrote:
> > > > On Tue, Feb 04, 2020 at 11:30:11AM +0800, Jason Wang wrote:
> > > > > 5) generate diffs of memory table and using IOMMU API to setup the dma
> > > > > mapping in this method
> > > > Frankly I think that's a bunch of work. Why not a MAP/UNMAP interface?
> > > > 
> > > Sure, so that basically VHOST_IOTLB_UPDATE/INVALIDATE I think?
> > Do you mean we let userspace to only use VHOST_IOTLB_UPDATE/INVALIDATE
> > to do the DMA mapping in vhost-vdpa case? When vIOMMU isn't available,
> > userspace will set msg->iova to GPA, otherwise userspace will set
> > msg->iova to GIOVA, and vhost-vdpa module will get HPA from msg->uaddr?
> > 
> > Thanks,
> > Tiwei
> 
> 
> I think so. Michael, do you think this makes sense?
> 
> Thanks

to make sure, could you post the suggested argument format for
these ioctls?

> 
> > 
> > > Thanks
> > > 
> > > 

