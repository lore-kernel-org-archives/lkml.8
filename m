Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4491AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243E020727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgEOJea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:34:30 -0400
Received: from foss.arm.com ([217.140.110.172]:52002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgEOJe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:34:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD32D2F;
        Fri, 15 May 2020 02:34:28 -0700 (PDT)
Received: from bogus (unknown [10.37.12.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75A863F71E;
        Fri, 15 May 2020 02:34:27 -0700 (PDT)
Date:   Fri, 15 May 2020 10:34:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: arm_scmi: fix SMCCC_RET_NOT_SUPPORTED
 management
Message-ID: <20200515093424.GC23671@bogus>
References: <20200514082428.27864-1-etienne.carriere@linaro.org>
 <20200514142924.GC23401@bogus>
 <CAN5uoS_bimZsFqwaODRRWeCe15JMepQa2z9J0+dq7qNfwxRsug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS_bimZsFqwaODRRWeCe15JMepQa2z9J0+dq7qNfwxRsug@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 05:06:22PM +0200, Etienne Carriere wrote:
> On Thu, 14 May 2020 at 16:29, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, May 14, 2020 at 10:24:28AM +0200, Etienne Carriere wrote:
> > > Fix management of argument a0 output value of arm_smccc_1_1_invoke() that
> > > should consider only SMCCC_RET_NOT_SUPPORTED as reporting an unsupported
> > > function ID as correctly stated in the inline comment.
> > >
> >
> > I agree on the comment part, but ...
> >
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > ---
> > >  drivers/firmware/arm_scmi/smc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> > > index 49bc4b0e8428..637ad439545f 100644
> > > --- a/drivers/firmware/arm_scmi/smc.c
> > > +++ b/drivers/firmware/arm_scmi/smc.c
> > > @@ -115,7 +115,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
> > >       mutex_unlock(&scmi_info->shmem_lock);
> > >
> > >       /* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
> > > -     if (res.a0)
> > > +     if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
> > >               return -EOPNOTSUPP;
> >
> > Now this will return 0 for all values other than SMCCC_RET_NOT_SUPPORTED.
> > Is that what we need ? Or do you see non-zero res.a0 for a success case ?
> > If later, we need some fixing, otherwise it is safer to leave it as is
> > IMO.
> 
> Firmware following SMCCC v1.x for some OEM/SiP invocation may simply
> not modify invocation register argument a0 on invocation with a
> SCMI-SMC transport function ID.

Yikes, I need to check specification again for this. I will also
check with the firmware implementation team/

> Resulting in res.a0 == scmi_info->func_id here. Which is, by SMCCC
> v1.x not an error.
>

But that may get fatal the result in some other cases, not here for sure.
But I would rather flag that as error so that it is fixed. Anyways I will
check on this again/

> From SMCCC v1.x only SMCCC_RET_NOT_SUPPORTED (-1 signed extended is a
> reserved ) is a generic return error whatever function ID value.
>

Not really, there are couple more I think now. But yes I need to check
on the generic return part.

> Or consider part of the SCMI-SMC transport API that output arg a0
> shall be 0 on success, SMCCC_RET_NOT_SUPPORTED if function ID is not
> supported and any non-zero value for non-generic **error** codes.
>

I prefer that. Anyways I will check and if anything changes I will ping
back on this thread.

--
Regards,
Sudeep
