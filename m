Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90954C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7986220715
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDXCDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:03:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:27886 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgDXCDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:03:19 -0400
IronPort-SDR: N8IV8flk2EiIF3zuOjRj5kPRkW5Q7yJWcvOQM4XfeeFjoLE4eVfSlvzCI0wBffyBpxTTVUCA1o
 /FHYs2S2m6Wg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 19:03:18 -0700
IronPort-SDR: Q5ITlOlizud7iEKv2iS9+MDWhT7dZCRnlCdskMeLXUH4d51rWKKH6+eTnvrVQB5rqSdsdB5i0G
 g9x47vnS/uiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,310,1583222400"; 
   d="scan'208";a="246453926"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga007.fm.intel.com with ESMTP; 23 Apr 2020 19:02:58 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/swapfile.c: simplify the scan loop in scan_swap_map_slots()
References: <20200422214111.19370-1-richard.weiyang@gmail.com>
        <87d07y2181.fsf@yhuang-dev.intel.com>
        <20200423131507.2rgrk3okh42oo6gh@master>
Date:   Fri, 24 Apr 2020 10:02:58 +0800
In-Reply-To: <20200423131507.2rgrk3okh42oo6gh@master> (Wei Yang's message of
        "Thu, 23 Apr 2020 13:15:07 +0000")
Message-ID: <87r1wdzlm5.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richard.weiyang@gmail.com> writes:

> On Thu, Apr 23, 2020 at 01:57:34PM +0800, Huang, Ying wrote:
>>Wei Yang <richard.weiyang@gmail.com> writes:
>>
>>> After commit c60aa176c6de8 ("swapfile: swap allocation cycle if
>>> nonrot"), swap allocation is cyclic. Current approach is done with two
>>> separate loop on the upper and lower half. This looks a little
>>> redundant.
>>
>>I can understand that the redundant code doesn't smell good.  But I
>>don't think the new code is easier to be understood than the original
>>one.
>>
>>> From another point of view, the loop iterates [lowest_bit, highest_bit]
>>> range starting with (offset + 1) but except scan_base. So we can
>>> simplify the loop with condition (next_offset() != scan_base) by
>>> introducing next_offset() which makes sure offset fit in that range
>>> with correct order.
>>>
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> CC: Hugh Dickins <hughd@google.com>
>>> CC: "Huang, Ying" <ying.huang@intel.com>
>>>
>>> ---
>>> v2:
>>>   * return scan_base if the lower part is eaten
>>>   * only start over when iterating on the upper part
>>> ---
>>>  mm/swapfile.c | 31 ++++++++++++++-----------------
>>>  1 file changed, 14 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index f903e5a165d5..0005a4a1c1b4 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -729,6 +729,19 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>>>  	}
>>>  }
>>>  
>>> +static unsigned long next_offset(struct swap_info_struct *si,
>>> +				unsigned long *offset, unsigned long scan_base)
>>> +{
>>> +	/* only start over when iterating on the upper part */
>>> +	if (++(*offset) > si->highest_bit && *offset > scan_base) {
>>> +		*offset = si->lowest_bit;
>>> +		/* someone has eaten the lower part */
>>> +		if (si->lowest_bit >= scan_base)
>>> +			return scan_base;
>>> +	}
>>
>>if "offset > si->highest_bit" is true and "offset < scan_base" is true,
>>scan_base need to be returned.
>>
>
> When this case would happen in the original code?

In the original code, the loop can still stop.

Best Regards,
Huang, Ying

>>Again, the new code doesn't make it easier to find this kind of issues.
>>
>>Best Regards,
>>Huang, Ying
