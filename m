Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42B721734
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597986126;
	bh=keywDDnmc2BgdhkVQo4jd6Uf3rJXgxmDUgazsUR4kHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1i45Le3AZjEUzHFdXgqYLfPl4GHTy0n40tXrbQBWp1bcaq1WDgp77WCt1QnIy02cm
	 ZxXNLDjtA8v0NoW6bKL0ozjI61T98uEoCt4Cj6G/Y03dCI+7v1G8l5m96Bg9IVcTGL
	 R/d38Pt64lyjbL/xRD8Q58PswClG6Ad+TgPk9a+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgHUFCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 01:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgHUFCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 01:02:04 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C57208E4;
        Fri, 21 Aug 2020 05:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597986124;
        bh=keywDDnmc2BgdhkVQo4jd6Uf3rJXgxmDUgazsUR4kHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jaqjnY1jUD/EE/weN+QRcHhIfwnA6shexdxHlqictJXVnjtmLACrg6OktI6asGzAi
         l2/SrNW89m35FhlEPidgDvvw9CG782isX6FVDeQycw8yu6M+TiLDrWYisPewKjoXSV
         GOV1DP9pXMqZ2lscIl36v3GJ3/Ae7DBM4NbtJvfQ=
Date:   Fri, 21 Aug 2020 10:31:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel: fix CONFIG_PM and CONFIG_PM_SLEEP
 confusion
Message-ID: <20200821050159.GH2639@vkoul-mobl>
References: <20200820140441.9478-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200820140441.9478-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-20, 22:04, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> When CONFIG_PM_SLEEP is not defined, GCC throws compilation warnings:
> 
> drivers/soundwire/intel.c:1816:12: warning: ‘intel_resume’ defined but
> not used [-Wunused-function]
>  1816 | static int intel_resume(struct device *dev)
>       |            ^~~~~~~~~~~~
> 
> drivers/soundwire/intel.c:1697:12: warning: ‘intel_suspend’ defined
> but not used [-Wunused-function]
>  1697 | static int intel_suspend(struct device *dev)
> 
> Fix by adding the missing CONFIG_PM_SLEEP.

Can you rather use __maybe for for these rather than wrapping in another
ifdef, that is the recommended way to do this

Thanks

> Note that we could move code around and use only 2 ifdefs, but this
> will generate conflicts so let's do this when all the pm handling is
> merged.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index dbcbe2708563..a2f0026cb2c1 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1525,7 +1525,7 @@ int intel_master_process_wakeen_event(struct platform_device *pdev)
>   * PM calls
>   */
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  
>  static int intel_suspend(struct device *dev)
>  {
> @@ -1562,6 +1562,9 @@ static int intel_suspend(struct device *dev)
>  
>  	return 0;
>  }
> +#endif
> +
> +#ifdef CONFIG_PM
>  
>  static int intel_suspend_runtime(struct device *dev)
>  {
> @@ -1624,6 +1627,9 @@ static int intel_suspend_runtime(struct device *dev)
>  
>  	return ret;
>  }
> +#endif
> +
> +#ifdef CONFIG_PM_SLEEP
>  
>  static int intel_resume(struct device *dev)
>  {
> @@ -1691,6 +1697,9 @@ static int intel_resume(struct device *dev)
>  
>  	return ret;
>  }
> +#endif
> +
> +#ifdef CONFIG_PM
>  
>  static int intel_resume_runtime(struct device *dev)
>  {
> @@ -1797,7 +1806,6 @@ static int intel_resume_runtime(struct device *dev)
>  
>  	return ret;
>  }
> -
>  #endif
>  
>  static const struct dev_pm_ops intel_pm = {
> -- 
> 2.17.1

-- 
~Vinod
