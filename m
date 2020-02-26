Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E1AC4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0B1222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgBZRcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:32:00 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:58114 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbgBZRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:32:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tr-QObo_1582738311;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tr-QObo_1582738311)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 27 Feb 2020 01:31:54 +0800
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <CAKgT0UdHhZznoS0kMdacCqgc=sFXj1Djmpd-DbPvAmyrhJq6CA@mail.gmail.com>
 <9b8ff9ca-75b0-c256-cf37-885ccd786de7@linux.alibaba.com>
 <CAKgT0UfPW+DKZhze-hCL6mThak+qJjx4wb-rXn+NKnp6-9RBDQ@mail.gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <9c30a891-011b-e041-2647-444d09fa7b8a@linux.alibaba.com>
Date:   Wed, 26 Feb 2020 09:31:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfPW+DKZhze-hCL6mThak+qJjx4wb-rXn+NKnp6-9RBDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/20 4:24 PM, Alexander Duyck wrote:
> On Fri, Feb 21, 2020 at 10:24 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>>
>>
>> On 2/20/20 10:16 AM, Alexander Duyck wrote:
>>> On Tue, Dec 3, 2019 at 4:43 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>>>> Currently when truncating shmem file, if the range is partial of THP
>>>> (start or end is in the middle of THP), the pages actually will just get
>>>> cleared rather than being freed unless the range cover the whole THP.
>>>> Even though all the subpages are truncated (randomly or sequentially),
>>>> the THP may still be kept in page cache.  This might be fine for some
>>>> usecases which prefer preserving THP.
>>>>
>>>> But, when doing balloon inflation in QEMU, QEMU actually does hole punch
>>>> or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
>>>> So, when using shmem THP as memory backend QEMU inflation actually doesn't
>>>> work as expected since it doesn't free memory.  But, the inflation
>>>> usecase really needs get the memory freed.  Anonymous THP will not get
>>>> freed right away too but it will be freed eventually when all subpages are
>>>> unmapped, but shmem THP would still stay in page cache.
>>>>
>>>> Split THP right away when doing partial hole punch, and if split fails
>>>> just clear the page so that read to the hole punched area would return
>>>> zero.
>>>>
>>>> Cc: Hugh Dickins <hughd@google.com>
>>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>> One question I would have is if this is really the desired behavior we
>>> are looking for?
>>>
>>> By proactively splitting the THP you are likely going to see a
>>> performance regression with the virtio-balloon driver enabled in QEMU.
>>> I would suspect the response to that would be to update the QEMU code
>>> to  identify the page size of the shared memory ramblock. At that
>>> point I suspect it would start behaving the same as how it currently
>>> handles anonymous memory, and the work done here would essentially
>>> have been wasted other than triggering the desire to resolve this in
>>> QEMU to avoid a performance regression.
>>>
>>> The code for inflating a the balloon in virtio-balloon in QEMU can be
>>> found here:
>>> https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c#L66
>>>
>>> If there is a way for us to just populate the value obtained via
>>> qemu_ram_pagesize with the THP page size instead of leaving it at 4K,
>>> which is the size I am assuming it is at since you indicated that it
>>> is just freeing the base page size, then we could address the same
>>> issue and likely get the desired outcome of freeing the entire THP
>>> page when it is no longer used.
>> If qemu could punch hole (this is how qemu free file-backed memory) in
>> THP unit, either w/ or w/o the patch the THP won't get split since the
>> whole THP will get truncated. But, if qemu has to free memory in sub-THP
>> size due to whatever reason (for example, 1MB for every 2MB section),
>> then we have to split THP otherwise no memory will be freed actually
>> with the current code. It is not about performance, it is about really
>> giving memory back to host.
> I get that, but at the same time I am not sure if everyone will be
> happy with the trade-off. That is my concern.
>
> You may want to change the patch description above if that is the
> case. Based on the description above it makes it sound as if the issue
> is that QEMU is using hole punch or MADV_DONTNEED with the wrong
> granularity. Based on your comment here it sounds like you want to
> have the ability to break up the larger THP page as soon as you want
> to push out a single 4K page from it.

Yes, you are right. The commit log may be confusing. What I wanted to 
convey is QEMU has no idea if THP is used or not so it treats memory 
with base size unless hugetlbfs is used since QEMU is aware huge page is 
used in this case.
This may sounds irrelevant to the problem, I would just remove that.

>
> I am not sure the description for the behavior of anonymous THP with
> respect to QEMU makes sense either. Based on the description you made
> it sound like it was somehow using the same process used for huge
> pages. That isn't the case right? My understanding is that in the case
> of an anonymous THP it is getting broken into 4K subpages and then
> those are freed individually. That should leave you with the same
> performance regression that I had brought up earlier.

No, anonymous THP won't get split immediately and those memory also 
won't get freed immediately if QEMU does MADV_DONTNEED on sub THP range 
(for example, 1MB range in THP). The THP will get freed when:
1. Host has memory pressure. The THP will get split and unmapped pages 
will be freed.
2. Other sub pages in the same THP are MADV_DONTNEED'ed (eventually the 
whole THP get unmapped).

The difference between shmem and anonymous page is shmem will not get 
freed unless hole punch the whole THP, anonymous page will get freed 
sooner or later.

>
> So if anything it sounds like what you are really wanting is feature
> parity with anonymous THP which will split the anonymous THP page when
> a single 4K page within the THP is hit with MADV_DONTNEED.
>
> - Alex

