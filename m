Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F666C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2137620702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgA2WHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:07:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:4266 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgA2WHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:07:13 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 14:07:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; 
   d="scan'208";a="218082796"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 29 Jan 2020 14:07:10 -0800
Date:   Thu, 30 Jan 2020 06:07:23 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com
Subject: Re: [Patch v2 4/4] mm/migrate.c: handle same node and add failure in
 the same way
Message-ID: <20200129220723.GC20736@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200122011647.13636-1-richardw.yang@linux.intel.com>
 <20200122011647.13636-5-richardw.yang@linux.intel.com>
 <17796dbb-b9b6-9481-5048-addfa5eec51e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17796dbb-b9b6-9481-5048-addfa5eec51e@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 11:13:23AM +0100, David Hildenbrand wrote:
>On 22.01.20 02:16, Wei Yang wrote:
>> When page is not queued for migration, there are two possible cases:
>> 
>>   * page already on the target node
>>   * failed to add to migration queue
>> 
>> Current code handle them differently, this leads to a behavior
>> inconsistency.
>> 
>> Usually for each page's status, we just do store for once. While for the
>> page already on the target node, we might store the node information for
>> twice:
>> 
>>   * once when we found the page is on the target node
>>   * second when moving the pages to target node successfully after above
>>     action
>> 
>> The reason is even we don't add the page to pagelist, but store_status()
>> does store in a range which still contains the page.
>> 
>> This patch handles these two cases in the same way to reduce this
>> inconsistency and also make the code a little easier to read.
>> 
>
>I'd rephrase to
>
>"mm/migrate.c: unify "not queued for migration" handling in do_pages_move()
>
>It can currently happen that we store the status of a page twice:
>* Once we detect that it is already on the target node
>* Once we moved a bunch of pages, and a page that's already on the
>  target node is contained in the current interval.
>
>Let's simplify the code and always call do_move_pages_to_node() in
>case we did not queue a page for migration. Note that pages that are
>already on the target node are not added to the pagelist and are,
>therefore, ignored by do_move_pages_to_node() - there is no functional
>change.
>
>The status of such a page is now only stored once.
>"
>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> ---
>>  mm/migrate.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>> 
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 80d2bba57265..591f2e5caed6 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1654,18 +1654,18 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>>  		err = add_page_for_migration(mm, addr, current_node,
>>  				&pagelist, flags & MPOL_MF_MOVE_ALL);
>>  
>> -		if (!err) {
>> -			/* The page is already on the target node */
>> -			err = store_status(status, i, current_node, 1);
>> -			if (err)
>> -				goto out_flush;
>> -			continue;
>> -		} else if (err > 0) {
>> +		if (err > 0) {
>>  			/* The page is successfully queued for migration */
>>  			continue;
>>  		}
>>  
>> -		err = store_status(status, i, err, 1);
>> +		/*
>> +		 * Two possible cases for err here:
>> +		 * == 0: page is already on the target node, then store
>> +		 *       current_node to status
>> +		 * <  0: failed to add page to list, then store err to status
>> +		 */
>
>I'd shorten that to
>
>/*
> * If the page is already on the target node (!err), store the node,
> * otherwise, store the err.
>*/
>
>> +		err = store_status(status, i, err ? : current_node, 1);
>>  		if (err)
>>  			goto out_flush;
>>  
>> 
>
>Thanks!
>
>Reviewed-by: David Hildenbrand <david@redhat.com>
>

Yep, thanks.

I would take this :-)

>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
