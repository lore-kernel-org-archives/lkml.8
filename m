Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B28C35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85202082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgBLCZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:25:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:31415 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbgBLCZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:25:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 18:25:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="222139494"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2020 18:25:36 -0800
Date:   Wed, 12 Feb 2020 10:25:55 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shakeelb@google.com,
        yang.shi@linux.alibaba.com
Subject: Re: [RFC Patch] mm/vmscan.c: not inherit classzone_idx from previous
 reclaim
Message-ID: <20200212022554.GA7855@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200209074145.31389-1-richardw.yang@linux.intel.com>
 <20200211104223.GL3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211104223.GL3466@techsingularity.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:42:23AM +0000, Mel Gorman wrote:
>On Sun, Feb 09, 2020 at 03:41:45PM +0800, Wei Yang wrote:
>> Before commit e716f2eb24de ("mm, vmscan: prevent kswapd sleeping
>> prematurely due to mismatched classzone_idx"), classzone_idx could have
>> two possibilities on a new loop based on whether there is a wakeup
>> during reclaiming:
>> 
>>   * 0 if no wakeup
>>   * the classzone_idx request by wakeup
>> 
>> As described in the changelog, this commit is willing to change the
>> first case to (MAX_NR_ZONES - 1) to avoid some premature sleep. But it
>> does not achieve the goal.
>> 
>> There are two versions of kswapd_classzone_idx() since this change:
>> 
>>   * commit e716f2eb24de ("mm, vmscan: prevent kswapd sleeping
>>     prematurely due to mismatched classzone_idx")
>>   * commit dffcac2cb88e ("mm/vmscan.c: prevent useless kswapd loops")
>> 
>> Both of them would return the classzone_idx we passed as the 2nd
>> parameter when (pgdat->kswapd_classzone_idx == MAX_NR_ZONES). This
>> means if there is no wakeup during reclaiming, we would use
>> classzone_idx in previous round to sleep.
>> 
>
>This is somewhat intended.
>
>> This patch fixes the logic by using (MAX_NR_ZONES - 1) for the first
>> case.
>> 
>
>Ok, what is the user-visible impact that is fixed by this patch or is
>this based on code review only? Please describe the test case exactly
>and the before and after results. I ask because this area is a magnet for
>regressions and intuitive ideas often lead to counter-intuitive results.
>

This is based on code review only. I know your concern. This is an area more
like art then engineering :-)

Would you mind sharing some idea why we intend to inherit the classzone_idx?
And for kswapd_order, we would restart at 0 if no wakeup during reclaim.

I am curious about the idea behind this design :-)

>-- 
>Mel Gorman
>SUSE Labs

-- 
Wei Yang
Help you, Help me
