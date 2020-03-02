Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395C3C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198DF21D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgCBLVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:21:24 -0500
Received: from foss.arm.com ([217.140.110.172]:59590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbgCBLVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:21:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3D7F2F;
        Mon,  2 Mar 2020 03:21:22 -0800 (PST)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 624963F6C4;
        Mon,  2 Mar 2020 03:21:20 -0800 (PST)
Date:   Mon, 2 Mar 2020 11:21:17 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>
Subject: Re: [PATCH V3 2/2] firmware: arm_scmi: add smc/hvc transport
Message-ID: <20200302112117.GB16218@e107533-lin.cambridge.arm.com>
References: <1582701171-26842-1-git-send-email-peng.fan@nxp.com>
 <1582701171-26842-3-git-send-email-peng.fan@nxp.com>
 <20200228161820.GA17229@bogus>
 <AM0PR04MB4481C79FD4EB32E6F111A22588E90@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481C79FD4EB32E6F111A22588E90@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 02:07:30AM +0000, Peng Fan wrote:
> Hi Sudeep,
>
> > Subject: Re: [PATCH V3 2/2] firmware: arm_scmi: add smc/hvc transport
> >
> > On Wed, Feb 26, 2020 at 03:12:51PM +0800, peng.fan@nxp.com wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Take arm,smc-id as the 1st arg, and protocol id as the 2nd arg when
> > > issuing SMC/HVC. Since we need protocol id, so add this parameter
> >
> > And why do we need protocol id here ? I couldn't find it out myself.
> > I would like to know why/what/how is it used in the firmware(smc/hvc
> > handler). I hope you are not mixing the need for multiple channel with
> > protocol id ? One can find out id from the command itself, no need to pass it
> > and hence asking here for more details.
>
> When each protocol needs its own shmem area, we need let firmware
> know which shmem area to parse the message from. Without protocol
> id, firmware not know which shmem area should use. Hope this is clear.
>

Not all platforms need to have a separate shmem for each protocol. Make it
it separate transport.

--
Regards,
Sudeep
