Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF33C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBB124677
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583820817;
	bh=fSXsWsBt9Dpiq6m0xApVOrGE8qP/RuICGKsCO6DuD3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VON8XFNUEV/3lvue2OxCACcb+XuLd6aFGOCsRxRKBynyJYl63C6Rg8d//FvwvHN/T
	 jZn879aStGtsEy3xJlcSX5sdvEFXJKpOf8AKWgbhrsFU23ulcmxdP7M/heIoUtAPdd
	 jZ+/4IR+woTBl1Cn/rbwtO+KDRMZutERT741A3uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgCJGNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgCJGNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:13:36 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B9DD24673;
        Tue, 10 Mar 2020 06:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583820815;
        bh=fSXsWsBt9Dpiq6m0xApVOrGE8qP/RuICGKsCO6DuD3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDJj3pyXtIEFr8bnNJC3SWe3F/LHSL8v7gsYOtJ5hrBXpCcBCxrKJ3DgKsUfRKIuh
         jRxG4g6jM8fJMIIMEv+sPmCDCNdjBA00KnxirI5cMx94av0V94B5ghGV3pNGXCLXJb
         JrcbgmWH+ZXCpVdHvJ7L2epmR6pOXr7T1QT4PCrc=
Date:   Tue, 10 Mar 2020 14:13:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, sboyd@kernel.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        abel.vesa@nxp.com
Subject: Re: [PATCH v2 09/14] ARM: imx: cpuidle-imx7ulp: Stop mode disallowed
 when HSRUN
Message-ID: <20200310061328.GK15729@dragon>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-10-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582099197-20327-10-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 03:59:52PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When cpu runs in HSRUN mode, cpuidle is not allowed to run into
> Stop mode. So add imx7ulp_get_mode to get thr cpu run mode,
> and use WAIT mode instead, when cpu in HSRUN mode.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Why do you have cpuidle patches in a series titled as adding cpufreq
support?

Shawn

> ---
>  arch/arm/mach-imx/common.h          |  1 +
>  arch/arm/mach-imx/cpuidle-imx7ulp.c | 14 +++++++++++---
>  arch/arm/mach-imx/pm-imx7ulp.c      | 10 ++++++++++
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index 5aa5796cff0e..db542da4fe67 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -104,6 +104,7 @@ void imx6_set_int_mem_clk_lpm(bool enable);
>  void imx6sl_set_wait_clk(bool enter);
>  int imx_mmdc_get_ddr_type(void);
>  int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode);
> +u32 imx7ulp_get_mode(void);
>  
>  void imx_cpu_die(unsigned int cpu);
>  int imx_cpu_kill(unsigned int cpu);
> diff --git a/arch/arm/mach-imx/cpuidle-imx7ulp.c b/arch/arm/mach-imx/cpuidle-imx7ulp.c
> index ca86c967d19e..e7009d10b331 100644
> --- a/arch/arm/mach-imx/cpuidle-imx7ulp.c
> +++ b/arch/arm/mach-imx/cpuidle-imx7ulp.c
> @@ -15,10 +15,18 @@
>  static int imx7ulp_enter_wait(struct cpuidle_device *dev,
>  			    struct cpuidle_driver *drv, int index)
>  {
> -	if (index == 1)
> +	u32 mode;
> +
> +	if (index == 1) {
>  		imx7ulp_set_lpm(ULP_PM_WAIT);
> -	else
> -		imx7ulp_set_lpm(ULP_PM_STOP);
> +	} else {
> +		mode = imx7ulp_get_mode();
> +
> +		if (mode == 3)
> +			imx7ulp_set_lpm(ULP_PM_WAIT);
> +		else
> +			imx7ulp_set_lpm(ULP_PM_STOP);
> +	}
>  
>  	cpu_do_idle();
>  
> diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
> index 393faf1e8382..1410ccfc71bd 100644
> --- a/arch/arm/mach-imx/pm-imx7ulp.c
> +++ b/arch/arm/mach-imx/pm-imx7ulp.c
> @@ -63,6 +63,16 @@ int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
>  	return 0;
>  }
>  
> +u32 imx7ulp_get_mode(void)
> +{
> +	u32 mode;
> +
> +	mode = readl_relaxed(smc1_base + SMC_PMCTRL) & BM_PMCTRL_RUNM;
> +	mode >>= BP_PMCTRL_RUNM;
> +
> +	return mode;
> +}
> +
>  void __init imx7ulp_pm_init(void)
>  {
>  	struct device_node *np;
> -- 
> 2.16.4
> 
