Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDB7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7922E20882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgATMNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:13:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:28226 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgATMNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:13:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 04:13:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="399356972"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2020 04:13:04 -0800
Date:   Mon, 20 Jan 2020 20:13:15 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com
Subject: Re: [Patch v2 2/4] mm/page_alloc.c: bad_[reason|flags] is not
 necessary when PageHWPoison
Message-ID: <20200120121315.GC18028@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
 <20200120030415.15925-3-richardw.yang@linux.intel.com>
 <3e7b4045-cd22-552a-c28d-1605a97bbdf7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e7b4045-cd22-552a-c28d-1605a97bbdf7@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 11:58:04AM +0530, Anshuman Khandual wrote:
>
>
>On 01/20/2020 08:34 AM, Wei Yang wrote:
>> Since function returns directly, bad_[reason|flags] is not used any
>> where.
>> 
>> This is a following cleanup for commit e570f56cccd21 ("mm:
>> check_new_page_bad() directly returns in __PG_HWPOISON case")
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Acked-by: David Rientjes <rientjes@google.com>
>> ---
>>  mm/page_alloc.c | 2 --
>>  1 file changed, 2 deletions(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 0cf6218aaba7..a43b9d2482f2 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2051,8 +2051,6 @@ static void check_new_page_bad(struct page *page)
>>  	if (unlikely(page_ref_count(page) != 0))
>>  		bad_reason = "nonzero _refcount";
>>  	if (unlikely(page->flags & __PG_HWPOISON)) {
>> -		bad_reason = "HWPoisoned (hardware-corrupted)";
>> -		bad_flags = __PG_HWPOISON;
>>  		/* Don't complain about hwpoisoned pages */
>>  		page_mapcount_reset(page); /* remove PageBuddy */
>>  		return;
>
>This bail out condition should be the first in the function
>check_new_page_bad() before evaluating bad_[reason|flags]
>as they will never be used.
>

This is reasonable.

>> 

-- 
Wei Yang
Help you, Help me
