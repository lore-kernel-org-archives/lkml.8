Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E947C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B04A204EF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7QAzb+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgFHHIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:08:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44897 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728053AbgFHHIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591600091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wizDwfwyoMPPXV4GkKbxmYvGh2D3w1K1LtMuM+YAACM=;
        b=c7QAzb+8vc+37HVzJSIMlX8sP3lTCp2E3Y95Q9rettJgJ7hLVpkMNKl8zHtfO1MeF7BMPI
        hrAdjXKc/sURCiZ9Ka4q/PMNDirOSi4mBYqAQsXvu7FM/DsOOwkWjPbY3ERXPBq1Zc4R+A
        /RbaYelrqUAA7LGczgFBOhYyVndcLLM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-cWUFPO7AOP6J7nUWXrhhWw-1; Mon, 08 Jun 2020 03:08:08 -0400
X-MC-Unique: cWUFPO7AOP6J7nUWXrhhWw-1
Received: by mail-wm1-f71.google.com with SMTP id u15so3599182wmm.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 00:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wizDwfwyoMPPXV4GkKbxmYvGh2D3w1K1LtMuM+YAACM=;
        b=ViCRGufKApHi6VHK0Lzf5Z/itgVYWy5bkd7xaGEXrMcLtrPClyFMXWPSQTT3HDVVz3
         6FjxrHh4wwlbghc5mlyQy4zhS+53dnrNQgHKluQKSVxRmkXKMSNwzsIXTJE+F1sUr41L
         AKd24JoaDeha+lpBydPcttVuPbDlmeNTUqm1l0UCKf2RJZcwa93wLiSLBwJhpRkert3k
         oM250elaRWuIT+TGmMWTWqofdIj/09KN8oDKvAV3rVvJZjx+QGTLYeprmYGKJ0iL7BzB
         J9yEVj8oBiDAJbyRBiNXK18QiTt5Ze73aLuuimi7pHf32sO+mcqkGaiLYMryi4wI/Xdb
         namg==
X-Gm-Message-State: AOAM5327duJZr2rGl9hM6zZ8pVtFdzIIk0AAh/ODpTaz8sE2Ti2KwY+o
        13VvjH+HPZm00L+CM+3r7CQH3vHJgnBms8lTWXYf4HqMRdnuwzvI5UJmefwZuxHbvqBNMqrC3Ul
        7VXJNA4+YWSXX6Jxd5nioALI8
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr21994662wrw.343.1591600087650;
        Mon, 08 Jun 2020 00:08:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGXpbzzaidmlnwd5ycIBSHFuqY9ai9qcMz+leuBEUc2i8LDNf3lxQQHaqRmYeHsaCi3Ivgmg==
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr21994630wrw.343.1591600087357;
        Mon, 08 Jun 2020 00:08:07 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id x205sm22956704wmx.21.2020.06.08.00.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 00:08:06 -0700 (PDT)
Date:   Mon, 8 Jun 2020 03:08:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        virtualization@lists.linux-foundation.org,
        teawater <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH] virtio_mem: prevent overflow with subblock size
Message-ID: <20200608030423-mutt-send-email-mst@kernel.org>
References: <20200608061406.709211-1-mst@redhat.com>
 <0930c9d0-0708-c079-29bd-b80d4e3ce446@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0930c9d0-0708-c079-29bd-b80d4e3ce446@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 08:58:31AM +0200, David Hildenbrand wrote:
> On 08.06.20 08:14, Michael S. Tsirkin wrote:
> > If subblock size is large (e.g. 1G) 32 bit math involving it
> > can overflow. Rather than try to catch all instances of that,
> > let's tweak block size to 64 bit.
> 
> I fail to see where we could actually trigger an overflow. The reported
> warning looked like a false positive to me.


So

    const uint64_t size = count * vm->subblock_size;

is it unreasonable for count to be 4K with subblock_size being 1M?

> > 
> > It ripples through UAPI which is an ABI change, but it's not too late to
> > make it, and it will allow supporting >4Gbyte blocks while might
> > become necessary down the road.
> > 
> 
> This might break cloud-hypervisor, who's already implementing this
> protocol upstream (ccing Hui).
> https://github.com/cloud-hypervisor/cloud-hypervisor/blob/master/vm-virtio/src/mem.rs
> 
> (blocks in the gigabyte range were never the original intention of
> virtio-mem, but I am not completely opposed to that)


So in that case, can you code up validation in the probe function?


> > Fixes: 5f1f79bbc9e26 ("virtio-mem: Paravirtualized memory hotplug")
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/virtio/virtio_mem.c     | 14 +++++++-------
> >  include/uapi/linux/virtio_mem.h |  4 ++--
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> > index 2f357142ea5e..7b1bece8a331 100644
> > --- a/drivers/virtio/virtio_mem.c
> > +++ b/drivers/virtio/virtio_mem.c
> > @@ -77,7 +77,7 @@ struct virtio_mem {
> >  	uint64_t requested_size;
> >  
> >  	/* The device block size (for communicating with the device). */
> > -	uint32_t device_block_size;
> > +	uint64_t device_block_size;
> >  	/* The translated node id. NUMA_NO_NODE in case not specified. */
> >  	int nid;
> >  	/* Physical start address of the memory region. */
> > @@ -86,7 +86,7 @@ struct virtio_mem {
> >  	uint64_t region_size;
> >  
> >  	/* The subblock size. */
> > -	uint32_t subblock_size;
> > +	uint64_t subblock_size;
> >  	/* The number of subblocks per memory block. */
> >  	uint32_t nb_sb_per_mb;
> >  
> > @@ -1698,9 +1698,9 @@ static int virtio_mem_init(struct virtio_mem *vm)
> >  	 * - At least the device block size.
> >  	 * In the worst case, a single subblock per memory block.
> >  	 */
> > -	vm->subblock_size = PAGE_SIZE * 1u << max_t(uint32_t, MAX_ORDER - 1,
> > -						    pageblock_order);
> > -	vm->subblock_size = max_t(uint32_t, vm->device_block_size,
> > +	vm->subblock_size = PAGE_SIZE * 1ul << max_t(uint32_t, MAX_ORDER - 1,
> > +						     pageblock_order);
> > +	vm->subblock_size = max_t(uint64_t, vm->device_block_size,
> >  				  vm->subblock_size);
> >  	vm->nb_sb_per_mb = memory_block_size_bytes() / vm->subblock_size;
> >  
> > @@ -1713,8 +1713,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
> >  
> >  	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
> >  	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
> > -	dev_info(&vm->vdev->dev, "device block size: 0x%x",
> > -		 vm->device_block_size);
> > +	dev_info(&vm->vdev->dev, "device block size: 0x%llx",
> > +		 (unsigned long long)vm->device_block_size);
> >  	dev_info(&vm->vdev->dev, "memory block size: 0x%lx",
> >  		 memory_block_size_bytes());
> >  	dev_info(&vm->vdev->dev, "subblock size: 0x%x",
> > diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
> > index a455c488a995..a9ffe041843c 100644
> > --- a/include/uapi/linux/virtio_mem.h
> > +++ b/include/uapi/linux/virtio_mem.h
> > @@ -185,10 +185,10 @@ struct virtio_mem_resp {
> >  
> >  struct virtio_mem_config {
> >  	/* Block size and alignment. Cannot change. */
> > -	__u32 block_size;
> > +	__u64 block_size;
> >  	/* Valid with VIRTIO_MEM_F_ACPI_PXM. Cannot change. */
> >  	__u16 node_id;
> > -	__u16 padding;
> > +	__u8 padding[6];
> >  	/* Start address of the memory region. Cannot change. */
> >  	__u64 addr;
> >  	/* Region size (maximum). Cannot change. */
> > 
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb

