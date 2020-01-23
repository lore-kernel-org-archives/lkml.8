Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6811C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E68C24125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAWKal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:30:41 -0500
Received: from foss.arm.com ([217.140.110.172]:37506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgAWKal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:30:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C1431B;
        Thu, 23 Jan 2020 02:30:40 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64F903F6C4;
        Thu, 23 Jan 2020 02:30:39 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:30:33 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arnd@arndb.de, jassisinghbrar@gmail.com, cristian.marussi@arm.com,
        peng.fan@nxp.com, peter.hilber@opensynergy.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4] firmware: arm_scmi: Make scmi core independent of the
 transport type
Message-ID: <20200123103033.GA7511@bogus>
References: <20200121183818.GA11522@bogus>
 <a9ec58818b5e0c982810e74efe3f5f22b930ae40.1579660436.git.viresh.kumar@linaro.org>
 <20200122121538.GA31240@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122121538.GA31240@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 12:15:38PM +0000, Sudeep Holla wrote:
> On Wed, Jan 22, 2020 at 08:06:23AM +0530, Viresh Kumar wrote:
>

[...]

> > Can you please help me getting this tested, now that I have rebased it
> > as well :) ?
> >
>
> Sure, I will give it a go on my Juno. Thanks for the rebase, makes it
> simpler.
>

Sorry for the delay. I gave this a spin on my Juno. I am seeing below
warning once on boot but it continues and everything seem to work fine.
Also the warning is not related to this change I believe and this patch
is just helping to hit some corner case with deferred probe and devres.
I need to spend some time to debug it.

Regards,
Sudeep

--->8

WARNING: CPU: 1 PID: 187 at drivers/base/dd.c:519 really_probe+0x11c/0x418
Modules linked in:
CPU: 1 PID: 187 Comm: kworker/1:2 Not tainted 5.5.0-rc7-00026-gf7231cd3108d-dirty #20
Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan 16 2020
Workqueue: events deferred_probe_work_func
pstate: 80000005 (Nzcv daif -PAN -UAO)
pc : really_probe+0x11c/0x418
lr : really_probe+0x10c/0x418
Call trace:
 really_probe+0x11c/0x418
 driver_probe_device+0xe4/0x138
 __device_attach_driver+0x90/0x110
 bus_for_each_drv+0x80/0xd0
 __device_attach+0xdc/0x160
 device_initial_probe+0x18/0x20
 bus_probe_device+0x98/0xa0
 deferred_probe_work_func+0x90/0xe0
 process_one_work+0x1ec/0x4a8
 worker_thread+0x210/0x490
 kthread+0x110/0x118
 ret_from_fork+0x10/0x18
---[ end trace 06f96d55ce6093a8 ]---

