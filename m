Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D9BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E485120772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O7jawF1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgGAV1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:27:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33576 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAV1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:27:30 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061LRP3M036911;
        Wed, 1 Jul 2020 16:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593638845;
        bh=DE8CnC7FP5Y5OqDbKoA3A18OoqaSIir0VAtnrw0TWg0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=O7jawF1cTxy7JuOAcSxI5kB+yWscyqAjMtP60MfTyv3ftaFiKXeyGvUbjHrtpkRVI
         SU9DLoFysPhGrm9bqnHq1lotAYP/bVFmp60E9OvenV9avvIIj+yPdxUsRb69byfGiM
         E55F3XYItd8W1B5SXOcUyrfFhj4bErnI60J6s2jc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061LRPan005461
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 16:27:25 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 16:27:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 16:27:24 -0500
Received: from [10.250.70.56] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061LROhk011033;
        Wed, 1 Jul 2020 16:27:24 -0500
Subject: Re: [PATCH 1/2] remoteproc: ingenic: Move clock handling to
 prepare/unprepare callbacks
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <paul@crapouillou.net>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200630163118.3830422-1-mathieu.poirier@linaro.org>
 <20200630163118.3830422-2-mathieu.poirier@linaro.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <8d089532-19a7-d687-d087-a3a48df16407@ti.com>
Date:   Wed, 1 Jul 2020 16:27:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630163118.3830422-2-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 6/30/20 11:31 AM, Mathieu Poirier wrote:
> This patch moves clock related operations to the remoteproc prepare()
> and unprepare() callbacks so that the PM runtime framework doesn't
> have to be involved needlessly.  This provides a simpler approach and
> requires less code.
> 
> Based on the work from Paul Cercueil published here:
> https://lore.kernel.org/linux-remoteproc/20191116170846.67220-4-paul@crapouillou.net/
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/remoteproc/ingenic_rproc.c | 84 +++++++++---------------------
>   1 file changed, 26 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/remoteproc/ingenic_rproc.c b/drivers/remoteproc/ingenic_rproc.c
> index 189020d77b25..b0fc8eace6ec 100644
> --- a/drivers/remoteproc/ingenic_rproc.c
> +++ b/drivers/remoteproc/ingenic_rproc.c
> @@ -11,7 +11,6 @@
>   #include <linux/io.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> -#include <linux/pm_runtime.h>
>   #include <linux/remoteproc.h>
>   
>   #include "remoteproc_internal.h"
> @@ -62,6 +61,28 @@ struct vpu {
>   	struct device *dev;
>   };
>   
> +static int ingenic_rproc_prepare(struct rproc *rproc)
> +{
> +	struct vpu *vpu = rproc->priv;
> +	int ret;
> +
> +	/* The clocks must be enabled for the firmware to be loaded in TCSM */
> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
> +	if (ret)
> +		dev_err(vpu->dev, "Unable to start clocks: %d", ret);

Minor nit, add a newline character at the end of the trace statement.

With that,
Reviewed-by: Suman Anna <s-anna@ti.com>

> +
> +	return ret;
> +}
> +
> +static int ingenic_rproc_unprepare(struct rproc *rproc)
> +{
> +	struct vpu *vpu = rproc->priv;
> +
> +	clk_bulk_disable_unprepare(ARRAY_SIZE(vpu->clks), vpu->clks);
> +
> +	return 0;
> +}
> +
>   static int ingenic_rproc_start(struct rproc *rproc)
>   {
>   	struct vpu *vpu = rproc->priv;
> @@ -115,6 +136,8 @@ static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
>   }
>   
>   static struct rproc_ops ingenic_rproc_ops = {
> +	.prepare = ingenic_rproc_prepare,
> +	.unprepare = ingenic_rproc_unprepare,
>   	.start = ingenic_rproc_start,
>   	.stop = ingenic_rproc_stop,
>   	.kick = ingenic_rproc_kick,
> @@ -135,16 +158,6 @@ static irqreturn_t vpu_interrupt(int irq, void *data)
>   	return rproc_vq_interrupt(rproc, vring);
>   }
>   
> -static void ingenic_rproc_disable_clks(void *data)
> -{
> -	struct vpu *vpu = data;
> -
> -	pm_runtime_resume(vpu->dev);
> -	pm_runtime_disable(vpu->dev);
> -
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(vpu->clks), vpu->clks);
> -}
> -
>   static int ingenic_rproc_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -206,35 +219,13 @@ static int ingenic_rproc_probe(struct platform_device *pdev)
>   
>   	disable_irq(vpu->irq);
>   
> -	/* The clocks must be enabled for the firmware to be loaded in TCSM */
> -	ret = clk_bulk_prepare_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
> -	if (ret) {
> -		dev_err(dev, "Unable to start clocks\n");
> -		return ret;
> -	}
> -
> -	pm_runtime_irq_safe(dev);
> -	pm_runtime_set_active(dev);
> -	pm_runtime_enable(dev);
> -	pm_runtime_get_sync(dev);
> -	pm_runtime_use_autosuspend(dev);
> -
> -	ret = devm_add_action_or_reset(dev, ingenic_rproc_disable_clks, vpu);
> -	if (ret) {
> -		dev_err(dev, "Unable to register action\n");
> -		goto out_pm_put;
> -	}
> -
>   	ret = devm_rproc_add(dev, rproc);
>   	if (ret) {
>   		dev_err(dev, "Failed to register remote processor\n");
> -		goto out_pm_put;
> +		return ret;
>   	}
>   
> -out_pm_put:
> -	pm_runtime_put_autosuspend(dev);
> -
> -	return ret;
> +	return 0;
>   }
>   
>   static const struct of_device_id ingenic_rproc_of_matches[] = {
> @@ -243,33 +234,10 @@ static const struct of_device_id ingenic_rproc_of_matches[] = {
>   };
>   MODULE_DEVICE_TABLE(of, ingenic_rproc_of_matches);
>   
> -static int __maybe_unused ingenic_rproc_suspend(struct device *dev)
> -{
> -	struct vpu *vpu = dev_get_drvdata(dev);
> -
> -	clk_bulk_disable(ARRAY_SIZE(vpu->clks), vpu->clks);
> -
> -	return 0;
> -}
> -
> -static int __maybe_unused ingenic_rproc_resume(struct device *dev)
> -{
> -	struct vpu *vpu = dev_get_drvdata(dev);
> -
> -	return clk_bulk_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
> -}
> -
> -static const struct dev_pm_ops __maybe_unused ingenic_rproc_pm = {
> -	SET_RUNTIME_PM_OPS(ingenic_rproc_suspend, ingenic_rproc_resume, NULL)
> -};
> -
>   static struct platform_driver ingenic_rproc_driver = {
>   	.probe = ingenic_rproc_probe,
>   	.driver = {
>   		.name = "ingenic-vpu",
> -#ifdef CONFIG_PM
> -		.pm = &ingenic_rproc_pm,
> -#endif
>   		.of_match_table = ingenic_rproc_of_matches,
>   	},
>   };
> 

