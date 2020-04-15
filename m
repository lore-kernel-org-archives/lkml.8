Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFDDC38A2C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C66F20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370711AbgDONQv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:16:51 -0400
Received: from foss.arm.com ([217.140.110.172]:45576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505190AbgDONQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:16:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 016531063;
        Wed, 15 Apr 2020 06:16:18 -0700 (PDT)
Received: from bogus (unknown [10.37.12.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D75C3F6C4;
        Wed, 15 Apr 2020 06:16:15 -0700 (PDT)
Date:   Wed, 15 Apr 2020 14:16:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     peng.fan@nxp.com, devicetree@vger.kernel.org, f.fainelli@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V5 2/2] firmware: arm_scmi: add smc/hvc transport
Message-ID: <20200415131612.GC31928@bogus>
References: <1583673879-20714-3-git-send-email-peng.fan@nxp.com>
 <5e96e916.1c69fb81.14365.050b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e96e916.1c69fb81.14365.050b@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:58:58PM +0200, Etienne Carriere wrote:
> Hello Peng,
>
> I  have 2 comments on this change. The main is about using
> arm_smccc_1_1_invoke(). Below some details and I added comments
> inside you patch. The second of on SMC return value, see my
> comment in your patch below.
>
> About arm_smccc_1_1_invoke(), this functon currently relies on PSCI
> driver to define a conduit method but SCMI agent driver does not
> mandate CONFIG_PSCI to be enable.
>

Yes this was discussed and it is done so deliberately. I have added the
build dependency when I merged the patch. There's no dependency on
CONFIG_PSCI.

> Could you add an optional "method" property for "arm,scmi-smc" for platforms
> willing to not rely on PSCI Linux driver? If no property "method" is
> defined in the FDT, invocation relies on arm_smccc_1_1_invoke().
>

Nope, we don't want mixture here. Why is the system not using PSCI/SMCCC ?

> "method" naming mimics what is done in the OP-TEE driver (drivers/tee/optee/).
> Here is a proposal for the documenting property "method" in
> Documentation/arm,scmi.txt:
>
> - method : "smc" or "hvc"
>             Optional property defining the conduit method for to be used
> 	    for invoking the SCMI server in secure world.
> 	    "smc" states instruction SMC #0 is used whereas "hvc" states
> 	    instruction HVC #0 is used.
>
>

It was rejected, you can try your luck with OPTEE :)
We will just use the system conduit here with SCMI for SMC/HVC transport.
Details in previous version of the patch.

[...]

> > +struct scmi_smc {
> > +	struct scmi_chan_info *cinfo;
> > +	struct scmi_shared_mem __iomem *shmem;
> > +	u32 func_id;
> > +};
>
> Add here a field for the secure world invocation function handler:
>
> 	scmi_arm_smccc_invoke_fn *invoke_fn;
>

As stated not needed if we use  arm_smccc_1_1_invoke()

[...]

>
> The SCMI server is likely not to return a errno compliant value.
>
> SMCCC specification states that unsupported function IDs should return signed
> extended -1. I suggest to change the return above with:
>
> 	return res.a0 == ~0 ? -EINVAL : 0;
>

I need to check that.

--
Regards,
Sudeep
