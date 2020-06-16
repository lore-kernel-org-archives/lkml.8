Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C224C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3260D206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgFPHpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:45:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:44598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFPHpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:45:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 10875AFBE;
        Tue, 16 Jun 2020 07:45:43 +0000 (UTC)
Subject: Re: [PATCH] mm, page_alloc: capture page in task context only
To:     Hugh Dickins <hughd@google.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Wang <liwang@redhat.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <alpine.LSU.2.11.2006101342250.4607@eggly.anvils>
 <01287865-153d-42e7-afd8-1178ec6bc5b9@suse.cz>
 <alpine.LSU.2.11.2006151337150.11413@eggly.anvils>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b17acf5b-5e8a-3edf-5a64-603bf6177312@suse.cz>
Date:   Tue, 16 Jun 2020 09:45:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2006151337150.11413@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 11:03 PM, Hugh Dickins wrote:
> On Fri, 12 Jun 2020, Vlastimil Babka wrote:
>> > This could presumably be fixed by a barrier() before setting
>> > current->capture_control in compact_zone_order(); but would also need
>> > more care on return from compact_zone(), in order not to risk leaking
>> > a page captured by interrupt just before capture_control is reset.
>> 
>> I was hoping a WRITE_ONCE(current->capture_control) would be enough,
>> but apparently it's not (I tried).
> 
> Right, I don't think volatiles themselves actually constitute barriers;
> but I'd better keep quiet, I notice the READ_ONCE/WRITE_ONCE/data_race
> industry has been busy recently, and I'm likely out-of-date and mistaken.

Same here, but from what I've read, volatiles should enforce order against other
volatiles, but not non-volatiles (which is the struct initialization). So
barrier() is indeed necessary, and WRITE_ONCE just to prevent (very
hypothetical, hopefully) store tearing.

>> 
>> > Maybe that is the preferable fix, but I felt safer for task_capc() to
>> > exclude the rather surprising possibility of capture at interrupt time.
>> 
>> > Fixes: 5e1f0f098b46 ("mm, compaction: capture a page under direct compaction")
>> > Cc: stable@vger.kernel.org # 5.1+
>> > Signed-off-by: Hugh Dickins <hughd@google.com>
>> 
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Thanks, and to Mel for his.
> 
>> 
>> But perhaps I would also make sure that we don't expose the half initialized
>> capture_control and run into this problem again later. It's not like this is a
>> fast path where barriers hurt. Something like this then? (with added comments)
> 
> Would it be very rude if I leave that to you and to Mel? to add, or

No problem.

> to replace mine if you wish - go ahead.  I can easily see that more
> sophistication at the compact_zone_order() end may be preferable to
> another test and branch inside __free_one_page()

Right, I think so, and will also generally sleep better if we don't put pointers
to unitialized structures to current.

> (and would task_capc()
> be better with an "unlikely" in it?).

I'll try and see if it generates better code. We should be also able to remove
the "capc->cc->direct_compaction" check, as the only place where we set capc is
compact_zone_order() which sets direct_compaction true unconditionally.

> But it seems unnecessary to have a fix at both ends, and I'm rather too
> wound up in other things at the moment, to want to read up on the current
> state of such barriers, and sign off on the Vlastipatch below myself (but
> I do notice that READ_ONCE seems to have more in it today than I remember,
> which probably accounts for why you did not put the barrier() I expected
> to see on the way out).

Right, minimally it's a volatile cast (I've checked 5.1 too, for stable reasons)
which should be enough.

So I'll send the proper patch.

Thanks!
Vlastimil

> Hugh
> 
>> 
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index fd988b7e5f2b..c89e26817278 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -2316,15 +2316,17 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
>>  		.page = NULL,
>>  	};
>>  
>> -	current->capture_control = &capc;
>> +	barrier();
>> +
>> +	WRITE_ONCE(current->capture_control, &capc);
>>  
>>  	ret = compact_zone(&cc, &capc);
>>  
>>  	VM_BUG_ON(!list_empty(&cc.freepages));
>>  	VM_BUG_ON(!list_empty(&cc.migratepages));
>>  
>> -	*capture = capc.page;
>> -	current->capture_control = NULL;
>> +	WRITE_ONCE(current->capture_control, NULL);
>> +	*capture = READ_ONCE(capc.page);
>>  
>>  	return ret;
>>  }
> 

