Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E561C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 21:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1B122522
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 21:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/oGc94I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgATVtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 16:49:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32880 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727372AbgATVtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 16:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579556947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7XraG6j1N/y3xLCXP92Th/VKfxmhRZrdg4uwGLI/Vm4=;
        b=b/oGc94Ifz3dnXu4d137Zl7ENNiYvuU4emeQUlY3tMmRediIJqph43VyGgpQheQ7O2WUve
        2+BIvmKqb1SMDRfyLPEVzUmgC12oUxdqkKx0/SCyLTRKbNNcP4LI9pabEQuZ0UScWdrO+b
        20jI9Fa3fINNxj5I53n2Y+isZpXdVqY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-VSGUkzxpMsu-4xC-fdLuig-1; Mon, 20 Jan 2020 16:49:06 -0500
X-MC-Unique: VSGUkzxpMsu-4xC-fdLuig-1
Received: by mail-qt1-f197.google.com with SMTP id c8so624547qte.22
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 13:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7XraG6j1N/y3xLCXP92Th/VKfxmhRZrdg4uwGLI/Vm4=;
        b=GLx6P0Bpvynf+Elg1Oq8IBZMaal2tcarMEsVwLFwObCBhmIGxC4Q1tBPW53XGQzcyH
         OfyRG4IRSzPPb1Qr0rzOYZCXZeKIhksImZ0K9etEVu1oSTLcKmxLYhAjc7/CEDCpq4xP
         bAjNRZRltJeKfzkoBoi+9MVz5L+BEFoQWV3Ap9AtQO6ghzqdTCAyD2CB7UI8VRpsybx8
         cyz0ZOgS1kHrWMTBJEi99N+wKm19IU16czPhdbiTbB8HohWW2p5WBpbt+y7+xlp83TSH
         ObuT/WKJyGOsn0SfGs/lNlzs9RWcyoSQ7zPOs5H0YRJ1xvrERlb+igxBCS9oYPnw+yon
         jCnw==
X-Gm-Message-State: APjAAAXpzzewv++H5V2MLmTad/NRPPiGQhXZZ2MjoEnkqpbDtYjXDtKu
        NEkskyDkt58sqB8EnID/Bh9VXT2lbx1rNSJxKvysO+yys8YhmcuqtAuyc8GLiOT9aoE8U4/GFyp
        j81sYo3d5pPpEkit9XkEIhMI8
X-Received: by 2002:ad4:478b:: with SMTP id z11mr1807806qvy.185.1579556945805;
        Mon, 20 Jan 2020 13:49:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxe+TaTURMeMIHCV1YM/fmBzkD8nEfrcjqkwq5BuJERHu3qsEZA9pujZr3ffzD4wXcl90YdAQ==
X-Received: by 2002:ad4:478b:: with SMTP id z11mr1807796qvy.185.1579556945609;
        Mon, 20 Jan 2020 13:49:05 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id g18sm18570113qtc.83.2020.01.20.13.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 13:49:04 -0800 (PST)
Date:   Mon, 20 Jan 2020 16:48:55 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Shahaf Shuler <shahafs@mellanox.com>,
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
Message-ID: <20200120164756-mutt-send-email-mst@kernel.org>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
 <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <d69918ca-8af4-44b2-9652-633530d4c113@redhat.com>
 <20200120174933.GB3891@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120174933.GB3891@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 05:49:39PM +0000, Jason Gunthorpe wrote:
> On Mon, Jan 20, 2020 at 04:43:53PM +0800, Jason Wang wrote:
> > This is similar to the design of platform IOMMU part of vhost-vdpa. We
> > decide to send diffs to platform IOMMU there. If it's ok to do that in
> > driver, we can replace set_map with incremental API like map()/unmap().
> > 
> > Then driver need to maintain rbtree itself.
> 
> I think we really need to see two modes, one where there is a fixed
> translation without dynamic vIOMMU driven changes and one that
> supports vIOMMU.
> 
> There are different optimization goals in the drivers for these two
> configurations.
> 
> > > If the first one, then I think memory hotplug is a heavy flow
> > > regardless. Do you think the extra cycles for the tree traverse
> > > will be visible in any way?
> > 
> > I think if the driver can pause the DMA during the time for setting up new
> > mapping, it should be fine.
> 
> This is very tricky for any driver if the mapping change hits the
> virtio rings. :(
> 
> Even a IOMMU using driver is going to have problems with that..
> 
> Jason

I think for starters we can assume this doesn't happen,
so any change doesn't affect any buffers in use.
Certainly true e.g. for memory hotplug.

-- 
MST

