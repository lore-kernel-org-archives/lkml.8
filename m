Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BECC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1262078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbgDAKnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:43:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:35532 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgDAKnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:43:39 -0400
IronPort-SDR: YSvIezuwlpYdkQ95J1W7Zs0l7jjiULvpnxAczA1IAeZbptUO7XyPQcrZktuM2x4q7cYnljX0D7
 BGyeGj8j3N7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:43:38 -0700
IronPort-SDR: l5cmCFw2/iUy8hM8ZPvhJ0ztv2eZKPv5r4qegJ5R/RX0E+NeKF9EfbY1++RRZhke+Dt0AsyLWj
 BWHEoxUJ5ZMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="267624873"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga002.jf.intel.com with ESMTP; 01 Apr 2020 03:43:34 -0700
Subject: Re: [PATCH V4 08/13] ftrace: Add perf text poke events for ftrace
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
References: <20200304090633.420-1-adrian.hunter@intel.com>
 <20200304090633.420-9-adrian.hunter@intel.com>
 <20200401100955.GY20713@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7e54c145-28d2-5175-6882-9f19e3939f13@intel.com>
Date:   Wed, 1 Apr 2020 13:42:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200401100955.GY20713@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/04/20 1:09 pm, Peter Zijlstra wrote:
> On Wed, Mar 04, 2020 at 11:06:28AM +0200, Adrian Hunter wrote:
>> Add perf text poke events for ftrace trampolines when created and when
>> freed.
> 
> If I'm not mistaken that ends up like so:
> 
> static void ftrace_update_trampoline(struct ftrace_ops *ops)
> {
> +       unsigned long trampoline = ops->trampoline;
> +
> 	arch_ftrace_update_trampoline(ops);
> +       if (ops->trampoline && ops->trampoline != trampoline &&
>> +	    (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP)) {
>> +		/* Add to kallsyms before the perf events */
> +               ftrace_add_trampoline_to_kallsyms(ops);
>> +		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
>> +				   ops->trampoline, ops->trampoline_size, false,
>> +				   FTRACE_TRAMPOLINE_SYM);
>> +		/*
>> +		 * Record the perf text poke event after the ksymbol register
>> +		 * event.
>> +		 */
>> +		perf_event_text_poke((void *)ops->trampoline, NULL, 0,
>> +				     (void *)ops->trampoline,
>> +				     ops->trampoline_size);
> 	}
> }
> 
> And afaict, that is wrong.
> 
> The thing is; arch_ftrace_update_trampoline() can actually *update* an
> existing trampoline, as per the name. Yes it also creates a trampoline
> if there isn't one already, but if there already is one, it will modify
> it in-place.
> 
> I see the appeal of having this event in generic code; but I'm thinking
> you'll need the update even in arch code anyway, at which point it'd
> probably be easier to do all of this in arch code.

For x86, we use text_poke_bp for updates which already does text_poke events
via text_poke_bp_batch.

It might be reasonable to assume other architectures will also need to put
updates through a common text poker which will take care of text_poke events.

The V3 patch had it in arch code but Steven Rostedt asked why it couldn't be
in ftrace_update)trampoline, so I moved it.
