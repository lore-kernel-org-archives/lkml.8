Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A88EC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234EA24684
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgA1Li2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:38:28 -0500
Received: from foss.arm.com ([217.140.110.172]:55540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgA1Li1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:38:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B170101E;
        Tue, 28 Jan 2020 03:38:27 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B5043F52E;
        Tue, 28 Jan 2020 03:38:26 -0800 (PST)
Date:   Tue, 28 Jan 2020 11:38:21 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        etienne carriere <etienne.carriere@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v11 2/2] mailbox: introduce ARM SMC based mailbox
Message-ID: <20200128113821.GA36168@bogus>
References: <CAN5uoS_YyPXiqZnNfM32cxeAsK+xuPX9QRK94-DJ6oMQFrZPXQ@mail.gmail.com>
 <CAN5uoS-9yUfAT4=a9ys4d_2wxh9nW_RgXd_-3T-zF2r-k-PtOw@mail.gmail.com>
 <AM0PR04MB448137850D19BADD11F75B18880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB448137850D19BADD11F75B18880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 12:58:12PM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH v11 2/2] mailbox: introduce ARM SMC based mailbox
> >
> > Hello Peng and all,
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > This mailbox driver implements a mailbox which signals transmitted
> > > data via an ARM smc (secure monitor call) instruction. The mailbox
> > > receiver is implemented in firmware and can synchronously return data
> > > when it returns execution to the non-secure world again.
> > > An asynchronous receive path is not implemented.
> > > This allows the usage of a mailbox to trigger firmware actions on SoCs
> > > which either don't have a separate management processor or on which
> > > such a core is not available. A user of this mailbox could be the SCP
> > > interface.
> > >

[...]

> > I've successfully tested your change on my board. It is a stm32mp1 with TZ
> > secure hardening and I run an OP-TEE firmware (possibly a TF-A
> > sp_min) with a SCMI server for clock and reset. Upstream in progress.
> > The platform uses 2 instances of your SMC based mailbox device driver
> > (2 mailboxes). Works nice with your change.
> >
> > You can add my T-b tag: Tested-by: Etienne Carriere
> > <etienne.carriere@linaro.org>
>
> Thanks, but this patch has been dropped.
>
> Per Sudeep, we all use smc transport, not smc mailbox ,
>
Yes, I asked if there are any other users of SMC mailbox other than
SCMI. We are planning to separate the transport from the SCMI driver[1]
to enable transport other than mailbox. SMC can be one of them and the
other one planned is virtio. Please feel free to add to the discussion
or review.

--
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/f170b33989b426ac095952634fcd1bf45b86a7a3.1580208329.git.viresh.kumar@linaro.org
