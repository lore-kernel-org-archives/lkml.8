Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB3FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 22:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF74C2224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 22:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596839144;
	bh=5d8J1XXPiuotV4kyoNsGQ2GCIAsJcMejftum46peWaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SFx3bdZ3PdVrnXQ36j4nwOftpxftYKYQ/O0NdQPiV3v6Q9EwYkyrHjKrTsu+zoqha
	 WNkkHcPkAEMRIlgnugOpU2KYzDPn9tFdq9GsjlRP9SiilC0fuQwk4QpprdxGeFmBdO
	 WV554VCqFoxe8jEpTLS3oXvVV4Hkn2wH8vIN7bJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgHGWZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 18:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHGWZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 18:25:42 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE88E2177B;
        Fri,  7 Aug 2020 22:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596839141;
        bh=5d8J1XXPiuotV4kyoNsGQ2GCIAsJcMejftum46peWaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJ1P9Hxef/cjB6dDGYTSjQuMigdd6ePzcd2lrH8T40SxRiohlf+MNZEzHJggn92Gt
         VLWIrVM2aKNqBv5YNEktomIJf1mQ3YFyRdz6Atmydyl8AxfGkB9uwPbUptETdSPm0H
         sryLAwpd7HUjfYK4pzh/cIqFQlIg8cRXLcP9IFF0=
Date:   Fri, 7 Aug 2020 18:25:39 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v4 00/14] liblockdep fixes for 5.9-rc1
Message-ID: <20200807222539.GE2975990@sasha-vm>
References: <20200805001043.3331907-1-sashal@kernel.org>
 <20200806080941.GA1697074@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200806080941.GA1697074@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 10:09:41AM +0200, Ingo Molnar wrote:
>
>* Sasha Levin <sashal@kernel.org> wrote:
>
>> Hi Linus,
>>
>> Please consider applying these patches for liblockdep, or alternatively
>> pull from:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/sashal/linux.git tags/liblockdep-fixes-040820
>>
>> The patches fix up compilation and functionality of liblockdep on 5.8,
>> they were tested using liblockdep's internal testsuite.
>>
>> I was unable to get the x86 folks to pull these fixes for the past few
>> months:
>
>So the primary reason I didn't pull is that liblockdep was permanently
>build-broken from February 2019 to around February 2020, despite me
>pinging you multiple times about it.

I'm not sure how ignoring me for additional 6 months helped the state of
liblockdep.

>>  - https://lkml.org/lkml/2020/2/17/1089
>
>This pull request still said that if fixes "most of" liblockdep, not
>"all of", which is the benchmark really after such a long series of
>breakage.
>
>>  - https://lkml.org/lkml/2020/4/18/817
>
>This still said "most of".
>
>>  - https://lkml.org/lkml/2020/6/22/1262
>
>Same 'most of' verbiage.

Right, and there are still benign build warnings around unused
variables which doesn't impede liblockdep's functionality.

Should they be cleaned up? sure, but let's get it working again.

>> Which is why this pull request ends up going straight to you.
>
>So at this point I think we need to ask whether it's worth it: are
>there any actual users of liblockdep, besides the testcases in
>liblockdep itself? I see there's a 'liblockdep-dev' package for
>Debian, but not propagated to Ubuntu or other popular variants AFAICS.

Right, I can't really say how many users of this there are out there. I
get an occasional email with a question or comment but I'm not aware of
how many of those users are out there.

I do think that if we keep liblockdep alive we should do a better job at
not taking commits that break it to begin with. The model where someone
is chasing lockdep to fix breakage after breakage isn't sustainable.

>Also, could you please specify whether all bugs are fixed or just
>'most'?

It passes the testsuite, there are compiler warnings that show up on
some gcc versions I'll work on cleaning up.

>> Sasha Levin (14):
>>   tools headers: Add kprobes.h header
>>   tools headers: Add rcupdate.h header
>>   tools/kernel.h: extend with dummy RCU functions
>>   tools bitmap: add bitmap_andnot definition
>>   tools/lib/lockdep: add definition required for IRQ flag tracing
>>   tools bitmap: add bitmap_clear definition
>>   tools/lib/lockdep: Hook up vsprintf, find_bit, hweight libraries
>>   tools/lib/lockdep: Enable building with CONFIG_TRACE_IRQFLAGS
>>   tools/lib/lockdep: New stacktrace API
>>   tools/lib/lockdep: call lockdep_init_task on init
>>   tools/lib/lockdep: switch to using lockdep_init_map_waits
>>   tools/kernel.h: hide noinstr
>>   tools/lib/lockdep: explicitly declare lockdep_init_task()
>>   tools/kernel.h: hide task_struct.hardirq_chain_key
>
>Style nits, please use consistent titles for patches:
>
> - First word should be capitalized consistently, instead of mismash
>   of lower case mixed with upper case.
>
> - First word should preferably be a verb, i.e. "Add new stacktrace
>   API stubs", not "New stacktrace API"

I'll address these.

>Also, please always check linux-next whether there's some new upstream
>changes that liblockdep needs to adapt to. Right now there's a new
>build breakage even with all your fixes applied:
>
>  thule:~/tip/tools/lib/lockdep> make
>    CC       common.o
>  In file included from ../../include/linux/lockdep.h:24,
>                   from common.c:5:
>   ../../include/linux/../../../include/linux/lockdep.h:13:10: fatal error: linux/lockdep_types.h: No such file or directory
>     13 | #include <linux/lockdep_types.h>
>        |          ^~~~~~~~~~~~~~~~~~~~~~~
>
>At which point we need to step back and analyze the development model:
>this comparatively high rate of breakage derives from the unorthodox
>direct coupling of a kernel subsystem to a user-space library.
>
>The solution for that would be to use the method how perf syncs to
>kernel space headers, by maintaining a 100% copy in tools/include/ and
>having automatic mechanism that warns about out of sync headers but
>doesn't break functionality.
>
>See tools/perf/check-headers.sh for details.
>
>I believe this same half-automated sync-on-upstream-changes model
>could be used for liblockdep as well, i.e. lets copy kernel/lockdep.c
>and lockdep*.h over to tools/lib/lockdep/, and reuse the perf header
>syncing method to keep it synchronized from that point on.
>
>That would result in a far more maintainable liblockdep end result
>IMO?

How does perf handle doing changes on top of those headers? As an
example, if you look at patch #12, it basically makes userspace ignore
the new "noinstr" annotation, otherwise compiling code that uses
"noinstr" in userspace breaks badly.

For liblockdep it's not enough to just sync headers, we need to do
changes to those headers as well.

-- 
Thanks,
Sasha
