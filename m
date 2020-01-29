Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BDFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B4D20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgA2QkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:40:23 -0500
Received: from foss.arm.com ([217.140.110.172]:43474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgA2QkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:40:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B84B2328;
        Wed, 29 Jan 2020 08:40:21 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B87F43F52E;
        Wed, 29 Jan 2020 08:40:20 -0800 (PST)
Date:   Wed, 29 Jan 2020 16:40:18 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        etienne carriere <etienne.carriere@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v11 2/2] mailbox: introduce ARM SMC based mailbox
Message-ID: <20200129164018.GE36496@bogus>
References: <CAN5uoS_YyPXiqZnNfM32cxeAsK+xuPX9QRK94-DJ6oMQFrZPXQ@mail.gmail.com>
 <CAN5uoS-9yUfAT4=a9ys4d_2wxh9nW_RgXd_-3T-zF2r-k-PtOw@mail.gmail.com>
 <AM0PR04MB448137850D19BADD11F75B18880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAN5uoS-cHxrFD-H245iHMU_zzk6wAL=YJvKFAY6rr2EMgd0L3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS-cHxrFD-H245iHMU_zzk6wAL=YJvKFAY6rr2EMgd0L3w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 04:01:07PM +0100, Etienne Carriere wrote:
> Hello Peng,
>
> On Mon, 27 Jan 2020 at 13:58, Peng Fan <peng.fan@nxp.com> wrote:
> >
> > > Subject: Re: [PATCH v11 2/2] mailbox: introduce ARM SMC based mailbox
> > >
> > > Hello Peng and all,
> > >
> > >
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > This mailbox driver implements a mailbox which signals transmitted
> > > > data via an ARM smc (secure monitor call) instruction. The mailbox
> > > > receiver is implemented in firmware and can synchronously return data
> > > > when it returns execution to the non-secure world again.
> > > > An asynchronous receive path is not implemented.
> > > > This allows the usage of a mailbox to trigger firmware actions on SoCs
> > > > which either don't have a separate management processor or on which
> > > > such a core is not available. A user of this mailbox could be the SCP
> > > > interface.
> > > >
> > > > Modified from Andre Przywara's v2 patch
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > > > .kernel.org%2Fpatchwork%2Fpatch%2F812999%2F&amp;data=02%7C01%7
> > > Cpeng.fa
> > > >
> > > n%40nxp.com%7C735cc6cd00404082bf8c08d79f67b93a%7C686ea1d3bc2b4
> > > c6fa92cd
> > > >
> > > 99c5c301635%7C0%7C0%7C637153140140878278&amp;sdata=m0lcAEIr0ZP
> > > tyPHorSW
> > > > NYgjfI5p0genJLlhqHMIHBg0%3D&amp;reserved=0
> > > >
> > > > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > > > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > >
> > > I've successfully tested your change on my board. It is a stm32mp1 with TZ
> > > secure hardening and I run an OP-TEE firmware (possibly a TF-A
> > > sp_min) with a SCMI server for clock and reset. Upstream in progress.
> > > The platform uses 2 instances of your SMC based mailbox device driver
> > > (2 mailboxes). Works nice with your change.
> > >
> > > You can add my T-b tag: Tested-by: Etienne Carriere
> > > <etienne.carriere@linaro.org>
> >
> > Thanks, but this patch has been dropped.
> >
> > Per Sudeep, we all use smc transport, not smc mailbox ,
> > I'll post patch in a few days based on the transport split patch.
>
> Ok, i am syncing.
>
> > >
> > > FYI, I'll (hopefully soon) post a change proposal in U-Boot ML for an equvalent
> > > 'SMC based mailbox' driver and SCMI agent protocol/device drivers for clock
> > > and reset controllers.
> >
> > Great to know you did scmi agent code in U-Boot. Do you have some public repo
> > for access?
>
> I've created a P-R on my github repo to share until I submit to u-boot:
>  https://github.com/etienne-lms/u-boot/pull/3
>
> I guess I will change my u-boot proposal and get a SMC SCMI transport
> outside of the mailbox framework.
>

Unless U-boot has mailbox framework or you are importing it, it's better
to keep U-boot implementation simple as SMC transport which I think you
already do. I had a look at the implementation[1], it shouldn't change
much other than if you prefer not to use "mailbox" terminology. I don't
understand the reason for even using the mailbox term there in the first
place.

--
Regards,
Sudeep

[1] https://github.com/etienne-lms/u-boot/pull/3/commits/34812c9175436f6a082f77347c5384393757c233
