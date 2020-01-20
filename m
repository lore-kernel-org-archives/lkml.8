Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22425C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 00:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0088820678
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 00:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgATAdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 19:33:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:29231 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbgATAdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 19:33:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 16:33:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,340,1574150400"; 
   d="scan'208";a="374184346"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2020 16:33:48 -0800
Date:   Mon, 20 Jan 2020 08:33:59 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/page_alloc.c: extract commom part to check page
Message-ID: <20200120003359.GB26292@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200119131408.23247-1-richardw.yang@linux.intel.com>
 <20200119131408.23247-2-richardw.yang@linux.intel.com>
 <alpine.DEB.2.21.2001191401240.43388@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001191401240.43388@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 02:06:18PM -0800, David Rientjes wrote:
>On Sun, 19 Jan 2020, Wei Yang wrote:
>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index d047bf7d8fd4..8cd06729169f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1025,13 +1025,9 @@ static inline bool page_expected_state(struct page *page,
>>  	return true;
>>  }
>>  
>> -static void free_pages_check_bad(struct page *page)
>> +static inline const char *__check_page(struct page *page)
>>  {
>> -	const char *bad_reason;
>> -	unsigned long bad_flags;
>> -
>> -	bad_reason = NULL;
>> -	bad_flags = 0;
>> +	const char *bad_reason = NULL;
>>  
>>  	if (unlikely(atomic_read(&page->_mapcount) != -1))
>>  		bad_reason = "nonzero mapcount";
>> @@ -1039,14 +1035,23 @@ static void free_pages_check_bad(struct page *page)
>>  		bad_reason = "non-NULL mapping";
>>  	if (unlikely(page_ref_count(page) != 0))
>>  		bad_reason = "nonzero _refcount";
>> -	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE)) {
>> -		bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
>> -		bad_flags = PAGE_FLAGS_CHECK_AT_FREE;
>> -	}
>>  #ifdef CONFIG_MEMCG
>>  	if (unlikely(page->mem_cgroup))
>>  		bad_reason = "page still charged to cgroup";
>>  #endif
>> +	return bad_reason;
>> +}
>> +
>> +static void free_pages_check_bad(struct page *page)
>> +{
>> +	const char *bad_reason = NULL;
>> +	unsigned long bad_flags = 0;
>> +
>> +	bad_reason = __check_page(page);
>> +	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE)) {
>> +		bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
>> +		bad_flags = PAGE_FLAGS_CHECK_AT_FREE;
>> +	}
>>  	bad_page(page, bad_reason, bad_flags);
>>  }
>>  
>> @@ -2044,12 +2049,7 @@ static void check_new_page_bad(struct page *page)
>>  	const char *bad_reason = NULL;
>>  	unsigned long bad_flags = 0;
>>  
>> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
>> -		bad_reason = "nonzero mapcount";
>> -	if (unlikely(page->mapping != NULL))
>> -		bad_reason = "non-NULL mapping";
>> -	if (unlikely(page_ref_count(page) != 0))
>> -		bad_reason = "nonzero _refcount";
>> +	bad_reason = __check_page(page);
>>  	if (unlikely(page->flags & __PG_HWPOISON)) {
>>  		bad_reason = "HWPoisoned (hardware-corrupted)";
>>  		bad_flags = __PG_HWPOISON;
>> @@ -2061,10 +2061,6 @@ static void check_new_page_bad(struct page *page)
>>  		bad_reason = "PAGE_FLAGS_CHECK_AT_PREP flag set";
>>  		bad_flags = PAGE_FLAGS_CHECK_AT_PREP;
>>  	}
>> -#ifdef CONFIG_MEMCG
>> -	if (unlikely(page->mem_cgroup))
>> -		bad_reason = "page still charged to cgroup";
>> -#endif
>>  	bad_page(page, bad_reason, bad_flags);
>>  }
>>  
>
>I think this is compounding a previous problem in these functions: these 
>are all "if" clauses, not "else if" clauses so they are presumably ordered 
>based on least significant to most significant (we only see the last 
>bad_reason that we find).  For the page->mem_cgroup check, this leaves 
>bad_flags set but it doesn't match bad_reason.
>

I have thought about this. And curious about the order of those reasons.

>Could you instead fix the problem with these functions so that we actually 
>list *all* the problems with the page rather than only the last 
>conditional that is true?

Sure, thanks for the suggestion.

-- 
Wei Yang
Help you, Help me
