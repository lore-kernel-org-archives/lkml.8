Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D448EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF002076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhp86kA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgFHG6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:58:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35508 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgFHG6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591599522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DGNUD0CJSxINo+NDhlYftL3Jy2sgThnr+VPQIk+OCvk=;
        b=fhp86kA49AiqA9i0WL4I35KVFSE+reV4qcKYgZ4VyvyFz+oFvDaI0cFSvSDP1g+La59kMo
        xSzMLUut56oU/wWkqiRZcoJymGN+aeskruYck5WMrvxWRo1GWIN0GPgeQrRftMbXHp9KGF
        rSeQit1SaLVn5BDM+5hxtxAQWHwH7SA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-LLibszdjNNSiCqbtPObHgQ-1; Mon, 08 Jun 2020 02:58:37 -0400
X-MC-Unique: LLibszdjNNSiCqbtPObHgQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E6FA100960F;
        Mon,  8 Jun 2020 06:58:36 +0000 (UTC)
Received: from [10.36.113.136] (ovpn-113-136.ams2.redhat.com [10.36.113.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F7457BA19;
        Mon,  8 Jun 2020 06:58:31 +0000 (UTC)
Subject: Re: [PATCH] virtio_mem: prevent overflow with subblock size
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        virtualization@lists.linux-foundation.org,
        teawater <teawaterz@linux.alibaba.com>
References: <20200608061406.709211-1-mst@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <0930c9d0-0708-c079-29bd-b80d4e3ce446@redhat.com>
Date:   Mon, 8 Jun 2020 08:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608061406.709211-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.20 08:14, Michael S. Tsirkin wrote:
> If subblock size is large (e.g. 1G) 32 bit math involving it
> can overflow. Rather than try to catch all instances of that,
> let's tweak block size to 64 bit.

I fail to see where we could actually trigger an overflow. The reported
warning looked like a false positive to me.

> 
> It ripples through UAPI which is an ABI change, but it's not too late to
> make it, and it will allow supporting >4Gbyte blocks while might
> become necessary down the road.
> 

This might break cloud-hypervisor, who's already implementing this
protocol upstream (ccing Hui).
https://github.com/cloud-hypervisor/cloud-hypervisor/blob/master/vm-virtio/src/mem.rs

(blocks in the gigabyte range were never the original intention of
virtio-mem, but I am not completely opposed to that)

> Fixes: 5f1f79bbc9e26 ("virtio-mem: Paravirtualized memory hotplug")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c     | 14 +++++++-------
>  include/uapi/linux/virtio_mem.h |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 2f357142ea5e..7b1bece8a331 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -77,7 +77,7 @@ struct virtio_mem {
>  	uint64_t requested_size;
>  
>  	/* The device block size (for communicating with the device). */
> -	uint32_t device_block_size;
> +	uint64_t device_block_size;
>  	/* The translated node id. NUMA_NO_NODE in case not specified. */
>  	int nid;
>  	/* Physical start address of the memory region. */
> @@ -86,7 +86,7 @@ struct virtio_mem {
>  	uint64_t region_size;
>  
>  	/* The subblock size. */
> -	uint32_t subblock_size;
> +	uint64_t subblock_size;
>  	/* The number of subblocks per memory block. */
>  	uint32_t nb_sb_per_mb;
>  
> @@ -1698,9 +1698,9 @@ static int virtio_mem_init(struct virtio_mem *vm)
>  	 * - At least the device block size.
>  	 * In the worst case, a single subblock per memory block.
>  	 */
> -	vm->subblock_size = PAGE_SIZE * 1u << max_t(uint32_t, MAX_ORDER - 1,
> -						    pageblock_order);
> -	vm->subblock_size = max_t(uint32_t, vm->device_block_size,
> +	vm->subblock_size = PAGE_SIZE * 1ul << max_t(uint32_t, MAX_ORDER - 1,
> +						     pageblock_order);
> +	vm->subblock_size = max_t(uint64_t, vm->device_block_size,
>  				  vm->subblock_size);
>  	vm->nb_sb_per_mb = memory_block_size_bytes() / vm->subblock_size;
>  
> @@ -1713,8 +1713,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
>  
>  	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
>  	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
> -	dev_info(&vm->vdev->dev, "device block size: 0x%x",
> -		 vm->device_block_size);
> +	dev_info(&vm->vdev->dev, "device block size: 0x%llx",
> +		 (unsigned long long)vm->device_block_size);
>  	dev_info(&vm->vdev->dev, "memory block size: 0x%lx",
>  		 memory_block_size_bytes());
>  	dev_info(&vm->vdev->dev, "subblock size: 0x%x",
> diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
> index a455c488a995..a9ffe041843c 100644
> --- a/include/uapi/linux/virtio_mem.h
> +++ b/include/uapi/linux/virtio_mem.h
> @@ -185,10 +185,10 @@ struct virtio_mem_resp {
>  
>  struct virtio_mem_config {
>  	/* Block size and alignment. Cannot change. */
> -	__u32 block_size;
> +	__u64 block_size;
>  	/* Valid with VIRTIO_MEM_F_ACPI_PXM. Cannot change. */
>  	__u16 node_id;
> -	__u16 padding;
> +	__u8 padding[6];
>  	/* Start address of the memory region. Cannot change. */
>  	__u64 addr;
>  	/* Region size (maximum). Cannot change. */
> 


-- 
Thanks,

David / dhildenb

