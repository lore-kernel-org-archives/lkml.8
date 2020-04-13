Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F860C2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4659E206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389171AbgDMVf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:35:29 -0400
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:42472 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389146AbgDMVfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:35:24 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 9FD37180424D6;
        Mon, 13 Apr 2020 21:35:22 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0946E1802766E;
        Mon, 13 Apr 2020 21:35:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: help61_68a97634c390c
X-Filterd-Recvd-Size: 3907
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Apr 2020 21:35:18 +0000 (UTC)
Message-ID: <12eb64714f3a7ae33912c468191a471d09ade504.camel@perches.com>
Subject: Re: [PATCH v4 01/10] drivers: qcom: rpmh-rsc: Clean code
 reading/writing TCS regs/cmds
From:   Joe Perches <joe@perches.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 13 Apr 2020 14:33:11 -0700
In-Reply-To: <CAD=FV=UOzVmwpoxd4QTSPiG9nt=YjUYZdgmK=SKU6vTFWcf=bw@mail.gmail.com>
References: <20200413170415.32463-1-dianders@chromium.org>
         <20200413100321.v4.1.I1b754137e8089e46cf33fc2ea270734ec3847ec4@changeid>
         <6566837cdb0e8db522c53daba8baf49c2ca79376.camel@perches.com>
         <CAD=FV=UOzVmwpoxd4QTSPiG9nt=YjUYZdgmK=SKU6vTFWcf=bw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-13 at 14:18 -0700, Doug Anderson wrote:
> Hi,

Rehi.

> On Mon, Apr 13, 2020 at 11:21 AM Joe Perches <joe@perches.com> wrote:
> > On Mon, 2020-04-13 at 10:04 -0700, Douglas Anderson wrote:
> > > This patch makes two changes, both of which should be no-ops:
> > > 
> > > 1. Make read_tcs_reg() / read_tcs_cmd() symmetric to write_tcs_reg() /
> > >    write_tcs_cmd().
> > > 
> > > 2. Change the order of operations in the above functions to make it
> > >    more obvious to me what the math is doing.  Specifically first you
> > >    want to find the right TCS, then the right register, and then
> > >    multiply by the command ID if necessary.
> > 
> > Though these operations are only used a couple times, perhaps
> > it'd be useful to have static inlines for the calcs.
> > 
> > > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> > []
> > > @@ -67,28 +67,33 @@
> > >  #define CMD_STATUS_ISSUED            BIT(8)
> > >  #define CMD_STATUS_COMPL             BIT(16)
> > 
> > Maybe something like:
> > 
> > static inline void __iomem *
> > tcs_reg_addr(struct rsc_drv drv, int reg, int tcs_id)
> > {
> >         return drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg;
> > }
> > 
> > static inline void __iomem *
> > tcs_cmd_addr(struct rsc_drv drv, int reg, int tcs_id, int cmd_id)
> > {
> >         return tcs_reg_addr(drv, reg, tcs_id) + RSC_DRV_CMD_OFFSET * cmd_id;
> > }
> > 
> > > -static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
> > > +static u32 read_tcs_cmd(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
> > >  {
> > > -     return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
> > > +     return readl_relaxed(drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg +
> > >                            RSC_DRV_CMD_OFFSET * cmd_id);
> > 
> >         return readl_relaxed(tcs_cmd_addr(drv, reg, tcs_id, cmd_id));
> > 
> > etc...
> 
> I won't object if you really feel passionately about making that
> change but at this point it doesn't add tons of extra readability for
> me personally.

Just a suggestion.

> I was kinda hoping that Maulik and my series could
> land in the next few days since having 16 patches outstanding gets a
> bit unwieldy.  I'd rather not send out another spin of my series at
> this point since it's just a bunch more churn in everyone's inboxes.
> Maybe after they land you can post that as a follow-up cleanup?

If I remember...

cheers, Joe

