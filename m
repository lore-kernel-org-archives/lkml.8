Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0D7C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29F6208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sG/VHChV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgIJXDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgIJXDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:03:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E00C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:03:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jw11so770273pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tvfyY+EQ1A9se+UIishx7R8RQe/Xnth3cDXfZrzfAiI=;
        b=sG/VHChVy8E26BgXZPFD7WHtcCt35Y6m4EBUHkGV6Hza+p5NDNqRauhertdtTUWdj/
         u44yi+tgriXMMauJNB7BvEXkBMh5P2t2Aiw61/NKuj6f3rhA5WCXJx+5+vnBlHzIqj8c
         VsWc4kKKr8TnM3T3nfe8hWPiEvQjHIxZ+ahTMpAnIXHEidlkEmEH0SAHeT8YpbJxPKiM
         HCr5ZR5Dd9E3GM1pIEUW+0Df8/zCnMSvy+86us5L8qb6Dc46W+Rur2tolH4X7hQnMkf3
         XvgLdVSBd/zAwFct5FszLJJQUgALthkixgpty+L0AWcjLGwtTOXLvuWT1W6vNxhc3vxd
         XdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tvfyY+EQ1A9se+UIishx7R8RQe/Xnth3cDXfZrzfAiI=;
        b=sqYDpJeQlwtgPJhhxokrk1bnPdvXqZCis2+pWNMbkELn0EKdQWX4WezYslZ9u42Saa
         Dp8fqaz+w+XA5EbZDQCe6QoUxOghMlnlB1xu3rlmVAw/rMxP+CRwaZ67OurY0ebHyVkZ
         m+949OEORALnsSBDabKd0QyvKoP7XyP2XgOOtRkQiB+J4vBVQS5Cj4T39OrY8GKmZYPp
         cm9cJH3eFIBiGTDX6P0d/5NUpxuYNTKgMppjV8aW0ir1KkJOrwgJyO8u1l1w7422au+p
         iGzKDQNf3zyaod6yeP9RIU95qOvooT/4QFsu6KNr7STFK4SyrPudE96K6+ff/tO3Maww
         v1xA==
X-Gm-Message-State: AOAM532YVDBP/cbfsuPuAJww89QocVAcJuTeC7te0jgp2cgbReT2Lzsr
        aWYYk9+7rrRlOUxlOZZLQ5PxqA==
X-Google-Smtp-Source: ABdhPJzf7mGPTli6PvrqPcra3i92nCo69WvqRfmz1WJG6xCdM1Juu+ZHG/7k0+WKgLzOJU6pzIXxcQ==
X-Received: by 2002:a17:90a:d152:: with SMTP id t18mr1980927pjw.27.1599778986439;
        Thu, 10 Sep 2020 16:03:06 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g5sm78407pjx.53.2020.09.10.16.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:03:05 -0700 (PDT)
Date:   Thu, 10 Sep 2020 17:03:03 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 21/24] coresight: cti: allow cti to be built as a
 module
Message-ID: <20200910230303.GE590446@xps15>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-22-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821034445.967-22-tingwei@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:44:42AM +0800, Tingwei Zhang wrote:
> Allow to build coresight-cti as a module, for ease of development.
> 
> - Kconfig becomes a tristate, to allow =m
> - append -core to source file name to allow module to
>   be called coresight-cti by the Makefile
> - add an cti_remove function, for module unload
> - move cti_remove_conn_xrefs to cti_remove
> - add a MODULE_DEVICE_TABLE for autoloading on boot
> 
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Tested-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by Mike Leach <mike.leach@linaro.org>
> ---
>  drivers/hwtracing/coresight/Kconfig           |  5 ++++-
>  drivers/hwtracing/coresight/Makefile          |  4 ++--
>  .../{coresight-cti.c => coresight-cti-core.c} | 20 ++++++++++++++++++-
>  .../hwtracing/coresight/coresight-platform.c  |  1 +
>  drivers/hwtracing/coresight/coresight.c       |  1 +
>  5 files changed, 27 insertions(+), 4 deletions(-)
>  rename drivers/hwtracing/coresight/{coresight-cti.c => coresight-cti-core.c} (98%)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index f31778dd0b5d..b04aae2ceecc 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -136,7 +136,7 @@ config CORESIGHT_CPU_DEBUG
>  	  module will be called coresight-cpu-debug.
>  
>  config CORESIGHT_CTI
> -	bool "CoreSight Cross Trigger Interface (CTI) driver"
> +	tristate "CoreSight Cross Trigger Interface (CTI) driver"
>  	depends on ARM || ARM64
>  	help
>  	  This driver provides support for CoreSight CTI and CTM components.
> @@ -147,6 +147,9 @@ config CORESIGHT_CTI
>  	  halt compared to disabling sources and sinks normally in driver
>  	  software.
>  
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called coresight-cti.
> +
>  config CORESIGHT_CTI_INTEGRATION_REGS
>  	bool "Access CTI CoreSight Integration Registers"
>  	depends on CORESIGHT_CTI
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index f2a568b969c4..0359d5a1588f 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -19,6 +19,6 @@ coresight-etm4x-y := coresight-etm4x-core.o coresight-etm4x-sysfs.o
>  obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
>  obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
>  obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
> -obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o \
> -				coresight-cti-platform.o \
> +obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
> +coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>  				coresight-cti-sysfs.o
> diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> similarity index 98%
> rename from drivers/hwtracing/coresight/coresight-cti.c
> rename to drivers/hwtracing/coresight/coresight-cti-core.c
> index ec286d617b73..d6d5419ec21c 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -838,7 +838,6 @@ static void cti_device_release(struct device *dev)
>  	struct cti_drvdata *ect_item, *ect_tmp;
>  
>  	mutex_lock(&ect_mutex);
> -	cti_remove_conn_xrefs(drvdata);
>  	cti_pm_release(drvdata);
>  
>  	/* remove from the list */
> @@ -853,6 +852,18 @@ static void cti_device_release(struct device *dev)
>  	if (drvdata->csdev_release)
>  		drvdata->csdev_release(dev);
>  }
> +static int __exit cti_remove(struct amba_device *adev)
> +{
> +	struct cti_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +
> +	mutex_lock(&ect_mutex);
> +	cti_remove_conn_xrefs(drvdata);
> +	mutex_unlock(&ect_mutex);
> +
> +	coresight_unregister(drvdata->csdev);
> +
> +	return 0;

Once again my recommendations from V8 were not followed.

> +}
>  
>  static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>  {
> @@ -973,6 +984,8 @@ static const struct amba_id cti_ids[] = {
>  	{ 0, 0},
>  };
>  
> +MODULE_DEVICE_TABLE(amba, cti_ids);
> +
>  static struct amba_driver cti_driver = {
>  	.drv = {
>  		.name	= "coresight-cti",
> @@ -980,6 +993,7 @@ static struct amba_driver cti_driver = {
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe		= cti_probe,
> +	.remove		= cti_remove,
>  	.id_table	= cti_ids,
>  };
>  
> @@ -1002,3 +1016,7 @@ static void __exit cti_exit(void)
>  
>  module_init(cti_init);
>  module_exit(cti_exit);
> +
> +MODULE_AUTHOR("Mike Leach <mike.leach@linaro.org>");
> +MODULE_DESCRIPTION("Arm CoreSight CTI Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 227e234a2470..3629b7885aca 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -75,6 +75,7 @@ coresight_find_csdev_by_fwnode(struct fwnode_handle *r_fwnode)
>  	}
>  	return csdev;
>  }
> +EXPORT_SYMBOL_GPL(coresight_find_csdev_by_fwnode);
>  
>  #ifdef CONFIG_OF
>  static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 6c9f6930b8b8..668963b4b7d4 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -288,6 +288,7 @@ void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
>  	csdev->ect_dev = ect_csdev;
>  	mutex_unlock(&coresight_mutex);
>  }
> +EXPORT_SYMBOL_GPL(coresight_set_assoc_ectdev_mutex);
>  
>  static int coresight_enable_sink(struct coresight_device *csdev,
>  				 u32 mode, void *data)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
