Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B82C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A42204EF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+znX66P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgFHGcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:32:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52544 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726929AbgFHGcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591597969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHa43udsYNKZo7N6VKsAJNE6lMJI4Ma06bbThMjTBZc=;
        b=E+znX66PqYlcKhzCZFErXyHapDYqr5vEZUDPRxGmkfHUA8OcBTRvH+GFH1sQLFfUFljnWq
        9M/QsOcfb+Vu8INbzRQlWLKdD3TNJp1MlAAfhuPJUqraLe1Bpoa0EIOm8XSjC/ZyzzLyxa
        W9oBZN05HHdgqRNrS7NbytwMMFbBlF8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-gJCNOSb-MBu07eb1AeqHjA-1; Mon, 08 Jun 2020 02:32:47 -0400
X-MC-Unique: gJCNOSb-MBu07eb1AeqHjA-1
Received: by mail-wm1-f71.google.com with SMTP id r1so1190935wmh.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 23:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uHa43udsYNKZo7N6VKsAJNE6lMJI4Ma06bbThMjTBZc=;
        b=HaQiRlmnavwwqdmaETkQ6fkJ2ZC/50bEhSRUwbmgDICmBMXq0nC4RkPV4s75/F/0Li
         Qne49XEf+JX18FxJtdX2XrJopol9turyVM+jFhg2QJ63ygpxj8NKmUx/RZZs35+IBrCj
         uWVXh8aD88utcQo5DQ80q8fTCILBXw0vYdIWK67VExS7bL3atXBBgORfkcCwUySNCdWu
         yuJW4ZPvP2Ggk0+j/WfFRbvKuJKxrv0SFqasiRoUq8fVrvN43JdeDmJ44h3mI6/V3a9m
         RxblGptMZI/bKlj9yHdjeqsLV+8qQtY7PeGkyE0SoE8b7ru1ZZs6cJsVn/LI6s5QyvkE
         FW3Q==
X-Gm-Message-State: AOAM5314XoW8Etey+MD3EK/vsOfAbwORsmETRWis30dQNoFSj4zHxN3n
        NtLN1a7jLPG3Jo7KsE/aK9VsUoXzrK/XoPGUpZMpEmwcl1tjEYSZUJ5rb1GrVy3KoEP0Fxgghy0
        mCWv141b0zQUTk5Ut2vgp4iS6
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr22588495wrp.398.1591597966538;
        Sun, 07 Jun 2020 23:32:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHTpMMuo2IYOqOej95ECMKiyl7nT0Q76q7fFs8v5zZkhDNtkqrniK0oE26ia6RYqO77tX8Xg==
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr22588471wrp.398.1591597966374;
        Sun, 07 Jun 2020 23:32:46 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id c16sm22492989wrx.4.2020.06.07.23.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 23:32:45 -0700 (PDT)
Date:   Mon, 8 Jun 2020 02:32:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH 5/6] vdpa: introduce virtio pci driver
Message-ID: <20200608021438-mutt-send-email-mst@kernel.org>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-6-jasowang@redhat.com>
 <20200602010332-mutt-send-email-mst@kernel.org>
 <5dbb0386-beeb-5bf4-d12e-fb5427486bb8@redhat.com>
 <6b1d1ef3-d65e-08c2-5b65-32969bb5ecbc@redhat.com>
 <20200607095012-mutt-send-email-mst@kernel.org>
 <9b1abd2b-232c-aa0f-d8bb-03e65fd47de2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b1abd2b-232c-aa0f-d8bb-03e65fd47de2@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 11:32:31AM +0800, Jason Wang wrote:
> 
> On 2020/6/7 下午9:51, Michael S. Tsirkin wrote:
> > On Fri, Jun 05, 2020 at 04:54:17PM +0800, Jason Wang wrote:
> > > On 2020/6/2 下午3:08, Jason Wang wrote:
> > > > > > +static const struct pci_device_id vp_vdpa_id_table[] = {
> > > > > > +    { PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },
> > > > > > +    { 0 }
> > > > > > +};
> > > > > This looks like it'll create a mess with either virtio pci
> > > > > or vdpa being loaded at random. Maybe just don't specify
> > > > > any IDs for now. Down the road we could get a
> > > > > distinct vendor ID or a range of device IDs for this.
> > > > 
> > > > Right, will do.
> > > > 
> > > > Thanks
> > > 
> > > Rethink about this. If we don't specify any ID, the binding won't work.
> > We can bind manually. It's not really for production anyway, so
> > not a big deal imho.
> 
> 
> I think you mean doing it via "new_id", right.

I really meant driver_override. This is what people have been using
with pci-stub for years now.

> 
> > 
> > > How about using a dedicated subsystem vendor id for this?
> > > 
> > > Thanks
> > If virtio vendor id is used then standard driver is expected
> > to bind, right? Maybe use a dedicated vendor id?
> 
> 
> I meant something like:
> 
> static const struct pci_device_id vp_vdpa_id_table[] = {
>     { PCI_DEVICE_SUB(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID,
> VP_TEST_VENDOR_ID, VP_TEST_DEVICE_ID) },
>     { 0 }
> };
> 
> Thanks
> 

Then regular virtio will still bind to it. It has

drivers/virtio/virtio_pci_common.c:     { PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },


-- 
MST

