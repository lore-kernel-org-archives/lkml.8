Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEBCC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 00:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0AC24688
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 00:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgA2Aqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 19:46:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:19872 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgA2Aqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 19:46:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 16:46:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,376,1574150400"; 
   d="scan'208";a="222916704"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jan 2020 16:46:25 -0800
Date:   Wed, 29 Jan 2020 08:46:37 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com
Subject: Re: [Patch v2 3/4] mm/migrate.c: check pagelist in
 move_pages_and_store_status()
Message-ID: <20200129004637.GD12835@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200122011647.13636-1-richardw.yang@linux.intel.com>
 <20200122011647.13636-4-richardw.yang@linux.intel.com>
 <f7f70c42-a9a6-6c84-cdb5-230205703ddf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f70c42-a9a6-6c84-cdb5-230205703ddf@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 11:21:13AM +0100, David Hildenbrand wrote:
>On 22.01.20 02:16, Wei Yang wrote:
>> When pagelist is empty, it is not necessary to do the move and store.
>> Also it consolidate the empty list check in one place.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> ---
>>  mm/migrate.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>> 
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index a4d3bd6475e1..80d2bba57265 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1499,9 +1499,6 @@ static int do_move_pages_to_node(struct mm_struct *mm,
>>  {
>>  	int err;
>>  
>> -	if (list_empty(pagelist))
>> -		return 0;
>> -
>>  	err = migrate_pages(pagelist, alloc_new_node_page, NULL, node,
>>  			MIGRATE_SYNC, MR_SYSCALL);
>>  	if (err)
>> @@ -1589,6 +1586,9 @@ static int move_pages_and_store_status(struct mm_struct *mm, int node,
>>  {
>>  	int err;
>>  
>> +	if (list_empty(pagelist))
>> +		return 0;
>> +
>>  	err = do_move_pages_to_node(mm, pagelist, node);
>>  	if (err)
>>  		return err;
>> @@ -1676,9 +1676,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>>  		current_node = NUMA_NO_NODE;
>>  	}
>>  out_flush:
>> -	if (list_empty(&pagelist))
>> -		return err;
>
>
>Am I wrong or are you discarding an error here? (err could be !0)
>

This is not obvious in this code snippet. If you look into the source code, it
might help you get the whole picture.

The following comment says:

  Make sure we do not overwrite the existing error

So we didn't eat error here.

>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
