Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D944C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613C6206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvy6L2gN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbgF2TP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731777AbgF2TOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:22 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26D8C08EAC8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:16:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so7836176pgq.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4irVPvy6SLfIHJxFGOTl27eLkGNjnPf7i0OL+P/LA5k=;
        b=gvy6L2gNxq9EwuQLge3KvNqHHwK00gDANooUZvO4v6O5WkSzyTrdIQh/0aKfX2EltN
         BC+F/sMOwIeTzytYh6C+biD3Z0k6ukqbdDxfzaddghnTjVpA5NWIn66UJGhUQht65PyZ
         UeQC58uEadA2EDA5nxAwZTOmY1XiiRXMAqh4qZqk5F0ktgOQ4Giv/rDvhNJX+IvYgcRF
         uyUIijuxIyKFEY98uEPgkKkWVz1lx7Yn194BvXvE9VqaqfoT3h524c71kZLvLyv0Y3xD
         Y9evO5z8oHOrC+f8Jlfh91dni7AyjZR5XVxyL1Ss6Xooxx2IhT7B1txyR0AIA+/7u5mi
         FGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4irVPvy6SLfIHJxFGOTl27eLkGNjnPf7i0OL+P/LA5k=;
        b=msXr0nHsQGlhIJl8LFNq/n8ETtu9nIaPgemG++ywxtHX3VGe+v0hG/seBd5vXoqoXd
         2MBLUobclwwtMZW1LL9nTmhs6S8CT5zL8DY9w5aKXpSwzA14t+9nX3R37hHzRfmi5+oc
         WdHu4s3s9kMfwQY3b64b50m750Sju4xpwwE7pzOJkcL6nDvab2lgI2jax6KsiLi4bHzO
         CTUDU3Gnll0HtOSmQL04BS0SH2RalUL+I2UhPCVwXzY5VHJauM0u3vi0WFR3NtkUQhoW
         nLQ10y6pI97EgeHQlJ/aZ+KS5+ov+UdOXn/0n8A1Ft5vPoIzgV6Z/bzXFUJzB2tUxfSW
         vTPQ==
X-Gm-Message-State: AOAM531llzO5SXAfoe911zzs9WCuBOGnYbSTp2NhHC5cPIYw9o+XZDMx
        ugO6LpiVN3j6CTOYvvIqjBxh4g==
X-Google-Smtp-Source: ABdhPJyWU8GRq0w0MyNAiW2bszj3RcxuYIa7V3PZhOEGRHvN2Ts53LH/NqZxHeCX7T8Kw8KhW0DfLg==
X-Received: by 2002:a63:182:: with SMTP id 124mr8482105pgb.288.1593411402221;
        Sun, 28 Jun 2020 23:16:42 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id m20sm34111505pfk.52.2020.06.28.23.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jun 2020 23:16:41 -0700 (PDT)
Date:   Mon, 29 Jun 2020 11:46:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v4 3/4] cpufreq: Add Tegra194 cpufreq
 driver
Message-ID: <20200629061639.7cwxfi64drkof6yu@vireshk-i7>
References: <1593186236-12760-1-git-send-email-sumitg@nvidia.com>
 <1593186236-12760-4-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593186236-12760-4-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-06-20, 21:13, Sumit Gupta wrote:
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

This will call destroy_workqueue() eventually and it will crash your
kernel.

Apart from this, this stuff looks okay. Don't resend the patch just
yet (and if required, send only this patch using --in-reply-to flag
for git send email). Lets wait for an Ack from Rob for the first two
patches.

> +	}
> +

-- 
viresh
