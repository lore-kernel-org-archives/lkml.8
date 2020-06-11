Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7949AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5674C20656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgFKIkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:40:21 -0400
Received: from foss.arm.com ([217.140.110.172]:48278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgFKIkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:40:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 143F21FB;
        Thu, 11 Jun 2020 01:40:20 -0700 (PDT)
Received: from bogus (unknown [10.37.12.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BA483F73D;
        Thu, 11 Jun 2020 01:40:17 -0700 (PDT)
Date:   Thu, 11 Jun 2020 09:40:14 +0100
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
Message-ID: <20200611084014.GB7357@bogus>
References: <20200607193023.52344-1-jassisinghbrar@gmail.com>
 <20200610082315.GB2689@bogus>
 <CABb+yY1T03YLwiFvBykxsAHQ9Kpu=r1nRTuaP3Emf5dP=Upm0g@mail.gmail.com>
 <20200610155629.GA7357@bogus>
 <CABb+yY0pQYD7DTf=MNpVPB7F2PESiWyTYj=ftRHDPkKMOobRVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY0pQYD7DTf=MNpVPB7F2PESiWyTYj=ftRHDPkKMOobRVQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 09:45:55PM -0500, Jassi Brar wrote:
> On Wed, Jun 10, 2020 at 10:56 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> [I admit you can write bigger posts than me, so I am not going to
> write a passionate response to each of your paragraphs.
> Let's keep it to the point.]
>
> > > > >       if (xfer->hdr.poll_completion) {
> > > > > -             ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
> > > > > +             ktime_t stop = ktime_add_ns(ktime_get(), 500 * 1000 * NSEC_PER_USEC);
> > > > >
> > > >
> > > > This is unacceptable delay for schedutil fast_switch. So no for this one.
> > > >
> > > Increasing timeout does not increase latency.
> >
> > Agreed, but worst case you may be stuck here for 500ms which is not
> > acceptable.
> >
> Not acceptable to who, you or the kernel? :)    Now that you said you
> are fixing the scmi's fast_switch implementation.
>

Sorry, I meant to disable it for single channel implementation. I am not
saying we want that on Juno/MHU.

> Even though I don't think 500ms would ruin our lives, but ok, I will
> make it 30ms - same as you did in the 'else' block. And drop the other
> change.

I am fine if cpufreq maintainers allow that in the fast switch path that
happens in the fast path.

--
Regards,
Sudeep
