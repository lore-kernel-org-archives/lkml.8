Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7665C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50362137B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjqx5W8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDIH51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:57:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33299 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgDIH51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:57:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay1so3575705plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L7od/SNZMrY/OjIFPZaOv2b3TyvmNPhMcosqFxdfLDI=;
        b=zjqx5W8KkmMneK16/D9nuMPmygTIPqYWf4Vd6eGnm9gqUtAR3j4xQ69VfkXrUrueFJ
         wPPakZoHREs2u/wgG411nGZEm/Y42jUKzHKJxi6KSNP8wUGJeblM4qpVMl5Mud58YCzU
         g+nbcTwV1kb8VpNDz1WuTeZ10EAZ0HPwcdoyPmjHyxE/VzQpQAliTqjYnWaACN+g2L+M
         zKjKsRNm1YGNcORWUHsVXAXhcrgn0pS8OPzTY+CT3/Gsph3YCiRXsusWJEZ7CBFDu3Mi
         YTpCeVvfRTjFi/lVDisiukzfFdX3mIm2pOfazX9Qbb/UpwnJVK/zYP+ipFnxwN3PBN6O
         hrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L7od/SNZMrY/OjIFPZaOv2b3TyvmNPhMcosqFxdfLDI=;
        b=Sj7ryCfYtnPPMFArRb+OuTGq/B/koC1YJGALaCACWwxY14dRwH1f3LGIl+8YTZ8hf4
         dKbbVfs1yctuFea/H02tytVKlocj5mpVXwBLBYfLcrkp+0z86AwJTDunrFRjm/i8/b7p
         uIunqE0C5TwDC5210mWJLI2qcFNkrjPSXw0r2l06+hLApVoMzVopww9WGv6K0AeaDREC
         3Ev9ANmZahcs+tAKxZ+hV5PJNWh1lVbtoFUL0MCsgw/+mw7q3bBJfyx8acKtwvLSGiTe
         5oN9IwaNxGBiA0AKfC/n+TTG2Ec+3JkfASBs66WNuDZCDJdcp9xF9wwqwXU60E4HJ8V7
         qieQ==
X-Gm-Message-State: AGi0Pub5ZPOuHZD13D/p0ib4Z7Iqa8v21QmP1E3mEcXZKAEz3JHy21wa
        JKhvgvJ7//S4FagXUGOfWi0rGw==
X-Google-Smtp-Source: APiQypIbnONC53q1xfm0EUVTCTkmGKZw7M3bRHyS3PLNupv2XFGRAdPfR+MCxXrsAGCMVmpUbkBJig==
X-Received: by 2002:a17:902:db83:: with SMTP id m3mr10079907pld.143.1586419046993;
        Thu, 09 Apr 2020 00:57:26 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id x4sm18314073pfi.202.2020.04.09.00.57.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 00:57:26 -0700 (PDT)
Date:   Thu, 9 Apr 2020 13:27:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     sboyd@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/21] opp: Manage empty OPP tables with clk handle
Message-ID: <20200409075724.7t3bt3oxaxoygldb@vireshk-i7>
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
 <1586353607-32222-2-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586353607-32222-2-git-send-email-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-04-20, 19:16, Rajendra Nayak wrote:
> With OPP core now supporting DVFS for IO devices, we have instances of
> IO devices (same IP block) which require an OPP on some platforms/SoCs

By OPP you mean both freq and voltage here ?

> while just needing to scale the clock on some others.

And only freq here ?

> In order to avoid conditional code in every driver which supports such
> devices (to check for availability of OPPs and then deciding to do
> either dev_pm_opp_set_rate() or clk_set_rate()) add support to manage
> empty OPP tables with a clk handle.

Why can't these devices have an opp table with just rate mentioned in each node
?

> This makes dev_pm_opp_set_rate() equivalent of a clk_set_rate() for
> devices with just a clk and no OPPs specified, and makes
> dev_pm_opp_set_rate(0) bail out without throwing an error.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/opp/core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index ba43e6a..e4f01e7 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -819,6 +819,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  	if (unlikely(!target_freq)) {
>  		if (opp_table->required_opp_tables) {
>  			ret = _set_required_opps(dev, opp_table, NULL);
> +		} else if (!_get_opp_count(opp_table)) {
> +			return 0;

Why should anyone call this with target_freq = 0 ? I know it was required to
drop votes in the above case, but why here ?

>  		} else {
>  			dev_err(dev, "target frequency can't be 0\n");
>  			ret = -EINVAL;
> @@ -849,6 +851,18 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  		goto put_opp_table;
>  	}
>  
> +	/*
> +	 * For IO devices which require an OPP on some platforms/SoCs
> +	 * while just needing to scale the clock on some others
> +	 * we look for empty OPP tables with just a clock handle and
> +	 * scale only the clk. This makes dev_pm_opp_set_rate()
> +	 * equivalent to a clk_set_rate()
> +	 */
> +	if (!_get_opp_count(opp_table)) {
> +		ret = _generic_set_opp_clk_only(dev, clk, freq);
> +		goto put_opp_table;
> +	}
> +

Is this enough? _of_add_opp_table_v2() returns with error if there is no OPP
node within the table. Please give an example of how DT looks for the case you
want to support.

>  	temp_freq = old_freq;
>  	old_opp = _find_freq_ceil(opp_table, &temp_freq);
>  	if (IS_ERR(old_opp)) {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

-- 
viresh
