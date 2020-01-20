Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A9C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A25922464
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgATMgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:36:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:63518 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgATMgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:36:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 04:36:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="228378979"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2020 04:36:10 -0800
Date:   Mon, 20 Jan 2020 20:36:21 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com
Subject: Re: [Patch v2 4/4] mm/page_alloc.c: extract commom part to check page
Message-ID: <20200120123621.GE18028@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
 <20200120030415.15925-5-richardw.yang@linux.intel.com>
 <3987ae0f-cbfc-1066-c78f-c5c6efc570ed@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3987ae0f-cbfc-1066-c78f-c5c6efc570ed@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 12:13:38PM +0530, Anshuman Khandual wrote:
>
>
>On 01/20/2020 08:34 AM, Wei Yang wrote:
>> During free and new page, we did some check on the status of page
>> struct. There is some common part, just extract them.
>
>Makes sense.
>
>> 
>> Besides this, this patch also rename two functions to keep the name
>> convention, since free_pages_check_bad/free_pages_check are counterparts
>> of check_new_page_bad/check_new_page.
>
>This probably should be in a different patch.
>

In v1, they are in two separate patches. While David Suggest to merge it.

I am not sure whether my understanding is correct.

>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  mm/page_alloc.c | 49 ++++++++++++++++++++++++-------------------------
>>  1 file changed, 24 insertions(+), 25 deletions(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index a7b793c739fc..7f23cc836f90 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1025,36 +1025,44 @@ static inline bool page_expected_state(struct page *page,
>>  	return true;
>>  }
>>  
>> -static void free_pages_check_bad(struct page *page)
>> +static inline int __check_page(struct page *page, int nr,
>> +				const char **bad_reason)
>
>free and new page checks are in and out of the buddy allocator, hence
>this common factored function should have a more relevant name.

Hmm... naming is really difficult. Do you have any suggestion?

-- 
Wei Yang
Help you, Help me
