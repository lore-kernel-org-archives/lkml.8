Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE9CC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BB92077B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgAOMLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:11:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:34661 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgAOMLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:11:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 04:11:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="219971966"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jan 2020 04:11:13 -0800
Received: from [10.125.252.177] (abudanko-mobl.ccr.corp.intel.com [10.125.252.177])
        by linux.intel.com (Postfix) with ESMTP id 5EA1E580409;
        Wed, 15 Jan 2020 04:11:07 -0800 (PST)
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>,
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
 <81abaa29-d1be-a888-8b2f-fdf9b7e9fde8@linux.intel.com>
 <CAADnVQKddDCRV9Zp7N_TR51wc5rtRwFN-pSZHLiXDXe23+B_5Q@mail.gmail.com>
 <257a949a-b7cc-5ff1-6f1a-34bc44b1efc5@linux.intel.com>
 <20200115184538.bb8604e914dcc0eaeaf357fd@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2610ef96-40c4-5ff1-f972-104d418a3ac8@linux.intel.com>
Date:   Wed, 15 Jan 2020 15:11:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115184538.bb8604e914dcc0eaeaf357fd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.01.2020 12:45, Masami Hiramatsu wrote:
> On Tue, 14 Jan 2020 21:50:33 +0300
> Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> 
>>
>> On 14.01.2020 21:06, Alexei Starovoitov wrote:
>>> On Tue, Jan 14, 2020 at 1:47 AM Alexey Budankov
>>> <alexey.budankov@linux.intel.com> wrote:
>>>>>>
>>>>>> As we talked at RFC series of CAP_SYS_TRACING last year, I just expected
>>>>>> to open it for enabling/disabling kprobes, not for creation.
>>>>>>
>>>>>> If we can accept user who has no admin priviledge but the CAP_SYS_PERFMON,
>>>>>> to shoot their foot by their own risk, I'm OK to allow it. (Even though,
>>>>>> it should check the max number of probes to be created by something like
>>>>>> ulimit)
>>>>>> I think nowadays we have fixed all such kernel crash problems on x86,
>>>>>> but not sure for other archs, especially on the devices I can not reach.
>>>>>> I need more help to stabilize it.
>>>>>
>>>>> I don't see how enable/disable is any safer than creation.
>>>>> If there are kernel bugs in kprobes the kernel will crash anyway.
>>>>> I think such partial CAP_SYS_PERFMON would be very confusing to the users.
>>>>> CAP_* is about delegation of root privileges to non-root.
>>>>> Delegating some of it is ok, but disallowing creation makes it useless
>>>>> for bpf tracing, so we would need to add another CAP later.
>>>>> Hence I suggest to do it right away instead of breaking
>>>>> sys_perf_even_open() access into two CAPs.
>>>>>
>>>>
>>>> Alexei, Masami,
>>>>
>>>> Thanks for your meaningful input.
>>>> If we know in advance that it still can crash the system in some cases and on
>>>> some archs, even though root fully controls delegation thru CAP_SYS_PERFMON,
>>>> such delegation looks premature until the crashes are avoided. So it looks like
>>>> access to eBPF for CAP_SYS_PERFMON privileged processes is the subject for
>>>> a separate patch set.
>>>
>>> perf_event_open is always dangerous. sw cannot guarantee non-bugginess of hw.
>>
> 
> OK, anyway, for higher security, admin may not give CAP_SYS_PERFMON to
> unpriviledged users, since it might allows users to analyze kernel, which
> can lead security concerns.

FWIW,
Discovered security related hardware issues could be mitigated in software and 
here [1] is the official procedure documented on how to follow up, so this could
be a draft plan to approach eBPF perf_events related hardware issues, if required.

[1] https://www.kernel.org/doc/html/latest/process/embargoed-hardware-issues.html

> 
>> Sure, software cannot guarantee, but known software bugs could still be fixed,
>> that's what I meant.
> 
> Agreed, bugs must be fixed anyway.
> 
> Thank you,
> 
>>> imo adding a cap just for pmc is pointless.
>>> if you add a new cap it should cover all of sys_perf_event_open syscall.
>>> subdividing it into sw vs hw counters, kprobe create vs enable, etc will
>>> be the source of ongoing confusion. nack to such cap.
>>>
>>
>> Well, as this patch set already covers complete perf_event_open functionality,
>> and also eBPF related parts too, could you please review and comment on it?
>> Does the patches 2/9 and 5/9 already bring all required extentions?
>>
>> Thanks,
>> Alexey
> 
> 
