Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1D1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AA22074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgFAKC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:02:56 -0400
Received: from foss.arm.com ([217.140.110.172]:35876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbgFAKC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 06:02:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 771751FB;
        Mon,  1 Jun 2020 03:02:55 -0700 (PDT)
Received: from A010555 (unknown [10.169.38.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1F903F305;
        Mon,  1 Jun 2020 03:02:51 -0700 (PDT)
References: <1590544271-125795-1-git-send-email-steve.maclean@linux.microsoft.com> <CAP-5=fXGXqkTbSwKv7eq9UkPvVqRJXDm3E-XNxD8+5fmQk3bpg@mail.gmail.com> <MN2PR21MB15185419971A29EF52B8138FF7B10@MN2PR21MB1518.namprd21.prod.outlook.com> <CAP-5=fVHo262Lo_Re31wM8Bt0soJ-m51J7MEnwvdTg5P8J6e6A@mail.gmail.com> <CAP-5=fV7F4u66388HC-q8btOYWKxtb1gTTi4LK_Besb-zE25Rw@mail.gmail.com> <xgl9tuzvz4wc.fsf@arm.com> <CAP-5=fWU==y-DMd5sD7AxHCUNg0L4Qt_VRVvyDVNYPCOdxmU_A@mail.gmail.com>
User-agent: mu4e 1.4.5; emacs 26.3
From:   Nick Gasson <nick.gasson@arm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Steve MacLean <Steve.MacLean@microsoft.com>,
        Steve MacLean <steve.maclean@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v4] perf inject --jit: Remove //anon mmap events
In-reply-to: <CAP-5=fWU==y-DMd5sD7AxHCUNg0L4Qt_VRVvyDVNYPCOdxmU_A@mail.gmail.com>
Date:   Mon, 01 Jun 2020 18:02:49 +0800
Message-ID: <xgl9mu5nyugm.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/20 16:53 PM, Ian Rogers wrote:
> On Sun, May 31, 2020 at 11:17 PM Nick Gasson <nick.gasson@arm.com> wrote:
>>
>> On 05/28/20 17:32 PM, Ian Rogers wrote:
>> >
>> > So on tip/perf/core with:
>> > 1c0cd2dbb993 perf jvmti: Fix jitdump for methods without debug info
>> > 3ce17c1e52f4 perf jvmti: remove redundant jitdump line table entries
>> >
>> > I've been trying variants of:
>> >
>> > Before:
>> > /tmp/perf/perf record -k 1 -e cycles:u -o /tmp/perf.data java
>> > -agentpath:/tmp/perf/libperf-jvmti.so -XX:+PreserveFramePointer
>> > -XX:InitialCodeCacheSize=20M -XX:ReservedCodeCacheSize=1G -jar
>> > dacapo-9.12-bach.jar jython
>> > /tmp/perf/perf inject -i /tmp/perf.data -o /tmp/perf-jit.data -j
>> > /tmp/perf/perf report -i /tmp/perf-jit.data |grep class\ |wc -l
>> > 578
>> > /tmp/perf/perf report -i /tmp/perf-jit.data |grep unknown |wc -l
>> > 6
>> >
>> > After:
>> > /tmp/perf/perf record -k 1 -e cycles:u -o /tmp/perf.data java
>> > -agentpath:/tmp/perf/libperf-jvmti.so -XX:+PreserveFramePointer
>> > -XX:InitialCodeCacheSize=20M -XX:ReservedCodeCacheSize=1G -jar
>> > dacapo-9.12-bach.jar jython
>> > /tmp/perf/perf inject -i /tmp/perf.data -o /tmp/perf-jit.data -j
>> > /tmp/perf/perf report -i /tmp/perf-jit.data |grep class\ |wc -l
>> > 589
>> > /tmp/perf/perf report -i /tmp/perf-jit.data |grep unknown |wc -l
>> > 60
>> >
>> > So maybe the jit cache isn't behaving the way that the patch cures,
>> > the uptick in unknowns appears consistent in my testing though. I
>> > expect user error, is there an obvious explanation I'm missing?
>> >
>>
>> Hi Ian,
>>
>> I tried this as well with latest perf/core. The difference is that
>> unresolved addresses currently look like:
>>
>>      0.00%  java             [JIT] tid 221782       [.] 0x0000ffff451499a4
>>      0.00%  java             [JIT] tid 221782       [.] 0x0000ffff4514f3e8
>>      0.00%  java             [JIT] tid 221782       [.] 0x0000ffff45149394
>>
>> But after Steve's patch this becomes:
>>
>>      0.00%  java             [unknown]              [.] 0x0000ffff58557d14
>>      0.00%  java             [unknown]              [.] 0x0000ffff785c03b4
>>      0.00%  java             [unknown]              [.] 0x0000ffff58386520
>>
>> I couldn't see any events that were symbolised before but are no longer
>> symbolised after this patch.
>
> I see this, thanks for digging into the explanation! Were you able to
> get a test case where the unknowns went down? For example, by forcing
> the code cache size to be small? This is the result I'd expect to see.

I tried the same Dacapo benchmark as you with different values of
InitialCodeCacheSize and grepped for -e '\[unknown\]' -e '\[JIT\]'.

       Base   Patched
 100M  338    373
 50M   333    315
 25M   323    368
 15M   1238   309
 10M   2600   333
 1M    6035   337

This looks fairly convincing to me: the cliff at 15M is where the code
cache starts needing to be enlarged.

>
>> I think most of these unknown events are caused by the asynchronous
>> nature of the JVMTI event handling. After an nmethod is compiled the
>> JVMTI event is posted to the Service Thread (*). So there can be a delay
>> between the time the compiled code starts executing and the time the
>> plugin receives the compiled code load event.
>>
>> Here's an edited down example:
>>
>>             java 215881 750014.947873:    1289634 cycles:u:      ffff7856ad10 [unknown] ([unknown])
>>   Service Thread 215895 750014.947971: PERF_RECORD_MMAP2 215879/215895: [0xffff785694c0(0x640) @ 0x40 fd:01 121010091 1]:
>>             java 215881 750014.948665:    1295994 cycles:u:      ffff7856ad10 org.python.core.__builtin__.range(org.python
>>
>> The plugin receives the event ~100us after the first sample inside that
>> method. Ideally we would use the timestamp when the method was actually
>> compiled, but I can't see any way to extract this information.
>
> Hmm.. this is a bit weird as the compile_info at one point was a
> resource allocation and so would be cleared out when the resource mark
> was passed on the compiler's return. Not something you'd want to do
> asynchronously. Presumably this has changed to improve performance,
> but doing the jvmti on a separate thread defeats jitdump - if we see
> samples in code ahead of the code being loaded. Perhaps a profiler
> like async-profiler
> (https://github.com/jvm-profiling-tools/async-profiler) has a
> workaround for the lag.
>

I had a brief look at the async-profiler JVMTI code but I can't see
anything it's doing differently. Their profiler.sh attaches to a running
JVM - I suspect this problem will be less obvious once the JIT has
warmed up.

The compile_info structure is still resource-allocated in
JvmtiExport::post_compiled_method_load() but that function is called
from the service thread not the compiler thread. The compiler thread
just pushes a nmethod* on a queue and the inlining data is recovered
from the nmethod object.

It seems we could extend JVMTI here to pass the code installation
timestamp as another CMLR record type.

--
Nick
