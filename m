Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A245C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4202224691
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/Fs6l++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgB1Geu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:34:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40168 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgB1Geu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:34:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id t24so985772pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 22:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H06v/GT9nj7/Fe27LeiShYTU4s7PYoRFGJxdUeLF4jk=;
        b=j/Fs6l++dZ9qALBWak3L+c7UXa4IIRLPenWuacNuEQd8dh3UcBTbCvLq9o546UICn3
         lwOjLXjWkV01CTlA8JXRELlPW1aRpgcFw/7OHYdLgBFUFjx0D4ZxDFSD+Gj/720l8LXJ
         OW/OZvqBxYdZrumh3va0nAAytKMaq1z0JFgITQCiXfy44z0D0d2OS52FEmUPTK0GC41r
         m1WodAtFulspPeMqlkk650z8YG3n0iwfGyyXF9emc6VaRNlDiB+ABeHPlHO/tKR2XTsW
         geeAgNNQplWQj+VceArexHJvFizxttahyfdxckRpNRAXwnEhxdGOmszhv6tNuYtO8COY
         hbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H06v/GT9nj7/Fe27LeiShYTU4s7PYoRFGJxdUeLF4jk=;
        b=pbaqaGMVeZmFvIqCZPvylxrI8UW7bcFuFs/roCABu5YdYUUX8ajBd+ga2T3Qyq5psC
         D8zD06gvO/k8TtU/qimDo4FamkOsxPI7TxAOScqEsr+kQPs1YTuWYRS1mBL+04aVbft4
         EfNTsME8WqVoBY5LzoE8GzZnxF+uiTMLRQFKgfrz97AXG1DpQmSEfz4NnUP9CThu6dOB
         lyXM7Pviu0noKsJSIfLJGUIg1bfjCvNd8rX8UM+t4SNKaMVdCqNpMDHt3eeKcFknzw8w
         Wx42q9ysQK5/JQZisLYUGEn8jVCc92IMCOPmNmwQCt7ZSPJsdjUZemkcsdg6VSY1/kLV
         t5ww==
X-Gm-Message-State: APjAAAXUdXUxWoIfLy4SnB3Q3J07CA4HrVhsXE4Y5RQIDecC+KD3+zlO
        ZGq3PNatXgwjpExxBHCvprVioA==
X-Google-Smtp-Source: APXvYqxyhqToHPPmsxUjYcwCyp1GEtdva6uxDKjmSZjjjjLhF2foY+Q+zG+CAqTI2APSlmWFURYZvA==
X-Received: by 2002:a63:2c03:: with SMTP id s3mr2934770pgs.19.1582871687805;
        Thu, 27 Feb 2020 22:34:47 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y5sm9392183pfr.169.2020.02.27.22.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 22:34:46 -0800 (PST)
Date:   Thu, 27 Feb 2020 22:34:44 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sc7180: Enable soc sleep stats
Message-ID: <20200228063444.GA857139@builder>
References: <1582274986-17490-1-git-send-email-mkshah@codeaurora.org>
 <1582274986-17490-4-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582274986-17490-4-git-send-email-mkshah@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 Feb 00:49 PST 2020, Maulik Shah wrote:

> SoC sleep stats provides various low power mode stats.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 8011c5f..eee6d92 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -745,6 +745,11 @@
>  			};
>  		};
>  
> +		rpmh_sleep_stats: soc-sleep-stats@c3f0000 {

I don't see any reason to reference this node, so you should be able to
omit the label(?)

> +			compatible = "qcom,rpmh-sleep-stats";
> +			reg = <0 0xc3f0000 0 0x400>;

Please pad the address to 8 digits and sort the nodes by address.

Regards,
Bjorn

> +		};
> +
>  		tcsr_mutex_regs: syscon@1f40000 {
>  			compatible = "syscon";
>  			reg = <0 0x01f40000 0 0x40000>;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
