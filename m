Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9A2C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CE12087C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgIHS23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:28:29 -0400
Received: from foss.arm.com ([217.140.110.172]:56900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731396AbgIHQKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:10:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 038A215DB;
        Tue,  8 Sep 2020 06:26:35 -0700 (PDT)
Received: from bogus (unknown [10.57.10.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98FA43F73C;
        Tue,  8 Sep 2020 06:26:32 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:26:26 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200908132602.GA27241@bogus>
References: <CABb+yY27Ngb0C-onkU2qyt=uKgG4iVrcv8hGkC+anypQbTRA1w@mail.gmail.com>
 <20200605045645.GD12397@bogus>
 <CABb+yY2YZ99NjHYNi0=KLGFDsVUeJmqiJD3E25Chwk-THJV4iw@mail.gmail.com>
 <20200605085830.GA32372@bogus>
 <CABb+yY2TR7tuMx6u8yah6mO2GwZ5SWYOO80EQRL-i=ybgn=Wog@mail.gmail.com>
 <20200610093334.yznxl2esv5ht27ns@vireshk-i7>
 <20200611100027.GB18781@bogus>
 <CABb+yY1OwVB+uk+0w+D-4Xy46iYn8tPZYBZ0qjrzQFLA6SaTvw@mail.gmail.com>
 <20200612052853.nds4iycie6ldjnnr@vireshk-i7>
 <CAK8P3a0nVOR7YYSZaKmzm3WsUZLgOqL7yZq+f0Dfnn2=16AkLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0nVOR7YYSZaKmzm3WsUZLgOqL7yZq+f0Dfnn2=16AkLA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 11:14:50AM +0200, Arnd Bergmann wrote:
> Picking up the old thread again after and getting pinged by multiple
> colleagues about it (thanks!) reading through the history.
> 
> On Fri, Jun 12, 2020 at 7:29 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 11-06-20, 19:34, Jassi Brar wrote:
> > > In the first post in this thread, Viresh lamented that mailbox
> > > introduces "a few ms" delay in the scheduler path.
> > > Your own tests show that is certainly not the case -- average is the
> > > same as proposed virtual channels 50-100us, the best case is 3us vs
> > > 53us for virtual channels.
> >
> > Hmmm, I am not sure where is the confusion here Jassi. There are two
> > things which are very very different from each other.
> >
> > - Time taken by the mailbox framework (and remote for acknowledging
> >   it) for completion of a single request, this can be 3us to 100s of
> >   us. This is clear for everyone. THIS IS NOT THE PROBLEM.
> >
> > - Delay introduced by few of such requests on the last one, i.e. 5
> >   normal requests followed by an important one (like DVFS), the last
> >   one needs to wait for the first 5 to finish first. THIS IS THE
> >   PROBLEM.
> 
> Earlier, Jassi also commented "Linux does not provide real-time
> guarantees", which to me is what actually causes the issue here:
> 
> Linux having timeouts when communicating to the firmware means
> that it relies on the hardware and firmware having real-time behavior
> even when not providing real-time guarantees to its processes.
> 
> When comparing the two usage models, it's clear that the minimum
> latency for a message delivery is always at least the time time
> to process an interrupt, plus at least one expensive MMIO read
> and one less expensive posted MMIO write for an Ack. If we
> have a doorbell plus out-of-band message, we need an extra
> DMA barrier and a read from coherent memory, both of which can
> be noticeable. As soon as messages are queued in the current
> model, the maximum latency increases by a potentially unbounded
> number of round-trips, while in the doorbell model that problem
> does not exist, so I agree that we need to handle both modes
> in the kernel deal with all existing hardware as well as firmware
> that requires low-latency communication.
> 
> It also sounds like that debate is already settled because there
> are platforms using both modes, and in the kernel we usually
> end up supporting the platforms that our users have, whether
> we think it's a good idea or not.
>

Thanks for the nice summary of the discussion so far.

> The only questions that I see in need of being answered are:
> 
> 1. Should the binding use just different "#mbox-cells" values or
>    also different "compatible" strings to tell that difference?

I initially proposed latter, but Rob preferred the former which
makes sense for the reasons you have mentioned below.

> 2. Should one driver try to handle both modes or should there
>    be two drivers?
>
> It sounds like Jassi strongly prefers separate drivers, which
> would make separate compatible strings the more practical
> approach.

Indeed.

> While the argument can be made that a single
> piece of hardware should only have one DT description,
> the counter-argument would be that the behavior described
> by the DT here is made up by both the hardware and the
> firmware behind it, and they are in fact different.
>

I am too fine either way.

--
Regards,
Sudeep
