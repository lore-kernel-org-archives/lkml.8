Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB806C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8725F20781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHCPrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:47:11 -0400
Received: from foss.arm.com ([217.140.110.172]:59264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgHCPrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:47:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CA3230E;
        Mon,  3 Aug 2020 08:47:10 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 948F03F718;
        Mon,  3 Aug 2020 08:47:08 -0700 (PDT)
References: <20200729033934.22349-1-alison.wang@nxp.com> <877dumbtoi.fsf@kurt> <20200729094943.lsmhsqlnl7rlnl6f@skbuf> <87mu3ho48v.fsf@kurt> <20200730082228.r24zgdeiofvwxijm@skbuf> <873654m9zi.fsf@kurt> <87lfiwm2bj.fsf@nanos.tec.linutronix.de> <20200803114112.mrcuupz4ir5uqlp6@skbuf> <87d047n4oh.fsf@nanos.tec.linutronix.de>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-reply-to: <87d047n4oh.fsf@nanos.tec.linutronix.de>
Date:   Mon, 03 Aug 2020 16:47:03 +0100
Message-ID: <jhjh7tjivew.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/08/20 16:13, Thomas Gleixner wrote:
> Vladimir Oltean <olteanv@gmail.com> writes:
>>>  1) When irq accounting is disabled, RT throttling kicks in as
>>>     expected.
>>> 
>>>  2) With irq accounting the RT throttler does not kick in and the RCU
>>>     stall/lockups happen.
>> What is this telling us?
>
> It seems that the fine grained irq time accounting affects the runtime
> accounting in some way which I haven't figured out yet.
>

With IRQ_TIME_ACCOUNTING, rq_clock_task() will always be incremented by a
lesser-or-equal value than when not having the option; you start with the
same delta_exec but slice some for the IRQ accounting, and leave the rest
for the rq_clock_task() (+paravirt).

IIUC this means that if you spend e.g. 10% of the time in IRQ and 90% of
the time running the stress-ng RT tasks, despite having RT tasks hogging
the entirety of the "available time" it is still only 90% runtime, which is
below the 95% default and the throttling doesn't happen.

I don't know if considering IRQ time in some way or another in
sched_rt_runtime_exceeded() really is a way out here.

> Thanks,
>
>         tglx

