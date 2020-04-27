Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F58C7C801
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97B12080C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgD0HWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:22:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:60264 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgD0HWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:22:46 -0400
IronPort-SDR: LRgKystjc+gMHerzY4XKWr5AuWOQCAU4Hc9Ym9Abvxd9B6bg0Eox8CLYwZ7qOOdmtHPugk5juX
 BOtdW8LEgehw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 00:22:46 -0700
IronPort-SDR: jBxyz+oJXa8SXxc/R5jboguwrqM3gqv+zl3VYzEVbPIrrdCrGGOdyDQo1IRPlqnowK7Bb91F4f
 7IsqG3GtXGMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; 
   d="scan'208";a="404162591"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga004.jf.intel.com with ESMTP; 27 Apr 2020 00:22:41 -0700
Subject: Re: [PATCH V6 08/15] ftrace: Add perf text poke events for ftrace
 trampolines
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200405201327.7332-1-adrian.hunter@intel.com>
 <20200405201327.7332-9-adrian.hunter@intel.com>
 <20200421134504.GQ20730@hirez.programming.kicks-ass.net>
 <ce16611a-8b6c-765d-c254-5bb98493b082@intel.com>
 <20200422114659.GE20730@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <76de871f-fb0a-6918-68a9-94aa7b049d6b@intel.com>
Date:   Mon, 27 Apr 2020 10:23:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422114659.GE20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/20 2:46 pm, Peter Zijlstra wrote:
> On Wed, Apr 22, 2020 at 10:39:06AM +0300, Adrian Hunter wrote:
>> On 21/04/20 4:45 pm, Peter Zijlstra wrote:
>>> On Sun, Apr 05, 2020 at 11:13:20PM +0300, Adrian Hunter wrote:
>>>> Add perf text poke events for ftrace trampolines when created and when
>>>> freed.
>>>
>>> Maybe also put in a little more detail on the various events. Because
>>> arch_ftrace_update_trampoline() can also generate text_poke_bp() events,
>>> to update an existing trampoline.
>>>
>>> A diagram, like with the kprobes thing perhaps.
>>
>> How about adding this:
>>
>> There can be 3 text_poke events for ftrace trampolines:
>>
>> 1. NULL -> trampoline
>>    By ftrace_update_trampoline() when !ops->trampoline
>>    Trampoline created
>>
>> 2. [e.g. on x86] CALL rel32 -> CALL rel32
>>    By arch_ftrace_update_trampoline() when ops->trampoline and
>>                         ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
>>    [e.g. on x86] via text_poke_bp() which generates text poke events
>>    Trampoline-called function target updated
>>
>> 3. trampoline -> NULL
>>    By ftrace_trampoline_free() when ops->trampoline and
>>                  ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
>>    Trampoline freed
> 
> Yes, very nice. Thanks!

Arnaldo, do you have this patchset on your radar?
