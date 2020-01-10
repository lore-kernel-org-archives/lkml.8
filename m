Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F6BC33CA5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7F520721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgAJMbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:31:07 -0500
Received: from foss.arm.com ([217.140.110.172]:43950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgAJMbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:31:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B151063;
        Fri, 10 Jan 2020 04:31:06 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AA483F534;
        Fri, 10 Jan 2020 04:31:05 -0800 (PST)
Date:   Fri, 10 Jan 2020 12:31:03 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, peng.fan@nxp.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20200110123103.GC45077@bogus>
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
> @Peng ?
>
> > > +/**
> > > + * struct scmi_chan_info - Structure representing a SCMI channel information
> > > + *
> > > + * @payload: Transmit/Receive payload area
> > > + * @dev: Reference to device in the SCMI hierarchy corresponding to this
> > > + *      channel
> > > + * @handle: Pointer to SCMI entity handle
> > > + * @transport_info: Transport layer related information
> > > + */
> > > +struct scmi_chan_info {
> > > +       void __iomem *payload;
> > > +       struct device *dev;
> > > +       struct scmi_handle *handle;
> > > +       void *transport_info;
> > > +};
> >
> > I would assume that with another transport, the 'payload' pointer would
> > not be __iomem
>
> Hmm, okay. I just separated things based on the current transport and
> didn't add much changes on top of it as I wasn't sure how things are
> going to look with next transport and so left the changes for then.
>
> I can now drop it though.
>
> > > +static int scmi_set_transport_ops(struct scmi_info *info)
> > > +{
> > > +       struct scmi_transport_ops *ops;
> > > +       struct device *dev = info->dev;
> > > +
> > > +       /* Only mailbox method supported for now */
> > > +       ops = scmi_mailbox_get_ops(dev);
> > > +       if (!ops) {
> > > +               dev_err(dev, "Transport protocol not found in %pOF\n",
> > > +                       dev->of_node);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       info->transport_ops = ops;
> > > +       return 0;
> > > +}
> >
> > This looks odd: rather than guessing the transport type based on
> > random DT properties, I would prefer to have it determined by
> > the device compatible string, and have different drivers bind
> > to one of them each, with each driver linking against a common
> > base implementation, either as separate modules or in one file.
>
> Since there are no platforms using the scmi binding in mainline kernel
> for now, it won't be difficult to add new compatible strings.

I am fine adding new compatible but since the binding is present in the
mainline for several releases now, we may have to have fallback to mailbox
as default if any of the new compatibles added is missing.

--
Regards,
Sudeep
