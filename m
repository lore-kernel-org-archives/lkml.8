Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553CCC2D0F9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BD220740
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PqfkBtYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgELU0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 16:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726081AbgELU0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:26:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68D7C05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 13:21:05 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s69so1804551pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 13:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=72idvkPptmj1azU8rAtl48UwMaAUDdF2tMlyiTXbnO4=;
        b=PqfkBtYQ1kGKKPCnNm4FQaAcD/duxrZ0D+KqZulhbu60V+BUGbU3hkn+7OlOnT7Rvd
         TUuOw5ILHWJELrrGFl9NAjuOfL+avlMHcvT05sn6egYjgVnmjtwN5B4Y5YJmes4f83j2
         jzUB2wKtNIHUs2AzJNj8IAX12teZOpIrsw5OpU02cadd3MzdcvySCv90rrQP/h2FD5nN
         QZ1r1MIMWeFFA970hWjba9RpjQ0M4VmCQtQ6om1dhBKUz97cRWwmNRmnaedj+c2Hpvv3
         aoYUwWwZu72kykMmaDgwibTh+fJ8dRyoDmx4zSqJsCDuDEuhJhSnyPyY/Qfo0PGlvwms
         URYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=72idvkPptmj1azU8rAtl48UwMaAUDdF2tMlyiTXbnO4=;
        b=F1wm7Z4Ml8o+gDAZU1h5woj44HvAGHo3BWv8rIOaHJkObvpFtAqXPOnlcD/Bme7iG5
         5iUwkWDkoWkJIsxRr+IcJeA0Zdl0qU4VW8z9UikCqML2Y6rUVROKG0FzAJ2LL9huFzOB
         2l4K9xu/SGGLnGsXHxWiQd98TUTmYvjcEOIurRb7wmBAm+7gD5Vnj4jaT0/EymGktaRi
         YqLHt9gvMqkGuJEo4bripfYTE9hDts7AXyw/u1EHenaWU09srWYBXNuy+ttLl3AkXvNF
         GcgZhh9NkJwFGGoa5GIrxJxgLYC7V65y41ENM2Rpr9aJl2aTAt7aBtYvJ1jb2dxVH3kq
         ArHQ==
X-Gm-Message-State: AGi0PuY0zhbP++qX1otCLSYcC6LPqIJKbSSPtN5Xa2BmnTNvrxpqUftI
        4H9XikCQf2IXdiHxf0mmovDA2A==
X-Google-Smtp-Source: APiQypLSU4mmFZVr2gVYe8hrtjzekUuVMmUf92oq/XmFxexZYGEEojsaDEN5PnC7TLeYTd7zUpFrmQ==
X-Received: by 2002:a17:90a:80c2:: with SMTP id k2mr30090534pjw.6.1589314865246;
        Tue, 12 May 2020 13:21:05 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u5sm11055229pgi.70.2020.05.12.13.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 13:21:04 -0700 (PDT)
Date:   Tue, 12 May 2020 13:19:31 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 7/8] mailbox: qcom: Add ipq6018 apcs compatible
Message-ID: <20200512201931.GJ2165@builder.lan>
References: <1588573224-3038-1-git-send-email-sivaprak@codeaurora.org>
 <1588573224-3038-8-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588573224-3038-8-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 03 May 23:20 PDT 2020, Sivaprakash Murugesan wrote:

> The Qualcomm ipq6018 has apcs block, add compatible for the same.
> Also, the apcs provides a clock controller functionality similar
> to msm8916 but the clock driver is different.
> 
> Create a child platform device based on the apcs compatible for the
> clock controller functionality.
> 
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index eeebafd..7c0c4b0 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -45,6 +45,16 @@ static const struct mbox_chan_ops qcom_apcs_ipc_ops = {
>  	.send_data = qcom_apcs_ipc_send_data,
>  };
>  
> +static const struct of_device_id apcs_clk_match_table[] = {
> +	{ .compatible = "qcom,msm8916-apcs-kpss-global",
> +	  .data = "qcom-apcs-msm8916-clk", },

These are easier to read if you ignore the 80-char limit.
Unless Jassi's object that is.

> +	{ .compatible = "qcom,qcs404-apcs-apps-global",
> +	  .data = "qcom-apcs-msm8916-clk", },
> +	{ .compatible = "qcom,ipq6018-apcs-apps-global",

Add your entry on top, to maintain sort order.

> +	  .data = "qcom,apss-ipq-clk", },
> +	{}
> +};
> +
>  static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>  {
>  	struct qcom_apcs_ipc *apcs;
> @@ -54,11 +64,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
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
> @@ -93,11 +99,12 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (of_match_device(apcs_clk_match_table, &pdev->dev)) {
> +	clk_device = of_match_device(apcs_clk_match_table, &pdev->dev);

Better use of_device_match_data() and get the string directly (or NULL).

> +	if (clk_device) {
>  		apcs->clk = platform_device_register_data(&pdev->dev,
> -							  "qcom-apcs-msm8916-clk",
> -							  PLATFORM_DEVID_NONE,
> -							  NULL, 0);
> +						(const char *)clk_device->data,
> +						PLATFORM_DEVID_NONE,
> +						NULL, 0);

I didn't apply the patch to look for myself, but please ensure to
maintain indentation to follow the parenthesis on the line before.

>  		if (IS_ERR(apcs->clk))
>  			dev_err(&pdev->dev, "failed to register APCS clk\n");
>  	}
> @@ -127,6 +134,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>  	{ .compatible = "qcom,sdm845-apss-shared", .data = (void *)12 },
>  	{ .compatible = "qcom,sm8150-apss-shared", .data = (void *)12 },
>  	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = (void *)8 },
> +	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = (void *)8 },

Add it one line up and you'll maintain partial sorting...

Regards,
Bjorn

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
> -- 
> 2.7.4
> 
