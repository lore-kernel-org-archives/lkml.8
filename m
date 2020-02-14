Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EF8C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE7A20848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgBND6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:58:51 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45830 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728242AbgBND6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:58:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TpwAdAy_1581652722;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TpwAdAy_1581652722)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Feb 2020 11:58:44 +0800
Subject: Re: [PATCH] mm: migrate.c: migrate PG_readahead flag
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     willy@infradead.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1581640185-95731-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200213185511.4660aca17553562d764dc7ea@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <c5936806-dc0b-e0a2-33f0-6d6dce45e0a9@linux.alibaba.com>
Date:   Thu, 13 Feb 2020 19:58:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200213185511.4660aca17553562d764dc7ea@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/20 6:55 PM, Andrew Morton wrote:
> On Fri, 14 Feb 2020 08:29:45 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> Currently migration code doesn't migrate PG_readahead flag.
>> Theoretically this would incur slight performance loss as the
>> application might have to ramp its readahead back up again.  Even though
>> such problem happens, it might be hidden by something else since
>> migration is typically triggered by compaction and NUMA balancing, any
>> of which should be more noticeable.
>>
>> Migrate the flag after end_page_writeback() since it may clear
>> PG_reclaim flag, which is the same bit as PG_readahead, for the new
>> page.
>>
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -647,6 +647,14 @@ void migrate_page_states(struct page *newpage, struct page *page)
>>   	if (PageWriteback(newpage))
>>   		end_page_writeback(newpage);
>>   
>> +	/*
>> +	 * PG_readahead share the same bit with PG_reclaim, the above
>> +	 * end_page_writeback() may clear PG_readahead mistakenly, so set
>> +	 * the bit after that.
>> +	 */
>> +	if (PageReadahead(page))
>> +		SetPageReadahead(newpage);
>> +
>>   	copy_page_owner(page, newpage);
>>   
> Why not

The newpage may not have writeback set, migrating readahead flag should 
not depend on it.

>
>    	if (PageWriteback(newpage)) {
>    		end_page_writeback(newpage);
> 		/*
> 		 * PG_readahead share the same bit with PG_reclaim, the above
> 		 * end_page_writeback() may clear PG_readahead mistakenly, so
> 		 * set the bit after that.
> 		 */
> 		if (PageReadahead(page))
> 			SetPageReadahead(newpage);
> 	}
>
> ?

