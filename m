Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E70BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AA922B48
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgCDRDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:03:24 -0500
Received: from foss.arm.com ([217.140.110.172]:37294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgCDRDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:03:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6697E31B;
        Wed,  4 Mar 2020 09:03:23 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3073A3F6CF;
        Wed,  4 Mar 2020 09:03:22 -0800 (PST)
Date:   Wed, 4 Mar 2020 17:03:20 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4 2/2] firmware: arm_scmi: add smc/hvc transport
Message-ID: <20200304170319.GB44525@bogus>
References: <1583201219-15839-1-git-send-email-peng.fan@nxp.com>
 <1583201219-15839-3-git-send-email-peng.fan@nxp.com>
 <20200304103954.GA25004@bogus>
 <AM0PR04MB4481A6DB7339C22A848DAFC988E50@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <AM0PR04MB44814B71E92C02956F4BED4588E50@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB44814B71E92C02956F4BED4588E50@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Wed, Mar 04, 2020 at 02:16:00PM +0000, Peng Fan wrote:
> > Subject: RE: [PATCH V4 2/2] firmware: arm_scmi: add smc/hvc transport
> >
> > Hi Sudeep,
> >
> > > Subject: Re: [PATCH V4 2/2] firmware: arm_scmi: add smc/hvc transport
> > >
> > > On Tue, Mar 03, 2020 at 10:06:59AM +0800, peng.fan@nxp.com wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Take arm,smc-id as the 1st arg, leave the other args as zero for now.
> > > > There is no Rx, only Tx because of smc/hvc not support Rx.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > >
> > > [...]
> > >
> > > > +static int smc_send_message(struct scmi_chan_info *cinfo,
> > > > +			    struct scmi_xfer *xfer)
> > > > +{
> > > > +	struct scmi_smc *scmi_info = cinfo->transport_info;
> > > > +	struct arm_smccc_res res;
> > > > +
> > > > +	shmem_tx_prepare(scmi_info->shmem, xfer);
> > >
> > > How do we protect another thread/process on another CPU going and
> > > modifying the same shmem with another request ? We may need notion of
> > > channel with associated shmem and it is protected with some lock.
> >
> > This is valid concern. But I think if shmem is shared bwteen protocols, the
> > access to shmem should be protected in
> > drivers/firmware/arm_scmi/driver.c: scmi_do_xfer, because send_message
> > and fetch_response both touches shmem
> >
> > The mailbox transport also has the issue you mentioned, I think.

No, it doesn't. I hope you realised that now based on your statement below.

>
> Ignore my upper comments. How do think the following diff based on current patch?
>
> If ok, I'll squash it with current patch and send out v5.
>
> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> index 88f91b68f297..7d770112f339 100644
> --- a/drivers/firmware/arm_scmi/smc.c
> +++ b/drivers/firmware/arm_scmi/smc.c
> @@ -29,6 +29,8 @@ struct scmi_smc {
>         u32 func_id;
>  };
>
> +static DEFINE_MUTEX(smc_mutex);
> +
>  static bool smc_chan_available(struct device *dev, int idx)
>  {
>         return true;
> @@ -99,11 +101,15 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>         struct scmi_smc *scmi_info = cinfo->transport_info;
>         struct arm_smccc_res res;
>
> +       mutex_lock(&smc_mutex);
> +
>         shmem_tx_prepare(scmi_info->shmem, xfer);
>
>         arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
>         scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info->shmem));
>
> +       mutex_unlock(&smc_mutex);
> +
>         return res.a0;
>  }
>

Yes, this may fix the issue. However I would like to know if we need to
support multiple channels/shared memory simultaneously. It is fair
requirement and may need some work which should be fine. I just want to
make sure we don't need anything more from DT or if we need to add more
to DT bindings, we need to ensure it won't break single channel. I will
think about that, but I would like to hear from other users of this SMC
for SCMI.

--
Regards,
Sudeep
