Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31213C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AC1206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eUWfIcTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgHFRh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:37:56 -0400
Received: from mail.efficios.com ([167.114.26.124]:44178 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbgHFRhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:37:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3FDA329B3CB;
        Thu,  6 Aug 2020 13:37:06 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id H0HhRYvWXMqS; Thu,  6 Aug 2020 13:37:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B325F29B5B3;
        Thu,  6 Aug 2020 13:37:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B325F29B5B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1596735425;
        bh=OrosOIBuaBgs7qXL5uOz7bAbp98TAnrOMrITAMPW1Rk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=eUWfIcTPd+W2tkiWaomJrp/lm1s26VFGZYzc8N6C0gBcJso2X1b7D55AtOjMYAOfc
         CCWCmmQMYQDFYX08/W/jRirCdr3UxcRRR1wc2kjY/PFAJnjp1FZD14Qjv0o4mgFtfq
         kjNyaWu/xdZLW8Le17XnYDI8siemWZ1CPItnbbkYfzDWlwCFRIAd91+oG6DpdMHUfa
         cAOw2Ft/ugPTyfzVJWWLjekkX6oCZ6FFeM8Z6Y6z3+kSGUHwj5MawO7KF4RmTceBHK
         2A1pzq35vSRMTGS03UWAVOKn4k0nBmk+h/V6ZZvaZaILA4fXJgk77DhD72ed8VrjyC
         ZTAEnS3oHdfvg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nI9X0H-SkiRq; Thu,  6 Aug 2020 13:37:05 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A408529B636;
        Thu,  6 Aug 2020 13:37:05 -0400 (EDT)
Date:   Thu, 6 Aug 2020 13:37:05 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Message-ID: <1668913120.1621.1596735425601.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFTs51Ufyds5mypiysL=2ZwtyMk9hjLm-9tJbYz=xciY1f2=5g@mail.gmail.com>
References: <20200806000859.160882-1-posk@google.com> <20200806134828.GA165568@hirez.programming.kicks-ass.net> <CAFTs51Ufyds5mypiysL=2ZwtyMk9hjLm-9tJbYz=xciY1f2=5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] membarrier: add
 MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: membarrier: add MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
Thread-Index: S/ODafaL6Qc5NbUukMlKTrc5xZy9ZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 6, 2020, at 1:07 PM, Peter Oskolkov posk@posk.io wrote:

> On Thu, Aug 6, 2020 at 6:48 AM <peterz@infradead.org> wrote:
>>
>> On Wed, Aug 05, 2020 at 05:08:58PM -0700, Peter Oskolkov wrote:
>>
>> Thanks for the Cc!
> 
> Always a pleasure!
> 
> (Sorry, included only membarrier maintainers in v1; in v2 included
> both membarrier and rseq maintainers).
> 
>>
>> > + * @MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU:
>> > + *                          If a thread belonging to the current process
>> > + *                          is currently in an RSEQ critical section on the
>> > + *                          CPU identified by flags parameter, restart it.
>> > + *                          @flags: if @flags >= 0, identifies the CPU to
>> > + *                                  restart RSEQ CS on; if == -1, restarts
>> > + *                                  RSEQ CSs on all CPUs.
>>
>> > +     } else if (cpu_id == -1) {
>> > +             on_each_cpu(membarrier_rseq_ipi,
>> > +                         current->group_leader, true);
>>
>> This is an unpriv IPI the world. That's a big no-no.
> 
> removed in v2.

I don't think the feature must be removed, but its implementation needs adjustment.

How about we simply piggy-back on the membarrier schemes we already have, and
implement:

membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ)
membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ)

All the logic is there to prevent sending IPIs to runqueues which are not running
threads associated with the same mm. Considering that preemption does an rseq abort,
running a thread belonging to a different mm should mean that this CPU is not
currently executing an rseq critical section, or if it was, it has already been
aborted, so it is quiescent.

Then you'll probably want to change membarrier_private_expedited so it takes an
extra "cpu" argument. If cpu=-1, iterate on all runqueues like we currently do.
If cpu >= 0, only IPI that CPU if the thread currently running has the same mm.

Also, should this belong to the membarrier or the rseq system call ? It just
looks like the membarrier happens to implement very similar things for barriers,
but arguably this is really about rseq. I wonder if we should expose this through
rseq instead, even if we end up using membarrier code.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
