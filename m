Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D967BC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 21:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BBC22525
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 21:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1s3SHwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgATV4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 16:56:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31891 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726942AbgATV4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 16:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579557378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=62LNkLQMXjSxzZ1qGIQnfYNgDgSpvkpj5nXVuzQSLnI=;
        b=H1s3SHwKMXbHdsrs8727GxtDJBRc3UVRvqk7noaEDU4g9CCixc398oy1qP/dkG9rObPNg2
        HCD2ezH1RvDzi/ZVwedN3e+zYcFoKj/AyelWdduT89BkE8mwwYG1Dt2qYTpa4TOy5dwCxV
        WX6nJ+tJck5zRwcM7rQeaGPwyqO6Rro=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-P-doivMaNhi9lH5_udOCPg-1; Mon, 20 Jan 2020 16:56:16 -0500
X-MC-Unique: P-doivMaNhi9lH5_udOCPg-1
Received: by mail-qt1-f198.google.com with SMTP id e1so665050qto.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 13:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=62LNkLQMXjSxzZ1qGIQnfYNgDgSpvkpj5nXVuzQSLnI=;
        b=SKvQD4FOZU+607P2r6OGa36MPQInjiyh76L2T30ldW3EpXQrkkpI9mvPJCKBmC/YNG
         w53jTxLZrZ/KjhNI01jdkpwg4l3t7ye5wQLg+vwThRgRBpL/IGYGpgmIEyjFRyfynfI8
         sZMBqvwuaAtOxkiYxM/9K9kc/a5RHlo8+E3XtWRrEwR2EaLAZZPXLDvRuyeuG7gXa3jO
         L2j5u9iYB/uY019ytLkRNnaD+J9Ns5vmSkBFNHIazE2GRVcbR8lkXrLAvd3uQQMBbuWV
         iUe6p3eY4D+rh0b4EpYLJnYBEENixMmRXtM2wJc+Vv/PpDYOsB+M1Uc82elvymZ3yE6Q
         +ifQ==
X-Gm-Message-State: APjAAAWBrw67sajLbm/jwgSMMutdeVHemzBxLyltu36SmPmbgv02sl1M
        ePiYGR9MEU1KiOe7Z6MACoX4jxkYuR4dX2BrJTWL7uEyx/DIsoKrTySYk8fdf77rnAbfyXmAkqq
        F8OHNBl6WFLtJH4HL5MNbLk6w
X-Received: by 2002:aed:27de:: with SMTP id m30mr1474667qtg.151.1579557376425;
        Mon, 20 Jan 2020 13:56:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqw38PiLJQwBkH5yonvL8qdp0NwjRgW2RVHdE4B/0tWoQNPZFObTe7mxpwhkFj/2blsxmgzW3w==
X-Received: by 2002:aed:27de:: with SMTP id m30mr1474647qtg.151.1579557376187;
        Mon, 20 Jan 2020 13:56:16 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id z15sm7493120qtv.56.2020.01.20.13.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 13:56:15 -0800 (PST)
Date:   Mon, 20 Jan 2020 16:56:06 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tiwei.bie@intel.com" <tiwei.bie@intel.com>,
        "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
        "cunming.liang@intel.com" <cunming.liang@intel.com>,
        "zhihong.wang@intel.com" <zhihong.wang@intel.com>,
        "rob.miller@broadcom.com" <rob.miller@broadcom.com>,
        "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>,
        "haotian.wang@sifive.com" <haotian.wang@sifive.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "aadam@redhat.com" <aadam@redhat.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Shahaf Shuler <shahafs@mellanox.com>,
        "hanand@xilinx.com" <hanand@xilinx.com>,
        "mhabets@solarflare.com" <mhabets@solarflare.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Message-ID: <20200120164916-mutt-send-email-mst@kernel.org>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200116152209.GH20978@mellanox.com>
 <03cfbcc2-fef0-c9d8-0b08-798b2a293b8c@redhat.com>
 <20200117135435.GU20978@mellanox.com>
 <20200120071406-mutt-send-email-mst@kernel.org>
 <20200120175050.GC3891@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120175050.GC3891@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 05:50:55PM +0000, Jason Gunthorpe wrote:
> On Mon, Jan 20, 2020 at 07:17:26AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Jan 17, 2020 at 01:54:42PM +0000, Jason Gunthorpe wrote:
> > > > 1) "virtio" vs "vhost", I implemented matching method for this in mdev
> > > > series, but it looks unnecessary for vDPA device driver to know about this.
> > > > Anyway we can use sysfs driver bind/unbind to switch drivers
> > > > 2) virtio device id and vendor id. I'm not sure we need this consider the
> > > > two drivers so far (virtio/vhost) are all bus drivers.
> > > 
> > > As we seem to be contemplating some dynamic creation of vdpa devices I
> > > think upon creation time it should be specified what mode they should
> > > run it and then all driver binding and autoloading should happen
> > > automatically. Telling the user to bind/unbind is a very poor
> > > experience.
> > 
> > Maybe but OTOH it's an existing interface. I think we can reasonably
> > start with bind/unbind and then add ability to specify
> > the mode later. bind/unbind come from core so they will be
> > maintained anyway.
> 
> Existing where?

Driver core.

> For vfio? vfio is the only thing I am aware doing
> that, and this is not vfio..
> 
> Jason


vfio is not doing anything. anyone can use a combination
of unbind and driver_override to attach a driver to a device.

It's not a great interface but it's there without any code,
and it will stay there without maintainance overhead
if we later add a nicer one.

-- 
MST

