Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590E1C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373582082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgBGKku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:40:50 -0500
Received: from foss.arm.com ([217.140.110.172]:38670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgBGKku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:40:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55FDE30E;
        Fri,  7 Feb 2020 02:40:49 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 576A13F52E;
        Fri,  7 Feb 2020 02:40:48 -0800 (PST)
Date:   Fri, 7 Feb 2020 10:40:43 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] firmware: arm_scmi: mark channel free when init
Message-ID: <20200207104043.GA36345@bogus>
References: <1580993846-17712-1-git-send-email-peng.fan@nxp.com>
 <1580993846-17712-2-git-send-email-peng.fan@nxp.com>
 <20200206143337.GC3383@bogus>
 <AM0PR04MB44817B64CB35B2B2FB50D8F7881C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB44817B64CB35B2B2FB50D8F7881C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 02:16:04AM +0000, Peng Fan wrote:
>
> > Subject: Re: [PATCH 2/2] firmware: arm_scmi: mark channel free when init
> >
> > On Thu, Feb 06, 2020 at 08:57:26PM +0800, peng.fan@nxp.com wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > The firmware itself might not mark channel free, so let's explicitly
> > > mark it free when do initialization.
> > >
> > > Also move struct scmi_shared_mem to common.h
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/firmware/arm_scmi/common.h  | 19 +++++++++++++++++--
> > > drivers/firmware/arm_scmi/mailbox.c |  2 ++
> > >  drivers/firmware/arm_scmi/shmem.c   | 18 ------------------
> > >  3 files changed, 19 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/firmware/arm_scmi/common.h
> > > b/drivers/firmware/arm_scmi/common.h
> > > index fd091a4ccbff..5df262a564a4 100644
> > > --- a/drivers/firmware/arm_scmi/common.h
> > > +++ b/drivers/firmware/arm_scmi/common.h
> > > @@ -211,8 +211,23 @@ extern const struct scmi_desc scmi_mailbox_desc;
> > > void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr);
> > > void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr,
> > > int id);
> > >
> > > -/* shmem related declarations */
> > > -struct scmi_shared_mem;
> > > +/*
> > > + * SCMI specification requires all parameters, message headers,
> > > +return
> > > + * arguments or any protocol data to be expressed in little endian
> > > + * format only.
> > > + */
> > > +struct scmi_shared_mem {
> > > +	__le32 reserved;
> > > +	__le32 channel_status;
> > > +#define SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR	BIT(1)
> > > +#define SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE	BIT(0)
> > > +	__le32 reserved1[2];
> > > +	__le32 flags;
> > > +#define SCMI_SHMEM_FLAG_INTR_ENABLED	BIT(0)
> > > +	__le32 length;
> > > +	__le32 msg_header;
> > > +	u8 msg_payload[0];
> > > +};
> > >
> > >  void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
> > >  		      struct scmi_xfer *xfer);
> > > diff --git a/drivers/firmware/arm_scmi/mailbox.c
> > > b/drivers/firmware/arm_scmi/mailbox.c
> > > index 68ed58e2a47a..2d34bf6e94e2 100644
> > > --- a/drivers/firmware/arm_scmi/mailbox.c
> > > +++ b/drivers/firmware/arm_scmi/mailbox.c
> > > @@ -104,6 +104,8 @@ static int mailbox_chan_setup(struct
> > scmi_chan_info *cinfo, struct device *dev,
> > >  	cinfo->transport_info = smbox;
> > >  	smbox->cinfo = cinfo;
> > >
> > > +	iowrite32(BIT(0), &smbox->shmem->channel_status);
> > > +
> >
>
> +arm list
>
> > If we need this then we may need to put this as a function in shmem.c I am
> > still not convinced if we can do this unconditionally, i.e. will that affect Rx
> > channel if there's notification pending before we initialise. But we can deal
> > with that later.
>
> Per understanding, channel is specific to an agent, it could not be shared.
> So the shmem binded to the channel will not be used by others.
>

Yes

> Since this is the initialization process, the firmware might not init the shmem.
>

But, is there any particular reason for firmware not to ? It means platform
holds the channel and needs to release it to agent(OSPM) in this case after
initialisation.

> The shmem.c shmem_tx_prepare will spin until channel free, so I did the patch.
> Otherwise it might spin forever.
>

Yes I guessed that to be reason.

> I'll add a check as following
> if (tx)
>  iowrite32(BIT(0), &smbox->shmem->channel_status);
>

Not yet, I need answers to above query.

> I not find a good place to put this in shmem.c (:
>

Least of the problem :), let us first agree if we have to have it.

> >
> > Also what about error fields ? I would rather clear it to 0, not just BIT(0)
>
> Tx channel error should also be cleared, fix in v2.
>

OK but wait for a while before you post for the discussion to end.

--
Regards,
Sudeep
