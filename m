Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFC7C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B28215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgCCGTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:19:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:61509 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgCCGTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:19:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 22:19:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,510,1574150400"; 
   d="scan'208";a="286888659"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Mar 2020 22:19:19 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm, migrate: Check return value of try_to_unmap()
References: <20200303033645.280694-1-ying.huang@intel.com>
        <alpine.LSU.2.11.2003022150540.1344@eggly.anvils>
Date:   Tue, 03 Mar 2020 14:19:18 +0800
In-Reply-To: <alpine.LSU.2.11.2003022150540.1344@eggly.anvils> (Hugh Dickins's
        message of "Mon, 2 Mar 2020 22:11:45 -0800")
Message-ID: <87blpe55ax.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hugh,

Hugh Dickins <hughd@google.com> writes:
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 3900044cfaa6..981f8374a6ef 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1116,8 +1116,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>>  		/* Establish migration ptes */
>>  		VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
>>  				page);
>> -		try_to_unmap(page,
>> -			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
>> +		if (!try_to_unmap(page,
>> +			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS)) {
>> +			rc = -EIO;
>> +			goto out_unlock_both;
>
> No: even if try_to_unmap() says that it did not entirely succeed,
> it may have unmapped some ptes, inserting migration entries in their
> place. Those need to be replaced by proper ptes before the page is
> unlocked, which page_was_mapped 1 and remove_migration_ptes() do;
> but this goto skips those.

Yes.  You are right.  I misunderstand the original code.  Please ignore
this patch.

Best Regards,
Huang, Ying
