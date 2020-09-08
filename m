Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EB9C2D0E0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF732087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599585378;
	bh=1aTFK3wrKIl3Mo4Chtk/yn6JQv5X2Nyp1Ci6BW8SyI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q3axuRkmm1bcPTYS13O4Rlb18Uyv9NyLq3fb2qWnBr4G20Wc4864XoqIqY7XW+HOk
	 1tGqSNMGy5FX9Cv+zT6f1R93W80Fiz/jHhwCYfUWPa/SJb5LjPRA1AR3vDr8f0+h0T
	 +i2S7Ra2Qpln0fcf1F+pENYpL/CXHdMPaY2HsR5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbgIHRQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731663AbgIHQSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:18:35 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC6D720759
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 12:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599566457;
        bh=1aTFK3wrKIl3Mo4Chtk/yn6JQv5X2Nyp1Ci6BW8SyI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LIXs/gZyAk9GNt2yixruYAVg2viiTVBEuI5apAI4uewwCfE4DOjVvfgLZ5cKJxvsv
         ZeJi5RHF70a/v8y2yL2XE4AJFnQypOkT+GuZlnt8u8kS+NV55gKpkPCN5Fzdym/vUJ
         tdxG+eTLMaNB0Kfet5yVogz7IQnRR/WFyXLD4lao=
Received: by mail-vs1-f43.google.com with SMTP id x203so8807323vsc.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:00:57 -0700 (PDT)
X-Gm-Message-State: AOAM5337h8l25/2a3K1PZj0Q5BTMaAhu1v4fjOrD2Zn3eY6BJ85z/vuH
        3qkLhPLuw/NI1iGo7yLvYUvZ5pc5qy4En8B6f9Pj5Q==
X-Google-Smtp-Source: ABdhPJyYkWtg85XcWPeyawb3EFV2os5iuaBNJfXoSrodk+wDb1H3FBtK2+2Zl6YHEkrEqZ/LOKC+qbizNv8q7lZ0Xv0=
X-Received: by 2002:a67:985:: with SMTP id 127mr13908841vsj.17.1599566455058;
 Tue, 08 Sep 2020 05:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org> <20200908075716.30357-8-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20200908075716.30357-8-manivannan.sadhasivam@linaro.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Tue, 8 Sep 2020 17:30:44 +0530
X-Gmail-Original-Message-ID: <CAHLCerPKahfGmj_vuuMXzUkqNZq+DVBLxkYqi5Q-D4ae4=8jFQ@mail.gmail.com>
Message-ID: <CAHLCerPKahfGmj_vuuMXzUkqNZq+DVBLxkYqi5Q-D4ae4=8jFQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] cpufreq: qcom-hw: Use devm_platform_ioremap_resource()
 to simplify code
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 1:27 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> devm_platform_ioremap_resource() is the combination of
> platform_get_resource() and devm_ioremap_resource(). Hence, use it to
> simplify the code a bit.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Amit Kucheria <amitk@kernel.org>

> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index c3c397cc3dc6..6eeeb2bd4dfa 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -307,7 +307,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>         struct of_phandle_args args;
>         struct device_node *cpu_np;
>         struct device *cpu_dev;
> -       struct resource *res;
>         void __iomem *base;
>         struct qcom_cpufreq_data *data;
>         const struct of_device_id *match;
> @@ -333,13 +332,9 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>
>         index = args.args[0];
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> -       if (!res)
> -               return -ENODEV;
> -
> -       base = devm_ioremap(dev, res->start, resource_size(res));
> -       if (!base)
> -               return -ENOMEM;
> +       base = devm_platform_ioremap_resource(pdev, index);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
>
>         data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>         if (!data) {
> --
> 2.17.1
>
