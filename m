Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AECC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4B9217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/bJ8NW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgAUOPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:15:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37833 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727255AbgAUOPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579616129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W0ISVuuIVoP4ewOzYniLTSVuw4vxN7wzv55HQyIkjTg=;
        b=N/bJ8NW9621mWaRa8VVneSI0rSabpB5JlDmSbCrOM8UqOmkNH4LIBHwJFviAf+xhQPR90i
        j3f8aYA/NU9ThkKgyUMhAN5N1i81cqPibJZy4jzjkGlot8fv+aC/SvD5QXs8rE8Bc6yOjS
        MeKIcLV6j7lH13ajCUPGwQoijAApfl4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-DN5Hv7dHO5ig1AI02qumZg-1; Tue, 21 Jan 2020 09:15:25 -0500
X-MC-Unique: DN5Hv7dHO5ig1AI02qumZg-1
Received: by mail-qt1-f197.google.com with SMTP id d9so1957934qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 06:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W0ISVuuIVoP4ewOzYniLTSVuw4vxN7wzv55HQyIkjTg=;
        b=BGDTw/2pNwnfan8lwvYgKu8TKnrj2Yd3Y012n32GDFS1xJgnPagVubF/3FmpEd/zTH
         dX5Hw5rwCATsmbyJ3ZFzHu2RUIxmvYxFT1W2gbQJeLjm0gNtU+/MnB68VVM5NAoV5u/f
         s1fhE4IfMJiNFL22wXTDQ6ZQzvYtZ/APDHFLyxUrEztQD3owBIunz1LfDc8HLKxyoK6O
         Dys0BK7ZDFOPjtM9qQNaUZC7idYE6my+CehK0POvPG1JhmZYXmXjgj+YPVdTn6ACUVYu
         bYZC73Y0+hREDgeG/oR/j+TH7sYWQZjYMCO2EgZpS/mrEH5b0AdgXYH5Src9n6ze4jQf
         12hQ==
X-Gm-Message-State: APjAAAXqI77hH+XLzxvyavynxpd9b1/+5ns9zCM5pFXEkD+1TwKE9XOV
        iE5+q3Zd8ucQgaPxuCsdNqGdk2z0pfw5dJGa8Dmn9jSTrHkgaiP309IjjB4OyPcha3AcHI24h1m
        NXoWwsxTBR+a0i0WpLLKQF4bw
X-Received: by 2002:a05:6214:1907:: with SMTP id er7mr4996634qvb.199.1579616125384;
        Tue, 21 Jan 2020 06:15:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8AFk0N0aDDxiY+h2t6Rh1k1ou2Ux/pEPzCq29EZUwXk9nLKkey+jnpSszBH9mQmuAKQMoKA==
X-Received: by 2002:a05:6214:1907:: with SMTP id er7mr4996599qvb.199.1579616125108;
        Tue, 21 Jan 2020 06:15:25 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id o16sm17323139qkj.91.2020.01.21.06.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 06:15:23 -0800 (PST)
Date:   Tue, 21 Jan 2020 09:15:14 -0500
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
Message-ID: <20200121091456-mutt-send-email-mst@kernel.org>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200116152209.GH20978@mellanox.com>
 <03cfbcc2-fef0-c9d8-0b08-798b2a293b8c@redhat.com>
 <20200117135435.GU20978@mellanox.com>
 <20200120071406-mutt-send-email-mst@kernel.org>
 <20200120175050.GC3891@mellanox.com>
 <20200120164916-mutt-send-email-mst@kernel.org>
 <20200121141200.GC12330@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121141200.GC12330@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 02:12:05PM +0000, Jason Gunthorpe wrote:
> On Mon, Jan 20, 2020 at 04:56:06PM -0500, Michael S. Tsirkin wrote:
> > > For vfio? vfio is the only thing I am aware doing
> > > that, and this is not vfio..
> > 
> > vfio is not doing anything. anyone can use a combination
> > of unbind and driver_override to attach a driver to a device.
> > 
> > It's not a great interface but it's there without any code,
> > and it will stay there without maintainance overhead
> > if we later add a nicer one.
> 
> Well, it is not a great interface, and it is only really used in
> normal cases by vfio.
> 
> I don't think it is a good idea to design new subsystems with that
> idea in mind, particularly since detatching the vdpa driver would not
> trigger destruction of the underlying dynamic resource (ie the SF).
> 
> We need a way to trigger that destruction..
> 
> Jason 

You wanted a netlink command for this, right?

-- 
MST

