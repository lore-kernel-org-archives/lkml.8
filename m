Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FA4C352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171A220848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgBNCFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:05:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:62741 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgBNCFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:05:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 18:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,438,1574150400"; 
   d="scan'208";a="434638612"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 13 Feb 2020 18:05:00 -0800
Date:   Fri, 14 Feb 2020 10:05:15 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shakeelb@google.com,
        yang.shi@linux.alibaba.com
Subject: Re: [RFC Patch] mm/vmscan.c: not inherit classzone_idx from previous
 reclaim
Message-ID: <20200214020515.GC20833@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200209074145.31389-1-richardw.yang@linux.intel.com>
 <20200211104223.GL3466@techsingularity.net>
 <20200212022554.GA7855@richard>
 <20200212074333.GM3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212074333.GM3466@techsingularity.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:43:33AM +0000, Mel Gorman wrote:
>On Wed, Feb 12, 2020 at 10:25:55AM +0800, Wei Yang wrote:
>> On Tue, Feb 11, 2020 at 10:42:23AM +0000, Mel Gorman wrote:
>> >On Sun, Feb 09, 2020 at 03:41:45PM +0800, Wei Yang wrote:
>> >> Before commit e716f2eb24de ("mm, vmscan: prevent kswapd sleeping
>> >> prematurely due to mismatched classzone_idx"), classzone_idx could have
>> >> two possibilities on a new loop based on whether there is a wakeup
>> >> during reclaiming:
>> >> 
>> >>   * 0 if no wakeup
>> >>   * the classzone_idx request by wakeup
>> >> 
>> >> As described in the changelog, this commit is willing to change the
>> >> first case to (MAX_NR_ZONES - 1) to avoid some premature sleep. But it
>> >> does not achieve the goal.
>> >> 
>> >> There are two versions of kswapd_classzone_idx() since this change:
>> >> 
>> >>   * commit e716f2eb24de ("mm, vmscan: prevent kswapd sleeping
>> >>     prematurely due to mismatched classzone_idx")
>> >>   * commit dffcac2cb88e ("mm/vmscan.c: prevent useless kswapd loops")
>> >> 
>> >> Both of them would return the classzone_idx we passed as the 2nd
>> >> parameter when (pgdat->kswapd_classzone_idx == MAX_NR_ZONES). This
>> >> means if there is no wakeup during reclaiming, we would use
>> >> classzone_idx in previous round to sleep.
>> >> 
>> >
>> >This is somewhat intended.
>> >
>> >> This patch fixes the logic by using (MAX_NR_ZONES - 1) for the first
>> >> case.
>> >> 
>> >
>> >Ok, what is the user-visible impact that is fixed by this patch or is
>> >this based on code review only? Please describe the test case exactly
>> >and the before and after results. I ask because this area is a magnet for
>> >regressions and intuitive ideas often lead to counter-intuitive results.
>> >
>> 
>> This is based on code review only. I know your concern. This is an area more
>> like art then engineering :-)
>> 
>
>Then I'm afraid that until there is a corner case identified and a
>description of the impact it's
>
>Nacked-by: Mel Gorman <mgorman@techsingularity.net>
>

Yep, no problem. I am glad if I could get some idea from you.

>> Would you mind sharing some idea why we intend to inherit the classzone_idx?
>> And for kswapd_order, we would restart at 0 if no wakeup during reclaim.
>> 
>
>Broadly speaking it was driven by cases whereby kswapd either a) fell
>asleep prematurely and there were many stalls in direct reclaim before
>kswapd recovered, b) stalls in direct reclaim immediately after kswapd went
>to sleep or c) kswapd reclaimed for lower zones and went to sleep while
>parallel tasks were direct reclaiming in higher zones or higher orders.
>

Thanks for your explanation. I am trying to understand the connection between
those cases and the behavior of kswapd.

In summary, all three cases are related to direct reclaim, while happens in
three different timing of kswapd:

   a) premature sleep
   b) full sleep
   c) full sleep after reclaim lower zone

Hmm... I am not sure the difference between b) and c). Looks both face direct
reclaim when kswapd is sleeping.

If I am correct, direct reclaim here is performed by function
__perform_reclaim(). Its scan order and zone_idx is retrieved from allocation
parameters, so it doesn't affect pgdat{.kswapd_order, .kswapd_classzone_idx} if
I am correct.

Direct reclaim do affect the pgdat status. After reclaiming, we may have more
available pages. But I am stuck in the connection between direct reclaim and
kswapd. Would you mind sharing more light on this part?

>-- 
>Mel Gorman
>SUSE Labs

-- 
Wei Yang
Help you, Help me
