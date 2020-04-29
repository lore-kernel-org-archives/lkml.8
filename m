Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF37C83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950F0206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgD2Aws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:52:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:22099 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgD2Awr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:52:47 -0400
IronPort-SDR: rlI7tY2MeIdhqLi3R+AiGtAswfr8CN/0TSUTl2+n2fLkJtWUKcbRWRDivs1j4kJTsLbkqYGb1/
 wfZO0zflwFwg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 17:52:46 -0700
IronPort-SDR: Fd6uQ9lwwQ85EzfLAX6e4y1AEbWHJf6ORQs6hOYnYtB06NkRGVybQKjmw5ymjutF8LgrygL5tg
 kolmEaxyLZXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,329,1583222400"; 
   d="scan'208";a="404874335"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga004.jf.intel.com with ESMTP; 28 Apr 2020 17:52:45 -0700
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
        <87tv17xdfk.fsf@yhuang-dev.intel.com>
        <20200426211958.m7aheswirqaj2nte@master>
        <87d07tycfu.fsf@yhuang-dev.intel.com>
        <20200428212230.3aobygpy62bto4gz@master>
Date:   Wed, 29 Apr 2020 08:52:44 +0800
In-Reply-To: <20200428212230.3aobygpy62bto4gz@master> (Wei Yang's message of
        "Tue, 28 Apr 2020 21:22:30 +0000")
Message-ID: <874kt3xgdf.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richard.weiyang@gmail.com> writes:

> On Mon, Apr 27, 2020 at 08:55:33AM +0800, Huang, Ying wrote:
>>Wei Yang <richard.weiyang@gmail.com> writes:
>>
>>> On Sun, Apr 26, 2020 at 09:07:11AM +0800, Huang, Ying wrote:
>>>>Wei Yang <richard.weiyang@gmail.com> writes:
>>>>
>>>>> On Fri, Apr 24, 2020 at 10:02:58AM +0800, Huang, Ying wrote:
>>>>>>Wei Yang <richard.weiyang@gmail.com> writes:
>>>>>>
>>>>> [...]
>>>>>>>>
>>>>>>>>if "offset > si->highest_bit" is true and "offset < scan_base" is true,
>>>>>>>>scan_base need to be returned.
>>>>>>>>
>>>>>>>
>>>>>>> When this case would happen in the original code?
>>>>>>
>>>>>>In the original code, the loop can still stop.
>>>>>>
>>>>>
>>>>> Sorry, I don't get your point yet.
>>>>>
>>>>> In original code, there are two separate loops
>>>>>
>>>>>     while (++offset <= si->highest_bit) {
>>>>>     }
>>>>>
>>>>>     while (offset < scan_base) {
>>>>>     }
>>>>>
>>>>> And for your condition, (offset > highest_bit) && (offset < scan_base), which
>>>>> terminates the first loop and fits the second loop well.
>>>>>
>>>>> Not sure how this condition would stop the loop in original code?
>>>>
>>>>Per my understanding, in your code, if some other task changes
>>>>si->highest_bit to be less than scan_base in parallel.  The loop may
>>>>cannot stop.
>>>
>>> When (offset > scan_base), (offset >  si->highest_bit) means offset will be
>>> set to si->lowest_bit.
>>>
>>> When (offset < scan_base), next_offset() would always increase offset till
>>> offset is scan_base.
>>>
>>> Sorry, I didn't catch your case. Would you minding giving more detail?
>>
>>Don't think in single thread model.  There's no lock to prevent other
>>tasks to change si->highest_bit simultaneously.  For example, task B may
>>change si->highest_bit to be less than scan_base in task A.
>>
>
> Yes, I am trying to think about it in parallel mode.
>
> Here are the cases, it might happen in parallel when task B change highest_bit
> to be less than scan_base.
>
> (1)
>                                                      offset
>                                                        v
>           +-------------------+------------------+
> 	  ^                   ^                  ^
>           lowest_bit       highest_bit    scan_base
>
>
> (2)
>                                        offset
>                                          v
>           +-------------------+------------------+
> 	  ^                   ^                  ^
>           lowest_bit       highest_bit    scan_base
>

This is the case in my mind.  But my original understanding to your code
wasn't correct.  As you said, loop can stop because offset is kept
increasing.  Sorry about that.

But I still don't like your new code.  It's not as obvious as the
original one.

Best Regards,
Huang, Ying

> (3)
>                        offset
>                          v
>           +-------------------+------------------+
> 	  ^                   ^                  ^
>           lowest_bit       highest_bit    scan_base
>
> Case (1), (offset > highest) && (offset > scan_base),  offset would be set to
> lowest_bit. This  looks good.
>
> Case (2), (offset > highest) && (offset < scan_base),  since offset is less
> than scan_base, it wouldn't be set to lowest. Instead it will continue to
> scan_base.
>
> Case (3), almost the same as Case (2).
>
> In Case (2) and (3), one thing interesting is the loop won't stop at
> highest_bit, while the behavior is the same as original code.
>
> Maybe your concern is this one? I still not figure out your point about the
> infinite loop. Hope you would share some light on it.
>
>
>>Best Regards,
>>Huang, Ying
>>
>>>>
>>>>Best Regards,
>>>>Huang, Ying
>>>>
>>>>>>Best Regards,
>>>>>>Huang, Ying
>>>>>>
>>>>>>>>Again, the new code doesn't make it easier to find this kind of issues.
>>>>>>>>
>>>>>>>>Best Regards,
>>>>>>>>Huang, Ying
