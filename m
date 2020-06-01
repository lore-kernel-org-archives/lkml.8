Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE035C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904842074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgFALn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:43:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725925AbgFALn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:43:57 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6FD09ECC3EF7D00DC03F;
        Mon,  1 Jun 2020 19:43:54 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 1 Jun 2020
 19:43:53 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix retry logic in
 f2fs_write_cache_pages()
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1590546056-17871-1-git-send-email-stummala@codeaurora.org>
 <1d54379e-35c7-76e0-0c8a-d89bfcecb935@huawei.com>
 <78d2f29b-3ec0-39bc-46cf-88e82f1970c9@huawei.com>
 <20200528191839.GA180586@google.com> <20200601092035.GA19831@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8e938d5c-251c-9922-34a0-5e606cdb4afb@huawei.com>
Date:   Mon, 1 Jun 2020 19:43:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200601092035.GA19831@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/1 17:20, Sahitya Tummala wrote:
> Hi Chao,
> 
> Can you please help review the diff given by Jaegeuk below?
> If it looks good, I can post a v2.

Oops, I missed to review that patch...

> 
> Thanks,
> 
> On Thu, May 28, 2020 at 12:18:39PM -0700, Jaegeuk Kim wrote:
>> On 05/28, Chao Yu wrote:
>>> On 2020/5/28 10:45, Chao Yu wrote:
>>>> On 2020/5/27 10:20, Sahitya Tummala wrote:
>>>>> In case a compressed file is getting overwritten, the current retry
>>>>> logic doesn't include the current page to be retried now as it sets
>>>>> the new start index as 0 and new end index as writeback_index - 1.
>>>>> This causes the corresponding cluster to be uncompressed and written
>>>>> as normal pages without compression. Fix this by allowing writeback to
>>>>> be retried for the current page as well (in case of compressed page
>>>>> getting retried due to index mismatch with cluster index). So that
>>>>> this cluster can be written compressed in case of overwrite.
>>>>>
>>>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>>>> ---
>>>>>  fs/f2fs/data.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index 4af5fcd..bfd1df4 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -3024,7 +3024,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>>>>  	if ((!cycled && !done) || retry) {
>>>>
>>>> IMO, we add retry logic in wrong place, you can see that cycled value is
>>>> zero only if wbc->range_cyclic is true, in that case writeback_index is valid.
>>>>
>>>> However if retry is true and wbc->range_cyclic is false, then writeback_index
>>>> would be uninitialized variable.
>>>>
>>>> Thoughts?
>>>>
>>>> Thanks,
>>>>
>>>>>  		cycled = 1;
>>>>>  		index = 0;
>>>>> -		end = writeback_index - 1;
>>>
>>> BTW, I notice that range_cyclic writeback flow was refactored in below commit,
>>> and skeleton of f2fs.writepages was copied from mm/page-writeback.c::write_cache_pages(),
>>> I guess we need follow that change.
>>>
>>> 64081362e8ff ("mm/page-writeback.c: fix range_cyclic writeback vs writepages deadlock")
>>
>> Is that something like this?
>>
>> ---
>>  fs/f2fs/data.c | 11 ++---------
>>  1 file changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 48a622b95b76e..28fcdf0d4dcb9 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -2861,7 +2861,6 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>  	pgoff_t index;
>>  	pgoff_t end;		/* Inclusive */
>>  	pgoff_t done_index;
>> -	int cycled;
>>  	int range_whole = 0;
>>  	xa_mark_t tag;
>>  	int nwritten = 0;
>> @@ -2879,17 +2878,12 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>  	if (wbc->range_cyclic) {
>>  		writeback_index = mapping->writeback_index; /* prev offset */
>>  		index = writeback_index;
>> -		if (index == 0)
>> -			cycled = 1;
>> -		else
>> -			cycled = 0;
>>  		end = -1;
>>  	} else {
>>  		index = wbc->range_start >> PAGE_SHIFT;
>>  		end = wbc->range_end >> PAGE_SHIFT;
>>  		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
>>  			range_whole = 1;
>> -		cycled = 1; /* ignore range_cyclic tests */
>>  	}
>>  	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
>>  		tag = PAGECACHE_TAG_TOWRITE;
>> @@ -3054,10 +3048,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>  		}
>>  	}
>>  #endif
>> -	if ((!cycled && !done) || retry) {
>> -		cycled = 1;
>> +	if (retry) {
>>  		index = 0;
>> -		end = writeback_index - 1;
>> +		end = -1;
>>  		goto retry;
>>  	}

+	if (wbc->range_cyclic && !done)
+		done_index = 0;

Thanks,

>>  	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
>> -- 
>> 2.27.0.rc0.183.gde8f92d652-goog
>>
> 
