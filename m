Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9010BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D6C20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cmd08oWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgGOLQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGOLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:16:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334B0C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 04:16:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 207so1963090pfu.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Al8E5HmATuJ+GiI/GL3GJgZoIv0xq0hJd+rjqtG6u28=;
        b=Cmd08oWTVw0Awoc8Fml8J+O9ZGWu3GHbpoTMQzmIpXnJ3M0FqILbarAKC80qKeQ3vY
         vdAlCNIddilloNS8cKdhKPXvfBeU1f//RFbN+wY3YsR9PsvflIm1eUN5mpNdYudM1t1j
         rYDETtx+aaBL3fP8bklgRBrDu8Skx8OKNF5xkG+LizQSf8sGGmOAIx4iphb/9RCuR2u/
         AHbK21dFJ5yMu97xivHwEPLnIs/4ng1vb7/JBrdw21wS33TbfLxeKmwSwOsA4C8cNvVB
         ZcmeaDFb6NCdQ+3GioUaDqAcacMNpTxF97FS6lFKyHAW6M5tF1Nny94FOR77WDVlSd3d
         nhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Al8E5HmATuJ+GiI/GL3GJgZoIv0xq0hJd+rjqtG6u28=;
        b=IeBR5OMB2cEVTM9EmMdc2B9yEh6L0Aao09Wu7i3G6JqXM+ADG0XK3rau3NiSh/0F0b
         jL5Z7FEOqm9LGHlPV28KiCFIOakdv/1ECJ/63/w0t/SlO/EwOQ0tMY58HUOHB7cE7wL1
         hHsxsP5BrNAAFWtI+xZcctaqv71s6bTHRZj39IAYWQkhSHrsGGOL/QdqjWpwU74X7Kod
         CyjcNQ+3sC9w2cETyj9euQx6rCjtSnYpshSftYFgCIRCbYL+z/W2oTXAHyLikfKoKhia
         v9WGJfbOhuGZ/yywbme2R03ZbSYo298ne2hnYTKCp8X2Gl5r51cu6gA+DRci0zk8fpRA
         SBKg==
X-Gm-Message-State: AOAM531vXXmGfbXUkTlJrSHtMNrFUT1qgICa8aIHPJCAyJ1RsG/rOdBb
        D2noP05XSJvgfVm4yP6qIyhtFg==
X-Google-Smtp-Source: ABdhPJwYyn51fkcsmGpAYEj+Ce/SdbgTijjhZogOt1iy4T+cQInWGwNY6/4HUVohxJ+skFofTxZPpA==
X-Received: by 2002:a63:c509:: with SMTP id f9mr7701828pgd.144.1594811794511;
        Wed, 15 Jul 2020 04:16:34 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id o12sm2053461pfu.188.2020.07.15.04.16.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 04:16:33 -0700 (PDT)
Date:   Wed, 15 Jul 2020 16:46:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        mirq-linux@rere.qmqm.pl, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v5 3/4] cpufreq: Add Tegra194 cpufreq
 driver
Message-ID: <20200715111631.o46qgajh56pjkwfo@vireshk-i7>
References: <1594649209-29394-1-git-send-email-sumitg@nvidia.com>
 <1594649209-29394-4-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594649209-29394-4-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-20, 19:36, Sumit Gupta wrote:
> Add support for CPU frequency scaling on Tegra194. The frequency
> of each core can be adjusted by writing a clock divisor value to
> a MSR on the core. The range of valid divisors is queried from
> the BPMP.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/Kconfig.arm        |   6 +
>  drivers/cpufreq/Makefile           |   1 +
>  drivers/cpufreq/tegra194-cpufreq.c | 397 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 404 insertions(+)
>  create mode 100644 drivers/cpufreq/tegra194-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 15c1a12..f3d8f09 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -314,6 +314,12 @@ config ARM_TEGRA186_CPUFREQ
>  	help
>  	  This adds the CPUFreq driver support for Tegra186 SOCs.
>  
> +config ARM_TEGRA194_CPUFREQ
> +	tristate "Tegra194 CPUFreq support"
> +	depends on ARCH_TEGRA && TEGRA_BPMP

Shouldn't this depend on ARCH_TEGRA_194_SOC instead ? And I asked you
to add a default y here itself instead of patch 4/4.

> +	help
> +	  This adds CPU frequency driver support for Tegra194 SOCs.
> +
>  config ARM_TI_CPUFREQ
>  	bool "Texas Instruments CPUFreq support"
>  	depends on ARCH_OMAP2PLUS
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index f6670c4..66b5563 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_ARM_TANGO_CPUFREQ)		+= tango-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
> +obj-$(CONFIG_ARM_TEGRA194_CPUFREQ)	+= tegra194-cpufreq.o
>  obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
>  
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> +static struct cpufreq_frequency_table *
> +init_freq_table(struct platform_device *pdev, struct tegra_bpmp *bpmp,
> +		unsigned int cluster_id)
> +{
> +	struct cpufreq_frequency_table *freq_table;
> +	struct mrq_cpu_ndiv_limits_response resp;
> +	unsigned int num_freqs, ndiv, delta_ndiv;
> +	struct mrq_cpu_ndiv_limits_request req;
> +	struct tegra_bpmp_message msg;
> +	u16 freq_table_step_size;
> +	int err, index;
> +
> +	memset(&req, 0, sizeof(req));
> +	req.cluster_id = cluster_id;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.mrq = MRQ_CPU_NDIV_LIMITS;
> +	msg.tx.data = &req;
> +	msg.tx.size = sizeof(req);
> +	msg.rx.data = &resp;
> +	msg.rx.size = sizeof(resp);
> +
> +	err = tegra_bpmp_transfer(bpmp, &msg);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	/*
> +	 * Make sure frequency table step is a multiple of mdiv to match
> +	 * vhint table granularity.
> +	 */
> +	freq_table_step_size = resp.mdiv *
> +			DIV_ROUND_UP(CPUFREQ_TBL_STEP_HZ, resp.ref_clk_hz);
> +
> +	dev_dbg(&pdev->dev, "cluster %d: frequency table step size: %d\n",
> +		cluster_id, freq_table_step_size);
> +
> +	delta_ndiv = resp.ndiv_max - resp.ndiv_min;
> +
> +	if (unlikely(delta_ndiv == 0))
> +		num_freqs = 1;
> +	else
> +		/* We store both ndiv_min and ndiv_max hence the +1 */
> +		num_freqs = delta_ndiv / freq_table_step_size + 1;

You need {} in the if else blocks here because of the comment here.

> +
> +	num_freqs += (delta_ndiv % freq_table_step_size) ? 1 : 0;
> +
> +	freq_table = devm_kcalloc(&pdev->dev, num_freqs + 1,
> +				  sizeof(*freq_table), GFP_KERNEL);
> +	if (!freq_table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (index = 0, ndiv = resp.ndiv_min;
> +			ndiv < resp.ndiv_max;
> +			index++, ndiv += freq_table_step_size) {
> +		freq_table[index].driver_data = ndiv;
> +		freq_table[index].frequency = map_ndiv_to_freq(&resp, ndiv);
> +	}
> +
> +	freq_table[index].driver_data = resp.ndiv_max;
> +	freq_table[index++].frequency = map_ndiv_to_freq(&resp, resp.ndiv_max);
> +	freq_table[index].frequency = CPUFREQ_TABLE_END;
> +
> +	return freq_table;
> +}
> +
> +static int tegra194_cpufreq_probe(struct platform_device *pdev)
> +{
> +	struct tegra194_cpufreq_data *data;
> +	struct tegra_bpmp *bpmp;
> +	int err, i;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->num_clusters = MAX_CLUSTERS;
> +	data->tables = devm_kcalloc(&pdev->dev, data->num_clusters,
> +				    sizeof(*data->tables), GFP_KERNEL);
> +	if (!data->tables)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	bpmp = tegra_bpmp_get(&pdev->dev);
> +	if (IS_ERR(bpmp))
> +		return PTR_ERR(bpmp);
> +
> +	read_counters_wq = alloc_workqueue("read_counters_wq", __WQ_LEGACY, 1);
> +	if (!read_counters_wq) {
> +		dev_err(&pdev->dev, "fail to create_workqueue\n");
> +		err = -EINVAL;
> +		goto put_bpmp;
> +	}
> +
> +	for (i = 0; i < data->num_clusters; i++) {
> +		data->tables[i] = init_freq_table(pdev, bpmp, i);
> +		if (IS_ERR(data->tables[i])) {
> +			err = PTR_ERR(data->tables[i]);
> +			goto err_free_res;
> +		}
> +	}
> +
> +	tegra194_cpufreq_driver.driver_data = data;
> +
> +	err = cpufreq_register_driver(&tegra194_cpufreq_driver);
> +	if (err)
> +		goto err_free_res;
> +
> +	tegra_bpmp_put(bpmp);
> +
> +	return err;

rather just do:

if (!err)
        goto put_bpmp;

> +
> +err_free_res:
> +	tegra194_cpufreq_free_resources();
> +put_bpmp:
> +	tegra_bpmp_put(bpmp);
> +	return err;
> +}
-- 
viresh
