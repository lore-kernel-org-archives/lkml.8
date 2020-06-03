Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 046442053B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFCSb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:31:29 -0400
Received: from foss.arm.com ([217.140.110.172]:36738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgFCSb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:31:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 022D931B;
        Wed,  3 Jun 2020 11:31:27 -0700 (PDT)
Received: from bogus (unknown [10.37.8.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 948313F305;
        Wed,  3 Jun 2020 11:31:23 -0700 (PDT)
Date:   Wed, 3 Jun 2020 19:31:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200603183120.GE23722@bogus>
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200519012927.GT2165@builder.lan>
 <20200519034055.hfvifqz442yfduhg@vireshk-i7>
 <CABb+yY30nmbBUzYG62xGEbrr7107h_Edyq3jKPheZAQ0Cvr9Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY30nmbBUzYG62xGEbrr7107h_Edyq3jKPheZAQ0Cvr9Yg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:05:03PM -0500, Jassi Brar wrote:
> On Mon, May 18, 2020 at 10:40 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 18-05-20, 18:29, Bjorn Andersson wrote:
> > > On Thu 14 May 22:17 PDT 2020, Viresh Kumar wrote:
> > > > This stuff has been doing rounds on the mailing list since several years
> > > > now with no agreed conclusion by all the parties. And here is another
> > > > attempt to get some feedback from everyone involved to close this once
> > > > and for ever. Your comments will very much be appreciated.
> > > >
> > > > The ARM MHU is defined here in the TRM [1] for your reference, which
> > > > states following:
> > > >
> > > >     "The MHU drives the signal using a 32-bit register, with all 32
> > > >     bits logically ORed together. The MHU provides a set of
> > > >     registers to enable software to set, clear, and check the status
> > > >     of each of the bits of this register independently.  The use of
> > > >     32 bits for each interrupt line enables software to provide more
> > > >     information about the source of the interrupt. For example, each
> > > >     bit of the register can be associated with a type of event that
> > > >     can contribute to raising the interrupt."
> > > >
> > >
> > > Does this mean that there are 32 different signals and they are all ORed
> > > into the same interrupt line to trigger software action when something
> > > happens?
> > >
> > > Or does it mean that this register is used to pass multi-bit information
> > > and when any such information is passed an interrupt will be triggered?
> > > If so, what does that information mean? How is it tied into other Linux
> > > drivers/subsystems?
> >
> > I have started to believe the hardware is written badly at this point
> > :)
> >
> H/W is actually fine :)   Its just that the driver is written to
> _also_ support a platform (my original) that doesn't have shmem and
> need to pass data via 32bit registers.
> Frankly, I am not against the doorbell mode, I am against implementing
> two modes in a driver. If it really helped (note the past tense) the
> SCMI, we could implement the driver only in doorbell mode but
> unfortunately SCMI would still be _broken_ for non-doorbell
> controllers.

Should be fine as the specification is designed to work with only shmem
for any data transfer and mailbox is just a signal mechanism. I won't
be too worried about that.

--
Regards,
Sudeep
