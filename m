Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CEDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320E1206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgFJP4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:56:41 -0400
Received: from foss.arm.com ([217.140.110.172]:60402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbgFJP4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:56:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A52401FB;
        Wed, 10 Jun 2020 08:56:39 -0700 (PDT)
Received: from bogus (unknown [10.37.12.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 448083F6CF;
        Wed, 10 Jun 2020 08:56:36 -0700 (PDT)
Date:   Wed, 10 Jun 2020 16:56:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] firmware: arm_scmi: fix timeout value for send_message
Message-ID: <20200610155629.GA7357@bogus>
References: <20200607193023.52344-1-jassisinghbrar@gmail.com>
 <20200610082315.GB2689@bogus>
 <CABb+yY1T03YLwiFvBykxsAHQ9Kpu=r1nRTuaP3Emf5dP=Upm0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY1T03YLwiFvBykxsAHQ9Kpu=r1nRTuaP3Emf5dP=Upm0g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:21:19AM -0500, Jassi Brar wrote:
> On Wed, Jun 10, 2020 at 3:23 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Sun, Jun 07, 2020 at 02:30:23PM -0500, jassisinghbrar@gmail.com wrote:
> > > From: Jassi Brar <jaswinder.singh@linaro.org>
> > >
> > > Currently scmi_do_xfer() submits a message to mailbox api and waits
> > > for an apparently very short time. This works if there are not many
> > > messages in the queue already. However, if many clients share a
> > > channel and/or each client submits many messages in a row, the
> >
> > The recommendation in such scenarios is to use multiple channel.
> >
> If SCMI is to be accepted as a standard (which I hope), it has to
> support most kinds of controllers, but currently the implementation is
> too myopic. It is only a matter of time, when someone sees value in
> reusing firmware implementation (scmi) but does not have a MHU like
> controller.
>

It is being used with other transports like smc/hvc and virtio.
But I agree, this experiment made me realise we need to work with
single channel disabling certain features like fast_switch. I will
work on that and push a solution. Thanks for asking for traces
and having stared at it for sometime, I see some issues but that's
orthogonal to this one. Fixing that won't solve the issue we are
discussing though.

But that said, that is not the solution for Juno/MHU. We can parallelise
there with multiple requests and we should do so.

> > > timeout value becomes too short and returns error even if the mailbox
> > > is working fine according to the load. The timeout occurs when the
> > > message is still in the api/queue awaiting its turn to ride the bus.
> > >
> > >  Fix this by increasing the timeout value enough (500ms?) so that it
> > > fails only if there is an actual problem in the transmission (like a
> > > lockup or crash).
> > >
> > > [If we want to capture a situation when the remote didn't
> > > respond within expected latency, then the timeout should not
> > > start here, but from tx_prepare callback ... just before the
> > > message physically gets on the channel]
> > >
> >
> > The bottle neck may not be in the remote. It may be mailbox serialising
> > the requests even when it can parallelise.
> >
> Your logs show (in your test case), using 1 physical channel shows
> better transfer (those that complete) rates than virtual channels.

Indeed that is expected. It is like comparing output with 1 vs 2 CPUs
with some multi-thread load. The remote is now handling 2 requests at
a time and it clearly puts DVFS at priority and this will show up as
little higher latency for other requests like sensors.

> The transfers that fail are purely because of this short timeout.
>
> > >
> > >       if (xfer->hdr.poll_completion) {
> > > -             ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
> > > +             ktime_t stop = ktime_add_ns(ktime_get(), 500 * 1000 * NSEC_PER_USEC);
> > >
> >
> > This is unacceptable delay for schedutil fast_switch. So no for this one.
> >
> Increasing timeout does not increase latency.

Agreed, but worst case you may be stuck here for 500ms which is not
acceptable. That's what I meant, not that the request will take 500ms.
Sorry if I was not clear earlier on that.

> Also scmi_xfer() can not know if it was reached from the fast_switch path.
>
> If a platform has many users over a channel such that it can not
> guarantee low enough latency, then it must not set the
> fast_switch_possible flag, which is optional for this reason.
>

Yes, that's what I am trying to explore and that's what I meant above
when I mentioned I see some issues. I have hacked and checked that doesn't
change much, the timeout happens but under bit heavy load and not in simpler
use-case as I showed in my traces. In short, having multiple channels
helps. And we have been so fixated on Tx in our discussions. More fun
with Rx and serialising as it impacts remote firmware too.

>
> > > @@ -313,7 +313,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
> > >                       ret = -ETIMEDOUT;
> > >       } else {
> > >               /* And we wait for the response. */
> > > -             timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
> > > +             timeout = msecs_to_jiffies(500);
> >
> > In general, this hides issues in the remote.
> >
> If you want to uncover remote issues, start the timeout in
> tx_prepare() because that is when the message is physically sent to
> the remote.
>

In that case we need to set it to 1ms as I mentioned earlier. Current
timeout of 30ms is for MBOX_MAX_LEN=20 which gives more than 1ms for each
and that's what we are targeting. I see no point in just changing the
timeout as you already mentioned above it is not changing the latency
anyway.

> > We are trying to move towards
> > tops 1ms for a request and with MBOX_QUEUE at 20, I see 20ms is more that
> > big enough. We have it set to 30ms now. 500ms is way too large and not
> > required IMO.
> >
> Again, increasing timeout does not slow the system down. It is to
> support more variety of platform setups.
>

Agreed and I have acknowledge. 30ms is chosen based on experiments and
also we are trying to achieve 1ms tops for each message. If some platform
has serious limitation, desc->max_rx_timeout_ms is configurable. We can
identify the platform and add specific timings for that. Same is true
do other parameters like the max_len and max_msg_size. If default is not
suitable, it can be changed.

--
Regards,
Sudeep
