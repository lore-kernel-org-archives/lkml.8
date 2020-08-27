Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A17C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C64020825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuTqcx5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgH0Uob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgH0Uoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 16:44:30 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97166C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:44:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l191so4194453pgd.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s8YaKv8+m9IxoJzXPURkxkMNti4FPntiidcvS+dNgUY=;
        b=AuTqcx5/kcqvu/RdXY9L6Kpt44qohbSUhvPDlmQ4qB34AJKL03FqRsZBY50iDXcQDx
         t1Cv1LMNly9vukmEogwoAm6Uq5ScTw4F1oIbKdg9am6QOeHIkcDzZguCvBI69nHvA5ea
         g5JZ/Iy6LRWAJLyrOAXa3iaQuXP4mDN5z0W+ZvIub7926sW01iKFlCffSLlBm1CZdLfS
         miz6ZUPf13JOOOV/n/ixkafYKqOdMCdNISvXNyMff0uXFB4Q4GCESL5052yiA8cvh+aB
         XMh2e73Kv8UZhA2WqZfy1N7vZnVXoNmOB4GjG5GMxhlRGBvWhAapKK0VLob1FIK0jXzR
         DHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s8YaKv8+m9IxoJzXPURkxkMNti4FPntiidcvS+dNgUY=;
        b=JBJcY2pI7NIxpa19LExgyFciBFk1vtYyUsZmBxsexfx6+FpY+7V6RIwrAPpK/bGFHp
         /qOsAgB6D7M266yU7SYPViPBBaMgz8+TtlClQSvZLpwmZqqTQnkyrxBgFRJbqMDBDWAQ
         3vIVVyTvqpbHn3j84DirmmmQoSPJp2DMrOc4EeVXIvAVfxlP0c4NbHxhaBkdq00NgJvT
         +22rusRQRdOOriwLt8OLAtjVzOBkk+JWeDTNO5QQ8pVMkLSJ0L0fL0oQ8BgoCJN5GERd
         i5XVfvWO9yTNfGPfID5S7a4+GpwP2PfkPLbbUfbrrH7bfCSsK9y6c8wm1K/h8ptKsU1F
         8M+Q==
X-Gm-Message-State: AOAM5324Qq0BM5RRqU58U6/Ry4JMrZwhyZMcC1QHJ6C6UwofMD9SOuHK
        LAzjg65Hh6yy+cwiMUk8PaoBXg==
X-Google-Smtp-Source: ABdhPJzr3/XwrNjyxoR7452oKT/vJGZFAw/XorztPpIgHC6zomZSWDbt/glUOjFbTWsVwwlSzlcV8A==
X-Received: by 2002:a17:902:ee03:: with SMTP id z3mr17839812plb.301.1598561069036;
        Thu, 27 Aug 2020 13:44:29 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v6sm3292828pgf.55.2020.08.27.13.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 13:44:28 -0700 (PDT)
Date:   Thu, 27 Aug 2020 14:44:26 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        coresight@lists.linaro.org
Subject: Re: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to
 avoid the overflow of HiSilicon ETM
Message-ID: <20200827204426.GD22307@xps15>
References: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

On Wed, Aug 19, 2020 at 04:06:37PM +0800, Qi Liu wrote:
> When too much trace information is generated on-chip, the ETM will
> overflow, and cause data loss. This is a common phenomenon on ETM
> devices.
> 
> But sometimes we do not want to lose performance trace data, so we
> suppress the speed of instructions sent from CPU core to ETM to
> avoid the overflow of ETM.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
> 
> Changes since v1:
> - ETM on HiSilicon Hip09 platform supports backpressure, so does
> not need to modify core commit.
> 
>  drivers/hwtracing/coresight/coresight-etm4x.c | 43 +++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 7797a57..7641f89 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -43,6 +43,10 @@ MODULE_PARM_DESC(boot_enable, "Enable tracing on boot");
>  #define PARAM_PM_SAVE_NEVER	  1 /* never save any state */
>  #define PARAM_PM_SAVE_SELF_HOSTED 2 /* save self-hosted state only */
> 
> +#define CORE_COMMIT_CLEAR	0x3000
> +#define CORE_COMMIT_SHIFT	12
> +#define HISI_ETM_AMBA_ID_V1	0x000b6d01
> +
>  static int pm_save_enable = PARAM_PM_SAVE_FIRMWARE;
>  module_param(pm_save_enable, int, 0444);
>  MODULE_PARM_DESC(pm_save_enable,
> @@ -104,11 +108,40 @@ struct etm4_enable_arg {
>  	int rc;
>  };
> 
> +static void etm4_cpu_actlr1_cfg(void *info)
> +{
> +	struct etm4_enable_arg *arg = (struct etm4_enable_arg *)info;
> +	u64 val;
> +
> +	asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
> +	val &= ~CORE_COMMIT_CLEAR;
> +	val |= arg->rc << CORE_COMMIT_SHIFT;
> +	asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val));
> +}
> +
> +static void etm4_config_core_commit(int cpu, int val)
> +{
> +	struct etm4_enable_arg arg = {0};
> +
> +	arg.rc = val;
> +	smp_call_function_single(cpu, etm4_cpu_actlr1_cfg, &arg, 1);

Function etm4_enable/disable_hw() are already running on the CPU they are
supposed to so no need to call smp_call_function_single(). 

> +}
> +
>  static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  {
>  	int i, rc;
> +	struct amba_device *adev;
>  	struct etmv4_config *config = &drvdata->config;
>  	struct device *etm_dev = &drvdata->csdev->dev;
> +	struct device *dev = drvdata->csdev->dev.parent;
> +
> +	adev = container_of(dev, struct amba_device, dev);
> +	/*
> +	 * If ETM device is HiSilicon ETM device, reduce the
> +	 * core-commit to avoid ETM overflow.
> +	 */
> +	if (adev->periphid == HISI_ETM_AMBA_ID_V1)

Do you have any documentation on this back pressure feature?  I doubt this is
specific to Hip09 platform and as such would prefer to have a more generic
approach that works on any platform that supports it. 

Anyone on the CS mailing list that knows what this is about?

Thanks,
Mathieu

> +		etm4_config_core_commit(drvdata->cpu, 1);
> 
>  	CS_UNLOCK(drvdata->base);
> 
> @@ -472,10 +505,20 @@ static void etm4_disable_hw(void *info)
>  {
>  	u32 control;
>  	struct etmv4_drvdata *drvdata = info;
> +	struct device *dev = drvdata->csdev->dev.parent;
>  	struct etmv4_config *config = &drvdata->config;
>  	struct device *etm_dev = &drvdata->csdev->dev;
> +	struct amba_device *adev;
>  	int i;
> 
> +	adev = container_of(dev, struct amba_device, dev);
> +	/*
> +	 * If ETM device is HiSilicon ETM device, resume the
> +	 * core-commit after ETM trace is complete.
> +	 */
> +	if (adev->periphid == HISI_ETM_AMBA_ID_V1)
> +		etm4_config_core_commit(drvdata->cpu, 0);
> +
>  	CS_UNLOCK(drvdata->base);
> 
>  	if (!drvdata->skip_power_up) {
> --
> 2.8.1
> 
