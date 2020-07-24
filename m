Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63ABC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB8E20771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgGXOT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:19:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:46189 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgGXOT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:19:29 -0400
IronPort-SDR: nRnK/G0KWBMIK7bUpz/ktxV2LcA7ZRLGFV+il8k0I4cKFK7IhF62O1H+1jKUfm2BaAHtbrCmW0
 hU5L0+qTWboQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="151999228"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="151999228"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 07:19:28 -0700
IronPort-SDR: M15gSmBAZFSwW5sx31wOEJE5JR2PYjmucNIRxIeU7lc3rLCBd9s9e6270tzXgDV2t2cGQ6K2LT
 bXjY8SLbMGGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="488753651"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jul 2020 07:19:27 -0700
Received: from [10.252.140.222] (kliang2-mobl.ccr.corp.intel.com [10.252.140.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DDA34580638;
        Fri, 24 Jul 2020 07:19:26 -0700 (PDT)
Subject: Re: [PATCH V7 07/14] perf/core: Add a new PERF_EV_CAP_COEXIST event
 capability
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-8-kan.liang@linux.intel.com>
 <20200724105543.GV119549@hirez.programming.kicks-ass.net>
 <20200724114628.GJ43129@hirez.programming.kicks-ass.net>
 <0d33a25c-cfe4-af7f-c915-a98dba17b53b@linux.intel.com>
 <20200724135412.GA10769@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <e04f1708-e8c0-3787-1572-443f03ab73ca@linux.intel.com>
Date:   Fri, 24 Jul 2020 10:19:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724135412.GA10769@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2020 9:54 AM, Peter Zijlstra wrote:
> On Fri, Jul 24, 2020 at 09:43:44AM -0400, Liang, Kan wrote:
>>
>>
>> On 7/24/2020 7:46 AM, peterz@infradead.org wrote:
>>> On Fri, Jul 24, 2020 at 12:55:43PM +0200, peterz@infradead.org wrote:
>>>>> +	event_sched_out(event, cpuctx, ctx);
>>>>> +	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
>>>>> +}
>>>>
>>>> Ah, so the problem here is that ERROR is actually recoverable using
>>>> IOC_ENABLE. We don't want that either. Let me try and figure out of EXIT
>>>> would work.
>>>
>>> EXIT is difficult too.. Also, that COEXIST thing hurt my brian, can't we
>>> do a simpler SIBLING thing that simply requires the event to be a group
>>> sibling?
>>>
>>> The consequence is that SLOTS must be the leader, is that really a
>>> problem? You keep providing the {cycles, slots, metric-things} example,
>>> but afaict {slots, metric-thing, cycles} should work just fine too.
>>> PERF_SAMPLE_READ with PERF_FORMAT_GROUP doesn't need to the the leader.
>>
>> I'm not sure I get your point.
>> For the PERF_SAMPLE_READ with PERF_FORMAT_GROUP case, other events can be
>> the leader, e.g., {cycles, slots, metric-things}:S.
>> In this case, the SLOTS event is not a leader. I don't think we can assume
>> that the SLOTS event must be the leader.
> 
> You can have a sibling event with SAMPLE_READ and FORMAT_GROUP just
> fine. The sampling event doesn't need to be the leader.
> 

There will be a problem for the current perf tool, which assumes that 
the leader event is the sampling event.

I will check how can we specially handle it in the perf tool.

Thanks,
Kan

