Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807ACC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE04214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4FVLUfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgIJXAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIJXAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:00:17 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3F0C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:00:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so5716507pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2dzaHwMJ36N3lHsGz+9WGLYGK0RTqQ+MiSBCelwtxPg=;
        b=u4FVLUfMVIZYnZvXjz42qfG0Eoar+u9d9ZLO8uqAG0tzNJ/ZOB4v45hFKBOwihqa1N
         LJ0aZ6njXqSNYDoZo6nWbyOlunx/cz+B4RIwxm/XaMIOOZqFmiF7pUe12QWDTOtaedVL
         U6YqIuKI7NmnR9CxXEQX4cXETi2m4zUS36BYpPOU9z2TUlvHKntpYuxDzgkmmG7n/gNM
         Y1t8ftYTwH34RTQa6xm3FGA9S0yfXnb3GbPkVU9rd9GEXk0mQ9lAmLo83QheM6ECUqt+
         Se8LFU1S4HH7tAYP/752cFD2fBTt5Wer6ga8M09/52PSEOyt0+oEVh2rBaOK/RnJ5MGc
         CpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2dzaHwMJ36N3lHsGz+9WGLYGK0RTqQ+MiSBCelwtxPg=;
        b=LwD1SQrs6/z7zbOAShsku2WYeNwzTtxAKIa5TBnj5mY8BTFcUwOIseF8i4M1PqT24Z
         viVqmu4RzUqrgB+1/HXsYewTWGIVd1ROPL55Djo7SqjmvMiBLkvPrSSccEfYdecDo8Dc
         9QyOLGpZgkEj8n40fYCTtOo2BsTMW0AdWVipjY6NkhDAQn7cpwJrzNlQq7wegFpaBnlU
         nd4VoyLiP3udZ0whhR9bHILWIVeEs0la2nd3cusQBuv8K3L7RHBkvlvJgJvdo/yazG6X
         4DxKgE7DQExfQIXS73JLA8uQoumSdSpjzcng1DxU/CWal7fQhd7TyrlXRtN3XxGpDxut
         qGjw==
X-Gm-Message-State: AOAM530cnsjWfH9QuUQw0ddXytxLNzCHJc0DY2witillyPYBd/9vPd+4
        jMKWrLEUfKUE6XrE4nTVDhqR7A==
X-Google-Smtp-Source: ABdhPJz1e7t8bgr2eyVNyfao1sPAS6yivfI5WsxQe0ucf8Bc2Ej0E5qgnTEUVsn/0tQSMK2VZfmL0Q==
X-Received: by 2002:a63:7a57:: with SMTP id j23mr6522515pgn.262.1599778816624;
        Thu, 10 Sep 2020 16:00:16 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 13sm151185pfp.3.2020.09.10.16.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:00:16 -0700 (PDT)
Date:   Thu, 10 Sep 2020 17:00:13 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 15/24] coresight: allow replicator driver to be built
 as module
Message-ID: <20200910230013.GC590446@xps15>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-16-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821034445.967-16-tingwei@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:44:36AM +0800, Tingwei Zhang wrote:
> From: Kim Phillips <kim.phillips@arm.com>
> 
> Allow to build coresight-replicator as modules, for ease of development.
> 
> - Kconfig becomes a tristate, to allow =m
> - combine static and dynamic replicator init into single
>   module_init/exit call
> - add replicator_remove functions, for module unload
> - add a MODULE_DEVICE_TABLE for autoloading on boot
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Co-developed-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Tested-by: Mike Leach <mike.leach@linaro.org>
> ---
>  drivers/hwtracing/coresight/Kconfig           |  5 +-
>  .../coresight/coresight-replicator.c          | 65 ++++++++++++++++++-
>  2 files changed, 67 insertions(+), 3 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index fc48ae086746..f31778dd0b5d 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -17,13 +17,16 @@ menuconfig CORESIGHT
>  
>  if CORESIGHT
>  config CORESIGHT_LINKS_AND_SINKS
> -	bool "CoreSight Link and Sink drivers"
> +	tristate "CoreSight Link and Sink drivers"
>  	help
>  	  This enables support for CoreSight link and sink drivers that are
>  	  responsible for transporting and collecting the trace data
>  	  respectively.  Link and sinks are dynamically aggregated with a trace
>  	  entity at run time to form a complete trace path.
>  
> +	  To compile these drivers as modules, choose M here: the
> +	  modules will be called coresight-funnel and coresight-replicator.
> +
>  config CORESIGHT_LINK_AND_SINK_TMC
>  	tristate "Coresight generic TMC driver"
>  
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 78acf29c49ca..62afdde0e5ea 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -291,6 +291,14 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  	return ret;
>  }
>  
> +static int __exit replicator_remove(struct device *dev)
> +{
> +	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +	coresight_unregister(drvdata->csdev);
> +	return 0;
> +}
> +
>  static int static_replicator_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -310,6 +318,13 @@ static int static_replicator_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int __exit static_replicator_remove(struct platform_device *pdev)
> +{
> +	replicator_remove(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM
>  static int replicator_runtime_suspend(struct device *dev)
>  {
> @@ -343,24 +358,29 @@ static const struct of_device_id static_replicator_match[] = {
>  	{}
>  };
>  
> +MODULE_DEVICE_TABLE(of, static_replicator_match);
> +
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id static_replicator_acpi_ids[] = {
>  	{"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
>  	{}
>  };
> +
> +MODULE_DEVICE_TABLE(acpi, static_replicator_acpi_ids);
>  #endif
>  
>  static struct platform_driver static_replicator_driver = {
>  	.probe          = static_replicator_probe,
> +	.remove         = static_replicator_remove,
>  	.driver         = {
>  		.name   = "coresight-static-replicator",
> +		.owner	= THIS_MODULE,
>  		.of_match_table = of_match_ptr(static_replicator_match),
>  		.acpi_match_table = ACPI_PTR(static_replicator_acpi_ids),
>  		.pm	= &replicator_dev_pm_ops,
>  		.suppress_bind_attrs = true,
>  	},
>  };
> -builtin_platform_driver(static_replicator_driver);
>  
>  static int dynamic_replicator_probe(struct amba_device *adev,
>  				    const struct amba_id *id)
> @@ -368,19 +388,60 @@ static int dynamic_replicator_probe(struct amba_device *adev,
>  	return replicator_probe(&adev->dev, &adev->res);
>  }
>  
> +static int __exit dynamic_replicator_remove(struct amba_device *adev)
> +{
> +	return replicator_remove(&adev->dev);
> +}
> +
>  static const struct amba_id dynamic_replicator_ids[] = {
>  	CS_AMBA_ID(0x000bb909),
>  	CS_AMBA_ID(0x000bb9ec),		/* Coresight SoC-600 */
>  	{},
>  };
>  
> +MODULE_DEVICE_TABLE(amba, dynamic_replicator_ids);
> +
>  static struct amba_driver dynamic_replicator_driver = {
>  	.drv = {
>  		.name	= "coresight-dynamic-replicator",
>  		.pm	= &replicator_dev_pm_ops,
> +		.owner	= THIS_MODULE,
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe		= dynamic_replicator_probe,
> +	.remove         = dynamic_replicator_remove,
>  	.id_table	= dynamic_replicator_ids,
>  };
> -builtin_amba_driver(dynamic_replicator_driver);
> +
> +static int __init replicator_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&static_replicator_driver);
> +	if (ret) {
> +		pr_info("Error registering platform driver\n");
> +		return ret;
> +	}
> +
> +	ret = amba_driver_register(&dynamic_replicator_driver);
> +	if (ret) {
> +		pr_info("Error registering amba driver\n");
> +		platform_driver_unregister(&static_replicator_driver);
> +	}
> +
> +	return ret;
> +}
> +
> +static void __exit replicator_exit(void)
> +{
> +	platform_driver_unregister(&static_replicator_driver);
> +	amba_driver_unregister(&dynamic_replicator_driver);
> +}
> +
> +module_init(replicator_init);
> +module_exit(replicator_exit);
> +
> +MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
> +MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> +MODULE_DESCRIPTION("Arm CoreSight Replicator Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
