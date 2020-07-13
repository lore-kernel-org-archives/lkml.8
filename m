Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96510C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D2320771
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArYa7GKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGMTi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgGMTi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:38:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E558C08C5DB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:38:59 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s189so1424886pgc.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m1cPmH+hFXrNBeuHVfceQp+ZKi7rr5KGkoahmXXlTpc=;
        b=ArYa7GKnxfKy/XekmLKd1+ZnWE4Eg6I4UU4+OKmmLrwXdnc56kNSOYjrPaUt099Sls
         u8IB1YtXiKVrsQMMYDO4jSG9wIEv4LLd08ILqh4GKk3KLAHzURA6/Zc2DR8kG6eLs4b7
         BJtW5pmIahiNelrizIOnhJiEU8MIiqa2Ih3PwT3WT7o2OJl4eZCk4O4bIq8fQZspvc59
         25PR4vIo6ZB3LAZCJfYoPNyA51nFnCcjwF4obr42R4BtB4F1pt6WziuffgL7XRzA5ql+
         2AArRgTqKmkuG7T+aED3DUQqWanG71c3x7PjKN4nzo3k9i496q0ugI8tW//+tEJCHRRZ
         J/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m1cPmH+hFXrNBeuHVfceQp+ZKi7rr5KGkoahmXXlTpc=;
        b=R076yKIrArPS0Fx8T9AA03KKHxbSy5b7Hn/7oAJQxx5W0+5+ggd5nAHFcZrG9k/SP+
         yv1Ia6FdNhIwdj4g7qQ4TGcMVJLPzzmlzZvf/McrKN+eDdnmvhytEn7aq4XVxg+SKS/0
         5Z+0kmQw/uXBkUZwFm454utMtfS+KJIvsIQeKRzlHCtRKevS1jnEBT/ZVZONYVPm6fO2
         LaJOIxrbGTLgh9Fdptfk8E8lYUKG5LjFVavnur9REX45MSpBtB8qxvqIZY6txKG6/8eY
         PFt5Hr04VUd64E6GWuPnCIWSh0Gu34bPGKR8WdIEyo5X+pi8FLb4hoZefPOFbI07wrdc
         MF/Q==
X-Gm-Message-State: AOAM533plL87AQsZWXTaSiiTc1KKIKwpfQ0XSALJYNBnIYBNqOzTV8KC
        AP7lEVGcAxr77DPxnXOAUX6Onw==
X-Google-Smtp-Source: ABdhPJyIR701lX4zcq/mDuzWOuwYckJ9T8VeG8AiIhMwwek593fSPu/by5Xh72G/oC6bd6Jw2x3AQQ==
X-Received: by 2002:a63:cf49:: with SMTP id b9mr570890pgj.31.1594669138418;
        Mon, 13 Jul 2020 12:38:58 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h194sm14224374pfe.201.2020.07.13.12.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:38:57 -0700 (PDT)
Date:   Mon, 13 Jul 2020 12:36:50 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] mailbox: qcom: Add msm8994 apcs compatible
Message-ID: <20200713193650.GC1218486@builder.lan>
References: <20200624150107.76234-1-konradybcio@gmail.com>
 <20200624150107.76234-6-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624150107.76234-6-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24 Jun 08:01 PDT 2020, Konrad Dybcio wrote:

> MSM8994 has an APCS block similar to 8916, but
> with a different clock driver due to the former
> one having 2 clusters.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml   | 1 +
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c                      | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> index 12eff942708d..5125ca3533d2 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> @@ -18,6 +18,7 @@ properties:
>      enum:
>        - qcom,ipq8074-apcs-apps-global
>        - qcom,msm8916-apcs-kpss-global
> +      - qcom,msm8994-apcs-kpss-global
>        - qcom,msm8996-apcs-hmss-global
>        - qcom,msm8998-apcs-hmss-global
>        - qcom,qcs404-apcs-apps-global
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index cec34f0af6ce..6d892136e0e6 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -41,6 +41,10 @@ static const struct qcom_apcs_ipc_data msm8916_apcs_data = {
>  	.offset = 8, .clk_name = "qcom-apcs-msm8916-clk"
>  };
>  
> +static const struct qcom_apcs_ipc_data msm8994_apcs_data = {
> +	.offset = 8, .clk_name = NULL
> +};
> +
>  static const struct qcom_apcs_ipc_data msm8996_apcs_data = {
>  	.offset = 16, .clk_name = NULL
>  };
> @@ -146,6 +150,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>  	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
>  	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq8074_apcs_data },
>  	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
> +	{ .compatible = "qcom,msm8994-apcs-kpss-global", .data = &msm8994_apcs_data },
>  	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = &msm8996_apcs_data },
>  	{ .compatible = "qcom,msm8998-apcs-hmss-global", .data = &msm8998_apcs_data },
>  	{ .compatible = "qcom,qcs404-apcs-apps-global", .data = &msm8916_apcs_data },
> -- 
> 2.27.0
> 
