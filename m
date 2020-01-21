Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8760CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1C52465A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgAUTaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:30:23 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60186 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727383AbgAUTaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:30:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0ToJ3e.._1579635010;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0ToJ3e.._1579635010)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Jan 2020 03:30:19 +0800
Subject: Re: [Patch v2] mm/migrate.c: also overwrite error when it is bigger
 than zero
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, jhubbard@nvidia.com, vbabka@suse.cz,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mhocko@kernel.org
References: <20200119065753.21694-1-richardw.yang@linux.intel.com>
 <20200121015326.GE1567@richard>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <6fc3e936-eed0-eb18-ecd8-36dcc4c51218@linux.alibaba.com>
Date:   Tue, 21 Jan 2020 11:30:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200121015326.GE1567@richard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/20 5:53 PM, Wei Yang wrote:
> On Sun, Jan 19, 2020 at 02:57:53PM +0800, Wei Yang wrote:
>> If we get here after successfully adding page to list, err would be
>> 1 to indicate the page is queued in the list.
>>
>> Current code has two problems:
>>
>>   * on success, 0 is not returned
>>   * on error, if add_page_for_migratioin() return 1, and the following err1
>>     from do_move_pages_to_node() is set, the err1 is not returned since err
>>     is 1
>>
>> And these behaviors break the user interface.
>>
>> Fixes: e0153fc2c760 ("mm: move_pages: return valid node id in status if the
>> page is already on the target node").
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>
>> ---
>> v2:
>>   * put more words to explain the error case
>> ---
>> mm/migrate.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 86873b6f38a7..430fdccc733e 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1676,7 +1676,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>> 	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
>> 	if (!err1)
>> 		err1 = store_status(status, start, current_node, i - start);
>> -	if (!err)
>> +	if (err >= 0)
>> 		err = err1;
> Ok, as mentioned by Yang and Michal, only err == 0 means no error.

I think Michal means do_move_pages_to_node() only, 
add_page_for_migration() returns 1 on purpose.

But, actually the syscall may still return > 0 value since err1 might be 
 > 0. Anyway, this is another regression. The patch itself looks correct 
to me.

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>


>
> Sounds this regression should be fixed in another place. Let me send out
> another patch.
>
>> out:
>> 	return err;
>> -- 
>> 2.17.1

