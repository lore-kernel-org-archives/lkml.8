Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C2AC38A24
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339A320663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bs2Q1swc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgEFMdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728230AbgEFMdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:33:35 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A788C0610D5
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 05:33:35 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id j127so468992vke.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bX4H3SHet9hEaEY2R/CcawnJOfM8m99AFlVmYLIN7Q=;
        b=bs2Q1swc0Z7CzycUADk1C52HoAOiFigeUgR6iRD/IaEVUpqskoK0XPgBV8BxU+JBpU
         uVAxQCebM/+qcl3U5WENV0wtVIrvgZ1X8HgaY3pCMVs3C4PhJnblGlb+yeHmWv+ng0DN
         zwEse5UtkB8MCvu3zF4Sei+D1Od9uLQ4UbBi+s8Xoxf7im9W7oqU++Fd3UpnFrA+5ir4
         N3pKmtFIeL9WLBz0y1HUFaR4k84UYpWHP8wRnvamIChXNQGrMf54fwOBdS6yHTiViZZT
         NZK8iqWatHq+qpWCuWWHNenAMA4k2nSTsMghX3gkzOeubeAx08olb/5gABkjPFSTLVOv
         JXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bX4H3SHet9hEaEY2R/CcawnJOfM8m99AFlVmYLIN7Q=;
        b=F3XWSPTeh/8EENo4FMks9UKhGm1yi117S55PQm7yXrnjSexR4yRbZCgCA2XgdZ1HCG
         +fDudhBEoz0+stcBewbFl9dMijr7ObPbQXmI5HSwk8H5h/zJ/Buft0z/P/xdTZ8oRvMs
         a6xL/X2ygUO9mWbAdXPbC9/yXUlX+JJ/2guaJaaO8VUiKjz27zcVuULGsK1aoheNw8mf
         lNw/mfmRS+Seq5dmNhwi4a76Bcnt5jW9bYpFrcJXmsN4MuQtYFisY47SgFKZSDEhzN98
         uL0UsKvSK8j1dpaV2Xn1n2FwndS9rQE3iX/ZNYX4Yp0XmE1KxhMTr5STPNnR9JKLLy41
         rOPA==
X-Gm-Message-State: AGi0PuZ0sqdUJWpC1qGgFxzOuw2wabZ7O2L/Bd+cKH0Wr3Qc0qnDuq7q
        oeLRHif8yRMvZGWcuYLYqRY0sXN6it04QJbwaIpEpZ8CR/s=
X-Google-Smtp-Source: APiQypJ8ySkE9MyP8aKuTdXnUNaUlx5nX44KM48t0myuuXVzfd9ErOa0ab3rJfFanLwy2XYmgWClPX7dMfg+uL2NO6g=
X-Received: by 2002:a1f:2a13:: with SMTP id q19mr6510137vkq.73.1588768414310;
 Wed, 06 May 2020 05:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200504202243.5476-1-sibis@codeaurora.org> <20200504202243.5476-3-sibis@codeaurora.org>
In-Reply-To: <20200504202243.5476-3-sibis@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 6 May 2020 18:02:59 +0530
Message-ID: <CAHLCerPb+xT7bEZj0f49LKUN60ToUFXEWcCc8K3-FmUXFzP_GQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] cpufreq: blacklist SDM845 in cpufreq-dt-platdev
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nishanth Menon <nm@ti.com>, Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 1:54 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add SDM845 to cpufreq-dt-platdev blacklist since the actual scaling is
> handled by the 'qcom-cpufreq-hw' driver.
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>
> v4:
>  * Updated commit message [Matthias]
>  * Picked up R-b from Matthias
>
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 5c8baf603e056..6ed68bc906f8d 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -131,6 +131,7 @@ static const struct of_device_id blacklist[] __initconst = {
>         { .compatible = "qcom,apq8096", },
>         { .compatible = "qcom,msm8996", },
>         { .compatible = "qcom,qcs404", },
> +       { .compatible = "qcom,sdm845", },
>
>         { .compatible = "st,stih407", },
>         { .compatible = "st,stih410", },
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
