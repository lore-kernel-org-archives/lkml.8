Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01943C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AA0206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDVHjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:39:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:41788 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgDVHjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:39:47 -0400
IronPort-SDR: ayo8cCg8ajFOOTdASh6lBOIhqPIEwTThV3dw8F3JB8GrEM0Xn5+ugtCZqTFZnNq6F2S/qX1yuT
 +8vQJdnWhqXw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 00:39:44 -0700
IronPort-SDR: Y4kJm8tR+zcYkVeYbRmYKmz7vFnym1XDSE0gfzRmkCsjqNxyzXCQIgvJ0vGn3licwk1jCyoJHR
 NJZy1UT7TZbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; 
   d="scan'208";a="245907344"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by fmsmga007.fm.intel.com with ESMTP; 22 Apr 2020 00:39:40 -0700
Subject: Re: [PATCH V6 08/15] ftrace: Add perf text poke events for ftrace
 trampolines
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20200405201327.7332-1-adrian.hunter@intel.com>
 <20200405201327.7332-9-adrian.hunter@intel.com>
 <20200421134504.GQ20730@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ce16611a-8b6c-765d-c254-5bb98493b082@intel.com>
Date:   Wed, 22 Apr 2020 10:39:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421134504.GQ20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/20 4:45 pm, Peter Zijlstra wrote:
> On Sun, Apr 05, 2020 at 11:13:20PM +0300, Adrian Hunter wrote:
>> Add perf text poke events for ftrace trampolines when created and when
>> freed.
> 
> Maybe also put in a little more detail on the various events. Because
> arch_ftrace_update_trampoline() can also generate text_poke_bp() events,
> to update an existing trampoline.
> 
> A diagram, like with the kprobes thing perhaps.

How about adding this:

There can be 3 text_poke events for ftrace trampolines:

1. NULL -> trampoline
   By ftrace_update_trampoline() when !ops->trampoline
   Trampoline created

2. [e.g. on x86] CALL rel32 -> CALL rel32
   By arch_ftrace_update_trampoline() when ops->trampoline and
                        ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
   [e.g. on x86] via text_poke_bp() which generates text poke events
   Trampoline-called function target updated

3. trampoline -> NULL
   By ftrace_trampoline_free() when ops->trampoline and
                 ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
   Trampoline freed

> 
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  kernel/trace/ftrace.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 398d58b8ffa5..3318f7eca76c 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -2792,6 +2792,13 @@ static void ftrace_trampoline_free(struct ftrace_ops *ops)
>>  {
>>  	if (ops && (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP) &&
>>  	    ops->trampoline) {
>> +		/*
>> +		 * Record the text poke event before the ksymbol unregister
>> +		 * event.
>> +		 */
>> +		perf_event_text_poke((void *)ops->trampoline,
>> +				     (void *)ops->trampoline,
>> +				     ops->trampoline_size, NULL, 0);
>>  		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
>>  				   ops->trampoline, ops->trampoline_size,
>>  				   true, FTRACE_TRAMPOLINE_SYM);
>> @@ -6816,6 +6823,13 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops)
>>  		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
>>  				   ops->trampoline, ops->trampoline_size, false,
>>  				   FTRACE_TRAMPOLINE_SYM);
>> +		/*
>> +		 * Record the perf text poke event after the ksymbol register
>> +		 * event.
>> +		 */
>> +		perf_event_text_poke((void *)ops->trampoline, NULL, 0,
>> +				     (void *)ops->trampoline,
>> +				     ops->trampoline_size);
>>  	}
>>  }
>>  
>> -- 
>> 2.17.1
>>

