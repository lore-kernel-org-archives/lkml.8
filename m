Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B83BC2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0A920732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSavr5fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896770AbgDOLLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408849AbgDOLJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:09:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050BBC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:59:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so10609352wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:from:to:cc:subject:date:in-reply-to:references
         :in-reply-to;
        bh=gyOymjuJpKySMZCoUKVOaXwQZFqz9S9M2EkURePP5JQ=;
        b=aSavr5fcI+OXIFlvsLqoQHRmt7boXGXEmcyhWu3T0F/omWnvm4iDIcBBIohbmgnj5W
         JvCt1uK3Qgu3BYPz6Oe9maleNLiKPYVM3LyoQj27hZGEnUktPHRshqd3ReGBuJBbNbTc
         87Y5jNWK0EBZZLyDTy14UnxYUGD+b+1A2lPKjcFpnQrVSPPKyUVE8Wnw72JE/vx3D94U
         jyz3lw/s0r/IJN9epLTv+ldfuM32xCbAaOOPRIlq91RwBHs2Mj/Q0cpk5DRB2gS44219
         3i0XpwtgUrrU3ZrU3rXDP4sG9jeoFYcGRYmPW19rZBq1pV7W88XFq91BqrliFYLSRNZb
         9dAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:in-reply-to
         :references:in-reply-to;
        bh=gyOymjuJpKySMZCoUKVOaXwQZFqz9S9M2EkURePP5JQ=;
        b=jm74Zp+E2JzJblF/Qhb5VWz3c2IeVb3m294ntqK8r4LKuI10ccxmOLbuG3RHHLr9ba
         xFRaDG3iFKEpNQ76f1ZpLf4KpMuCpBFSHnQ8cC0YUV3HFWLuukvW06W+YAR9lTc+tp6b
         OJScFzkYiz2PaxAXefojVWL+31Wnm4Lb4VSe4nOiT4J+5Pl0fk8sKHJ5LanE057/ZU9b
         jUeivPPgrLerCgLq+YuFOkuqa3acj3rt7nEhi6lJaIpYxnIUIH42VkftkGCRiDQyIpNG
         DteJF6b+XZYSZuUFVjcewG9D2wPWT7Ya0yN85GfHp/Ivind2QDGFI+15lfyQD5aKyANx
         zOlA==
X-Gm-Message-State: AGi0PuZM/i458XZypLTp93wQFc+D6Ag+8mx/TVeSPeech10PkfSMA1Mv
        6QLhLWarMrIIhtM26YpPmFnVHw==
X-Google-Smtp-Source: APiQypJztDCWY3SxxxokhuvLaaPLo3CbRWDQ/iFxWNphnpUZe0SQ/R33vBiYdtlOrGu0yYj3ol714Q==
X-Received: by 2002:a1c:7d90:: with SMTP id y138mr4956426wmc.121.1586948375471;
        Wed, 15 Apr 2020 03:59:35 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058702ff002dd4025d621b0504.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:2dd4:25d:621b:504])
        by smtp.gmail.com with ESMTPSA id c83sm20122796wmd.23.2020.04.15.03.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 03:59:34 -0700 (PDT)
Message-ID: <5e96e916.1c69fb81.14365.050b@mx.google.com>
X-Google-Original-Message-ID: <1583673879-20714-3-git-send-email-peng.fan@nxp.com> (raw)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     peng.fan@nxp.com
Cc:     devicetree@vger.kernel.org, f.fainelli@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        sudeep.holla@arm.com, viresh.kumar@linaro.org
Subject: [PATCH V5 2/2] firmware: arm_scmi: add smc/hvc transport
Date:   Wed, 15 Apr 2020 12:58:58 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1583673879-20714-3-git-send-email-peng.fan@nxp.com>
References: <1583673879-20714-3-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1583673879-20714-1-git-send-email-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peng,

I  have 2 comments on this change. The main is about using
arm_smccc_1_1_invoke(). Below some details and I added comments
inside you patch. The second of on SMC return value, see my
comment in your patch below.


About arm_smccc_1_1_invoke(), this functon currently relies on PSCI
driver to define a conduit method but SCMI agent driver does not
mandate CONFIG_PSCI to be enable.

Could you add an optional "method" property for "arm,scmi-smc" for platforms
willing to not rely on PSCI Linux driver? If no property "method" is
defined in the FDT, invocation relies on arm_smccc_1_1_invoke().

"method" naming mimics what is done in the OP-TEE driver (drivers/tee/optee/).
Here is a proposal for the documenting property "method" in 
Documentation/arm,scmi.txt:

- method : "smc" or "hvc"
            Optional property defining the conduit method for to be used
	    for invoking the SCMI server in secure world.
	    "smc" states instruction SMC #0 is used whereas "hvc" states
	    instruction HVC #0 is used.



Regards,
Etienne


> From: Peng Fan <peng.fan@nxp.commm>
> 
> Take arm,smc-id as the 1st arg, leave the other args as zero for now.
> There is no Rx, only Tx because of smc/hvc not support Rx.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> (...)
>
> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> new file mode 100644
> index 000000000000..336168e40f49
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/smc.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Management Interface (SCMI) Message SMC/HVC
> + * Transport driver
> + *
> + * Copyright 2020 NXP
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#include "common.h"
> +
> +/**
> + * struct scmi_smc - Structure representing a SCMI smc transport
> + *
> + * @cinfo: SCMI channel info
> + * @shmem: Transmit/Receive shared memory area
> + * @func_id: smc/hvc call function id
> + */
> +
> +struct scmi_smc {
> +	struct scmi_chan_info *cinfo;
> +	struct scmi_shared_mem __iomem *shmem;
> +	u32 func_id;
> +};

Add here a field for the secure world invocation function handler:

	scmi_arm_smccc_invoke_fn *invoke_fn;

With function proto type defined:

  typedef void (scmi_arm_smccc_invoke_fn)(unsigned long, struct arm_smccc_res *);

And materials to set the invocation hanlder:

/* Simple wrapper functions to be able to use a function pointer */
static void _smccc_smc(unsigned long func_id, struct arm_smccc_res *res)
{
	arm_smccc_smc(func_id, 0, 0, 0, 0, 0, 0, 0, res);
}

static void _smccc_hvc(unsigned long func_id, struct arm_smccc_res *res)
{
        arm_smccc_hvc(func_id, 0, 0, 0, 0, 0, 0, 0, res);
}

static void _smccc_1_1(unsigned long func_id, struct arm_smccc_res *res)
{
	arm_smccc_1_1_invoke(func_id, 0, 0, 0, 0, 0, 0, 0, res);
}

static scmi_arm_smccc_invoke_fn *get_invoke_function(struct device *dev)
{
        const char *method;

        if (device_property_read_string(dev, "method", &method))
		return _smccc_1_1;

        if (!strcmp("hvc", method))
                return _smccc_hvc;

        if (!strcmp("smc", method))
                return _smccc_smc;

        dev_err(dev, "Invalid \"method\" property: %s\n", method);
        return ERR_PTR(-EINVAL);
}
 
> +
> +static DEFINE_MUTEX(smc_mutex);
> +
> +static bool smc_chan_available(struct device *dev, int idx)
> +{
> +	return true;
> +}
> +
> +static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> +			  bool tx)
> +{
> +	struct device *cdev = cinfo->dev;
> +	struct scmi_smc *scmi_info;
> +	resource_size_t size;
> +	struct resource res;
> +	struct device_node *np;
> +	u32 func_id;
> +	int ret;
> +
> +	if (!tx)
> +		return -ENODEV;
> +
> +	scmi_info = devm_kzalloc(dev, sizeof(*scmi_info), GFP_KERNEL);
> +	if (!scmi_info)
> +		return -ENOMEM;
> +
> +	np = of_parse_phandle(cdev->of_node, "shmem", 0> );
> +	if (!np)
> +		np = of_parse_phandle(dev->of_node, "shmem", 0);
> +	ret = of_address_to_resource(np, 0, &res);
> +	of_node_put(np);
> +	if (ret) {
> +		dev_err(cdev, "failed to get SCMI Tx shared memory\n");
> +		return ret;
> +	}
> +
> +	size = resource_size(&res);
> +	scmi_info->shmem = devm_ioremap(dev, res.start, size);
> +	if (!scmi_info->shmem) {
> +		dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	ret = of_property_read_u32(dev->of_node, "arm,smc-id", &func_id);
> +	if (ret < 0)
> +		return ret;

Here to get the handler for the invocation method:

	scmi_info->invoke_fn = get_invoke_function(dev);
	if (IS_ERR(scmi_info->invoke_fn))
		return PTR_ERR(scmi_info->invoke_fn);
 
> +
> +	scmi_info->func_id = func_id;
> +	scmi_info->cinfo = cinfo;
> +	cinfo->transport_info = scmi_info;
> +
> +	return 0;
> +}
> +
> +static int smc_chan_free(int id, void *p, void *data)
> +{
> +	struct scmi_chan_info *cinfo = p;
> +	struct scmi_smc *scmi_info = cinfo->transport_info;
> +
> +	cinfo->transport_info = NULL;
> +	scmi_info->cinfo = NULL;
> +
> +	scmi_free_channel(cinfo, data, id);
> +
> +	return 0;
> +}
> +
> +static int smc_send_message(struct scmi_chan_info *cinfo,
> +			    struct scmi_xfer *xfer)
> +{
> +	struct scmi_smc *scmi_info = cinfo->transport_info;
> +	struct arm_smccc_res res;
> +
> +	mutex_lock(&smc_mutex);
> +
> +	shmem_tx_prepare(scmi_info->shmem, xfer);
> +
> +	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);

Last, here would rahter call the registered handler instead:

	scmi_info->invoke_fn(scmi_info->func_id, &res);


> +	scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info->shmem));
> +
> +	mutex_unlock(&smc_mutex);
> +
> +	return res.a0;


The SCMI server is likely not to return a errno compliant value.

SMCCC specification states that unsupported function IDs should return signed
extended -1. I suggest to change the return above with:

	return res.a0 == ~0 ? -EINVAL : 0;


Regards,
Etienne

> +}
> +
> +static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret)
> +{
> +}
> +
> +static void smc_fetch_response(struct scmi_chan_info *cinfo,
> +			       struct scmi_xfer *xfer)
> +{
> +	struct scmi_smc *scmi_info = cinfo->transport_info;
> +
> +	shmem_fetch_response(scmi_info->shmem, xfer);
> +}
> +
> +static bool
> +smc_poll_done(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
> +{
> +	struct scmi_smc *scmi_info = cinfo->transport_info;
> +
> +	return shmem_poll_done(scmi_info->shmem, xfer);
> +}
> +
> +static struct scmi_transport_ops scmi_smc_ops = {
> +	.chan_available = smc_chan_available,
> +	.chan_setup = smc_chan_setup,
> +	.chan_free = smc_chan_free,
> +	.send_message = smc_send_message,
> +	.mark_txdone = smc_mark_txdone,
> +	.fetch_response = smc_fetch_response,
> +	.poll_done = smc_poll_done,
> +};
> +
> +const struct scmi_desc scmi_smc_desc = {
> +	.ops = &scmi_smc_ops,
> +	.max_rx_timeout_ms = 30,
> +	.max_msg = 1,
> +	.max_msg_size = 128,
> +};
> -- 
> 2.16.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
