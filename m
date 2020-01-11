Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D223FC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A526620848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgAKJ52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:57:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:11196 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgAKJ52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:57:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2020 01:57:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,420,1571727600"; 
   d="scan'208";a="240570568"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 11 Jan 2020 01:57:27 -0800
Received: from [10.252.24.8] (abudanko-mobl.ccr.corp.intel.com [10.252.24.8])
        by linux.intel.com (Postfix) with ESMTP id 380C858045A;
        Sat, 11 Jan 2020 01:57:19 -0800 (PST)
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
To:     arnaldo.melo@gmail.com, Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Robert Richter <rric@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <c93309dc-b920-f5fa-f997-e8b2faf47b88@linux.intel.com>
 <20200108160713.GI2844@hirez.programming.kicks-ass.net>
 <cc239899-5c52-2fd0-286d-4bff18877937@linux.intel.com>
 <20200110140234.GO2844@hirez.programming.kicks-ass.net>
 <20200111005213.6dfd98fb36ace098004bde0e@kernel.org>
 <20200110164531.GA2598@kernel.org>
 <20200111084735.0ff01c758bfbfd0ae2e1f24e@kernel.org>
 <2B79131A-3F76-47F5-AAB4-08BCA820473F@fb.com>
 <5e191833.1c69fb81.8bc25.a88c@mx.google.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <158a4033-f8d6-8af7-77b0-20e62ec913b0@linux.intel.com>
Date:   Sat, 11 Jan 2020 12:57:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <5e191833.1c69fb81.8bc25.a88c@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.01.2020 3:35, arnaldo.melo@gmail.com wrote:
> <keescook@chromium.org>,Jann Horn <jannh@google.com>,Thomas Gleixner <tglx@linutronix.de>,Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,Lionel Landwerlin <lionel.g.landwerlin@intel.com>,linux-kernel <linux-kernel@vger.kernel.org>,"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,"selinux@vger.kernel.org" <selinux@vger.kernel.org>,"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,"bpf@vger.kernel.org" <bpf@vger.kernel.org>,"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,"oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>
> From: Arnaldo Carvalho de Melo <acme@kernel.org>
> Message-ID: <A7F0BF73-9189-44BA-9264-C88F2F51CBF3@kernel.org>
> 
> On January 10, 2020 9:23:27 PM GMT-03:00, Song Liu <songliubraving@fb.com> wrote:
>>
>>
>>> On Jan 10, 2020, at 3:47 PM, Masami Hiramatsu <mhiramat@kernel.org>
>> wrote:
>>>
>>> On Fri, 10 Jan 2020 13:45:31 -0300
>>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>
>>>> Em Sat, Jan 11, 2020 at 12:52:13AM +0900, Masami Hiramatsu escreveu:
>>>>> On Fri, 10 Jan 2020 15:02:34 +0100 Peter Zijlstra
>> <peterz@infradead.org> wrote:
>>>>>> Again, this only allows attaching to previously created kprobes,
>> it does
>>>>>> not allow creating kprobes, right?
>>>>
>>>>>> That is; I don't think CAP_SYS_PERFMON should be allowed to create
>>>>>> kprobes.
>>>>
>>>>>> As might be clear; I don't actually know what the user-ABI is for
>>>>>> creating kprobes.
>>>>
>>>>> There are 2 ABIs nowadays, ftrace and ebpf. perf-probe uses ftrace
>> interface to
>>>>> define new kprobe events, and those events are treated as
>> completely same as
>>>>> tracepoint events. On the other hand, ebpf tries to define new
>> probe event
>>>>> via perf_event interface. Above one is that interface. IOW, it
>> creates new kprobe.
>>>>
>>>> Masami, any plans to make 'perf probe' use the perf_event_open()
>>>> interface for creating kprobes/uprobes?
>>>
>>> Would you mean perf probe to switch to perf_event_open()?
>>> No, perf probe is for setting up the ftrace probe events. I think we
>> can add an
>>> option to use perf_event_open(). But current kprobe creation from
>> perf_event_open()
>>> is separated from ftrace by design.
>>
>> I guess we can extend event parser to understand kprobe directly.
>> Instead of
>>
>> 	perf probe kernel_func
>> 	perf stat/record -e probe:kernel_func ...
>>
>> We can just do 
>>
>> 	perf stat/record -e kprobe:kernel_func ...
> 
> 
> You took the words from my mouth, exactly, that is a perfect use case, an alternative to the 'perf probe' one of making a disabled event that then gets activated via record/stat/trace, in many cases it's better, removes the explicit probe setup case.

Arnaldo, Masami, Song,

What do you think about making this also open to CAP_SYS_PERFMON privileged processes?
Could you please also review and comment on patch 5/9 for bpf_trace.c?

Thanks,
Alexey

> 
> Regards, 
> 
> - Arnaldo
> 
>>
>> Thanks,
>> Song
> 
