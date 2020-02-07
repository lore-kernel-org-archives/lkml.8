Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22B3C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C1622464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGLck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:32:40 -0500
Received: from foss.arm.com ([217.140.110.172]:39266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGLck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:32:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F3AA328;
        Fri,  7 Feb 2020 03:32:39 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3CFA3F68E;
        Fri,  7 Feb 2020 03:32:37 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:32:35 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        andre.przywara@arm.com, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
Message-ID: <20200207113235.GC40103@bogus>
References: <1580994086-17850-1-git-send-email-peng.fan@nxp.com>
 <1580994086-17850-2-git-send-email-peng.fan@nxp.com>
 <7875e2533c4ba23b8ca0a2a296699497@kernel.org>
 <20200207104736.GB36345@bogus>
 <5a073c37e877d23977e440de52dba6e0@kernel.org>
 <AM0PR04MB44815F11C94E5F35AE7B0B21881C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <ce775af0803d174fa2ad5dfc797592d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce775af0803d174fa2ad5dfc797592d9@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 11:09:48AM +0000, Marc Zyngier wrote:
> On 2020-02-07 11:00, Peng Fan wrote:
> > > Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc
> > > transports
> > > 
> > > On 2020-02-07 10:47, Sudeep Holla wrote:
> > > > On Fri, Feb 07, 2020 at 10:08:36AM +0000, Marc Zyngier wrote:
> > > >> On 2020-02-06 13:01, peng.fan@nxp.com wrote:
> > > >> > From: Peng Fan <peng.fan@nxp.com>
> > > >> >
> > > >> > SCMI could use SMC/HVC as tranports, so add into devicetree binding
> > > >> > doc.
> > > >> >
> > > >> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > >> > ---
> > > >> >  Documentation/devicetree/bindings/arm/arm,scmi.txt | 4 +++-
> > > >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >> >
> > > >> > diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > >> > b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > >> > index f493d69e6194..03cff8b55a93 100644
> > > >> > --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > >> > +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > >> > @@ -14,7 +14,7 @@ Required properties:
> > > >> >
> > > >> >  The scmi node with the following properties shall be under the
> > > >> > /firmware/ node.
> > > >> >
> > > >> > -- compatible : shall be "arm,scmi"
> > > >> > +- compatible : shall be "arm,scmi" or "arm,scmi-smc"
> > > >> >  - mboxes: List of phandle and mailbox channel specifiers. It
> > > >> > should contain
> > > >> >  	  exactly one or two mailboxes, one for transmitting messages("tx")
> > > >> >  	  and another optional for receiving the notifications("rx") if
> > > >> > @@ -25,6 +25,8 @@ The scmi node with the following properties shall
> > > >> > be under the /firmware/ node.
> > > >> >  	  protocol identifier for a given sub-node.
> > > >> >  - #size-cells : should be '0' as 'reg' property doesn't have any size
> > > >> >  	  associated with it.
> > > >> > +- arm,smc-id : SMC id required when using smc transports
> > > >> > +- arm,hvc-id : HVC id required when using hvc transports
> > > >> >
> > > >> >  Optional properties:
> > > >>
> > > >> Not directly related to DT: Why do we need to distinguish between SMC
> > > >> and HVC?
> > > >
> > > > IIUC you want just one property to get the function ID ? Does that
> > > > align with what you are saying ? I wanted to ask the same question and
> > > > I see no need for 2 different properties.
> > > 
> > > Exactly. Using SMC or HVC should come from the context, and there is
> > > zero
> > > value in having different different IDs, depending on the conduit.
> > > 
> > > We *really* want SMC and HVC to behave the same way. Any attempt to
> > > make them different should just be NAKed.
> > 
> > ok. Then just like psci node,
> > Add a "method" property for each protocol, and add "arm,func-id" to
> > indicate the ID.
> > 
> > How about this?
> 
> Or rather just a function ID, full stop. the conduit *MUST* be inherited
> from the PSCI context.

Absolutely, this is what I was expecting.

Peng,

You have already introduced a compatible for smc/hvc transport
instead of default mailbox, why do you need anything more ? Just
use SMC or HVC conduit from PSCI/SMCCC. I don't think you need anything
more than the function ID.

--
Regards,
Sudeep
