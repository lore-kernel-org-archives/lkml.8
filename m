Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1A0C3565D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E00D20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgBUSYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:24:22 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54280 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726408AbgBUSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:24:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TqXYzc5_1582309453;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TqXYzc5_1582309453)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 22 Feb 2020 02:24:16 +0800
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <CAKgT0UdHhZznoS0kMdacCqgc=sFXj1Djmpd-DbPvAmyrhJq6CA@mail.gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <9b8ff9ca-75b0-c256-cf37-885ccd786de7@linux.alibaba.com>
Date:   Fri, 21 Feb 2020 10:24:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdHhZznoS0kMdacCqgc=sFXj1Djmpd-DbPvAmyrhJq6CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/20 10:16 AM, Alexander Duyck wrote:
> On Tue, Dec 3, 2019 at 4:43 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>> Currently when truncating shmem file, if the range is partial of THP
>> (start or end is in the middle of THP), the pages actually will just get
>> cleared rather than being freed unless the range cover the whole THP.
>> Even though all the subpages are truncated (randomly or sequentially),
>> the THP may still be kept in page cache.  This might be fine for some
>> usecases which prefer preserving THP.
>>
>> But, when doing balloon inflation in QEMU, QEMU actually does hole punch
>> or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
>> So, when using shmem THP as memory backend QEMU inflation actually doesn't
>> work as expected since it doesn't free memory.  But, the inflation
>> usecase really needs get the memory freed.  Anonymous THP will not get
>> freed right away too but it will be freed eventually when all subpages are
>> unmapped, but shmem THP would still stay in page cache.
>>
>> Split THP right away when doing partial hole punch, and if split fails
>> just clear the page so that read to the hole punched area would return
>> zero.
>>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> One question I would have is if this is really the desired behavior we
> are looking for?
>
> By proactively splitting the THP you are likely going to see a
> performance regression with the virtio-balloon driver enabled in QEMU.
> I would suspect the response to that would be to update the QEMU code
> to  identify the page size of the shared memory ramblock. At that
> point I suspect it would start behaving the same as how it currently
> handles anonymous memory, and the work done here would essentially
> have been wasted other than triggering the desire to resolve this in
> QEMU to avoid a performance regression.
>
> The code for inflating a the balloon in virtio-balloon in QEMU can be
> found here:
> https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c#L66
>
> If there is a way for us to just populate the value obtained via
> qemu_ram_pagesize with the THP page size instead of leaving it at 4K,
> which is the size I am assuming it is at since you indicated that it
> is just freeing the base page size, then we could address the same
> issue and likely get the desired outcome of freeing the entire THP
> page when it is no longer used.

If qemu could punch hole (this is how qemu free file-backed memory) in 
THP unit, either w/ or w/o the patch the THP won't get split since the 
whole THP will get truncated. But, if qemu has to free memory in sub-THP 
size due to whatever reason (for example, 1MB for every 2MB section), 
then we have to split THP otherwise no memory will be freed actually 
with the current code. It is not about performance, it is about really 
giving memory back to host.

>
> - Alex

