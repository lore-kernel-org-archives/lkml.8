Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E07C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0031D2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgBMLEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:04:23 -0500
Received: from foss.arm.com ([217.140.110.172]:45006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbgBMLEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:04:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABF381FB;
        Thu, 13 Feb 2020 03:04:22 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E3233F6CF;
        Thu, 13 Feb 2020 03:04:21 -0800 (PST)
Date:   Thu, 13 Feb 2020 11:04:19 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     peng.fan@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, viresh.kumar@linaro.org,
        f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andre.przywara@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V2 2/2] firmware: arm_scmi: add smc/hvc transports
Message-ID: <20200213110419.GB23374@bogus>
References: <1581566330-1029-1-git-send-email-peng.fan@nxp.com>
 <1581566330-1029-3-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581566330-1029-3-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:58:50AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add SCMI smc/hvc transports support.
> 
> Take smc-id as the 2nd arg, and protocol id as the 2nd arg when
> invokding SMC/HVC. Since we need protocol id, so add this parrameter
> to chan_setup, then smc transport driver could directly use it.
> There is no Rx, only Tx because of smc/hvc not support Rx.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/Makefile  |   2 +-
>  drivers/firmware/arm_scmi/common.h  |   4 +-
>  drivers/firmware/arm_scmi/driver.c  |  11 +-
>  drivers/firmware/arm_scmi/mailbox.c |   2 +-
>  drivers/firmware/arm_scmi/smc.c     | 222 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 234 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/firmware/arm_scmi/smc.c

[...]

>
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index dbec767222e9..65c56328e6d8 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -595,7 +595,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
>  
>  	cinfo->dev = dev;
>  
> -	ret = info->desc->ops->chan_setup(cinfo, info->dev, tx);
> +	ret = info->desc->ops->chan_setup(cinfo, info->dev, prot_id, tx);

Why do you need this ?

>  	if (ret)
>  		return ret;
>  
> @@ -826,7 +829,7 @@ ATTRIBUTE_GROUPS(versions);
>  
>  /* Each compatible listed below must have descriptor associated with it */
>  static const struct of_device_id scmi_of_match[] = {
> -	{ .compatible = "arm,scmi", .data = &scmi_mailbox_desc },
> +	{ .compatible = "arm,scmi",  },

Don't do this, get "arm,scmi-smc"

>  	{ /* Sentinel */ },
>  };
>  
[...]


> +static unsigned long
> +__invoke_scmi_fn_hvc(unsigned long function_id, unsigned long arg0,
> +		     unsigned long arg1, unsigned long arg2,
> +		     unsigned long arg3, unsigned long arg4,
> +		     unsigned long arg5, unsigned long arg6)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4, arg5,
> +		      arg6, &res);
> +
> +	return res.a0;
> +}
> +
> +static unsigned long
> +__invoke_scmi_fn_smc(unsigned long function_id, unsigned long arg0,
> +		     unsigned long arg1, unsigned long arg2,
> +		     unsigned long arg3, unsigned long arg4,
> +		     unsigned long arg5, unsigned long arg6)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4, arg5,
> +		      arg6, &res);
> +
> +	return res.a0;
> +}
> +
> +static int scmi_smc_conduit_method(struct device_node *np)
> +{
> +	const char *method;
> +
> +	if (invoke_scmi_smc_fn)
> +		return 0;
> +
> +	if (of_property_read_string(np, "method", &method))
> +		return -ENXIO;
> +
> +	if (!strcmp("hvc", method)) {
> +		invoke_scmi_smc_fn = __invoke_scmi_fn_hvc;
> +	} else if (!strcmp("smc", method)) {
> +		invoke_scmi_smc_fn = __invoke_scmi_fn_smc;
> +	} else {
> +		pr_warn("invalid \"method\" property: %s\n", method);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +

You don't the above functions

[...]

> +
> +	np = of_find_node_by_path("/psci");
> +	if (!np) {
> +		dev_err(dev, "Not able to find /psci node\n");
> +		return -ENODEV;
> +	}

No need for this as mentioned below.

> +
> +	ret = scmi_smc_conduit_method(np);

Just use arm_smccc_1_1_get_conduit if you want to get the conduit which
I don't think you need. You can just use arm_smccc_1_1_invoke() directly.

--
Regards,
Sudeep
