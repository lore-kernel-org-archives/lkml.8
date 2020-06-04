Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016B3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6CF20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgFDJ0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:26:39 -0400
Received: from foss.arm.com ([217.140.110.172]:42376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgFDJ0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:26:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 241E955D;
        Thu,  4 Jun 2020 02:26:38 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 612973F6CF;
        Thu,  4 Jun 2020 02:26:37 -0700 (PDT)
References: <20200603173150.GB1551@shell.armlinux.org.uk> <jhjh7vshvwl.mognet@arm.com> <20200603184500.GC1551@shell.armlinux.org.uk> <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com> <20200603195853.GD1551@shell.armlinux.org.uk> <jhjftbbj3qi.mognet@arm.com> <a34fcb9a-ba4b-0c9e-328f-1244c2720ed2@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: v5.7: new core kernel option missing help text
Message-ID: <jhjeeqvi3m1.mognet@arm.com>
In-reply-to: <a34fcb9a-ba4b-0c9e-328f-1244c2720ed2@linaro.org>
Date:   Thu, 04 Jun 2020 10:26:27 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/06/20 01:48, Thara Gopinath wrote:
> Hi Russel/Valentin
>
> The feature itself like Valentin explained below allows scheduler to be
> aware of cpu capacity reduced due to thermal throttling.
> arch_set_thermal_pressure feeds the capped capacity to the scheduler and
> hence the feature makes sense only if arch_set_thermal_pressure is
> implemented. Having said that arch_set_thermal_pressure is implemented
> in arch_topology driver for arm and arm64 platforms. But the feature
> itself is not bound to arm/arm64 platforms. So it would make it wrong to
> add a "depends on (ARM || ARM64) option."
>
> I agree with Vincent that allowing user to choose this option is
> probably not the best. IMO, this should be enabled by default in arm64
> defconfig considering both GENERIC_ARCH_TOPOLOGY and CPU_FREQ_THERMAL
> are enabled by default.

Right, I had skimmed over that but it probably does make more sense not
to bother users with it.

> So if it is acceptable three things to be done are:
> 1. Add the help text.
> 2. Don't allow SCHED_THERMAL_PRESSURE configurable by user
> 3. Enable it by default in arm64 defconfig

... and arm as well, I suppose?
