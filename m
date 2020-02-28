Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4D5C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22245222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgB1W2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:28:41 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:41492 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgB1W2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 17:28:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TrAtt5r_1582928912;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TrAtt5r_1582928912)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 29 Feb 2020 06:28:36 +0800
Subject: Re: [PATCH] huge tmpfs: try to split_huge_page() when punching hole
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <alpine.LSU.2.11.2002261959020.10801@eggly.anvils>
 <20200227084704.aolem5nktpricrzo@box>
 <alpine.LSU.2.11.2002271909250.2026@eggly.anvils>
 <20200228042646.GF29971@bombadil.infradead.org>
 <20200228125407.5lnmjtnvlcnniokt@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <28448f09-3418-e0ad-b974-c540f2e7332b@linux.alibaba.com>
Date:   Fri, 28 Feb 2020 14:28:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200228125407.5lnmjtnvlcnniokt@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/20 4:54 AM, Kirill A. Shutemov wrote:
> On Thu, Feb 27, 2020 at 08:26:46PM -0800, Matthew Wilcox wrote:
>> On Thu, Feb 27, 2020 at 08:04:21PM -0800, Hugh Dickins wrote:
>>> It's good to consider the implications for hole-punch on a persistent
>>> filesystem cached with THPs (or lower order compound pages); but I
>>> disagree that they should behave differently from this patch.
>>>
>>> The hole-punch is fundamentally directed at freeing up the storage, yes;
>>> but its page cache must also be removed, otherwise you have the user
>>> writing into cache which is not backed by storage, and potentially losing
>>> the data later.  So a hole must be punched in the compound page in that
>>> case too: in fact, it's then much more important that split_huge_page()
>>> succeeds - not obvious what the fallback should be if it fails (perhaps
>>> in that case the compound page must be kept, but all its pmds removed,
>>> and info on holes kept in spare fields of the compound page, to prevent
>>> writes and write faults without calling back into the filesystem:
>>> soluble, but more work than tmpfs needs today)(and perhaps when that
>>> extra work is done, we would choose to rely on it rather than
>>> immediately splitting; but it will involve discounting the holes).
>> Ooh, a topic that reasonable people can disagree on!
> Hugh wins me over on this.
>
> Removing PMDs will not do much as we track dirty status on compound page
> level.
>
> I see two reasonable options for persistent filesystem to handle the
> punch hole:
>
>    - Keep the page and PMD mappings intact, but trigger writeback if page
>      is dirty. After the page is clean we can safely punch hole in the
>      storage. Following write access to the area would trigger
>      page_mkwrite() which would allocate storage accordingly.
>
>      This is reasonable behaviour if we allow to allocate THPs not fully
>      covered by space allocated on disk.
>
>    - Try to split the page or drop it completely from the page cache (after
>      write back if need) before punching the hole. Fallback to the first
>      scenario if we cannot split or get rid of the page.
>
> I cannot say I strongly prefer one approach over another. The first one
> fits better with THP attitude: pay for performance with memory (and
> storage I guess). The second may work better if resources is limited.

I'm afraid any approach which would not drop page cache may get us end 
up being in the same situation as what Hugh or my patch is trying to 
solve. IMHO the latter one might be preferred.

>
>> The current prototype I have will allocate (huge) pages and then
>> ask the filesystem to fill them.  The filesystem may well find that
>> the extent is a hole, and if it is, it will fill the page with zeroes.
>> Then, the application may write to those pages, and if it does, the
>> filesystem will be notified to create an on-disk extent for that write.
>>
>> I haven't looked at the hole-punch path in detail, but presumably it
>> notifies the filesystem to create a hole extent and zeroes out the
>> pagecache for that range (possibly by removing entire pages, and with
>> memset for partial pages).  Then a subsequent write to the hole will
>> cause the filesystem to allocate a new non-hole extent, just like the
>> previous case.
>>
>> I think it's reasonable for the page cache to interpret a hole-punch
>> request as being a hint that the hole is unlikely to be accessed again,
>> so allocating new smaller pages for that region of the file (or just
>> writing back & dropping the covering page altogether) would seem like
>> a reasonable implementation decision.
>>
>> However, it also seems reasonable that just memset() of the affected
>> region and leaving the page intact would also be an acceptable
>> implementation.  As long as writes to the newly-created hole cause the
>> page to become dirtied and thus writeback to be in effect.  It probably
>> wouldn't be as good an implementation, but it shouldn't lose writes as
>> you suggest above.
>>
>> I'm not sure I'd choose to split a large page into smaller pages.  I think
>> I'd prefer to allocate lower-order pages and memcpy() the data over.
>> Again, that's an implementation choice, and not something that should
>> be visible outside the implementation.
> Copying over the data has the same limitation as split: you need to get
> refcounts to the well-known state (no extra pins) before you can proceed.
> So it will not be never-fail operation.
>
>> [1] http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray-pagecache

