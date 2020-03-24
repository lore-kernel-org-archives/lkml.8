Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83151C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C156207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCXMyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:54:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:53196 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgCXMyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:54:50 -0400
IronPort-SDR: Sd18ajisI7DHy+Q8rKrS79Jc0fvueL+LeQwCTR94hHN9TWIWHsQFHKz4zfCL4GMcOkOvaqBFCh
 s22fnzLadBSg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 05:54:50 -0700
IronPort-SDR: NK3xfEI5svL0DAmLzPZOfxBMQVX1SyRFV8NMte9sRJIbdPUq1rMFpy7/YmJjOMqkUSKozREHfr
 gcHE7oAigyZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="240258330"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga008.jf.intel.com with ESMTP; 24 Mar 2020 05:54:46 -0700
Subject: Re: [PATCH V4 03/13] kprobes: Add symbols for kprobe insn pages
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
 <20200304090633.420-4-adrian.hunter@intel.com>
 <20200324123108.GO20696@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f79e6ff3-5459-64c9-385a-68ab10b1c33c@intel.com>
Date:   Tue, 24 Mar 2020 14:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324123108.GO20696@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/20 2:31 pm, Peter Zijlstra wrote:
> On Wed, Mar 04, 2020 at 11:06:23AM +0200, Adrian Hunter wrote:
>> Symbols are needed for tools to describe instruction addresses. Pages
>> allocated for kprobe's purposes need symbols to be created for them.
>> Add such symbols to be visible via /proc/kallsyms.
>>
>> Note: kprobe insn pages are not used if ftrace is configured. To see the
>> effect of this patch, the kernel must be configured with:
>>
>> 	# CONFIG_FUNCTION_TRACER is not set
>> 	CONFIG_KPROBES=y
>>
>> and for optimised kprobes:
>>
>> 	CONFIG_OPTPROBES=y
>>
>> Example on x86:
>>
>> 	# perf probe __schedule
>> 	Added new event:
>> 	  probe:__schedule     (on __schedule)
>> 	# cat /proc/kallsyms | grep '\[__builtin__kprobes\]'
>> 	ffffffffc00d4000 t kprobe_insn_page     [__builtin__kprobes]
>> 	ffffffffc00d6000 t kprobe_optinsn_page  [__builtin__kprobes]
>>
> 
> I'm confused; why are you iterating pages and not slots? A 'page' is not
> a symbol, they contain text, sometimes.

A symbol for each slot is not necessary, and it doesn't look like the slots
can be walked without taking a mutex, which is a problem for kallsyms.

> 
> If you iterate slots you can even get them a proper name; something
> like:
> 
> 	optinsn-sym+xxx [__builtin__kprobes]
> 
> 	insn-sym+xxx [__builtin__kprobes]
> 

Addresses resolve to the previous symbol plus an offset, so it seems to me
that the only difference in what you are proposing is the symbol name, which
can be changed if you like.
