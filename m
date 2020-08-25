Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B23EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44D22067C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgHYJDT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:03:19 -0400
Received: from foss.arm.com ([217.140.110.172]:53808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgHYJDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:03:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 315FD30E;
        Tue, 25 Aug 2020 02:03:18 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BC9D3F68F;
        Tue, 25 Aug 2020 02:03:17 -0700 (PDT)
References: <20200824153902.57875-1-andriy.shevchenko@linux.intel.com> <jhjeenwdl7u.mognet@arm.com> <20200825082636.GQ1891694@smile.fi.intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v1] sched/topology: Make compiler happy about unused constant definitions
In-reply-to: <20200825082636.GQ1891694@smile.fi.intel.com>
Date:   Tue, 25 Aug 2020 10:03:12 +0100
Message-ID: <jhjd03fdrn3.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/08/20 09:26, Andy Shevchenko wrote:
> On Mon, Aug 24, 2020 at 06:09:41PM +0100, Valentin Schneider wrote:
>> On 24/08/20 16:39, Andy Shevchenko wrote:
>> > Compilation of almost each file ends up with
>> >
>> >  In file included from .../include/linux/energy_model.h:10,
>> >                 from .../include/linux/device.h:16,
>> >                 from .../drivers/spi/spi.c:8:
>> >  .../include/linux/sched/topology.h:30:27: warning: ‘SD_DEGENERATE_GROUPS_MASK’ defined but not used [-Wunused-const-variable=]
>> >     30 | static const unsigned int SD_DEGENERATE_GROUPS_MASK =
>> >        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
>> >  ...
>> >
>> > Make compiler happy by annotating the static constants with __maybwe_unused.
>> >
>>
>> That should see some use as long as the build is for SMP. This whole region
>> is guarded by #ifdef CONFIG_SMP, so an !SMP build shouldn't trigger this.
>
> Isn't SMP is default for most of the kernel builds?
> And honestly I didn't get the purpose of this comment.
>

Sorry, that's what I get for trying to be too succinct; what I tried to say
was that SD_DEGENERATE_GROUPS_MASK should very much be used for SMP. If the
build is !SMP, it shouldn't even be defined, IOW I'm perplexed as to where
this is coming from.

>> With what config/kernel are you getting this?
>
> x86_64_defconfig from the kernel sources with some drivers added (SMP or so has
> not been touched, DEBUG_SHED was enabled once to confirm that another static
> const has same issue).

Thanks, I'll poke around this.
