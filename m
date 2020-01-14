Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D566BC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E04324670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgANJrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:47:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:11077 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgANJrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:47:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 01:47:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,432,1571727600"; 
   d="scan'208";a="248001520"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jan 2020 01:47:50 -0800
Received: from [10.252.24.8] (abudanko-mobl.ccr.corp.intel.com [10.252.24.8])
        by linux.intel.com (Postfix) with ESMTP id 9A6C15804A9;
        Tue, 14 Jan 2020 01:47:43 -0800 (PST)
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
 <158a4033-f8d6-8af7-77b0-20e62ec913b0@linux.intel.com>
 <20200114122506.3cf442dc189a649d4736f86e@kernel.org>
 <CAADnVQLCtrvvagbbkZG4PyAKb2PWzUouxG3=nxvm8QdpgEWtGQ@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <81abaa29-d1be-a888-8b2f-fdf9b7e9fde8@linux.intel.com>
Date:   Tue, 14 Jan 2020 12:47:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQLCtrvvagbbkZG4PyAKb2PWzUouxG3=nxvm8QdpgEWtGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14.01.2020 8:17, Alexei Starovoitov wrote:
> On Mon, Jan 13, 2020 at 7:25 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>
>> On Sat, 11 Jan 2020 12:57:18 +0300
>> Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
>>
>>>
>>> On 11.01.2020 3:35, arnaldo.melo@gmail.com wrote:
>>
>>>> Message-ID: <A7F0BF73-9189-44BA-9264-C88F2F51CBF3@kernel.org>
>>>>
>>>> On January 10, 2020 9:23:27 PM GMT-03:00, Song Liu <songliubraving@fb.com> wrote:
>>>>>
>>>>>
>>>>>> On Jan 10, 2020, at 3:47 PM, Masami Hiramatsu <mhiramat@kernel.org>
>>>>> wrote:
>>>>>>
>>>>>> On Fri, 10 Jan 2020 13:45:31 -0300
>>>>>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>>>>
>>>>>>> Em Sat, Jan 11, 2020 at 12:52:13AM +0900, Masami Hiramatsu escreveu:
>>>>>>>> On Fri, 10 Jan 2020 15:02:34 +0100 Peter Zijlstra
>>>>> <peterz@infradead.org> wrote:
>>>>>>>>> Again, this only allows attaching to previously created kprobes,
>>>>> it does
>>>>>>>>> not allow creating kprobes, right?
>>>>>>>
>>>>>>>>> That is; I don't think CAP_SYS_PERFMON should be allowed to create
>>>>>>>>> kprobes.
>>>>>>>
>>>>>>>>> As might be clear; I don't actually know what the user-ABI is for
>>>>>>>>> creating kprobes.
>>>>>>>
>>>>>>>> There are 2 ABIs nowadays, ftrace and ebpf. perf-probe uses ftrace
>>>>> interface to
>>>>>>>> define new kprobe events, and those events are treated as
>>>>> completely same as
>>>>>>>> tracepoint events. On the other hand, ebpf tries to define new
>>>>> probe event
>>>>>>>> via perf_event interface. Above one is that interface. IOW, it
>>>>> creates new kprobe.
>>>>>>>
>>>>>>> Masami, any plans to make 'perf probe' use the perf_event_open()
>>>>>>> interface for creating kprobes/uprobes?
>>>>>>
>>>>>> Would you mean perf probe to switch to perf_event_open()?
>>>>>> No, perf probe is for setting up the ftrace probe events. I think we
>>>>> can add an
>>>>>> option to use perf_event_open(). But current kprobe creation from
>>>>> perf_event_open()
>>>>>> is separated from ftrace by design.
>>>>>
>>>>> I guess we can extend event parser to understand kprobe directly.
>>>>> Instead of
>>>>>
>>>>>    perf probe kernel_func
>>>>>    perf stat/record -e probe:kernel_func ...
>>>>>
>>>>> We can just do
>>>>>
>>>>>    perf stat/record -e kprobe:kernel_func ...
>>>>
>>>>
>>>> You took the words from my mouth, exactly, that is a perfect use case, an alternative to the 'perf probe' one of making a disabled event that then gets activated via record/stat/trace, in many cases it's better, removes the explicit probe setup case.
>>>
>>> Arnaldo, Masami, Song,
>>>
>>> What do you think about making this also open to CAP_SYS_PERFMON privileged processes?
>>> Could you please also review and comment on patch 5/9 for bpf_trace.c?
>>
>> As we talked at RFC series of CAP_SYS_TRACING last year, I just expected
>> to open it for enabling/disabling kprobes, not for creation.
>>
>> If we can accept user who has no admin priviledge but the CAP_SYS_PERFMON,
>> to shoot their foot by their own risk, I'm OK to allow it. (Even though,
>> it should check the max number of probes to be created by something like
>> ulimit)
>> I think nowadays we have fixed all such kernel crash problems on x86,
>> but not sure for other archs, especially on the devices I can not reach.
>> I need more help to stabilize it.
> 
> I don't see how enable/disable is any safer than creation.
> If there are kernel bugs in kprobes the kernel will crash anyway.
> I think such partial CAP_SYS_PERFMON would be very confusing to the users.
> CAP_* is about delegation of root privileges to non-root.
> Delegating some of it is ok, but disallowing creation makes it useless
> for bpf tracing, so we would need to add another CAP later.
> Hence I suggest to do it right away instead of breaking
> sys_perf_even_open() access into two CAPs.
> 

Alexei, Masami,

Thanks for your meaningful input.
If we know in advance that it still can crash the system in some cases and on 
some archs, even though root fully controls delegation thru CAP_SYS_PERFMON,
such delegation looks premature until the crashes are avoided. So it looks like
access to eBPF for CAP_SYS_PERFMON privileged processes is the subject for
a separate patch set.

Thanks,
Alexey
