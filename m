Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F482206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGPIZL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:25:11 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:50431 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbgGPIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:25:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U2shvgI_1594887901;
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0U2shvgI_1594887901)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jul 2020 16:25:05 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC for Linux v4 1/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
From:   teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20200716024114-mutt-send-email-mst@kernel.org>
Date:   Thu, 16 Jul 2020 16:25:00 +0800
Cc:     Hui Zhu <teawater@gmail.com>, David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CEB4BCB7-E146-4F62-A8AC-8641B5469963@linux.alibaba.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <1594867315-8626-2-git-send-email-teawater@gmail.com>
 <20200716024114-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2020年7月16日 14:43，Michael S. Tsirkin <mst@redhat.com> 写道：
> 
> On Thu, Jul 16, 2020 at 10:41:51AM +0800, Hui Zhu wrote:
>> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
>> index dc3e656..4d0151a 100644
>> --- a/include/uapi/linux/virtio_balloon.h
>> +++ b/include/uapi/linux/virtio_balloon.h
>> @@ -37,6 +37,7 @@
>> #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>> #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>> #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
>> +#define VIRTIO_BALLOON_F_CONT_PAGES	6 /* VQ to report continuous pages */
>> 
>> /* Size of a PFN in the balloon interface. */
>> #define VIRTIO_BALLOON_PFN_SHIFT 12
> 
> So how does the guest/host interface look like?
> Could you write up something about it?

Continuous pages are report by num_pfns and pfns in virtio_balloon too.
The function to set pfns is set_page_pfns_size in https://github.com/teawater/linux/blob/balloon_conts/drivers/virtio/virtio_balloon.c#L221

static void set_page_pfns_size(struct virtio_balloon *vb,
                               __virtio32 pfns[], struct page *page,
                               size_t size)
{
        /* Set the first pfn of the continuous pages.  */
        pfns[0] = cpu_to_virtio32(vb->vdev, page_to_balloon_pfn(page));
        /* Set the size of the continuous pages.  */
        pfns[1] = (__virtio32) size;
}

Each of continuous pages need 2 pfn.
The first pfn of the pages is set to pfns[0].  The size of the pages is set to pfns[1].

The pfn is 32 bits.
So the max order of inflate continuous pages is VIRTIO_BALLOON_INFLATE_MAX_ORDER.
#define VIRTIO_BALLOON_INFLATE_MAX_ORDER min((int) (sizeof(__virtio32) * BITS_PER_BYTE - \
                                                    1 - PAGE_SHIFT), (MAX_ORDER-1))

The max page number of deflate continuous pages is VIRTIO_BALLOON_DEFLATE_MAX_PAGES_NUM.
#define VIRTIO_BALLOON_DEFLATE_MAX_PAGES_NUM (((__virtio32)~0U) >> PAGE_SHIFT)

Best,
Hui
