Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7756C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4D420737
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbgDAUur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:50:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:47612 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732345AbgDAUur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:50:47 -0400
IronPort-SDR: Q7VYTvpHqkKzyQ80zxqPM0cIhE3tLl0OHp9uw6au9GtVFGCo8A8s+mzGCNfaoe5H15aJSnR9BB
 +ZUSJmubm0HQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 13:50:46 -0700
IronPort-SDR: 0b20xBx0A+LWhmYt/DccnKIYCYCqk/ISmwhfHQrIh/eB4ygb6we7J6eaX/VnQfIFgQBZCzysWR
 r1vcJXjKZ5wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="242851775"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2020 13:50:46 -0700
Received: from [10.213.137.102] (abudanko-MOBL.ccr.corp.intel.com [10.213.137.102])
        by linux.intel.com (Postfix) with ESMTP id 143425803DA;
        Wed,  1 Apr 2020 13:50:39 -0700 (PDT)
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
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
 <CAADnVQKSb8ZEq7mG0XwGx_btLxoEU5XDTu_p6eseDGuO-G+5tw@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <687dc836-4d86-c281-75b3-c4df451e7cd1@linux.intel.com>
Date:   Wed, 1 Apr 2020 23:50:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQKSb8ZEq7mG0XwGx_btLxoEU5XDTu_p6eseDGuO-G+5tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexei,

On 15.01.2020 4:52, Alexei Starovoitov wrote:
> On Tue, Jan 14, 2020 at 10:50 AM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
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
>> Sure, software cannot guarantee, but known software bugs could still be fixed,
>> that's what I meant.
>>
>>> imo adding a cap just for pmc is pointless.
>>> if you add a new cap it should cover all of sys_perf_event_open syscall.
>>> subdividing it into sw vs hw counters, kprobe create vs enable, etc will
>>> be the source of ongoing confusion. nack to such cap.
>>>
>>
>> Well, as this patch set already covers complete perf_event_open functionality,
>> and also eBPF related parts too, could you please review and comment on it?
>> Does the patches 2/9 and 5/9 already bring all required extentions?
> 
> yes. the current patches 2 and 5 look good to me.

Could this have you explicit Reviewed-by or Acked-by tag so
the changes could be driven into the kernel?
Latest v7 is here: https://lore.kernel.org/lkml/c8de937a-0b3a-7147-f5ef-69f467e87a13@linux.intel.com/

Thanks,
Alexey
