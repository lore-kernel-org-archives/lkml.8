Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2FCC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B932137B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k6EEGwGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgHaWAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 18:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHaWAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:00:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB9DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:00:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t9so1460919pfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OUlZUgZzQF5M5m1ib2u3HxHz3gbPIUVDIvDEY7LKaiI=;
        b=k6EEGwGG8A+t9k5+SxAgJCt7cOeB14Z5mhjWfG9+KRaWMEjaLDC7eB5V9DoXUbIEc3
         KPtVmreEVRUPIN3nntzGQ4lTSR59d0puwrm8hmVXvZZmD2K7SiIxhsF5i7qQbpGJ8XCX
         Ao0/6XLROEWlPZlAsAkQ9hBCcXgVT4ELm0UIwQFuphpmh1heNZeaomPQBnpx+bDun4XF
         gGFgmNzw3Q0CDfKHZYyZKQIMYLezxok0iS3RKypaVuBjuX5ALje/WMxoc4uPf2//8wHX
         lIxLOUdoEeUNbUppVkwHJ84tu2Lp8KVWl+rcXm4kWXAUXTSoxhw8Ckgg2mqi/x0aq/qW
         o3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OUlZUgZzQF5M5m1ib2u3HxHz3gbPIUVDIvDEY7LKaiI=;
        b=su4uxTg34qb9UES41aHzO1Zj89157SoF9oo2XxNnHnJ+GdjsIl62q9dvRSCWoGDcFx
         HINWe3wDtrcZu+57+46F049KmFMYWXVeSvLx3qjiHQShOjCRg315peJLK8QdzZN3uE2A
         jOoCBdztXZA939W3jP2JlHBtNQ7+AdEt/kgSlUCRygWL7LYmfRnHqVxa6Jt2tEBzMj6d
         xYQPvpEkF+CHw6FptemFDAPf6gd2N4Dtd+uB9IviS3kjHFJowQwJ6EnPMaJ0AQSPL4ET
         jNwvGoxFeDasW9Lvg3tWc9dIupKhxj8PbF5MbF6E6qimny05v/fcF8QNnywjUk/G2cwm
         ltrg==
X-Gm-Message-State: AOAM531jgXNAfSupTumk/BjlespRQK+HGtupkLu6XbtObhlpQqcITVVH
        rH0DtaQnYDqVlG475iQ4MmnoIw==
X-Google-Smtp-Source: ABdhPJwbwKW/62qODrUd+90mwQkQ7jiGBImGECOqbx+v7/dxn5JhD3gita4ifbw/PBv2I2VwKNVWcg==
X-Received: by 2002:a62:4c7:: with SMTP id 190mr2927607pfe.103.1598911232761;
        Mon, 31 Aug 2020 15:00:32 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r91sm554899pja.56.2020.08.31.15.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 15:00:32 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:00:30 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Al Grant <Al.Grant@arm.com>
Cc:     Qi Liu <liuqi115@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>
Subject: Re: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to
 avoid the overflow of HiSilicon ETM
Message-ID: <20200831220030.GA207013@xps15>
References: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
 <20200827204426.GD22307@xps15>
 <DB7PR08MB3355B59AE058823AEE3B372E86520@DB7PR08MB3355.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR08MB3355B59AE058823AEE3B372E86520@DB7PR08MB3355.eurprd08.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 09:00:16AM +0000, Al Grant wrote:
> Hi Mathieu and CS maintainers,
> 
> > Hi Liu,
> > 
> > On Wed, Aug 19, 2020 at 04:06:37PM +0800, Qi Liu wrote:
> > > When too much trace information is generated on-chip, the ETM will
> > > overflow, and cause data loss. This is a common phenomenon on ETM
> > > devices.
> > >
> > > But sometimes we do not want to lose performance trace data, so we
> > > suppress the speed of instructions sent from CPU core to ETM to avoid
> > > the overflow of ETM.
> > >
> > > Signed-off-by: Qi Liu <liuqi115@huawei.com>
> > > ---
> > >
> > > Changes since v1:
> > > - ETM on HiSilicon Hip09 platform supports backpressure, so does not
> > > need to modify core commit.
> > >
> > >  drivers/hwtracing/coresight/coresight-etm4x.c | 43
> > > +++++++++++++++++++++++++++
> > >  1 file changed, 43 insertions(+)
> > >
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c
> > > b/drivers/hwtracing/coresight/coresight-etm4x.c
> > > index 7797a57..7641f89 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> > > @@ -43,6 +43,10 @@ MODULE_PARM_DESC(boot_enable, "Enable tracing
> > on boot");
> > >  #define PARAM_PM_SAVE_NEVER	  1 /* never save any state */
> > >  #define PARAM_PM_SAVE_SELF_HOSTED 2 /* save self-hosted state only */
> > >
> > > +#define CORE_COMMIT_CLEAR	0x3000
> > > +#define CORE_COMMIT_SHIFT	12
> > > +#define HISI_ETM_AMBA_ID_V1	0x000b6d01
> > > +
> > >  static int pm_save_enable = PARAM_PM_SAVE_FIRMWARE;
> > > module_param(pm_save_enable, int, 0444);
> > > MODULE_PARM_DESC(pm_save_enable, @@ -104,11 +108,40 @@ struct
> > > etm4_enable_arg {
> > >  	int rc;
> > >  };
> > >
> > > +static void etm4_cpu_actlr1_cfg(void *info) {
> > > +	struct etm4_enable_arg *arg = (struct etm4_enable_arg *)info;
> > > +	u64 val;
> > > +
> > > +	asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
> > > +	val &= ~CORE_COMMIT_CLEAR;
> > > +	val |= arg->rc << CORE_COMMIT_SHIFT;
> > > +	asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val)); }
> > > +
> > > +static void etm4_config_core_commit(int cpu, int val) {
> > > +	struct etm4_enable_arg arg = {0};
> > > +
> > > +	arg.rc = val;
> > > +	smp_call_function_single(cpu, etm4_cpu_actlr1_cfg, &arg, 1);
> > 
> > Function etm4_enable/disable_hw() are already running on the CPU they are
> > supposed to so no need to call smp_call_function_single().
> > 
> > > +}
> > > +
> > >  static int etm4_enable_hw(struct etmv4_drvdata *drvdata)  {
> > >  	int i, rc;
> > > +	struct amba_device *adev;
> > >  	struct etmv4_config *config = &drvdata->config;
> > >  	struct device *etm_dev = &drvdata->csdev->dev;
> > > +	struct device *dev = drvdata->csdev->dev.parent;
> > > +
> > > +	adev = container_of(dev, struct amba_device, dev);
> > > +	/*
> > > +	 * If ETM device is HiSilicon ETM device, reduce the
> > > +	 * core-commit to avoid ETM overflow.
> > > +	 */
> > > +	if (adev->periphid == HISI_ETM_AMBA_ID_V1)
> > 
> > Do you have any documentation on this back pressure feature?  I doubt this is
> > specific to Hip09 platform and as such would prefer to have a more generic
> > approach that works on any platform that supports it.
> 
> It's not a standard Arm architecture feature, this is a model-specific register.
> Some cores may be able to throttle throughput under user control,
> but this isn't standardized. It may (as in this case) be something that you
> want to enable whenever you enable ETM - and, I guess, disable whenever
> you disable ETM. It's a bit unclean to have model-specific code in the main
> ETM driver, and names like CORE_COMMIT_CLEAR really ought to be more
> specific, but I don't see that it's more ugly than the model-specific code in
> e.g. arch/arm64/kernel/perf_event.c or its equivalent on other architectures.
> 
> Ideally, a core that has an inherent difficulty generating ETM at full speed,
> i.e. where the ETM can't keep up with the core pipeline, would reduce
> commit rate automatically, and some already do. So if this core needs it
> to be done manually via a system register, we might allow that in the
> same way as we might allow other core-specific actions that need to be
> done to enable ETM.
> 
> There are of course issues with trace overflow at all stages up to and
> including harvesting trace from buffers into perf.data (for which solutions
> might involve DVFS, trace strobing, scheduling etc.), and I am assuming
> this patch is not addressing those but dealing with a very specific concern
> about overflow within the core and its ETM.

Thanks for chiming in on this - very valuable input.

Mathieu

> 
> Al
> 
> 
> > 
> > Anyone on the CS mailing list that knows what this is about?
> > 
> > Thanks,
> > Mathieu
> > 
> > > +		etm4_config_core_commit(drvdata->cpu, 1);
> > >
> > >  	CS_UNLOCK(drvdata->base);
> > >
> > > @@ -472,10 +505,20 @@ static void etm4_disable_hw(void *info)  {
> > >  	u32 control;
> > >  	struct etmv4_drvdata *drvdata = info;
> > > +	struct device *dev = drvdata->csdev->dev.parent;
> > >  	struct etmv4_config *config = &drvdata->config;
> > >  	struct device *etm_dev = &drvdata->csdev->dev;
> > > +	struct amba_device *adev;
> > >  	int i;
> > >
> > > +	adev = container_of(dev, struct amba_device, dev);
> > > +	/*
> > > +	 * If ETM device is HiSilicon ETM device, resume the
> > > +	 * core-commit after ETM trace is complete.
> > > +	 */
> > > +	if (adev->periphid == HISI_ETM_AMBA_ID_V1)
> > > +		etm4_config_core_commit(drvdata->cpu, 0);
> > > +
> > >  	CS_UNLOCK(drvdata->base);
> > >
> > >  	if (!drvdata->skip_power_up) {
> > > --
> > > 2.8.1
> > >
> > _______________________________________________
> > CoreSight mailing list
> > CoreSight@lists.linaro.org
> > https://lists.linaro.org/mailman/listinfo/coresight
