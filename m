Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCDCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365E12075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390386AbgAXOPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:15:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:15290 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388691AbgAXOPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:15:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 06:15:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,357,1574150400"; 
   d="scan'208";a="292642836"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2020 06:15:26 -0800
Date:   Fri, 24 Jan 2020 22:15:38 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, yang.shi@linux.alibaba.com,
        jhubbard@nvidia.com, vbabka@suse.cz, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] mm/migrate.c: also overwrite error when it is bigger
 than zero
Message-ID: <20200124141538.GA12509@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200119065753.21694-1-richardw.yang@linux.intel.com>
 <20200124072127.GO29276@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124072127.GO29276@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 08:21:27AM +0100, Michal Hocko wrote:
>[Sorry I have missed this patch previously]
>

No problem, thanks for your comment.

>On Sun 19-01-20 14:57:53, Wei Yang wrote:
>> If we get here after successfully adding page to list, err would be
>> 1 to indicate the page is queued in the list.
>> 
>> Current code has two problems:
>> 
>>   * on success, 0 is not returned
>>   * on error, if add_page_for_migratioin() return 1, and the following err1
>>     from do_move_pages_to_node() is set, the err1 is not returned since err
>>     is 1
>
>This made my really scratch my head to grasp. So essentially err > 0
>will happen when we reach the end of the loop and rely on the
>out_flush flushing to migrate the batch. Then err contains the
>add_page_for_migratioin return value. And that would leak to the
>userspace.
>
>What would you say about the following wording instead?
>"
>out_flush part of do_pages_move is responsible for migrating the last
>batch that accumulated while processing the input in the loop.
>do_move_pages_to_node return value is supposed to override any
>preexisting error (e.g. when the user input is garbage) but the current

I am afraid I have a different understanding here.

If we jump to out_flush on the test of node_isset(), err is -EACCESS. Current
logic would return this instead of the error from do_move_pages_to_node().
Seems we don't override -EACCESS.

Is my understanding correct?

>logic is wrong because add_page_for_migration returns 1 when
>successfully adding a page into the batch and therefore this will be the
>last err value after the loop is processed without any actual error.
>We want to override that value of course because do_pages_move would
>return 1 to the userspace even without any errors.
>"
>
>> And these behaviors break the user interface.
>> 
>> Fixes: e0153fc2c760 ("mm: move_pages: return valid node id in status if the
>> page is already on the target node").
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Acked-by: Michal Hocko <mhocko@suse.com>
>
>> 
>> ---
>> v2:
>>   * put more words to explain the error case
>> ---
>>  mm/migrate.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 86873b6f38a7..430fdccc733e 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1676,7 +1676,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>>  	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
>>  	if (!err1)
>>  		err1 = store_status(status, start, current_node, i - start);
>> -	if (!err)
>> +	if (err >= 0)
>>  		err = err1;
>>  out:
>>  	return err;
>> -- 
>> 2.17.1
>> 
>
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
