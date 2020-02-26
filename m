Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4C1C4BA1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB84720801
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e51f26/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgBZRqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:46:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25501 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgBZRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582739163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=OuRjWvoHjMsYr1nXv+KCcKFchlUgvDSOYjDXy45/uPA=;
        b=e51f26/dWFqCjMnc2mRf1nNFYx17pZqVT/ugbGoeg0U3Fxty/ZZ/Ju318W3/nFYEX6eihf
        iQu59qc3j1oPfsdbcVWjtauxD6AhD0GtyZ88cEYEVlaooiZYW/YVDM4NndjqdY5vnavaf5
        gaNTxXd5t7ccejHrdcFJWlA+/lqNn7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-5OCBKSBnOpewzERr7M3Yrw-1; Wed, 26 Feb 2020 12:45:58 -0500
X-MC-Unique: 5OCBKSBnOpewzERr7M3Yrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01FC0800D5F;
        Wed, 26 Feb 2020 17:45:57 +0000 (UTC)
Received: from [10.36.117.196] (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A4B41001DC0;
        Wed, 26 Feb 2020 17:45:51 +0000 (UTC)
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
To:     Yang Shi <yang.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
 <9c30a891-011b-e041-2647-444d09fa7b8a@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <84492260-726c-dda1-3ec8-b445fe269cad@redhat.com>
Date:   Wed, 26 Feb 2020 18:45:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9c30a891-011b-e041-2647-444d09fa7b8a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.02.20 18:31, Yang Shi wrote:
> 
> 
> On 2/21/20 4:24 PM, Alexander Duyck wrote:
>> On Fri, Feb 21, 2020 at 10:24 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>>>
>>>
>>> On 2/20/20 10:16 AM, Alexander Duyck wrote:
>>>> On Tue, Dec 3, 2019 at 4:43 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>>>>> Currently when truncating shmem file, if the range is partial of THP
>>>>> (start or end is in the middle of THP), the pages actually will just get
>>>>> cleared rather than being freed unless the range cover the whole THP.
>>>>> Even though all the subpages are truncated (randomly or sequentially),
>>>>> the THP may still be kept in page cache.  This might be fine for some
>>>>> usecases which prefer preserving THP.
>>>>>
>>>>> But, when doing balloon inflation in QEMU, QEMU actually does hole punch
>>>>> or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
>>>>> So, when using shmem THP as memory backend QEMU inflation actually doesn't
>>>>> work as expected since it doesn't free memory.  But, the inflation
>>>>> usecase really needs get the memory freed.  Anonymous THP will not get
>>>>> freed right away too but it will be freed eventually when all subpages are
>>>>> unmapped, but shmem THP would still stay in page cache.
>>>>>
>>>>> Split THP right away when doing partial hole punch, and if split fails
>>>>> just clear the page so that read to the hole punched area would return
>>>>> zero.
>>>>>
>>>>> Cc: Hugh Dickins <hughd@google.com>
>>>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>>> One question I would have is if this is really the desired behavior we
>>>> are looking for?
>>>>
>>>> By proactively splitting the THP you are likely going to see a
>>>> performance regression with the virtio-balloon driver enabled in QEMU.
>>>> I would suspect the response to that would be to update the QEMU code
>>>> to  identify the page size of the shared memory ramblock. At that
>>>> point I suspect it would start behaving the same as how it currently
>>>> handles anonymous memory, and the work done here would essentially
>>>> have been wasted other than triggering the desire to resolve this in
>>>> QEMU to avoid a performance regression.
>>>>
>>>> The code for inflating a the balloon in virtio-balloon in QEMU can be
>>>> found here:
>>>> https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c#L66
>>>>
>>>> If there is a way for us to just populate the value obtained via
>>>> qemu_ram_pagesize with the THP page size instead of leaving it at 4K,
>>>> which is the size I am assuming it is at since you indicated that it
>>>> is just freeing the base page size, then we could address the same
>>>> issue and likely get the desired outcome of freeing the entire THP
>>>> page when it is no longer used.
>>> If qemu could punch hole (this is how qemu free file-backed memory) in
>>> THP unit, either w/ or w/o the patch the THP won't get split since the
>>> whole THP will get truncated. But, if qemu has to free memory in sub-THP
>>> size due to whatever reason (for example, 1MB for every 2MB section),
>>> then we have to split THP otherwise no memory will be freed actually
>>> with the current code. It is not about performance, it is about really
>>> giving memory back to host.
>> I get that, but at the same time I am not sure if everyone will be
>> happy with the trade-off. That is my concern.
>>
>> You may want to change the patch description above if that is the
>> case. Based on the description above it makes it sound as if the issue
>> is that QEMU is using hole punch or MADV_DONTNEED with the wrong
>> granularity. Based on your comment here it sounds like you want to
>> have the ability to break up the larger THP page as soon as you want
>> to push out a single 4K page from it.
> 
> Yes, you are right. The commit log may be confusing. What I wanted to 
> convey is QEMU has no idea if THP is used or not so it treats memory 
> with base size unless hugetlbfs is used since QEMU is aware huge page is 
> used in this case.
> This may sounds irrelevant to the problem, I would just remove that.
> 
>>
>> I am not sure the description for the behavior of anonymous THP with
>> respect to QEMU makes sense either. Based on the description you made
>> it sound like it was somehow using the same process used for huge
>> pages. That isn't the case right? My understanding is that in the case
>> of an anonymous THP it is getting broken into 4K subpages and then
>> those are freed individually. That should leave you with the same
>> performance regression that I had brought up earlier.
> 
> No, anonymous THP won't get split immediately and those memory also 
> won't get freed immediately if QEMU does MADV_DONTNEED on sub THP range 
> (for example, 1MB range in THP). The THP will get freed when:
> 1. Host has memory pressure. The THP will get split and unmapped pages 
> will be freed.
> 2. Other sub pages in the same THP are MADV_DONTNEED'ed (eventually the 
> whole THP get unmapped).
> 
> The difference between shmem and anonymous page is shmem will not get 
> freed unless hole punch the whole THP, anonymous page will get freed 
> sooner or later.
> 

As far as I understood Hugh, the "page size" we'll see in QEMU via
fstatfs() is 4k, not 2MB. IMHO, that's the block size of the "device",
and breaking up THP is the right think to to obey the documentation of
"FALLOC_FL_PUNCH_HOLE".

IMHO THP is called "transparent" because it shouldn't have any such
visible side effects.

As always, anybody correct me if I am wrong here.

-- 
Thanks,

David / dhildenb

