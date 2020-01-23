Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DA4C35242
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D4E207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgAWXhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:37:16 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:32933 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729288AbgAWXhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:37:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0ToQ2aA1_1579822620;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0ToQ2aA1_1579822620)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Jan 2020 07:37:12 +0800
Subject: Re: [v2 PATCH] mm: move_pages: report the number of non-attempted
 pages
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     mhocko@suse.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1579736331-85494-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200123225940.GC29851@richard>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <424a0fbb-1e9a-ca9d-ba43-cb247d7a4b67@linux.alibaba.com>
Date:   Thu, 23 Jan 2020 15:36:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200123225940.GC29851@richard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/20 2:59 PM, Wei Yang wrote:
> On Thu, Jan 23, 2020 at 07:38:51AM +0800, Yang Shi wrote:
>> Since commit a49bd4d71637 ("mm, numa: rework do_pages_move"),
>> the semantic of move_pages() was changed to return the number of
>> non-migrated pages (failed to migration) and the call would be aborted
>> immediately if migrate_pages() returns positive value.  But it didn't
>> report the number of pages that we even haven't attempted to migrate.
>> So, fix it by including non-attempted pages in the return value.
>>
>> Fixes: a49bd4d71637 ("mm, numa: rework do_pages_move")
>> Suggested-by: Michal Hocko <mhocko@suse.com>
>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>> Cc: <stable@vger.kernel.org>    [4.17+]
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>> v2: Rebased on top of the latest mainline kernel per Andrew
>>
>> mm/migrate.c | 24 ++++++++++++++++++++++--
>> 1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 86873b6..9b8eb5d 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1627,8 +1627,18 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>> 			start = i;
>> 		} else if (node != current_node) {
>> 			err = do_move_pages_to_node(mm, &pagelist, current_node);
>> -			if (err)
>> +			if (err) {
>> +				/*
>> +				 * Positive err means the number of failed
>> +				 * pages to migrate.  Since we are going to
>> +				 * abort and return the number of non-migrated
>> +				 * pages, so need incude the rest of the
>> +				 * nr_pages that have not attempted as well.
>> +				 */
>> +				if (err > 0)
>> +					err += nr_pages - i - 1;
>> 				goto out;
>> +			}
>> 			err = store_status(status, start, current_node, i - start);
>> 			if (err)
>> 				goto out;
>> @@ -1659,8 +1669,11 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>> 			goto out_flush;
>>
>> 		err = do_move_pages_to_node(mm, &pagelist, current_node);
>> -		if (err)
>> +		if (err) {
>> +			if (err > 0)
>> +				err += nr_pages - i - 1;
>> 			goto out;
>> +		}
>> 		if (i > start) {
>> 			err = store_status(status, start, current_node, i - start);
>> 			if (err)
>> @@ -1674,6 +1687,13 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>>
>> 	/* Make sure we do not overwrite the existing error */
>> 	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
>> +	/*
>> +	 * Don't have to report non-attempted pages here since:
> In previous comment, you use "non-migrated". Here is "non-attempted". What's
> the difference?

In that comment "non-migrated" includes both reported by migrate_pages() 
and the non-attempted.

>
>> +	 *     - If the above loop is done gracefully there is not non-attempted
>> +	 *       page.
>> +	 *     - If the above loop is aborted to it means more fatal error
>> +	 *       happened, should return err.
>> +	 */
>> 	if (!err1)
>> 		err1 = store_status(status, start, current_node, i - start);
>> 	if (!err)
>> -- 
>> 1.8.3.1

