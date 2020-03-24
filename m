Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603D1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C3820719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgCXR76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:59:58 -0400
Received: from foss.arm.com ([217.140.110.172]:39104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbgCXR76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:59:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 328D031B;
        Tue, 24 Mar 2020 10:59:57 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C79FA3F71F;
        Tue, 24 Mar 2020 10:59:56 -0700 (PDT)
Date:   Tue, 24 Mar 2020 17:59:55 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [tip: timers/core] clocksource/drivers/timer-probe: Avoid
 creating dead devices
Message-ID: <20200324175955.GA16972@arm.com>
References: <20200111052125.238212-1-saravanak@google.com>
 <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On Thursday 19 Mar 2020 at 08:47:46 (-0000), tip-bot2 for Saravana Kannan wrote:
> The following commit has been merged into the timers/core branch of tip:
> 
> Commit-ID:     4f41fe386a94639cd9a1831298d4f85db5662f1e
> Gitweb:        https://git.kernel.org/tip/4f41fe386a94639cd9a1831298d4f85db5662f1e
> Author:        Saravana Kannan <saravanak@google.com>
> AuthorDate:    Fri, 10 Jan 2020 21:21:25 -08:00
> Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
> CommitterDate: Tue, 17 Mar 2020 13:10:07 +01:00
> 
> clocksource/drivers/timer-probe: Avoid creating dead devices
> 
> Timer initialization is done during early boot way before the driver
> core starts processing devices and drivers. Timers initialized during
> this early boot period don't really need or use a struct device.
> 
> However, for timers represented as device tree nodes, the struct devices
> are still created and sit around unused and wasting memory. This change
> avoid this by marking the device tree nodes as "populated" if the
> corresponding timer is successfully initialized.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Link: https://lore.kernel.org/r/20200111052125.238212-1-saravanak@google.com
> ---
>  drivers/clocksource/timer-probe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
> index ee9574d..a10f28d 100644
> --- a/drivers/clocksource/timer-probe.c
> +++ b/drivers/clocksource/timer-probe.c
> @@ -27,8 +27,10 @@ void __init timer_probe(void)
>  
>  		init_func_ret = match->data;
>  
> +		of_node_set_flag(np, OF_POPULATED);
>  		ret = init_func_ret(np);
>  		if (ret) {
> +			of_node_clear_flag(np, OF_POPULATED);
>  			if (ret != -EPROBE_DEFER)
>  				pr_err("Failed to initialize '%pOF': %d\n", np,
>  				       ret);
> 

This patch is creating problems on some vexpress platforms - ones that
are using CLKSRC_VERSATILE (drivers/clocksource/timer-versatile.c).
I noticed issues on TC2 and FVPs (fixed virtual platforms) starting with
next-20200318 and still reproducible with next-20200323.

It seems the issue this patch causes on TC2 and FVP is related to the
vexpress-sysreg node being used early for sched_clock_init
(timer_versatile.c: versatile_sched_clock_init). At this point (at
time_init) the node will be marked as OF_POPULATED, which flags that a
device is already created for it, but it is not, in this case.

Later at sysreg_init (vexpress-sysreg.c) a device will fail to be created
for it, as one already exists. This will result in a failure to create a
bridge and a system controller for a bunch of devices (mostly clocks and
regulators).

I think on the FVP it does not cause many issues as clocks are fixed and
regulator settings are probably nops so it boots fine and throws only
some warnings. On TC2 on the other hand it fails to boot and it hangs at
starting the kernel.

In my opinion the idea of the patch is not bad, but I'm not an expert on
this so the most I can offer for now is the basic understanding of the
issue. I've Cc-ed a few folks to potentially suggest alternatives/fixes.

For now, reverting this patch solves the problems on both platforms.
I tested this on next-20200318 which introduced the problem.

Hope it helps,
Ionela.
