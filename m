Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1521AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FE3206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbgGMNwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:52:42 -0400
Received: from foss.arm.com ([217.140.110.172]:36156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729457AbgGMNwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:52:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A3EC30E;
        Mon, 13 Jul 2020 06:52:41 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A387E3F7BB;
        Mon, 13 Jul 2020 06:52:40 -0700 (PDT)
References: <20200701190656.10126-1-valentin.schneider@arm.com> <20200701190656.10126-8-valentin.schneider@arm.com> <20200713125543.GJ10769@hirez.programming.kicks-ass.net> <jhjimerlf2a.mognet@arm.com> <20200713134347.GL10769@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com
Subject: Re: [PATCH v3 7/7] sched/topology: Use prebuilt SD flag degeneration mask
In-reply-to: <20200713134347.GL10769@hirez.programming.kicks-ass.net>
Date:   Mon, 13 Jul 2020 14:52:38 +0100
Message-ID: <jhjh7ubldy1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/07/20 14:43, Peter Zijlstra wrote:
> On Mon, Jul 13, 2020 at 02:28:29PM +0100, Valentin Schneider wrote:
>>
>> On 13/07/20 13:55, Peter Zijlstra wrote:
>> > On Wed, Jul 01, 2020 at 08:06:55PM +0100, Valentin Schneider wrote:
>> >> Leverage SD_DEGENERATE_GROUPS_MASK in sd_degenerate() and
>> >> sd_degenerate_parent().
>> >>
>> >> Note that this changes sd_degenerate() somewhat: I'm using the negation of
>> >> SD_DEGENERATE_GROUPS_MASK as the mask of flags not requiring groups, which
>> >> is equivalent to:
>> >>
>> >> SD_WAKE_AFFINE | SD_SERIALIZE | SD_NUMA
>> >>
>> >> whereas the current mask for that is simply
>> >>
>> >> SD_WAKE_AFFINE
>> >>
>> >> I played with a few toy NUMA topologies on QEMU and couldn't cause a
>> >> different degeneration than what mainline does currently. If that is deemed
>> >> too risky, we can go back to using SD_WAKE_AFFINE explicitly.
>> >
>> > Arguably SD_SERIALIZE needs groups, note how we're only having that
>> > effective for machines with at least 2 nodes. It's a bit shit how we end
>> > up there, but IIRC that's what it ends up as.
>> >
>>
>> Right, AFAICT we get SD_SERIALIZE wherever we have SD_NUMA, which is any
>> level above NODE.
>
> Oh, right, I forgot we have NODE, d'0h. But in that case these lines:
>
>       if (nr_node_ids == 1)
>               pflags &= ~SD_SERIALIZE;
>
> are dead code, right?
>

Uuuuh right, that does sound like something made obsolete by having NODE;
we didn't have it back then:

5436499e6098 ("sched: fix sd_parent_degenerate on non-numa smp machine")

I'll fold that in (and test it, just to be sure :-)).

>> > SD_NUMA is descriptive, and not marking a group as degenerates because
>> > it has SD_NUMA seems a bit silly.
>>
>> It does, although we can still degenerate it, see below.
>>
>> > But then, it would be the top domain
>> > and would survive anyway?
>>
>> So from what I've tested we still get rid of those via
>> sd_parent_degenerate(): child and parent have the same flags and same span,
>> so parent goes out.
>>
>> That happens in the middle of the NUMA topology levels on that borked
>> topology with weird distances, aka
>>
>>   node distances:
>>   node   0   1   2   3
>>     0:  10  12  20  22
>>     1:  12  10  22  24
>>     2:  20  22  10  12
>>     3:  22  24  12  10
>>
>> which ought to look something like (+local distance to end result)
>>
>>       2      10      2
>>   1 <---> 0 <---> 2 <---> 3
>>
>> We end up with the following NUMA levels (i.e. deduplicated distances)
>>   NUMA (<= 12)
>>   NUMA (<= 20)
>>   NUMA (<= 22)
>>   NUMA (<= 24)
>>
>> For e.g. any CPU of node1, NUMA(<=20) is gonna have the same span as
>> NUMA(<=12), so we'll degenerate it.
>
> Man, that's horrible :-)

It is :(

> OK, fair enough, keep it as is, we'll see what
> if anything breaks.
