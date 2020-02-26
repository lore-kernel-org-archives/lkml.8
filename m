Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54485C4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328C720801
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgBZRoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:44:03 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:45129 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbgBZRoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:44:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tr-OYTc_1582739036;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tr-OYTc_1582739036)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 27 Feb 2020 01:43:58 +0800
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
To:     Hugh Dickins <hughd@google.com>
Cc:     kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.LSU.2.11.1912041601270.12930@eggly.anvils>
 <00f0bb7d-3c25-a65f-ea94-3e2de8e9bcdd@linux.alibaba.com>
 <alpine.LSU.2.11.2002241831060.3084@eggly.anvils>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <cba16817-8555-f84f-134a-1ff9f168247b@linux.alibaba.com>
Date:   Wed, 26 Feb 2020 09:43:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2002241831060.3084@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/20 7:46 PM, Hugh Dickins wrote:
> On Tue, 14 Jan 2020, Yang Shi wrote:
>> On 12/4/19 4:15 PM, Hugh Dickins wrote:
>>> On Wed, 4 Dec 2019, Yang Shi wrote:
>>>
>>>> Currently when truncating shmem file, if the range is partial of THP
>>>> (start or end is in the middle of THP), the pages actually will just get
>>>> cleared rather than being freed unless the range cover the whole THP.
>>>> Even though all the subpages are truncated (randomly or sequentially),
>>>> the THP may still be kept in page cache.  This might be fine for some
>>>> usecases which prefer preserving THP.
>>>>
>>>> But, when doing balloon inflation in QEMU, QEMU actually does hole punch
>>>> or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
>>>> So, when using shmem THP as memory backend QEMU inflation actually
>>>> doesn't
>>>> work as expected since it doesn't free memory.  But, the inflation
>>>> usecase really needs get the memory freed.  Anonymous THP will not get
>>>> freed right away too but it will be freed eventually when all subpages
>>>> are
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
>>>> ---
>>>> v2: * Adopted the comment from Kirill.
>>>>       * Dropped fallocate mode flag, THP split is the default behavior.
>>>>       * Blended Huge's implementation with my v1 patch. TBH I'm not very
>>>> keen to
>>>>         Hugh's find_get_entries() hack (basically neutral), but without
>>>> that hack
>>> Thanks for giving it a try.  I'm not neutral about my find_get_entries()
>>> hack: it surely had to go (without it, I'd have just pushed my own patch).
>>> I've not noticed anything wrong with your patch, and it's in the right
>>> direction, but I'm still not thrilled with it.  I also remember that I
>>> got the looping wrong in my first internal attempt (fixed in what I sent),
>>> and need to be very sure of the try-again-versus-move-on-to-next conditions
>>> before agreeing to anything.  No rush, I'll come back to this in days or
>>> month ahead: I'll try to find a less gotoey blend of yours and mine.
>> Hi Hugh,
>>
>> Any update on this one?
> I apologize for my dreadful unresponsiveness.
>
> I've spent the last day trying to love yours, and considering how mine
> might be improved; but repeatedly arrived at the conclusion that mine is
> about as nice as we can manage, just needing more comment to dignify it.

Those gotoes do seems convoluted, I do agree.

>
> I did willingly call my find_get_entries() stopping at PageTransCompound
> a hack; but now think we should just document that behavior and accept it.
> The contortions of your patch come from the need to release those 14 extra
> unwanted references: much better not to get them in the first place.
>
> Neither of us handle a failed split optimally, we treat every tail as an
> opportunity to retry: which is good to recover from transient failures,
> but probably excessive.  And we both have to restart the pagevec after
> each attempt, but at least I don't get 14 unwanted extras each time.
>
> What of other find_get_entries() users and its pagevec_lookup_entries()
> wrapper: does an argument to select this "stop at PageTransCompound"
> behavior need to be added?
>
> No.  The pagevec_lookup_entries() calls from mm/truncate.c prefer the
> new behavior - evicting the head from page cache removes all the tails
> along with it, so getting the tails a waste of time there too, just as
> it was in shmem_undo_range().

TBH I'm not a fun of this hack. This would bring in other confusion or 
complexity. Pagevec is supposed to count in the number of base page, now 
it would treat THP as one page, and there might be mixed base page and 
THP in one pagevec. But, I tend to agree avoiding getting those 14 extra 
pins at the first place might be a better approach. All the complexity 
are used to release those extra pins.

>
> Whereas shmem_unlock_mapping() and shmem_seek_hole_data(), as they
> stand, are not removing pages from cache, but actually wanting to plod
> through the tails.  So those two would be slowed a little, while the
> pagevec collects 1 instead of 15 pages.  However: if we care about those
> two at all, it's clear that we should speed them up, by noticing the
> PageTransCompound case and accelerating over it, instead of plodding
> through the tails.  Since we haven't bothered with that optimization
> yet, I'm not very worried to slow them down a little until it's done.
>
> I must take a look at where we stand with tmpfs 64-bit ino tomorrow,
> then recomment my shmem_punch_compound() patch and post it properly,
> probably day after.  (Reviewing it, I see I have a "page->index +
> HPAGE_PMD_NR <= end" test which needs correcting - I tend to live
> in the past, before v4.13 doubled the 32-bit MAX_LFS_FILESIZE.)
>
> I notice that this thread has veered off into QEMU ballooning
> territory: which may indeed be important, but there's nothing at all
> that I can contribute on that.  I certainly do not want to slow down
> anything important, but remain convinced that the correct filesystem
> implementation for punching a hole is to punch a hole.
>
> Hugh

