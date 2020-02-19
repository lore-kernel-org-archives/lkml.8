Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68CDC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF34207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aO6M0kr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgBSJfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:35:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34235 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgBSJf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:35:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so9337932plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 01:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GCLJlhQbmqtvLX++5mWx+FHf2ZtKUxmqooelutz8LgU=;
        b=aO6M0kr1/raWi+gakS6VlXlIr4daF1fCcZUrrxn+M0nHUsoSbXR3AFySQb/eCMyElX
         LAPT3W1HSXZ+qD7usQqJWCWFoJt0YrEulyvhzKNiDDZGiwSwNVNBJDV+zatkzmZn/wdH
         oBK2eTXGgcPofsjmOGNFv+uPnkvtY3+HaEJLmF1N30J50QTPK88pV5+gToyfTXVwKMWu
         digQVoD3fvlVzVDNS7DRklL6b+Npo5xI/bxkG+QYATPITNf1e0S3O07ktnFTO4zKhcNc
         j8wTDyMj5+OH76h4VaOq8WaprW/cFkKkiSyndvXE9S8F8nrK8y0cv0AqSHv6eAzJON4x
         GPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GCLJlhQbmqtvLX++5mWx+FHf2ZtKUxmqooelutz8LgU=;
        b=QDdN1GXSJLB9RdFFu1u6Ym5OR/+yJ70F/LjF+SzpDaXPK7mq6ZIVuFBcadNxBUTUl+
         3y8u9qiQKPAjf5++LiAMVC6nUl6onrKkY5PBCHzGv34Z32lYFw2r0hetvIOaxEseutoe
         GlRPbxdpz1w2pYAMbmw4vNz+rmdjNwB6SbUa2amzFbqvm/BCigxTIPH8G/7wx2Ps1jSv
         9+yV7bhcZ6rFFD9DeMM084rxYC93E5qNXlzr+ZOaUBN0mb9v/4Ju2xkj458nRVId3L84
         2rWwpJXEXvJx13Njcwr+zkScteDJNPL7y7X09ieSniwXQsxcxKh+KOEgn3SUR8ido5iR
         bMQw==
X-Gm-Message-State: APjAAAUiLDTOm4uqNy465PAh9+mFrD68hF5v50mkVlikseN4Arw2zVPW
        EgoVNcTm1VPDOjMeiJ10W551Aw==
X-Google-Smtp-Source: APXvYqxxfL+nqG1A8dD9hdN+866t39oDu/9xqIUm1q4+NC3N1VUDra5qDxiSB4GF1hGVpJ2+n0Lkdg==
X-Received: by 2002:a17:902:6bcb:: with SMTP id m11mr26229011plt.10.1582104929171;
        Wed, 19 Feb 2020 01:35:29 -0800 (PST)
Received: from localhost ([223.226.55.170])
        by smtp.gmail.com with ESMTPSA id fz21sm1883319pjb.15.2020.02.19.01.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 01:35:28 -0800 (PST)
Date:   Wed, 19 Feb 2020 15:05:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        abel.vesa@nxp.com
Subject: Re: [PATCH v2 10/14] cpufreq: dt: Allow platform specific
 intermediate callbacks
Message-ID: <20200219093526.hexyzhfuirb2lg4m@vireshk-i7>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-11-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582099197-20327-11-git-send-email-peng.fan@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-20, 15:59, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Platforms may need to implement platform specific get_intermediate and
> target_intermediate hooks.
> 
> Update cpufreq-dt driver's platform data to contain those for such
> platforms.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 4 ++++
>  drivers/cpufreq/cpufreq-dt.h | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index d2b5f062a07b..26fe8dfb9ce6 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -363,6 +363,10 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
>  		dt_cpufreq_driver.resume = data->resume;
>  		if (data->suspend)
>  			dt_cpufreq_driver.suspend = data->suspend;
> +		if (data->get_intermediate) {
> +			dt_cpufreq_driver.target_intermediate = data->target_intermediate;
> +			dt_cpufreq_driver.get_intermediate = data->get_intermediate;
> +		}
>  	}
>  
>  	ret = cpufreq_register_driver(&dt_cpufreq_driver);
> diff --git a/drivers/cpufreq/cpufreq-dt.h b/drivers/cpufreq/cpufreq-dt.h
> index a5a45b547d0b..28c8af7ec5ef 100644
> --- a/drivers/cpufreq/cpufreq-dt.h
> +++ b/drivers/cpufreq/cpufreq-dt.h
> @@ -14,6 +14,10 @@ struct cpufreq_policy;
>  struct cpufreq_dt_platform_data {
>  	bool have_governor_per_policy;
>  
> +	unsigned int	(*get_intermediate)(struct cpufreq_policy *policy,
> +					    unsigned int index);
> +	int		(*target_intermediate)(struct cpufreq_policy *policy,
> +					       unsigned int index);

Who calls them ?

-- 
viresh
