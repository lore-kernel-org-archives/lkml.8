Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53523C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203AE20737
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCYVrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:47:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49070 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgCYVrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:47:31 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jHDrx-0000zc-Pk; Wed, 25 Mar 2020 22:47:25 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3E80F100C51; Wed, 25 Mar 2020 22:47:25 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Saravana Kannan <saravanak@google.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [tip: timers/core] clocksource/drivers/timer-probe: Avoid creating dead devices
In-Reply-To: <CAGETcx80wvGnS0-MwJ9M9RR9Mny0jmmep+JfwaUJUOR2bfJYsQ@mail.gmail.com>
References: <20200111052125.238212-1-saravanak@google.com> <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2> <20200324175955.GA16972@arm.com> <CAGETcx8Qhy3y66vJyi8kRvg1+hXf-goDvyty-bsG5qFrA-CKgg@mail.gmail.com> <CAGETcx80wvGnS0-MwJ9M9RR9Mny0jmmep+JfwaUJUOR2bfJYsQ@mail.gmail.com>
Date:   Wed, 25 Mar 2020 22:47:25 +0100
Message-ID: <87lfnoxg2a.fsf@nanos.tec.linutronix.de>
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
> On Tue, Mar 24, 2020 at 11:34 AM Saravana Kannan <saravanak@google.com> wrote:
> I took a closer look. So two different drivers [1] [2] are saying they
> know how to handle "arm,vexpress-sysreg" and are expecting to run at
> the same time. That seems a bit unusual to me. I wonder if this is a
> violation of the device-driver model because this expectation would
> never be allowed if these device drivers were actual drivers
> registered with driver-core. But that's a discussion for another time.
>
> To fix this issue you are facing, this patch should work:
> https://lore.kernel.org/lkml/20200324195302.203115-1-saravanak@google.com/T/#u

Sorry, that's not a fix. That's a crude hack.

As this is also causing trouble on tegra30-cardhu-a04 the only sane
solution is to revert it and start over with a proper solution for the
vexpress problem and a root cause analysis for the tegra.

Thanks,

        tglx
