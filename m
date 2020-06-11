Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F51AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E519520747
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYEQB49j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgFKKIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:08:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39321 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726802AbgFKKIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591870083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hti1yQlaKXXa4b8vH7t/CX8EVQPiSGu8ey4rYtxv/ZU=;
        b=cYEQB49jkTSsgEo/hHpLKrJeIg2ba0KWYxVNqpZ09l9sGR7hfKBNm1qDPuofVMQwPnBPMs
        YFqzIhmpqr+I/b1Q4M+qtSDrBQh5B+JR7u9Sdn12ldRe2So5rzh86wew73AsWhi0bAWEBL
        M3qlCb8Njufmli54vDDNnGVdGGuzCQQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-jdwmW1qOPs-8vTHF986FmQ-1; Thu, 11 Jun 2020 06:07:59 -0400
X-MC-Unique: jdwmW1qOPs-8vTHF986FmQ-1
Received: by mail-wr1-f71.google.com with SMTP id o1so2355222wrm.17
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 03:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hti1yQlaKXXa4b8vH7t/CX8EVQPiSGu8ey4rYtxv/ZU=;
        b=fGJ34ecZbdsK8Ebw4/LMb6Poy91REU9xed5DVo6qsS1D0PHe8ZAaZ9wdQaTzV9/ZoF
         PyTWGPtrNEeX9gXPKlbeybn9gA2GHlDMtw/Ruf5SBWFAbIw7ltwkW4EnurMX2wryRX3o
         otNejGefUqw51e9UiyWMta/wkeXNV2EiJorz+QLr+oqCVaFi/EFp2HlV17uHbUAfPqaP
         g3U6S/CJtmuTGIlvYczwBzMkMImfRB2WINZhy6bOVZnxN8FTIfwp0+d6Tr9uylGI0JFe
         9FQWaZpkUnPhxw8DX6iJ0MiuckgsGaF+bvul4iu38MHx3CuIPnhOgyFM8zAfRQDY1TsS
         kgBQ==
X-Gm-Message-State: AOAM5320odu/v3kmBgc0viUBeWPinEH0PFf+lWM9ouWSaqlRBbl5Mqfb
        aROA4NEeELxOTRj0LNeV1AR6SKTK8Giqe8sIuI01dZWW75PBPTKIp8I2zYatKO5yMfStNR/1EIe
        2YPYzU438l9HmPqO94jkE8xvZ
X-Received: by 2002:a5d:5449:: with SMTP id w9mr8887306wrv.106.1591870078453;
        Thu, 11 Jun 2020 03:07:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7fUMwNnhBKL0yD4hzPZy5EKspCjidE0BlArAAtqV0VBMDwrTb+hVc8kTwnh7wCpCs88IQZw==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr8887273wrv.106.1591870078148;
        Thu, 11 Jun 2020 03:07:58 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id u4sm3363234wmb.48.2020.06.11.03.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 03:07:57 -0700 (PDT)
Date:   Thu, 11 Jun 2020 06:07:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        teawater <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH v1] virtio-mem: add memory via add_memory_driver_managed()
Message-ID: <20200611060249-mutt-send-email-mst@kernel.org>
References: <20200611093518.5737-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611093518.5737-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-mem: add memory via add_memory_driver_managed()


On Thu, Jun 11, 2020 at 11:35:18AM +0200, David Hildenbrand wrote:
> Virtio-mem managed memory is always detected and added by the virtio-mem
> driver, never using something like the firmware-provided memory map.
> This is the case after an ordinary system reboot, and has to be guaranteed
> after kexec. Especially, virtio-mem added memory resources can contain
> inaccessible parts ("unblocked memory blocks"), blindly forwarding them
> to a kexec kernel is dangerous, as unplugged memory will get accessed
> (esp. written).
> 
> Let's use the new way of adding special driver-managed memory introduced
> in commit 75ac4c58bc0d ("mm/memory_hotplug: introduce
> add_memory_driver_managed()").
> 
> This will result in no entries in /sys/firmware/memmap ("raw firmware-
> provided memory map"), the memory resource will be flagged
> IORESOURCE_MEM_DRIVER_MANAGED (esp., kexec_file_load() will not place
> kexec images on this memory), and it is exposed as "System RAM
> (virtio_mem)" in /proc/iomem, so esp. kexec-tools can properly handle it.
> 
> Example /proc/iomem before this change:
>   [...]
>   140000000-333ffffff : virtio0
>     140000000-147ffffff : System RAM
>   334000000-533ffffff : virtio1
>     338000000-33fffffff : System RAM
>     340000000-347ffffff : System RAM
>     348000000-34fffffff : System RAM
>   [...]
> 
> Example /proc/iomem after this change:
>   [...]
>   140000000-333ffffff : virtio0
>     140000000-147ffffff : System RAM (virtio_mem)
>   334000000-533ffffff : virtio1
>     338000000-33fffffff : System RAM (virtio_mem)
>     340000000-347ffffff : System RAM (virtio_mem)
>     348000000-34fffffff : System RAM (virtio_mem)
>   [...]
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: teawater <teawaterz@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Based on latest Linus' tree (and not a tag) because
> - virtio-mem has just been merged via the vhost tree
> - add_memory_driver_managed() has been merged a week ago via the -mm tree
> 
> I'd like to have this patch in 5.8, with the initial merge of virtio-mem
> if possible (so the user space representation of virtio-mem added memory
> resources won't change anymore).

So my plan is to rebase on top of -rc1 and merge this for rc2 then.
I don't like rebase on top of tip as the results are sometimes kind of
random.
And let's add a Fixes: tag as well, this way people will remember to
pick this.
Makes sense?


> ---
>  drivers/virtio/virtio_mem.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 50c689f250450..d2eab3558a9e1 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -101,6 +101,11 @@ struct virtio_mem {
>  
>  	/* The parent resource for all memory added via this device. */
>  	struct resource *parent_resource;
> +	/*
> +	 * Copy of "System RAM (virtio_mem)" to be used for
> +	 * add_memory_driver_managed().
> +	 */
> +	const char *resource_name;
>  
>  	/* Summary of all memory block states. */
>  	unsigned long nb_mb_state[VIRTIO_MEM_MB_STATE_COUNT];
> @@ -414,8 +419,20 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
>  	if (nid == NUMA_NO_NODE)
>  		nid = memory_add_physaddr_to_nid(addr);
>  
> +	/*
> +	 * When force-unloading the driver and we still have memory added to
> +	 * Linux, the resource name has to stay.
> +	 */
> +	if (!vm->resource_name) {
> +		vm->resource_name = kstrdup_const("System RAM (virtio_mem)",
> +						  GFP_KERNEL);
> +		if (!vm->resource_name)
> +			return -ENOMEM;
> +	}
> +
>  	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
> -	return add_memory(nid, addr, memory_block_size_bytes());
> +	return add_memory_driver_managed(nid, addr, memory_block_size_bytes(),
> +					 vm->resource_name);
>  }
>  
>  /*
> @@ -1890,10 +1907,12 @@ static void virtio_mem_remove(struct virtio_device *vdev)
>  	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL] ||
>  	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE] ||
>  	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL] ||
> -	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE])
> +	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE]) {
>  		dev_warn(&vdev->dev, "device still has system memory added\n");
> -	else
> +	} else {
>  		virtio_mem_delete_resource(vm);
> +		kfree_const(vm->resource_name);
> +	}
>  
>  	/* remove all tracking data - no locking needed */
>  	vfree(vm->mb_state);
> -- 
> 2.26.2

