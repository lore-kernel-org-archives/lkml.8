Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91306C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B242051A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgBKMC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:02:57 -0500
Received: from foss.arm.com ([217.140.110.172]:44698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbgBKMC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:02:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A17631FB;
        Tue, 11 Feb 2020 04:02:56 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 360283F6CF;
        Tue, 11 Feb 2020 04:02:55 -0800 (PST)
Date:   Tue, 11 Feb 2020 12:02:53 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
Message-ID: <20200211120253.GB52147@bogus>
References: <1580994086-17850-1-git-send-email-peng.fan@nxp.com>
 <1580994086-17850-2-git-send-email-peng.fan@nxp.com>
 <AM0PR04MB44814779B2307B20598E598288190@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB44814779B2307B20598E598288190@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 12:59:43AM +0000, Peng Fan wrote:
> > Subject: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > SCMI could use SMC/HVC as tranports, so add into devicetree binding doc.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/arm/arm,scmi.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > index f493d69e6194..03cff8b55a93 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > @@ -14,7 +14,7 @@ Required properties:
> >
> >  The scmi node with the following properties shall be under the /firmware/
> > node.
> >
> > -- compatible : shall be "arm,scmi"
> > +- compatible : shall be "arm,scmi" or "arm,scmi-smc"
>
> One question here, are you fine with compatible "arm,scmi-smc" or
> add a new property 'transport' such as:

Not required.

> transport = "mailbox"; for mailbox
> transport = "smc"; for smc and hvc.
>
Each transport will have it's own specific property like mailboxes for
mailbox, smc/hvc function IDs for SMC/HVC. That should be sufficient.

--
Regards,
Sudeep
