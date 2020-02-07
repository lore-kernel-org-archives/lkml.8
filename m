Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF97AC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA5C20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgBGLGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:06:07 -0500
Received: from foss.arm.com ([217.140.110.172]:38970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGLGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:06:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B091930E;
        Fri,  7 Feb 2020 03:06:05 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BFED3F68E;
        Fri,  7 Feb 2020 03:06:04 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:06:02 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
Message-ID: <20200207110602.GE36345@bogus>
References: <1580994086-17850-1-git-send-email-peng.fan@nxp.com>
 <1580994086-17850-2-git-send-email-peng.fan@nxp.com>
 <7875e2533c4ba23b8ca0a2a296699497@kernel.org>
 <20200207104736.GB36345@bogus>
 <AM0PR04MB4481B1D5E2725E85BC6D6D71881C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481B1D5E2725E85BC6D6D71881C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 10:55:44AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
> >
> > On Fri, Feb 07, 2020 at 10:08:36AM +0000, Marc Zyngier wrote:
> > > On 2020-02-06 13:01, peng.fan@nxp.com wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > SCMI could use SMC/HVC as tranports, so add into devicetree binding
> > > > doc.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/arm,scmi.txt | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > > b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > > index f493d69e6194..03cff8b55a93 100644
> > > > --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > > +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > > @@ -14,7 +14,7 @@ Required properties:
> > > >
> > > >  The scmi node with the following properties shall be under the
> > > > /firmware/ node.
> > > >
> > > > -- compatible : shall be "arm,scmi"
> > > > +- compatible : shall be "arm,scmi" or "arm,scmi-smc"
> > > >  - mboxes: List of phandle and mailbox channel specifiers. It should
> > > > contain
> > > >  	  exactly one or two mailboxes, one for transmitting messages("tx")
> > > >  	  and another optional for receiving the notifications("rx") if @@
> > > > -25,6 +25,8 @@ The scmi node with the following properties shall be
> > > > under the /firmware/ node.
> > > >  	  protocol identifier for a given sub-node.
> > > >  - #size-cells : should be '0' as 'reg' property doesn't have any size
> > > >  	  associated with it.
> > > > +- arm,smc-id : SMC id required when using smc transports
> > > > +- arm,hvc-id : HVC id required when using hvc transports
> > > >
> > > >  Optional properties:
> > >
> > > Not directly related to DT: Why do we need to distinguish between SMC
> > > and HVC?
> >
> > IIUC you want just one property to get the function ID ? Does that align with
> > what you are saying ? I wanted to ask the same question and I see no need for
> > 2 different properties.
>
> The multiple protocols might use SMC or HVC. Saying
>
>  Protocol@x {
>     method="smc";
>     arm,func-id=<0x....>
>  };
>  Protocol@y {
>     method="hvc";
>     arm,func-id=<0x....>
>  };
>

Wow, stop there. Please don't do that. You either use SMC or HVC consistently.
Not both at the same time. Any particular reasons for trying such crazy things.

> With my propose:
>
> Protocol@x {
>     arm,smc-id=<0x....>
>  };
>  Protocol@y {
>     arm,hvc-id=<0x....>
>  };
>
> No need an extra method property to indicate it is smc or hvc.
> The driver use take arm,smc-id as SMC, arm,hvc-id as HVC.
>

NACK, just have one function ID, I am not very particular on the name
'smc-id' is just fine for me. But only one function ID for any conduit
used and that is chosen by PSCI/SMCCC.

If you need multiple channels(unique per protocol) then I suggest go for
an channel ID or you can even manage just with shmem associated with it
(I prefer latter but again I am fine either way)

--
Regards,
Sudeep
