Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18274C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE64420737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585234967;
	bh=aFhpJni6/CsdULCawfOYAw4NLfGaTvWSDBG0TOaDnoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KAXl2sEhcu26/rvKAuhg/XRTOainCve3+HMMqFNR12HfUtZRuXnIv+3TCcvrYHdGC
	 7ScMVFLz6g0udX8fcW8DscNO1o3WXtlja+BjQLUr2r2xaQw0OAWbMLAjBmCLtgfyNo
	 GygoSyaMi6lrQrLlDY5f0SqusLwbf/201l94Io/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgCZPCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgCZPCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:02:46 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1F6620737;
        Thu, 26 Mar 2020 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585234965;
        bh=aFhpJni6/CsdULCawfOYAw4NLfGaTvWSDBG0TOaDnoM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OHYRQTyLSsYSPoUl6SZEiyMAUR6rTUhuXiGvPh/3UoTTvgCtJnfcGU+x1sMZPRZP9
         0v64ZGV9OGSx58uesR2IQH5ak0NVdTL4XRaf30mRrnGdv/JCXyajGMKha5zai5OlWO
         bf+2QL9mggVeVI5hp8O0lR2susQJZAYVFNLieWRs=
Received: by mail-qv1-f47.google.com with SMTP id m2so3047343qvu.13;
        Thu, 26 Mar 2020 08:02:44 -0700 (PDT)
X-Gm-Message-State: ANhLgQ20TV5JWDmEdlp9YA/0/lqQ+B/WrlY4+uaMt6QONw/ZcVIvzf0d
        3tQ7NmpO+Dk6bCyjXZEmwBHM5fEAjCn+7BCr2w==
X-Google-Smtp-Source: ADFU+vuqAZmLCbZGmwxWI/Q5si27yCPAGJMMn6YIKMYX8mHxHUsqX+kMnnH+O6NAtvkOEOYCpxZSs9Uojued4Yax7VI=
X-Received: by 2002:ad4:4829:: with SMTP id h9mr8086052qvy.135.1585234963992;
 Thu, 26 Mar 2020 08:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
 <20200324175955.GA16972@arm.com> <CAGETcx8Qhy3y66vJyi8kRvg1+hXf-goDvyty-bsG5qFrA-CKgg@mail.gmail.com>
 <CAGETcx80wvGnS0-MwJ9M9RR9Mny0jmmep+JfwaUJUOR2bfJYsQ@mail.gmail.com>
 <87lfnoxg2a.fsf@nanos.tec.linutronix.de> <CAGETcx_3GSKmSveiGrM2vQp=q57iZYc0T4ELMY7Zw8UwzPEnYA@mail.gmail.com>
 <87imirxv57.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87imirxv57.fsf@nanos.tec.linutronix.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 26 Mar 2020 09:02:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLas2mi-kTrEY=9vnopU57qwJNDtvui0erMghfG4-pOZw@mail.gmail.com>
Message-ID: <CAL_JsqLas2mi-kTrEY=9vnopU57qwJNDtvui0erMghfG4-pOZw@mail.gmail.com>
Subject: Re: [tip: timers/core] clocksource/drivers/timer-probe: Avoid
 creating dead devices
To:     Thomas Gleixner <tglx@linutronix.de>,
        Saravana Kannan <saravanak@google.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 4:34 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Saravana Kannan <saravanak@google.com> writes:
> > On Wed, Mar 25, 2020 at 2:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >> Saravana Kannan <saravanak@google.com> writes:
> >> > On Tue, Mar 24, 2020 at 11:34 AM Saravana Kannan <saravanak@google.com> wrote:
> >> > I took a closer look. So two different drivers [1] [2] are saying they
> >> > know how to handle "arm,vexpress-sysreg" and are expecting to run at
> >> > the same time. That seems a bit unusual to me. I wonder if this is a
> >> > violation of the device-driver model because this expectation would
> >> > never be allowed if these device drivers were actual drivers
> >> > registered with driver-core. But that's a discussion for another time.
> >> >
> >> > To fix this issue you are facing, this patch should work:
> >> > https://lore.kernel.org/lkml/20200324195302.203115-1-saravanak@google.com/T/#u
> >>
> >> Sorry, that's not a fix. That's a crude hack.
> >
> > If device nodes are being handled by drivers without binding a driver
> > to struct devices, then not setting OF_POPULATED is wrong. So the
> > original patch sets it. There are also very valid reasons for allowing
> > OF_POPULATED to be cleared by a driver as discussed here [1].
> >
> > The approach of the original patch (setting the flag and letting the
> > driver sometimes clear it) is also followed by many other frameworks
> > like irq, clk, i2c, etc. Even ingenic-timer.c already does it for the
> > exact same reason.
> >
> > So, why is the vexpress fix a crude hack?
>
> If it's the right thing to do and accepted by the DT folks, then the
> changelog should provide a proper explanation for it. The one you
> provided just baffles me. Plus the clearing of the flag really needs a
> big fat comment.

IMO, commit 4f41fe386a946 should be reverted and be done with it.
There's no way the timer core can know whether a specific node should
be scanned or not. If you really want to avoid a struct device, then
set OF_POPULATED in specific timer drivers. But I'd rather not see
more places mucking with OF_POPULATED. It's really only bus code that
should be touching it.

Is having a struct device really a problem? If we want to save memory
usage, I have some ideas that would save much more than 1 or 2 struct
devices.

> It still does not make any sense to me.
>
> arm,vexpress-sysreg is a MFD device, so can the ARM people please
> explain, why the sched clock part is not just another MFD sub-device or
> simply has it's own DT match?

The issue is DT nodes and Linux drivers aren't necessarily 1-1. That
would be nice, but hardware is messy and DT doesn't abstract that
away. If we tried to always make things 1-1, then if/when the Linux
driver structure changes we'd have to change the DT. If we decided to
add a node now, we'd still have to support the old DT for backwards
compatibility. We also have to consider the structure for another OS
may be different.

Generally, if I see a node with a compatible only it gets NAKed as
that's a sure sign of someone just trying to bind a driver and not
describing the h/w. We only do MFD sub-devices if those devices
provide or consume other DT resources.

Rob
