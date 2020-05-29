Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50019C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCF3207D3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UU3f4Vlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391715AbgE2DMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390134AbgE2DMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:12:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214F5C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:12:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id g5so505213pfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jVt7Y0VPLTIVWIdqG4Ni/hFAS2PRP6UgxY4YjtcC/uY=;
        b=UU3f4VlcnLowzuDd0XrgoRLDz0ZyvMeRvHgpTqihqosn6x+6ba6gAwJDjb0yC+hK5g
         iDPaIjJ+FhRVlN6Cq1Whi0jeU3760rRVCKr/UIzgqaUL4qdE1PUDTDqpsSJFTaJ95KBc
         uMVZ1bAbHU5QoStDpqrjdoXGVeaTcLuMF4XQivLz9pvM4JPE3GlRw1kAM7hDTi6voC3Q
         jEtPk09zBcE6PHhBjAOFDCQIO2f4tjCaDpyOQn4AlwnWks8n/qkNpwKCSJj+W4OoeX7j
         rjxg8Rk58lzkKG1+CygNMbFdBR6a+ilgOYzxJF93Z62KNNvgFsma4+SWo9I8psOdl/9h
         alfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jVt7Y0VPLTIVWIdqG4Ni/hFAS2PRP6UgxY4YjtcC/uY=;
        b=c838CwPuKau5zSc8UOjHWmu5anownCS/pcnwVOBZ8vfXkJ9alEDMR3HEXz1Kc6udiH
         c/zaI4B0JcEU8HvsEak0LFHT0cBHLFP6W5NVedfmTXrnLQfWJbthXYIGB055wX0e4/Rk
         5COPYV89KE+9N61n57B9qjmov0UOr0cHG97jyfn39PXGOiZcLgpYshw4THzln6dUf8wO
         28vlynIw8zc+MYbLpD34zi0Cu7598kGEHVzfzP2CLBuX+5H8w7b9eEWqmq4T8gV39Ulg
         sKX7hiwWyUj7HMm5bg84WaR6GPEWAzoLO9sD6fjxlyBmlmfiAHDQ2cxofR8xeJzjY6NZ
         kUDQ==
X-Gm-Message-State: AOAM530jRaRkHuZkDXvWIGtg0ra72qPjohEMw+CIQPuemaR+vgmD8luQ
        v7eX4DNucgvVXF1Y4rmy3/lmsA==
X-Google-Smtp-Source: ABdhPJz0JZRQDPVL8F5JhyfBvdcaKuoS64GcJjjDz3tvWP1n8Z1cLkyBBblLbGpDfoO81pvqG+0LbQ==
X-Received: by 2002:aa7:855a:: with SMTP id y26mr6479857pfn.281.1590721959429;
        Thu, 28 May 2020 20:12:39 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id gq19sm5910531pjb.55.2020.05.28.20.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 20:12:38 -0700 (PDT)
Date:   Thu, 28 May 2020 20:11:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mailbox: qcom: Add ipq6018 apcs compatible
Message-ID: <20200529031133.GZ279327@builder.lan>
References: <1590583092-24290-1-git-send-email-sivaprak@codeaurora.org>
 <1590583092-24290-4-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590583092-24290-4-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27 May 05:38 PDT 2020, Sivaprakash Murugesan wrote:

> The Qualcomm ipq6018 has apcs block, add compatible for the same.
> Also, the apcs provides a clock controller functionality similar
> to msm8916 but the clock driver is different.
> 
> Create a child platform device based on the apcs compatible for the
> clock controller functionality.
> 
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index eeebafd..db3f9518 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -45,6 +45,13 @@ static const struct mbox_chan_ops qcom_apcs_ipc_ops = {
>  	.send_data = qcom_apcs_ipc_send_data,
>  };
>  
> +static const struct of_device_id apcs_clk_match_table[] = {
> +	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = "qcom,apss-ipq6018-clk", },
> +	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = "qcom-apcs-msm8916-clk", },
> +	{ .compatible = "qcom,qcs404-apcs-apps-global",  .data = "qcom-apcs-msm8916-clk", },
> +	{}
> +};
> +
>  static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>  {
>  	struct qcom_apcs_ipc *apcs;
> @@ -54,11 +61,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>  	void __iomem *base;
>  	unsigned long i;
>  	int ret;
> -	const struct of_device_id apcs_clk_match_table[] = {
> -		{ .compatible = "qcom,msm8916-apcs-kpss-global", },
> -		{ .compatible = "qcom,qcs404-apcs-apps-global", },
> -		{}
> -	};
> +	const struct of_device_id *clk_device;
>  
>  	apcs = devm_kzalloc(&pdev->dev, sizeof(*apcs), GFP_KERNEL);
>  	if (!apcs)
> @@ -93,11 +96,12 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (of_match_device(apcs_clk_match_table, &pdev->dev)) {
> +	clk_device = of_match_device(apcs_clk_match_table, &pdev->dev);

I think you should replace the direct integer in qcom_apcs_ipc_of_match
with a small struct containing offset and the clock device's name -
allowing the latter to be omitted.

That avoids the apcs_clk_match_table being unreferenced when this is
compiled without CONFIG_OF and it removes the need for two of_device_id
arrays.

Regards,
Bjorn

> +	if (clk_device) {
>  		apcs->clk = platform_device_register_data(&pdev->dev,
> -							  "qcom-apcs-msm8916-clk",
> -							  PLATFORM_DEVID_NONE,
> -							  NULL, 0);
> +							clk_device->data,
> +							PLATFORM_DEVID_NONE,
> +							NULL, 0);
>  		if (IS_ERR(apcs->clk))
>  			dev_err(&pdev->dev, "failed to register APCS clk\n");
>  	}
> @@ -126,6 +130,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>  	{ .compatible = "qcom,sc7180-apss-shared", .data = (void *)12 },
>  	{ .compatible = "qcom,sdm845-apss-shared", .data = (void *)12 },
>  	{ .compatible = "qcom,sm8150-apss-shared", .data = (void *)12 },
> +	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = (void *)8 },
>  	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = (void *)8 },
>  	{}
>  };
> -- 
> 2.7.4
> 
