Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21FFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7817D2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgIIJbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:31:21 -0400
Received: from foss.arm.com ([217.140.110.172]:40556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgIIJbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:31:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD0491FB;
        Wed,  9 Sep 2020 02:31:15 -0700 (PDT)
Received: from bogus (unknown [10.57.10.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D07F3F66E;
        Wed,  9 Sep 2020 02:31:14 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:31:07 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200909093107.GA10762@bogus>
References: <20200605045645.GD12397@bogus>
 <CABb+yY2YZ99NjHYNi0=KLGFDsVUeJmqiJD3E25Chwk-THJV4iw@mail.gmail.com>
 <20200605085830.GA32372@bogus>
 <CABb+yY2TR7tuMx6u8yah6mO2GwZ5SWYOO80EQRL-i=ybgn=Wog@mail.gmail.com>
 <20200610093334.yznxl2esv5ht27ns@vireshk-i7>
 <20200611100027.GB18781@bogus>
 <CABb+yY1OwVB+uk+0w+D-4Xy46iYn8tPZYBZ0qjrzQFLA6SaTvw@mail.gmail.com>
 <20200612052853.nds4iycie6ldjnnr@vireshk-i7>
 <CAK8P3a0nVOR7YYSZaKmzm3WsUZLgOqL7yZq+f0Dfnn2=16AkLA@mail.gmail.com>
 <CABb+yY3HDs219C8Wcc+CJRLukV4OvCKhqevU-9jN4bCU6SC3rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY3HDs219C8Wcc+CJRLukV4OvCKhqevU-9jN4bCU6SC3rQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:23:33PM -0500, Jassi Brar wrote:
> On Tue, Sep 8, 2020 at 4:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Picking up the old thread again after and getting pinged by multiple
> > colleagues about it (thanks!) reading through the history.
> >
> > On Fri, Jun 12, 2020 at 7:29 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 11-06-20, 19:34, Jassi Brar wrote:
> > > > In the first post in this thread, Viresh lamented that mailbox
> > > > introduces "a few ms" delay in the scheduler path.
> > > > Your own tests show that is certainly not the case -- average is the
> > > > same as proposed virtual channels 50-100us, the best case is 3us vs
> > > > 53us for virtual channels.
> > >
> > > Hmmm, I am not sure where is the confusion here Jassi. There are two
> > > things which are very very different from each other.
> > >
> > > - Time taken by the mailbox framework (and remote for acknowledging
> > >   it) for completion of a single request, this can be 3us to 100s of
> > >   us. This is clear for everyone. THIS IS NOT THE PROBLEM.
> > >
> > > - Delay introduced by few of such requests on the last one, i.e. 5
> > >   normal requests followed by an important one (like DVFS), the last
> > >   one needs to wait for the first 5 to finish first. THIS IS THE
> > >   PROBLEM.
> >
> > Earlier, Jassi also commented "Linux does not provide real-time
> > guarantees", which to me is what actually causes the issue here:
> >
> > Linux having timeouts when communicating to the firmware means
> > that it relies on the hardware and firmware having real-time behavior
> > even when not providing real-time guarantees to its processes.
> >
> The timeout used in SCMI is simply based on how long the Juno (?)
> platform takes to reply in most cases.

Just FYI, the timeouts in SCMI can be platform specific. So each platform
have flexibility to choose it's own choice of timeout and need not be
stuck with so called *Juno values".

The architects of SCMI believe the transfers(especially DVFS) must not exceed
few 100s of uS and worst case for any transfers must be few ms. My initial
choice of 30ms was based on the jiffes based timer and 100Hz. Architect claim
that is too much, but I thought 3 jiffies at minimum in case we start timer
when we are close to the boundaries.

> Talking proper code-design, the timeout (if at all) shouldn't even be
> a hardcoded value, but instead taken from the platform.
> 
> > When comparing the two usage models, it's clear that the minimum
> > latency for a message delivery is always at least the time time
> > to process an interrupt, plus at least one expensive MMIO read
> > and one less expensive posted MMIO write for an Ack. If we
> > have a doorbell plus out-of-band message, we need an extra
> > DMA barrier and a read from coherent memory, both of which can
> > be noticeable. As soon as messages are queued in the current
> > model, the maximum latency increases by a potentially unbounded
> > number of round-trips, while in the doorbell model that problem
> > does not exist, so I agree that we need to handle both modes
> > in the kernel deal with all existing hardware as well as firmware
> > that requires low-latency communication.
> >
> From the test case Sudeep last shared, the scmi usage on mhu doesn't
> not even hit any bottleneck ... the test "failed" because of the too
> small hardcoded timeout value. Otherwise the current code actually
> shows better numbers.

No disagreement on the latter part. But we can't ignore the bottlenecks
even if they are rare.

> We need some synthetic tests to bring the limitation to the surface. I
> agree that there may be such a test case, however fictitious. For that
> reason, I am ok with the doorbell mode.
>

Thanks !

-- 
Regards,
Sudeep
