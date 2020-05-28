Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC4DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 04:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1F6207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 04:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgE1EjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 00:39:02 -0400
Received: from foss.arm.com ([217.140.110.172]:47000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbgE1EjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 00:39:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D20A31B;
        Wed, 27 May 2020 21:39:01 -0700 (PDT)
Received: from A010555 (unknown [10.169.38.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43AD03F6C4;
        Wed, 27 May 2020 21:38:59 -0700 (PDT)
References: <20200522065330.34872-1-nick.gasson@arm.com> <CAP-5=fU8CJzOttgVDSxqHQoRg_eZ1+sToywOiek+8vw4j2GykA@mail.gmail.com> <xgl9wo4ylyv5.fsf@arm.com> <CAP-5=fUXP7OVEAX+u7-t8VZ9d8xq747kWgdvC_s7=wiHg7iBSw@mail.gmail.com>
User-agent: mu4e 1.4.5; emacs 26.3
From:   Nick Gasson <nick.gasson@arm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf jvmti: remove redundant jitdump line table entries
In-reply-to: <CAP-5=fUXP7OVEAX+u7-t8VZ9d8xq747kWgdvC_s7=wiHg7iBSw@mail.gmail.com>
Date:   Thu, 28 May 2020 12:38:56 +0800
Message-ID: <xgl9y2pcfzbz.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/20 02:08 AM, Ian Rogers wrote:
>>
>> I noticed it loses information when the Hotspot code cache is
>> resized. I've been working around that by setting
>> -XX:InitialCodeCacheSize and -XX:ReservedCodeCacheSize to large
>> values. Does this help in your case?
>
> Thanks, I tried and also with Steve's patch:
> https://lore.kernel.org/lkml/1590544271-125795-1-git-send-email-steve.maclean@linux.microsoft.com/

Thanks for the reference! That patch fixes the problem I had with code
cache resizing so the workaround above is no longer necessary.

>
> Trying something very basic like just the -version command with compile only:
> /tmp/perf/perf record -k 1 -e cycles:u -F 6500 -o /tmp/perf.data java
> -agentpath:/tmp/perf/libperf-jvmti.so -XX:+PreserveFramePointer
> -XX:InitialCodeCacheSize=2G -XX:ReservedCodeCacheSize=2G
> -XX:CompileOnly=1 -version
> /tmp/perf/perf inject -i /tmp/perf.data -o /tmp/perf-jit.data -j
> /tmp/perf/perf report -i /tmp/perf-jit.data
>
> I don't see any of the JDK classes but 35 unknown symbols out of 272.
> The JDK classes are stripped to some degree iirc, but we should be
> able to give a symbol name as we don't care about local variables and
> like.
>

I tried this with latest perf/core and JDK 11 but I don't see any
[unknown] from jitted-*.so. All the events are in "Interpreter": I think
the options you want are -Xcomp -Xbatch rather than -XX:CompileOnly=1?
The latter restricts compilation to the named method/package.

There was a bug where no jitdump debug info was written for classes
compiled without line tables. That was fixed by d3ea46da3 ("perf jvmti:
Fix jitdump for methods without debug info").

--
Nick
