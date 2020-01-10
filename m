Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA0DC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1272077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgAJMWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:22:34 -0500
Received: from foss.arm.com ([217.140.110.172]:43746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgAJMWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:22:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8A951063;
        Fri, 10 Jan 2020 04:22:33 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5AB23F534;
        Fri, 10 Jan 2020 04:22:32 -0800 (PST)
Date:   Fri, 10 Jan 2020 12:22:26 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20200110122226.GA45077@bogus>
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
 <CAK8P3a3=q2zX9xQo7eZKp7e70rAeNB8VoSjg2aE06QJuSw8y3Q@mail.gmail.com>
 <20200109091613.fx2ggmmjvgjempks@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109091613.fx2ggmmjvgjempks@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:46:13PM +0530, Viresh Kumar wrote:
> On 09-01-20, 09:18, Arnd Bergmann wrote:
> > > +static int mailbox_chan_free(int id, void *p, void *data)
> > > +{
> > > +       struct scmi_chan_info *cinfo = p;
> > > +       struct scmi_mailbox *smbox = cinfo->transport_info;
> > > +
> > > +       if (!IS_ERR_OR_NULL(smbox->chan)) {
> > > +               mbox_free_channel(smbox->chan);
> > > +               cinfo->transport_info = NULL;
> > > +               smbox->chan = NULL;
> > > +               smbox->cinfo = NULL;
> > > +       }
> >
> > There is something wrong if smbox->chan can be be one of
> > three things (a valid pointer, a NULL pointer, or an error value).
> >
> > I see this is a preexisting problem, but please add a patch to
> > make it consistently use either NULL pointers or error codes
> > and remove all instances of IS_ERR_OR_NULL() from this
> > subsystem.
>
> This isn't a subsystem problem actually. mbox_request_channel() never
> returns NULL on error.
>
> @Sudeep, do we really need the IS_ERR_OR_NULL() check in
> scmi_mbox_free_channel() helper ? Or can it just be IS_ERR() ?
>

It can be just IS_ERR, just not noticed it so far I believe.

--
Regards,
Sudeep
