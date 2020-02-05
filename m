Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C6EC33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D98D20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSirP+bV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgBEJYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:24:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48456 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728109AbgBEJYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580894649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wSY3Qv6hAFiMJ+ZMELgFgVfUvrY9dNbp0gOuOjqy//g=;
        b=hSirP+bVQkqSokdGvewOsk95JplBC4SRu9CJ9kQaZUoLvSga6J5XFC8kNLkuRHAbcm2qqV
        RkaXm1QHYTmYjEplMBJSSgzkuSBp+kgaHW7C8AakIJ0Xi384azgiHm+MtZr8cgI//uTCwk
        WmXsSArc+c3iKVtLVlZM5BkUkT66N90=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-T15rbXrFMJS1oeO6Qp6NwA-1; Wed, 05 Feb 2020 04:24:07 -0500
X-MC-Unique: T15rbXrFMJS1oeO6Qp6NwA-1
Received: by mail-qv1-f71.google.com with SMTP id j15so1075390qvp.21
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 01:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wSY3Qv6hAFiMJ+ZMELgFgVfUvrY9dNbp0gOuOjqy//g=;
        b=EBdiDRgt8OLPE2GA899zUQgzAmNZUCRZur+kfweMc2cWAaia3DkEOOHJayccHBzbUa
         epJc4mzaz+QGQzAx1Mn1NRJGqkLfC0haL+gsAbGZRcRzihErsLrWTxv2fzgoZRMq3UjA
         kvNfFQWY9rsmIcB/oxxqG1o2Y7Y6mxQAq0aZNyCOdzaM8sdtPcO/Gf1xu4HvFMkcKzP3
         6bsOHAaYYsz1ok/m41WwgqXm7Er7DAqppiWU3WZoh2nvckicwJXdEv6WiwzVudAxTyTp
         cfjC+NOy2CaNuDF0KHPTWNvhDJ4qPnXVgVZ5PoaVQtCMCMAMrYHESdH7MGcCjuVZVXk3
         ts+Q==
X-Gm-Message-State: APjAAAWrfGpVF9OrL6FiJmu7ndMR24Cwt8ltm/+kAXxMGzLTfM6abt0h
        CHFJ70bgYXRRuTNl+ty1e0HajH0356P22CoM4JxIO5dU5tlYQU1Zs9NNupCsQMbITCpDj374QuU
        yFlTMgQJ2xMRmlELyeoYM/OgG
X-Received: by 2002:ac8:5353:: with SMTP id d19mr31605207qto.313.1580894647316;
        Wed, 05 Feb 2020 01:24:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyyschR+1xoeOuBpiIeSRa2/qJVXKJqzZtd++LLazpwBb3n6x85V08OIQ0LHH/2pAjxc8X/nw==
X-Received: by 2002:ac8:5353:: with SMTP id d19mr31605178qto.313.1580894647051;
        Wed, 05 Feb 2020 01:24:07 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id e130sm12534407qkb.72.2020.02.05.01.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 01:24:06 -0800 (PST)
Date:   Wed, 5 Feb 2020 04:23:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Shahaf Shuler <shahafs@mellanox.com>,
        Tiwei Bie <tiwei.bie@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "rob.miller@broadcom.com" <rob.miller@broadcom.com>,
        "haotian.wang@sifive.com" <haotian.wang@sifive.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "hanand@xilinx.com" <hanand@xilinx.com>,
        "mhabets@solarflare.com" <mhabets@solarflare.com>,
        "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "dan.daly@intel.com" <dan.daly@intel.com>,
        "cunming.liang@intel.com" <cunming.liang@intel.com>,
        "zhihong.wang@intel.com" <zhihong.wang@intel.com>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Message-ID: <20200205042259-mutt-send-email-mst@kernel.org>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
 <20200205020247.GA368700@___>
 <AM0PR0502MB37952015716C1D5E07E390B6C3020@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <112858a4-1a01-f4d7-e41a-1afaaa1cad45@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <112858a4-1a01-f4d7-e41a-1afaaa1cad45@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 03:50:14PM +0800, Jason Wang wrote:
> 
> On 2020/2/5 下午3:15, Shahaf Shuler wrote:
> > Wednesday, February 5, 2020 4:03 AM, Tiwei Bie:
> > > Subject: Re: [PATCH] vhost: introduce vDPA based backend
> > > 
> > > On Tue, Feb 04, 2020 at 11:30:11AM +0800, Jason Wang wrote:
> > > > On 2020/1/31 上午11:36, Tiwei Bie wrote:
> > > > > This patch introduces a vDPA based vhost backend. This backend is
> > > > > built on top of the same interface defined in virtio-vDPA and
> > > > > provides a generic vhost interface for userspace to accelerate the
> > > > > virtio devices in guest.
> > > > > 
> > > > > This backend is implemented as a vDPA device driver on top of the
> > > > > same ops used in virtio-vDPA. It will create char device entry named
> > > > > vhost-vdpa/$vdpa_device_index for userspace to use. Userspace can
> > > > > use vhost ioctls on top of this char device to setup the backend.
> > > > > 
> > > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > [...]
> > 
> > > > > +static long vhost_vdpa_do_dma_mapping(struct vhost_vdpa *v) {
> > > > > +	/* TODO: fix this */
> > > > 
> > > > Before trying to do this it looks to me we need the following during
> > > > the probe
> > > > 
> > > > 1) if set_map() is not supported by the vDPA device probe the IOMMU
> > > > that is supported by the vDPA device
> > > > 2) allocate IOMMU domain
> > > > 
> > > > And then:
> > > > 
> > > > 3) pin pages through GUP and do proper accounting
> > > > 4) store GPA->HPA mapping in the umem
> > > > 5) generate diffs of memory table and using IOMMU API to setup the dma
> > > > mapping in this method
> > > > 
> > > > For 1), I'm not sure parent is sufficient for to doing this or need to
> > > > introduce new API like iommu_device in mdev.
> > > Agree. We may also need to introduce something like the iommu_device.
> > > 
> > Would it be better for the map/umnap logic to happen inside each device ?
> > Devices that needs the IOMMU will call iommu APIs from inside the driver callback.
> 
> 
> Technically, this can work. But if it can be done by vhost-vpda it will make
> the vDPA driver more compact and easier to be implemented.
> 
> 
> > Devices that has other ways to do the DMA mapping will call the proprietary APIs.
> 
> 
> To confirm, do you prefer:
> 
> 1) map/unmap
> 
> or
> 
> 2) pass all maps at one time?
> 
> Thanks
> 
> 

I mean we really already have both right? ATM 1 is used with an iommu
and 2 without. I guess we can also have drivers ask for either or both
...

-- 
MST

