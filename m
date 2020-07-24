Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC56C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BC72067D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGXRAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:00:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:12416 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXRAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:00:32 -0400
IronPort-SDR: J+Im2xHnxTdEIj5ktuhQdb9xbQQXesExXlVsPAd+KbSROub+pWwTTEFmpWIZEbC+si2FodhUzV
 nCGzrFfXS9cA==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="138245666"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="138245666"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:00:31 -0700
IronPort-SDR: G6zJ9jlbWHEOMhv6Hj4P4IuC68udFVXIBCA/yuNM45GHvKH2Gyu0xJVeyhsY/k9PcKukfG/xjF
 HqLYGEcsaIow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="284985355"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2020 10:00:30 -0700
Received: from [10.252.140.222] (kliang2-mobl.ccr.corp.intel.com [10.252.140.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0AA4A580297;
        Fri, 24 Jul 2020 10:00:29 -0700 (PDT)
Subject: Re: [PATCH V7 07/14] perf/core: Add a new PERF_EV_CAP_COEXIST event
 capability
To:     peterz@infradead.org, Andi Kleen <ak@linux.intel.com>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, like.xu@linux.intel.com
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-8-kan.liang@linux.intel.com>
 <20200724105543.GV119549@hirez.programming.kicks-ass.net>
 <20200724114628.GJ43129@hirez.programming.kicks-ass.net>
 <0d33a25c-cfe4-af7f-c915-a98dba17b53b@linux.intel.com>
 <20200724135412.GA10769@hirez.programming.kicks-ass.net>
 <e04f1708-e8c0-3787-1572-443f03ab73ca@linux.intel.com>
 <20200724143258.GB10769@hirez.programming.kicks-ass.net>
 <20200724144632.GE1180481@tassilo.jf.intel.com>
 <20200724145934.GD10769@hirez.programming.kicks-ass.net>
 <20200724164356.GL43129@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <af274c58-6935-22cd-2830-519c3977e136@linux.intel.com>
Date:   Fri, 24 Jul 2020 13:00:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724164356.GL43129@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2020 12:43 PM, peterz@infradead.org wrote:
> On Fri, Jul 24, 2020 at 04:59:34PM +0200, Peter Zijlstra wrote:
>> On Fri, Jul 24, 2020 at 07:46:32AM -0700, Andi Kleen wrote:
>>>> Something that seems to 'work' is:
>>>> '{cycles,cpu/instructions,period=50000/}', so maybe you can make the
>>>> group modifier :S use any sampling event if there is one, and otherwise
>>>> designate the leader.
>>>>
>>>> Then you can write things like:
>>>>
>>>>    '{slots, metric1, metric2, cpu/cycles,freq=50000/}:S'
>>>>
>>>> and then since cycles is specified as a sampling event, it will use
>>>> that.
>>>
>>> Okay possible, but it makes things more complicated
>>> for the user to understand and requires special documentation.
>>> Hopefully it's worth it the internal simplification.
>>
>> You already require special documentation for this metrics stuff. We
>> already need to state that SLOTS cannot be a sampling event, so you
>> already need to pay attention to this anyway.
>>
>> A shortcut could be a :s event modifier, then you can write:
>>
>>   '{slots, metric1, metric2, cycles:s}:S'
>>
>> and have the tool select the :s tagged one.

It looks like PT encountered a similar issue as us.
They use the 2nd event of the group as the
"leader". I think we can simply extend the function to check the slots 
event in perf tool.
https://lore.kernel.org/lkml/20200401101613.6201-17-adrian.hunter@intel.com/


> 
> Having slots as leader also would allow doing something like
> FORMAT_METRIC, where we return sibling/leader in some fashion.
> 
> That also makes sense for instructions, because, IIRC,
> instructions/slots is the better IPC.
> 
> And we should probably consider FORMAT_RESET.

What's FORMAT_RESET for?

Thanks,
Kan

