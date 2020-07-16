Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F58C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C346206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgGPHcn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:32:43 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37076 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbgGPHcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:32:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U2sTlwu_1594884751;
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0U2sTlwu_1594884751)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jul 2020 15:32:37 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [virtio-dev] [RFC for qemu v4 2/2] virtio_balloon: Add dcvq to
 deflate continuous pages
From:   teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20200716023910-mutt-send-email-mst@kernel.org>
Date:   Thu, 16 Jul 2020 15:32:30 +0800
Cc:     Hui Zhu <teawater@gmail.com>, david@redhat.com,
        jasowang@redhat.com, akpm@linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4F64B592-03CF-46F5-B761-78B4EBA5028E@linux.alibaba.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <1594867315-8626-6-git-send-email-teawater@gmail.com>
 <20200716023910-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2020年7月16日 14:39，Michael S. Tsirkin <mst@redhat.com> 写道：
> 
> On Thu, Jul 16, 2020 at 10:41:55AM +0800, Hui Zhu wrote:
>> This commit adds a vq dcvq to deflate continuous pages.
>> When VIRTIO_BALLOON_F_CONT_PAGES is set, try to get continuous pages
>> from icvq and use madvise MADV_WILLNEED with the pages.
>> 
>> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> 
> This is arguably something to benchmark. Does guest benefit
> from MADV_WILLNEED or loose performance?

MADV_WILLNEED will call madvise_willneed in the host kernel.
madvise_willneed will schedule all required I/O operations (swap in or vfs_fadvise POSIX_FADV_WILLNEED) of the address.

But the pages of the balloon are released by MADV_DONTNEED.
So I think MADV_WILLNEED will not affect the performance of the guest in the most of situations.

Best,
Hui

> 
>> ---
>> hw/virtio/virtio-balloon.c         | 14 +++++++++-----
>> include/hw/virtio/virtio-balloon.h |  2 +-
>> 2 files changed, 10 insertions(+), 6 deletions(-)
>> 
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index d36a5c8..165adf7 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -138,7 +138,8 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
>> }
>> 
>> static void balloon_deflate_page(VirtIOBalloon *balloon,
>> -                                 MemoryRegion *mr, hwaddr mr_offset)
>> +                                 MemoryRegion *mr, hwaddr mr_offset,
>> +                                 size_t size)
>> {
>>     void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
>>     ram_addr_t rb_offset;
>> @@ -153,10 +154,11 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
>>     rb_page_size = qemu_ram_pagesize(rb);
>> 
>>     host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
>> +    size &= ~(rb_page_size - 1);
>> 
>>     /* When a page is deflated, we hint the whole host page it lives
>>      * on, since we can't do anything smaller */
>> -    ret = qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNEED);
>> +    ret = qemu_madvise(host_addr, size, QEMU_MADV_WILLNEED);
>>     if (ret != 0) {
>>         warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s",
>>                     strerror(errno));
>> @@ -354,7 +356,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>>             pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
>>             offset += 4;
>> 
>> -            if (vq == s->icvq) {
>> +            if (vq == s->icvq || vq == s->dcvq) {
>>                 uint32_t psize_ptr;
>>                 if (iov_to_buf(elem->out_sg, elem->out_num, offset, &psize_ptr, 4) != 4) {
>>                     break;
>> @@ -383,8 +385,9 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>>                     balloon_inflate_page(s, section.mr,
>>                                          section.offset_within_region,
>>                                          psize, &pbp);
>> -                } else if (vq == s->dvq) {
>> -                    balloon_deflate_page(s, section.mr, section.offset_within_region);
>> +                } else if (vq == s->dvq || vq == s->dcvq) {
>> +                    balloon_deflate_page(s, section.mr, section.offset_within_region,
>> +                                         psize);
>>                 } else {
>>                     g_assert_not_reached();
>>                 }
>> @@ -838,6 +841,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>> 
>>     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
>>         s->icvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>> +        s->dcvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>>     }
>> 
>>     reset_stats(s);
>> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
>> index 6a2514d..848a7fb 100644
>> --- a/include/hw/virtio/virtio-balloon.h
>> +++ b/include/hw/virtio/virtio-balloon.h
>> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
>> 
>> typedef struct VirtIOBalloon {
>>     VirtIODevice parent_obj;
>> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
>> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq, *dcvq;
>>     uint32_t free_page_report_status;
>>     uint32_t num_pages;
>>     uint32_t actual;
>> -- 
>> 2.7.4
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

