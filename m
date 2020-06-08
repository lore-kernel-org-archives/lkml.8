Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75824C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56AFB204EF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgFHHMX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:12:23 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:58283 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728948AbgFHHMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:12:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U-vT7af_1591600330;
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0U-vT7af_1591600330)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Jun 2020 15:12:13 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] virtio_mem: prevent overflow with subblock size
From:   teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <0930c9d0-0708-c079-29bd-b80d4e3ce446@redhat.com>
Date:   Mon, 8 Jun 2020 15:12:09 +0800
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        virtualization@lists.linux-foundation.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2D9A07BA-6FDC-48FF-9A1F-62272695B3EF@linux.alibaba.com>
References: <20200608061406.709211-1-mst@redhat.com>
 <0930c9d0-0708-c079-29bd-b80d4e3ce446@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2020年6月8日 14:58，David Hildenbrand <david@redhat.com> 写道：
> 
> On 08.06.20 08:14, Michael S. Tsirkin wrote:
>> If subblock size is large (e.g. 1G) 32 bit math involving it
>> can overflow. Rather than try to catch all instances of that,
>> let's tweak block size to 64 bit.
> 
> I fail to see where we could actually trigger an overflow. The reported
> warning looked like a false positive to me.
> 
>> 
>> It ripples through UAPI which is an ABI change, but it's not too late to
>> make it, and it will allow supporting >4Gbyte blocks while might
>> become necessary down the road.
>> 
> 
> This might break cloud-hypervisor, who's already implementing this
> protocol upstream (ccing Hui).
> https://github.com/cloud-hypervisor/cloud-hypervisor/blob/master/vm-virtio/src/mem.rs
> 
> (blocks in the gigabyte range were never the original intention of
> virtio-mem, but I am not completely opposed to that)

If you think virtio_mem need this patch, I think cloud-hypervisor should follow this update (I will post PR for it).

Best,
Hui

> 
>> Fixes: 5f1f79bbc9e26 ("virtio-mem: Paravirtualized memory hotplug")
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>> drivers/virtio/virtio_mem.c     | 14 +++++++-------
>> include/uapi/linux/virtio_mem.h |  4 ++--
>> 2 files changed, 9 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index 2f357142ea5e..7b1bece8a331 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -77,7 +77,7 @@ struct virtio_mem {
>> 	uint64_t requested_size;
>> 
>> 	/* The device block size (for communicating with the device). */
>> -	uint32_t device_block_size;
>> +	uint64_t device_block_size;
>> 	/* The translated node id. NUMA_NO_NODE in case not specified. */
>> 	int nid;
>> 	/* Physical start address of the memory region. */
>> @@ -86,7 +86,7 @@ struct virtio_mem {
>> 	uint64_t region_size;
>> 
>> 	/* The subblock size. */
>> -	uint32_t subblock_size;
>> +	uint64_t subblock_size;
>> 	/* The number of subblocks per memory block. */
>> 	uint32_t nb_sb_per_mb;
>> 
>> @@ -1698,9 +1698,9 @@ static int virtio_mem_init(struct virtio_mem *vm)
>> 	 * - At least the device block size.
>> 	 * In the worst case, a single subblock per memory block.
>> 	 */
>> -	vm->subblock_size = PAGE_SIZE * 1u << max_t(uint32_t, MAX_ORDER - 1,
>> -						    pageblock_order);
>> -	vm->subblock_size = max_t(uint32_t, vm->device_block_size,
>> +	vm->subblock_size = PAGE_SIZE * 1ul << max_t(uint32_t, MAX_ORDER - 1,
>> +						     pageblock_order);
>> +	vm->subblock_size = max_t(uint64_t, vm->device_block_size,
>> 				  vm->subblock_size);
>> 	vm->nb_sb_per_mb = memory_block_size_bytes() / vm->subblock_size;
>> 
>> @@ -1713,8 +1713,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
>> 
>> 	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
>> 	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
>> -	dev_info(&vm->vdev->dev, "device block size: 0x%x",
>> -		 vm->device_block_size);
>> +	dev_info(&vm->vdev->dev, "device block size: 0x%llx",
>> +		 (unsigned long long)vm->device_block_size);
>> 	dev_info(&vm->vdev->dev, "memory block size: 0x%lx",
>> 		 memory_block_size_bytes());
>> 	dev_info(&vm->vdev->dev, "subblock size: 0x%x",
>> diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
>> index a455c488a995..a9ffe041843c 100644
>> --- a/include/uapi/linux/virtio_mem.h
>> +++ b/include/uapi/linux/virtio_mem.h
>> @@ -185,10 +185,10 @@ struct virtio_mem_resp {
>> 
>> struct virtio_mem_config {
>> 	/* Block size and alignment. Cannot change. */
>> -	__u32 block_size;
>> +	__u64 block_size;
>> 	/* Valid with VIRTIO_MEM_F_ACPI_PXM. Cannot change. */
>> 	__u16 node_id;
>> -	__u16 padding;
>> +	__u8 padding[6];
>> 	/* Start address of the memory region. Cannot change. */
>> 	__u64 addr;
>> 	/* Region size (maximum). Cannot change. */
>> 
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb

