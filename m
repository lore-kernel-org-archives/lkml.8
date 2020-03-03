Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467E3C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226D220838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgCCK4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:56:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:23857 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgCCK4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:56:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 02:56:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="412703479"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 03 Mar 2020 02:56:06 -0800
Subject: Re: [OT] Pseudo module name in kallsyms (Re: [PATCH V3 03/13]
 kprobes: Add symbols for kprobe insn pages)
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200228135125.567-1-adrian.hunter@intel.com>
 <20200228135125.567-4-adrian.hunter@intel.com>
 <20200228233600.5f5c733584eac08b8a4a2b70@kernel.org>
 <20200228172004.GI5451@krava>
 <20200229134947.839096dbc8321cfdca980edb@kernel.org>
 <20200229184913.4e13e516@oasis.local.home> <20200302144307.GD204976@krava>
 <20200303194700.5810cbaf49bc6eacdffa7fa4@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <50754470-7675-c0b0-0931-9a6024e8eb90@intel.com>
Date:   Tue, 3 Mar 2020 12:55:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303194700.5810cbaf49bc6eacdffa7fa4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/03/20 12:47 pm, Masami Hiramatsu wrote:
> Hi,
> 
> On Mon, 2 Mar 2020 15:43:07 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
>> On Sat, Feb 29, 2020 at 06:49:13PM -0500, Steven Rostedt wrote:
>>> On Sat, 29 Feb 2020 13:49:47 +0900
>>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>>
>>>> On Fri, 28 Feb 2020 18:20:04 +0100
>>>> Jiri Olsa <jolsa@redhat.com> wrote:
>>>>
>>>>>> BTW, it seems to pretend to be a module, but is there no concern of
>>>>>> confusing users? Shouldn't it be [*kprobes] so that it is non-exist
>>>>>> module name?  
>>>>>
>>>>> note we already have bpf symbols as [bpf] module  
>>>>
>>>> Yeah, and this series adds [kprobe(s)] and [ftrace] too.
>>>> I simply concern that the those module names implicitly become
>>>> special word (rule) and embedded in the code. If such module names
>>>> are not exposed to users, it is OK (but I hope to have some comments).
>>>> However, it is under /proc, which means users can notice it.
>>>
>>> I share Masami's concerns. It would be good to have something
>>> differentiate local functions that are not modules. That's one way I
>>> look to see if something is a module or built in, is to see if kallsyms
>>> has it as a [].
>>>
>>> Perhaps prepend with: '&' ?
> 
> Yeah, '*' may not good from the filename point of view.
> 
>>
>> that would break some of the perf code.. IMO Arnaldo's explanation
>> makes sense and we could keep it as it is
> 
>  From the in-kernel API/coding point of view,
> 
> +static int get_ksymbol_kprobe(struct kallsym_iter *iter)
> +{
> +	strlcpy(iter->module_name, "kprobe", MODULE_NAME_LEN);
> +	iter->exported = 0;
> +	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
> +				  &iter->value, &iter->type,
> +				  iter->name) < 0 ? 0 : 1;
>  }
> 
> This clearly shows that is a iter->module_name.
> 
> And also, if someone make a module names "kprobes.ko", it will also
> have [kprobes] in kallsyms. That is also confusing.

If special characters are a problem, modules also do not start with '-' or
'_', so would "_kprobes" and "_ftrace" be acceptable to everyone?


