Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D4DC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB9A2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgAJM1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:27:30 -0500
Received: from foss.arm.com ([217.140.110.172]:43886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgAJM13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:27:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C9B01063;
        Fri, 10 Jan 2020 04:27:29 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E69F33F534;
        Fri, 10 Jan 2020 04:27:27 -0800 (PST)
Date:   Fri, 10 Jan 2020 12:27:25 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, peng.fan@nxp.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20200110122725.GB45077@bogus>
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
 <CAK8P3a3=q2zX9xQo7eZKp7e70rAeNB8VoSjg2aE06QJuSw8y3Q@mail.gmail.com>
 <20200109093442.4jt44eu2zlmjaq3f@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109093442.4jt44eu2zlmjaq3f@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 03:04:42PM +0530, Viresh Kumar wrote:
> On 09-01-20, 09:18, Arnd Bergmann wrote:
> > On Fri, Nov 29, 2019 at 10:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > The SCMI specification is fairly independent of the transport protocol,
> > > which can be a simple mailbox (already implemented) or anything else.
> > > The current Linux implementation however is very much dependent of the
> > > mailbox transport layer.
> > >
> > > This patch makes the SCMI core code (driver.c) independent of the
> > > mailbox transport layer and moves all mailbox related code to a new
> > > file: mailbox.c.
> > >
> > > We can now implement more transport protocols to transport SCMI
> > > messages.
> > >
> > > The transport protocols just need to provide struct scmi_transport_ops,
> > > with its version of the callbacks to enable exchange of SCMI messages.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Conceptually I think this is fine, but as others have said, it would be
> > better to have another transport implementation posted along with this
> > to see if the interfaces actually work out.
>
> @Sudeep/Vincent: Do you think we can add another transport
> implementation something right away for it ?
>

Even if we don't add new transport right away, I would like to see if
the requirements are met. I will take a look at you v2 with that in mind
anyways. We need not wait, we I want to see people think it meets their
requirement. I will also add couple of guys working on virtio transport
for SCMI when I respond to your v2. Thanks for posting it.

> @Peng ?
>
Peng, Did you get a chance to try this with SMC ? If SCMI was the only
usecase, you can try this approach instead of mailbox, now that no one
has any objects to this approach conceptually. Please use v2 as base
and update us.

--
Regards,
Sudeep
