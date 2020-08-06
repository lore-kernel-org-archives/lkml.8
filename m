Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233A2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB9A23120
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgHFQoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:44:44 -0400
Received: from foss.arm.com ([217.140.110.172]:45204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgHFQmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:42:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5598511D4;
        Thu,  6 Aug 2020 09:18:51 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54BBF3F887;
        Thu,  6 Aug 2020 09:18:50 -0700 (PDT)
References: <20200731115502.12954-1-valentin.schneider@arm.com> <20200731115502.12954-6-valentin.schneider@arm.com> <20200806140750.GC2077896@gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v4 05/10] sched/topology: Define and assign sched_domain flag metadata
Message-ID: <jhj8serixd4.mognet@arm.com>
In-reply-to: <20200806140750.GC2077896@gmail.com>
Date:   Thu, 06 Aug 2020 17:18:45 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/08/20 15:07, Ingo Molnar wrote:
> * Valentin Schneider <valentin.schneider@arm.com> wrote:
>
>> +#ifndef SD_FLAG
>> +#define SD_FLAG(x, y, z)
>> +#endif
>
> AFAICS there's not a single use of sd_flags.h that doesn't come with
> its own SD_FLAG definition, so I suppose this should be:
>
> #ifndef SD_FLAG
> # error "Should not happen."
> #endif
>
> ?
>

I can give this a try; for the context, I copied uapi/asm-generic/unistd.h
without thinking too much, and that does:

  #ifndef __SYSCALL
  #define __SYSCALL(x, y)
  #endif

> Also, some nits:
>
>> +/*
>> + * Expected flag uses
>> + *
>> + * SHARED_CHILD: These flags are meant to be set from the base domain upwards.
>> + * If a domain has this flag set, all of its children should have it set. This
>> + * is usually because the flag describes some shared resource (all CPUs in that
>> + * domain share the same foobar), or because they are tied to a scheduling
>> + * behaviour that we want to disable at some point in the hierarchy for
>> + * scalability reasons.
>
> s/foobar/resource
>
> ?
>

That's better indeed, I think that's a remnant of when I was listing a lot
of things that could be shared.

>> +/*
>> + * cross-node balancing
>> + *
>> + * SHARED_PARENT: Set for all NUMA levels above NODE.
>> + */
>> +SD_FLAG(SD_NUMA,                12, SDF_SHARED_PARENT)
>
> s/cross-node/Cross-node
>
> BTW., is there any particular reason why these need to be defines with
> a manual enumeration of flag values - couldn't we generate
> auto-enumerated C enums instead or so?
>

I remember exploring a few different options there, but it's been a while
already. I think one of the reasons I kept some form of explicit assignment
is to avoid making reading

  /proc/sys/kernel/sched_domain/cpu*/domain*/flags

more convoluted than it is now (i.e. you have to go fetch the
bit -> name translation in the source code).

In the grand scheme of things I'd actually like to have this file output
the names of the flags rather than their values (since I now save them when
SCHED_DEBUG=y), but I didn't find a simple way to hack the existing SD ctl
table (sd_alloc_ctl_domain_table() and co) into doing this.


Now as to making this fully automagic, I *think* I could do something like
having a first enum to set up an ordering:

  #define SD_FLAG(name, ...) __##name,
  enum {
    #include <linux/sched/sd_flags.h>
  };

A second one to have powers of 2:

  #define SD_FLAG(name, ...) name = 1 << __##name,
  enum {
    #include <linux/sched/sd_flags.h>
  };

And finally the metadata array assignment might be doable with:

  #define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },

Or, if there is a way somehow to directly get powers of 2 out of an enum:

  #define SD_FLAG(_name, mflags) [_ffs(_name)] = { .meta_flags = mflags, .name = #_name },

>> +#ifdef CONFIG_SCHED_DEBUG
>> +#define SD_FLAG(_name, idx, mflags) [idx] = {.meta_flags = mflags, .name = #_name},
>
> s/{./{ .
> s/e}/e }
>
> Thanks,
>
>       Ingo
