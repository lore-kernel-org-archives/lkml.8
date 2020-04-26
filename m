Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21963C55185
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051CB206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgDZBHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 21:07:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:63235 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgDZBHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 21:07:13 -0400
IronPort-SDR: 7nMZVM5FAP1m3v8Q3ihJ1Bt5fPC4tuKqZGXPY1nCbcBBu0/kF+NmXSADsrm7RVAUe7G6teqZL9
 eA5ylzBBno2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2020 18:07:13 -0700
IronPort-SDR: /6Hcha58W/8wp1T7uAZ5Kt+wyz24uAV0VhKBR3cC8j25XPuZORYv3JiVO9PTML6R7HlKedGf/6
 gzuj37e+4+wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,318,1583222400"; 
   d="scan'208";a="281265179"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2020 18:07:11 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/swapfile.c: simplify the scan loop in scan_swap_map_slots()
References: <20200422214111.19370-1-richard.weiyang@gmail.com>
        <87d07y2181.fsf@yhuang-dev.intel.com>
        <20200423131507.2rgrk3okh42oo6gh@master>
        <87r1wdzlm5.fsf@yhuang-dev.intel.com>
        <20200425003012.uuqh547feq3kz4y5@master>
Date:   Sun, 26 Apr 2020 09:07:11 +0800
In-Reply-To: <20200425003012.uuqh547feq3kz4y5@master> (Wei Yang's message of
        "Sat, 25 Apr 2020 00:30:12 +0000")
Message-ID: <87tv17xdfk.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richard.weiyang@gmail.com> writes:

> On Fri, Apr 24, 2020 at 10:02:58AM +0800, Huang, Ying wrote:
>>Wei Yang <richard.weiyang@gmail.com> writes:
>>
> [...]
>>>>
>>>>if "offset > si->highest_bit" is true and "offset < scan_base" is true,
>>>>scan_base need to be returned.
>>>>
>>>
>>> When this case would happen in the original code?
>>
>>In the original code, the loop can still stop.
>>
>
> Sorry, I don't get your point yet.
>
> In original code, there are two separate loops
>
>     while (++offset <= si->highest_bit) {
>     }
>
>     while (offset < scan_base) {
>     }
>
> And for your condition, (offset > highest_bit) && (offset < scan_base), which
> terminates the first loop and fits the second loop well.
>
> Not sure how this condition would stop the loop in original code?

Per my understanding, in your code, if some other task changes
si->highest_bit to be less than scan_base in parallel.  The loop may
cannot stop.

Best Regards,
Huang, Ying

>>Best Regards,
>>Huang, Ying
>>
>>>>Again, the new code doesn't make it easier to find this kind of issues.
>>>>
>>>>Best Regards,
>>>>Huang, Ying
