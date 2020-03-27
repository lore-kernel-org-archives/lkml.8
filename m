Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78081C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 04:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B878206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 04:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgC0Ell (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 00:41:41 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:40430 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbgC0Elk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 00:41:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ttk74ST_1585283958;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0Ttk74ST_1585283958)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 Mar 2020 12:39:19 +0800
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <20200319190512.cwnvgvv3upzcchkm@ca-dmjordan1.us.oracle.com>
 <20200326185822.6n56yl2llvdranur@ca-dmjordan1.us.oracle.com>
 <CA+CK2bDQ6qPfLsx=81L3_DVzvoCjkBRKvcw0Tz4Gd=Fd6pgQ3A@mail.gmail.com>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <427ce795-0274-56e5-16e4-7be00c7145f7@linux.alibaba.com>
Date:   Fri, 27 Mar 2020 12:39:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bDQ6qPfLsx=81L3_DVzvoCjkBRKvcw0Tz4Gd=Fd6pgQ3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/27 03:36, Pavel Tatashin wrote:
> I agree with Daniel, we should look into approach where
> pgdat_resize_lock is taken only for the duration of updating tracking
> values such as pgdat->first_deferred_pfn (perhaps we would need to add
> another tracker that would show chunks that are currently being worked
> on).
>
> The vast duration of struct page initialization process should happen
> outside of this lock, and only be taken when we update globally seen
> data structures: lists, tracking variables. This way we can solve
> several problems: 1. allow interrupt threads to grow zones if
> required. 2. keep jiffies happy. 3. allow future scaling when we will
> add inner node threads to initialize struct pages (i.e. ktasks from
> Daniel).

It make sense, looking forward to the inner node parallel init.

@Daniel
Is there schedule about ktasks?

Thanks!

>
> Pasha
>
> On Thu, Mar 26, 2020 at 2:58 PM Daniel Jordan
> <daniel.m.jordan@oracle.com> wrote:
>> On Thu, Mar 19, 2020 at 03:05:12PM -0400, Daniel Jordan wrote:
>>> Regardless,
>>> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>> Darn, I spoke too soon.
>>
>> On a two-socket Xeon, smaller values of TICK_PAGE_COUNT caused the deferred
>> init timestamp to grow by over 25%.  This was with pgdatinit0 bound to the
>> timer interrupt CPU to make sure the issue always reproduces.
>>
>>                 TICK_PAGE_COUNT     node 0 deferred
>>                                     init time (ms)
>>                 ---------------     ---------------
>>                            4096                 610
>>                            8192                 587
>>                           16384                 487
>>                           32768                 480    // used in the patch
>>
>> Instead of trying to find a constant that lets the timer interrupt run often
>> enough, I think a better way forward is to reconsider how we handle the resize
>> lock.  I plan to prototype something and reply back with what I get.

Yes, the time spend of pages init depends on the CPU frequency,
and the jiffies update controlled by HZ, so it's hard to find a general 
constant.

It seems we need a bigger refactors about the lock to get a better solution.


