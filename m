Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC98C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727772087E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzXmpIPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgAUOQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:16:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30613 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727817AbgAUOQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579616174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OtPQLFnT52uoZGzAoyi/3S949ctnhGBbphedOmgQ5wE=;
        b=TzXmpIPh7YTX+4YAcFiGvqIth/xMkJ+3ANA//C4hzErY2xiktczZ66fnDgd1wjhKG1zamM
        CTDphGQPAFZa4sZvex5Hxez2yEGXspAx7bMF7YFs6OVA6eBLVxr/Gva5gxNLLNzMI9zzRO
        CM3gqx3kXjvLCfA2HbaylVbjgpFNFJM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-P4kEpP7nOHaFdNi-1g5rdw-1; Tue, 21 Jan 2020 09:16:12 -0500
X-MC-Unique: P4kEpP7nOHaFdNi-1g5rdw-1
Received: by mail-qv1-f69.google.com with SMTP id z9so1646252qvo.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 06:16:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OtPQLFnT52uoZGzAoyi/3S949ctnhGBbphedOmgQ5wE=;
        b=JExrhlB8yxgZaO/8FYom7CFeVetkBk9y+39xyXMQLL9Rgyu++C+cN65eAsr249hsz4
         ESKt+WauTReB4rJ0K0Rs/klXqn9Dl7EJQ5AXTu2f3hZ4AK74Cxm3vUA6z6zVZZBRZE8E
         Bm6jq26L7ulqOr2pnnPd3xi/4fCfJmqKco1V+ALUoO+iGMo92kIkzyDe0vsyc2ow3olt
         PHG7915qOVrFhdBDy+4oWbbX4VDb0RaUdEfQQGJQADDuNMx61bfnyPVUu/1zgG/kqOVS
         ThYrvmXz3a2xTwLW/D6NkFLgY+smQ4gXmXNQ3sF16JnkqkGGlCqsBsD9Fw4z+T7nizyW
         T6LQ==
X-Gm-Message-State: APjAAAXr3J97yDz2FWugPW8T6f+fabqo2bPq0UdfGLHndgbN6Mjcipu0
        oGbqWoEwrss5s8mrzbs5SoqPg3SNhisfLDNHDJTwyhHY6wiDuJiksDkqdVx8E64TfzJqjC9oAsT
        fvpTqSc5x8WIMMN4wnBZNym5S
X-Received: by 2002:a37:4f8d:: with SMTP id d135mr4735785qkb.455.1579616172185;
        Tue, 21 Jan 2020 06:16:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQgYijZdgXt853mYL5TwvzVQ8pujRfHDSMvSEtlc0v2iUY5t9/9HUHWxN10Q3Sbj5SYLpKCg==
X-Received: by 2002:a37:4f8d:: with SMTP id d135mr4735725qkb.455.1579616171759;
        Tue, 21 Jan 2020 06:16:11 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id u55sm19847250qtc.28.2020.01.21.06.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 06:16:11 -0800 (PST)
Date:   Tue, 21 Jan 2020 09:16:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Shahaf Shuler <shahafs@mellanox.com>,
        Jason Wang <jasowang@redhat.com>,
        Rob Miller <rob.miller@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
        "Liang, Cunming" <cunming.liang@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>,
        "Wang, Xiao W" <xiao.w.wang@intel.com>,
        "haotian.wang@sifive.com" <haotian.wang@sifive.com>,
        "Zhu, Lingshan" <lingshan.zhu@intel.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Ariel Adam <aadam@redhat.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "hanand@xilinx.com" <hanand@xilinx.com>,
        "mhabets@solarflare.com" <mhabets@solarflare.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Message-ID: <20200121091540-mutt-send-email-mst@kernel.org>
References: <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
 <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <d69918ca-8af4-44b2-9652-633530d4c113@redhat.com>
 <20200120174933.GB3891@mellanox.com>
 <AM0PR0502MB3795C92485338180FC8059CFC3320@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <20200120162449-mutt-send-email-mst@kernel.org>
 <20200121140755.GB12330@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121140755.GB12330@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 02:07:59PM +0000, Jason Gunthorpe wrote:
> On Mon, Jan 20, 2020 at 04:25:23PM -0500, Michael S. Tsirkin wrote:
> > On Mon, Jan 20, 2020 at 08:51:43PM +0000, Shahaf Shuler wrote:
> > > Monday, January 20, 2020 7:50 PM, Jason Gunthorpe:
> > > > Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
> > > > 
> > > > On Mon, Jan 20, 2020 at 04:43:53PM +0800, Jason Wang wrote:
> > > > > This is similar to the design of platform IOMMU part of vhost-vdpa. We
> > > > > decide to send diffs to platform IOMMU there. If it's ok to do that in
> > > > > driver, we can replace set_map with incremental API like map()/unmap().
> > > > >
> > > > > Then driver need to maintain rbtree itself.
> > > > 
> > > > I think we really need to see two modes, one where there is a fixed
> > > > translation without dynamic vIOMMU driven changes and one that supports
> > > > vIOMMU.
> > > > 
> > > > There are different optimization goals in the drivers for these two
> > > > configurations.
> > > 
> > > +1.
> > > It will be best to have one API for static config (i.e. mapping can be
> > > set only before virtio device gets active), and one API for dynamic
> > > changes that can be set after the virtio device is active. 
> > 
> > Frankly I don't see when we'd use the static one.
> > Memory hotplug is enabled for most guests...
> 
> If someone wants to run a full performance application, like dpdk,
> then they may wish to trade memory hotplug in that VM for more
> performance.

Right. But let let's get basic functionality working first.

> Perhaps Shahaf can quantify the performance delta?
> 
> Jason

