Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1000C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C7F21744
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCFOXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:23:24 -0500
Received: from foss.arm.com ([217.140.110.172]:34582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgCFOXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:23:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6006C31B;
        Fri,  6 Mar 2020 06:23:23 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B29E3F534;
        Fri,  6 Mar 2020 06:23:22 -0800 (PST)
Date:   Fri, 6 Mar 2020 14:23:13 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4 2/2] firmware: arm_scmi: add smc/hvc transport
Message-ID: <20200306123442.GA47929@bogus>
References: <1583201219-15839-1-git-send-email-peng.fan@nxp.com>
 <1583201219-15839-3-git-send-email-peng.fan@nxp.com>
 <20200304103954.GA25004@bogus>
 <AM0PR04MB4481A6DB7339C22A848DAFC988E50@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <AM0PR04MB44814B71E92C02956F4BED4588E50@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200304170319.GB44525@bogus>
 <AM0PR04MB4481B90D03D1F68573B05BE088E20@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200305160613.GA53631@bogus>
 <d9734fd6-f855-296b-3a0b-ffc45ed0e3cb@gmail.com>
 <AM0PR04MB448167BD133BF57E548F2F0588E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB448167BD133BF57E548F2F0588E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 08:07:19AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH V4 2/2] firmware: arm_scmi: add smc/hvc transport
> >
> > On 3/5/20 8:06 AM, Sudeep Holla wrote:
> > > On Thu, Mar 05, 2020 at 11:25:35AM +0000, Peng Fan wrote:
> > >
> > > [...]
> > >
> > >>>
> > >>> Yes, this may fix the issue. However I would like to know if we need
> > >>> to support multiple channels/shared memory simultaneously. It is
> > >>> fair requirement and may need some work which should be fine.
> > >>
> > >> Do you have any suggestions? Currently I have not worked out an good
> > >> solution.
> > >>
> > >
> > > TBH, I haven't given it a much thought. I would like to know if people
> > > are happy with just one SMC channel for SCMI or do they need more ?
> > > If they need it, we can try to solve it. Otherwise, what you have will
> > > suffice IMO.
> >
> > On our platforms we have one channel/shared memory area/mailbox
> > instance for all standard SCMI protocols, and we have a separate
> > channel/shared memory area/mailbox driver instance for a proprietary one.
> > They happen to have difference throughput requirements, hence the split.
> >

OK, when you refer proprietary protocol, do you mean outside the scope of
SCMI ? The reason I ask is SCMI allows vendor specific protocols and if
you are using other channel for that, it still make sense to add
multi-channel support here.

> > If I read Peng's submission correctly, it seems to me that the usage model
> > described before is still fine.
>
> Thanks.
>
> Sudeep,
>
> Then should I repost with the global mutex added?
>

Sure, you can send the updated. I will think about adding support for more
than one channel and send a patch on top of it if I get around it.

Note that I sent PR for v5.7 last earlier this week, so this will be for v5.8

--
Regards,
Sudeep
