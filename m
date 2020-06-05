Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FA3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 04:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD4D207D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 04:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgFEE4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 00:56:52 -0400
Received: from foss.arm.com ([217.140.110.172]:50564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgFEE4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 00:56:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00B832B;
        Thu,  4 Jun 2020 21:56:51 -0700 (PDT)
Received: from bogus (unknown [10.37.12.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65DA43F6CF;
        Thu,  4 Jun 2020 21:56:48 -0700 (PDT)
Date:   Fri, 5 Jun 2020 05:56:45 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200605045645.GD12397@bogus>
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200528192005.GA494874@bogus>
 <20200529040758.kneg2j4n3gxh2rfv@vireshk-i7>
 <20200603180435.GB23722@bogus>
 <CABb+yY0cW1GZHVmwEr19JRdJTmsAxw9uq83QV_aq-tdPJO5_Fg@mail.gmail.com>
 <20200604092052.GD8814@bogus>
 <CABb+yY27Ngb0C-onkU2qyt=uKgG4iVrcv8hGkC+anypQbTRA1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY27Ngb0C-onkU2qyt=uKgG4iVrcv8hGkC+anypQbTRA1w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 10:15:55AM -0500, Jassi Brar wrote:
> On Thu, Jun 4, 2020 at 4:20 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Jun 03, 2020 at 01:32:42PM -0500, Jassi Brar wrote:
> > > On Wed, Jun 3, 2020 at 1:04 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Fri, May 29, 2020 at 09:37:58AM +0530, Viresh Kumar wrote:
> > > > > On 28-05-20, 13:20, Rob Herring wrote:
> > > > > > Whether Linux
> > > > > > requires serializing mailbox accesses is a separate issue. On that side,
> > > > > > it seems silly to not allow driving the h/w in the most efficient way
> > > > > > possible.
> > > > >
> > > > > That's exactly what we are trying to say. The hardware allows us to
> > > > > write all 32 bits in parallel, without any hardware issues, why
> > > > > shouldn't we do that ? The delay (which Sudeep will find out, he is
> > > > > facing issues with hardware access because of lockdown right now)
> > > >
> > > > OK, I was able to access the setup today. I couldn't reach a point
> > > > where I can do measurements as the system just became unusable with
> > > > one physical channel instead of 2 virtual channels as in my patches.
> > > >
> > > > My test was simple. Switch to schedutil and read sensors periodically
> > > > via sysfs.
> > > >
> > > >  arm-scmi firmware:scmi: message for 1 is not expected!
> > > >
> > > This sounds like you are not serialising requests on a shared channel.
> > > Can you please also share the patch?
> >
> > OK, I did try with a small patch initially and then realised we must hit
> > issue with mainline as is. Tried and the behaviour is exact same. All
> > I did is removed my patches and use bit[0] as the signal. It doesn't
> > matter as writes to the register are now serialised. Oh, the above
> > message comes when OS times out in advance while firmware continues to
> > process the old request and respond.
> >
> > The trace I sent gives much better view of what's going on.
> >
> BTW, you didn't even share 'good' vs 'bad' log for me to actually see
> if the api lacks.
>
> Let us look closely ...
>
>  >>    bash-1019  [005]  1149.452340: scmi_xfer_begin:
> transfer_id=1537 msg_id=7 protocol_id=19 seq=0 poll=1
>  >>    bash-1019  [005]  1149.452407: scmi_xfer_end:
> transfer_id=1537 msg_id=7 protocol_id=19 seq=0 status=0
> >
> This round trip took  67usecs.  (log shows some at even 3usecs)
> That includes mailbox api overhead, memcpy and the time taken by
> remote to respond.

This is DVFS request which firmware acknowledges quickly and expected
to at most 100us.

> So the api is definitely capable of much faster transfers than you require.
>

I am not complaining about that. The delay is mostly due to the load on
the mailbox and parallelising helps is the focus here.

> >>     bash-1526  [000]  1149.472553: scmi_xfer_begin:      transfer_id=1538 msg_id=6 protocol_id=21 seq=0 poll=0
> >>      <idle>-0     [001]  1149.472733: scmi_xfer_begin:      transfer_id=1539 msg_id=7 protocol_id=19 seq=1 poll=1
> >
> Here another request is started before the first is finished.

Ah, the prints are when the client requested. It is not when the mailbox
started it. So this just indicates the beginning of the transfer from the
client. I must have mentioned that earlier. Some request timeout before
being picked up by mailbox if the previous request is not acknowledge
quickly. E.g. Say a sensor command started which may take upto 1ms,
almost 5-6 DVFS request after that will timeout.

> If you want this to work you have to serialise access to the single
> physical channel and/or run the remote firmware in asynchronous mode -
> that is, the firmware ack the bit as soon as it sees and starts
> working in the background, so that we return in ~3usec always, while
> the data returns whenever it is ready.

Yes it does that for few requests like DVFS while it uses synchronous
mode for few others. While ideally I agree everything in asynchronous
most is better, I don't know there may be reasons for such design. Also
the solution given is to use different bits as independent channels
which hardware allows. Anyways it's open source SCP project[1].

--
Regards,
Sudeep

[1] https://github.com/ARM-software/SCP-firmware
