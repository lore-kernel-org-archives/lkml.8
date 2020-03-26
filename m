Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27460C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A7420787
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgCZKeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:34:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50298 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZKeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:34:02 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jHPpk-0004nJ-V5; Thu, 26 Mar 2020 11:33:57 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1959110069D; Thu, 26 Mar 2020 11:33:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [tip: timers/core] clocksource/drivers/timer-probe: Avoid creating dead devices
In-Reply-To: <CAGETcx_3GSKmSveiGrM2vQp=q57iZYc0T4ELMY7Zw8UwzPEnYA@mail.gmail.com>
References: <20200111052125.238212-1-saravanak@google.com> <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2> <20200324175955.GA16972@arm.com> <CAGETcx8Qhy3y66vJyi8kRvg1+hXf-goDvyty-bsG5qFrA-CKgg@mail.gmail.com> <CAGETcx80wvGnS0-MwJ9M9RR9Mny0jmmep+JfwaUJUOR2bfJYsQ@mail.gmail.com> <87lfnoxg2a.fsf@nanos.tec.linutronix.de> <CAGETcx_3GSKmSveiGrM2vQp=q57iZYc0T4ELMY7Zw8UwzPEnYA@mail.gmail.com>
Date:   Thu, 26 Mar 2020 11:33:56 +0100
Message-ID: <87imirxv57.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saravana Kannan <saravanak@google.com> writes:
> On Wed, Mar 25, 2020 at 2:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> Saravana Kannan <saravanak@google.com> writes:
>> > On Tue, Mar 24, 2020 at 11:34 AM Saravana Kannan <saravanak@google.com> wrote:
>> > I took a closer look. So two different drivers [1] [2] are saying they
>> > know how to handle "arm,vexpress-sysreg" and are expecting to run at
>> > the same time. That seems a bit unusual to me. I wonder if this is a
>> > violation of the device-driver model because this expectation would
>> > never be allowed if these device drivers were actual drivers
>> > registered with driver-core. But that's a discussion for another time.
>> >
>> > To fix this issue you are facing, this patch should work:
>> > https://lore.kernel.org/lkml/20200324195302.203115-1-saravanak@google.com/T/#u
>>
>> Sorry, that's not a fix. That's a crude hack.
>
> If device nodes are being handled by drivers without binding a driver
> to struct devices, then not setting OF_POPULATED is wrong. So the
> original patch sets it. There are also very valid reasons for allowing
> OF_POPULATED to be cleared by a driver as discussed here [1].
>
> The approach of the original patch (setting the flag and letting the
> driver sometimes clear it) is also followed by many other frameworks
> like irq, clk, i2c, etc. Even ingenic-timer.c already does it for the
> exact same reason.
>
> So, why is the vexpress fix a crude hack?

If it's the right thing to do and accepted by the DT folks, then the
changelog should provide a proper explanation for it. The one you
provided just baffles me. Plus the clearing of the flag really needs a
big fat comment.

It still does not make any sense to me.

arm,vexpress-sysreg is a MFD device, so can the ARM people please
explain, why the sched clock part is not just another MFD sub-device or
simply has it's own DT match?

>> As this is also causing trouble on tegra30-cardhu-a04 the only sane
>> solution is to revert it and start over with a proper solution for the
>> vexpress problem and a root cause analysis for the tegra.
>
> If someone can tell me which of the timer drivers are relevant for
> tegra30-cardhu-a04, I can help fix it.

git grep perhaps? And that's pretty much the same problem:

drivers/clocksource/timer-tegra.c:TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
drivers/rtc/rtc-tegra.c:        { .compatible = "nvidia,tegra20-rtc", },

Without looking deeper I suspect that these two are not the only ones.

Can the DT folks pretty please comment on this and provide some guidance
how to fix that w/o sprinkling 

    of_node_clear_flag(node, OF_POPULATED);

all over the place?

Thanks,

        tglx
