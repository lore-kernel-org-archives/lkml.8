Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2BAC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 00:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B104220866
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 00:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgHHATc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 20:19:32 -0400
Received: from foss.arm.com ([217.140.110.172]:40584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgHHATb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 20:19:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF5C91FB;
        Fri,  7 Aug 2020 17:19:30 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA6363F7D8;
        Fri,  7 Aug 2020 17:19:29 -0700 (PDT)
References: <20200731115502.12954-1-valentin.schneider@arm.com> <20200731115502.12954-6-valentin.schneider@arm.com> <20200806140750.GC2077896@gmail.com> <jhj8serixd4.mognet@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v4 05/10] sched/topology: Define and assign sched_domain flag metadata
In-reply-to: <jhj8serixd4.mognet@arm.com>
Date:   Sat, 08 Aug 2020 01:19:24 +0100
Message-ID: <jhj1rkihtv7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/08/20 17:18, Valentin Schneider wrote:
> In the grand scheme of things I'd actually like to have this file output
> the names of the flags rather than their values (since I now save them when
> SCHED_DEBUG=y), but I didn't find a simple way to hack the existing SD ctl
> table (sd_alloc_ctl_domain_table() and co) into doing this.
>

I "just" had to spend some more time grokking how the whole ctl
proc_handler thing is supposed to work; I now have a mostly working
solution, i.e. on my Juno:

  $ cat /proc/sys/kernel/sched_domain/cpu0/domain*/flags
  SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES
  SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_ASYM_CPUCAPACITY SD_PREFER_SIBLING

I'll clean that up and go for the automagic ordering I previously
described.

>
> Now as to making this fully automagic, I *think* I could do something like
> having a first enum to set up an ordering:
>
>   #define SD_FLAG(name, ...) __##name,
>   enum {
>     #include <linux/sched/sd_flags.h>
>   };
>
> A second one to have powers of 2:
>
>   #define SD_FLAG(name, ...) name = 1 << __##name,
>   enum {
>     #include <linux/sched/sd_flags.h>
>   };
>
> And finally the metadata array assignment might be doable with:
>
>   #define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
>
> Or, if there is a way somehow to directly get powers of 2 out of an enum:
>
>   #define SD_FLAG(_name, mflags) [_ffs(_name)] = { .meta_flags = mflags, .name = #_name },
>
>>> +#ifdef CONFIG_SCHED_DEBUG
>>> +#define SD_FLAG(_name, idx, mflags) [idx] = {.meta_flags = mflags, .name = #_name},
>>
>> s/{./{ .
>> s/e}/e }
>>
>> Thanks,
>>
>>       Ingo
