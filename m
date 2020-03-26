Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A22FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77352073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQHUd4g2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgCZSJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:09:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38632 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZSJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:09:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id t28so6882339ott.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U23zV80H/fWBc+iRgD1UjAaCfCC2dZVzJMDMBndseY4=;
        b=YQHUd4g2qLXtQjXBE4UkMWhIR8nDbvEUaciILNOK1DDGTPkVwxPnjuXXEl+PQHbM/1
         y6LDzWG05v6UkDFD+hMNUXbok89dYzFWteDm2vjHupA5u+YtneTqEU/fVPzR8E2nTUZ8
         66uNDVPrLuINvhQ8gOBxGfgdzbAs3VvT6YKpRtj30g+Zjzz8nXk+owbQRhHorhxFTmVZ
         JIwHb/KAKnILqy/tO+qHlvAZde4hejp45M8JGZWeHHHHfQO45fI7cyUT1Q5iH6ZbiFhu
         pJ49aMWlxdim62oSWBo3EI1E9poJSoNy/2Z0hdT7sSaBj/1L3nU1I2G8IPtyJeA6+sqi
         K6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U23zV80H/fWBc+iRgD1UjAaCfCC2dZVzJMDMBndseY4=;
        b=l0Wmo7FsV8lZ3FNLDtY5okLP/do4i4vU/IGkAaYooAkwObh3+7moDnEX0lHdXFUJqa
         4Mr5O2E4N3gMibCQcCaQyo8tsB6SBu1kmqjQrVh7sgdtwA/TPWFfHj6RGmMQZ2WLInld
         n1RrGNp9QzUiRt/iW9pEHm5n+jZnZ4whu9elJNcXmnDh5FKgIdHPW+iDVQYsPPAigRKQ
         xFbVMvQq2pm29Js9Utr+x96TP8SvfECHYoJFzOWJ5n7tJV4ULKIDtX/4JBA7qmTfh78t
         oLQEHFmTxdQ7qX/y3/XI0FGxhNXkjmJo0nkMnZN6R6hq716nTCTVqIgbhJkohaMADuYY
         Pwgg==
X-Gm-Message-State: ANhLgQ3IviGygA7rP2OR6leeBRJIjQhYdpeRznlYvZ54krjWTLLNE5KE
        MFxDfbo0XBnvEk1fQWv9gDffZPVSA9DiOpsZrHavog==
X-Google-Smtp-Source: ADFU+vvpl+5OQEhCNCLDYCWe7itQaBuqxVZA0v7+jdNtoVBCkI1H0Pb9vRkZPwD2wnPPVM/+flWYswsezj+oPgatsOA=
X-Received: by 2002:a4a:4190:: with SMTP id x138mr6179666ooa.35.1585246139794;
 Thu, 26 Mar 2020 11:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
 <20200324175955.GA16972@arm.com> <CAGETcx8Qhy3y66vJyi8kRvg1+hXf-goDvyty-bsG5qFrA-CKgg@mail.gmail.com>
 <CAGETcx80wvGnS0-MwJ9M9RR9Mny0jmmep+JfwaUJUOR2bfJYsQ@mail.gmail.com>
 <87lfnoxg2a.fsf@nanos.tec.linutronix.de> <CAGETcx_3GSKmSveiGrM2vQp=q57iZYc0T4ELMY7Zw8UwzPEnYA@mail.gmail.com>
 <87imirxv57.fsf@nanos.tec.linutronix.de> <CAL_JsqLas2mi-kTrEY=9vnopU57qwJNDtvui0erMghfG4-pOZw@mail.gmail.com>
In-Reply-To: <CAL_JsqLas2mi-kTrEY=9vnopU57qwJNDtvui0erMghfG4-pOZw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 26 Mar 2020 11:08:23 -0700
Message-ID: <CAGETcx_MC7weVSYF9CpWt_5Otf3G1Hd75Z8_0LcN0SS42UDyJw@mail.gmail.com>
Subject: Re: [tip: timers/core] clocksource/drivers/timer-probe: Avoid
 creating dead devices
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
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

On Thu, Mar 26, 2020 at 8:02 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Mar 26, 2020 at 4:34 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Saravana Kannan <saravanak@google.com> writes:
> > > On Wed, Mar 25, 2020 at 2:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > >> Saravana Kannan <saravanak@google.com> writes:
> > >> > On Tue, Mar 24, 2020 at 11:34 AM Saravana Kannan <saravanak@google.com> wrote:
> > >> > I took a closer look. So two different drivers [1] [2] are saying they
> > >> > know how to handle "arm,vexpress-sysreg" and are expecting to run at
> > >> > the same time. That seems a bit unusual to me. I wonder if this is a
> > >> > violation of the device-driver model because this expectation would
> > >> > never be allowed if these device drivers were actual drivers
> > >> > registered with driver-core. But that's a discussion for another time.
> > >> >
> > >> > To fix this issue you are facing, this patch should work:
> > >> > https://lore.kernel.org/lkml/20200324195302.203115-1-saravanak@google.com/T/#u
> > >>
> > >> Sorry, that's not a fix. That's a crude hack.
> > >
> > > If device nodes are being handled by drivers without binding a driver
> > > to struct devices, then not setting OF_POPULATED is wrong. So the
> > > original patch sets it. There are also very valid reasons for allowing
> > > OF_POPULATED to be cleared by a driver as discussed here [1].
> > >
> > > The approach of the original patch (setting the flag and letting the
> > > driver sometimes clear it) is also followed by many other frameworks
> > > like irq, clk, i2c, etc. Even ingenic-timer.c already does it for the
> > > exact same reason.
> > >
> > > So, why is the vexpress fix a crude hack?
> >
> > If it's the right thing to do and accepted by the DT folks, then the
> > changelog should provide a proper explanation for it. The one you
> > provided just baffles me. Plus the clearing of the flag really needs a
> > big fat comment.
>
> IMO, commit 4f41fe386a946 should be reverted and be done with it.
> There's no way the timer core can know whether a specific node should
> be scanned or not. If you really want to avoid a struct device, then
> set OF_POPULATED in specific timer drivers. But I'd rather not see
> more places mucking with OF_POPULATED. It's really only bus code that
> should be touching it.

Since most drivers don't need the struct device, my patch sets the
flag in the timer core. And for the few exception cases where the
device is needed, we can clear the flag in the driver. That'll reduce
the number of places mucking with OF_POPULATED.

Does this seem okay to you?

> Is having a struct device really a problem? If we want to save memory
> usage, I have some ideas that would save much more than 1 or 2 struct
> devices.

Keep in mind that struct devices cost more than one struct device of
memory. They also create a bunch of sysfs nodes, uevents, etc.

> > It still does not make any sense to me.
> >
> > arm,vexpress-sysreg is a MFD device, so can the ARM people please
> > explain, why the sched clock part is not just another MFD sub-device or
> > simply has it's own DT match?
>
> The issue is DT nodes and Linux drivers aren't necessarily 1-1. That
> would be nice, but hardware is messy and DT doesn't abstract that
> away. If we tried to always make things 1-1, then if/when the Linux
> driver structure changes we'd have to change the DT.

I agree with this. I'm definitely not asking to create a node just
because we want another struct device.

> If we decided to
> add a node now, we'd still have to support the old DT for backwards
> compatibility.

Right, I agree it's too late to fix this DT for vexpress-sysreg now.

> We also have to consider the structure for another OS
> may be different.
>
> Generally, if I see a node with a compatible only it gets NAKed as
> that's a sure sign of someone just trying to bind a driver and not
> describing the h/w. We only do MFD sub-devices if those devices
> provide or consume other DT resources.

If we have a timer MFD, it'd technically consume a fixed-clock and not
be empty. vexpress-sysreg just assumes the clock is 24 MHz right now.

My point about the vexpress DT nodes being weird is not about Linux
devices, rather it's that:
1. It's already a MFD
2. Most of the functions are separated clearly into their functional
device nodes
3. However, the timer functionality is combined with the parent MFD
device when the parent MFD device implements a completely separate
function (gpio?). Why?

If one wants to split out the functions, do it fully. If one wants it
all under one mega driver (ugh!) then combine it all. Going halfway
causes these weird issues. That's my complaint about how the DT layout
is for this device.

Having said all that, I'd rather manipulate the OF_POPULATED flag than
break DT backward compatibility at this point.

But in general, I think we should try to reject two separate drivers
claiming to be compatible with the same device and expecting to work
at the same time. That's just weird.

-Saravana
