Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29621C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080A924125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgAUSi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:38:26 -0500
Received: from foss.arm.com ([217.140.110.172]:47354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729081AbgAUSiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:38:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BD521FB;
        Tue, 21 Jan 2020 10:38:25 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB3F93F6C4;
        Tue, 21 Jan 2020 10:38:23 -0800 (PST)
Date:   Tue, 21 Jan 2020 18:38:18 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        cristian.marussi@arm.com, Peng Fan <peng.fan@nxp.com>,
        peter.hilber@opensynergy.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V3] firmware: arm_scmi: Make scmi core independent of the
 transport type
Message-ID: <20200121183818.GA11522@bogus>
References: <4b74f1b6c1f9653241a1b5754525e230b3d76a3f.1579595093.git.viresh.kumar@linaro.org>
 <CAK8P3a0fWf-wd8exJa+_UL9n0bQ26W6wd0iQH32osM1Q+cLu_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0fWf-wd8exJa+_UL9n0bQ26W6wd0iQH32osM1Q+cLu_w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:11:11PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 21, 2020 at 9:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The SCMI specification is fairly independent of the transport protocol,
> > which can be a simple mailbox (already implemented) or anything else.
> > The current Linux implementation however is very much dependent on the
> > mailbox transport layer.
> >
> > This patch makes the SCMI core code (driver.c) independent of the
> > mailbox transport layer and moves all mailbox related code to a new
> > file: mailbox.c.
> >
> > We can now implement more transport protocols to transport SCMI
> > messages.
> >
> > The transport protocols just need to provide struct scmi_transport_ops,
> > with its version of the callbacks to enable exchange of SCMI messages.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > @Sudeep: Can you please help me getting this tested?
> >

Sure(I may need to rebase on top of -next to test on top of what's queued
for v5.6)

> > V2->V3:
> > - Added more ops to the structure to read/write/memcpy data
> > - Payload is moved to mailbox.c and is handled in transport specific way
> >   now. This resulted in lots of changes.
>
> This addresses the comments I had about the implementation.
>

Thanks for review and all the suggestions Arnd.

> It's still hard for me to judge whether this is a good abstraction as
> long as there is only one backend in the framework, but I see nothing
> immediately wrong with it either.
>

Peter and Peng(both in cc) is trying out virtio and smc/hvc based transport
respectively. Hopefully they will raise concerns(if any) with the abstraction.

--
Regards,
Sudeep
