Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C30C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A3520786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgGHKti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:49:38 -0400
Received: from foss.arm.com ([217.140.110.172]:59988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGHKti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:49:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E54531B;
        Wed,  8 Jul 2020 03:49:37 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DF843F68F;
        Wed,  8 Jul 2020 03:49:36 -0700 (PDT)
References: <cover.1594062828.git.yu.c.chen@intel.com> <20200706200049.GB5523@worktop.programming.kicks-ass.net> <jhj7dvg8faj.mognet@arm.com> <20200707115621.GB25765@chenyu-office.sh.intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2][RFC] Makes sd->flags sysctl writable
In-reply-to: <20200707115621.GB25765@chenyu-office.sh.intel.com>
Date:   Wed, 08 Jul 2020 11:49:33 +0100
Message-ID: <jhjy2nu703m.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chen,

On 07/07/20 12:56, Chen Yu wrote:
> Hi Valentin,
> On Mon, Jul 06, 2020 at 11:11:32PM +0100, Valentin Schneider wrote:
>>
>> On 06/07/20 21:00, Peter Zijlstra wrote:
>> > On Tue, Jul 07, 2020 at 03:36:13AM +0800, Chen Yu wrote:
>> >> It was found that recently the flags of sched domain could
>> >> not be customized via sysctl, which might make it a little
>> >> inconenient for performance tuning/debugging.
>> >
>> > What specific goals do you have? This is a debug interface.
>>
>> Also, while the update_top_cache_domain() call on sysctl write may work,
>> you're back to square one as soon as you go through a hotplug cycle, which
>> is icky.
> Do you mean, after the hotplug, all the settings of flags are lost? Yes,
> it is, but in our testing environment we do not do hotplug offen : )

Right, and neither do I, but sadly hotplug is one of those things that we
have to take into account :(

>>
>> That said, I second Peter in that I'm curious as to what you're really
>> using this interface for. Manually hacking the default / arch topology
>> flags is a bit tedious, but it's doable.
> Agree, but since we do monitor performance testings automatically,
> it might save more time for us to not have to reboot everytime we
> change the flags. So I guess we can hack the code to make that
> flags field temporarily writable. I guess the concern here is that it
> looks a little overkilled for us to invoke update_top_cache_domain(),
> I'm okay with current read-only attribute.
>

To properly update the SD landscape (i.e. the cached pointers), we *need*
that update_top_cache_domain() call. But then there's also the hotplug
thing, so we would need to e.g. write back the flags values into the right
topology level of sched_domain_topology.

I can see value in it for testing, but I'm not convinced it is something we
want to open up again. At least it's not too complicated to automate
testing of different flag combinations - you just need to commit some
change to the topology flags (either default_topology or whatever your arch
uses).

> Thanks,
> Chenyu
