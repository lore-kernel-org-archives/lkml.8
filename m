Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0411C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9506E20BED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBP9+WYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDJB3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 21:29:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35963 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgDJB3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 21:29:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id n10so409193pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 18:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nN8xwvqZ4ahN4tlReVAi/RVQy676gCX473FCAHCL3fg=;
        b=UBP9+WYQjNxRjKr+51/Qa6T9+gHFoX0+gwGNYylPV15IvRDx7YYOcGu72q8lRcX4/w
         xDO0AL5qEJ0F4u12luB9Dgw+Pqjy+GZ4j2nH82BvrQWCf2zxOGvIwrpDOOVnVhHFiF35
         YUhufF6/ix5n/gDXtC1mUIoY3W8AsD1E6isd90H0G/UhCy0zN/ywbRCrn1WVMOdO2N06
         GNIwK3pF8yr1Sru7lb63vBbRaArbOV+hJUeXYhEhjjvEBvsfBt/wIpuz9Ar5s78ASgzy
         mijTJv5KdZSIJJqrNX1Z9YS6uAnp79zjei+j04oM+fTQx2rlZWO9l/HZ0pEwHVrv7Hjl
         wLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nN8xwvqZ4ahN4tlReVAi/RVQy676gCX473FCAHCL3fg=;
        b=hRb9/gBkfoyxKC1TWRKo77hol45KmOy2kq9n93wN/PJJfPip1L13CaorWHfiHMKMUp
         NPM6EFx5N+scFuFI7Felc53XBf4BAh6+EE7Xh83jLcYUmI8fxK6swmteHTJwZlRlmQAW
         63bcRU5XRFVVVs7AYlptw3NabJa6R+rckjwx+bG18R0KiY6IBf05i/HPhO2rC84lJOvi
         k7PiGUu9QXf4/oVbMM8wjdrEUxKVGtCYtp5Vm23ZkTeLtcdvSYq70C+kgMhq4fJzPqfP
         QXncB/EnMnZUEPs0HPg28mJQuSQLDgajqNnLbPjGi5SmZubD4lJX3XiQKP6q49rF+iII
         Kk1g==
X-Gm-Message-State: AGi0PuYziAadApU3nTmRD4/qlCfgqK+Pigw7AH5s3J7O8sVXMrp6T7SY
        zb5Jx75A1eJLyQk3RUfJq53p3xQJXlw=
X-Google-Smtp-Source: APiQypL3buBWpQzlgFFQmY0P9M+5wVLAzIqpm2p8VIUbBN27OoqhVsPZTiuNQoUe8y6dFl1x74NTEg==
X-Received: by 2002:a63:e749:: with SMTP id j9mr2140127pgk.319.1586482150941;
        Thu, 09 Apr 2020 18:29:10 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e187sm329384pfe.143.2020.04.09.18.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 18:29:10 -0700 (PDT)
Date:   Thu, 9 Apr 2020 18:29:19 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     agross@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom_rpm: remove defined but not used
 'pm8921_ftsmps'
Message-ID: <20200410012919.GW20625@builder.lan>
References: <20200409114026.38383-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409114026.38383-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09 Apr 04:40 PDT 2020, Jason Yan wrote:

> Fix the following gcc warning:
> 
> drivers/regulator/qcom_rpm-regulator.c:607:34: warning: ‘pm8921_ftsmps’
> defined but not used [-Wunused-const-variable=]
>  static const struct qcom_rpm_reg pm8921_ftsmps = {
>                                   ^~~~~~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/regulator/qcom_rpm-regulator.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
> index 7fc97f23fcf4..1ee8ec686ed3 100644
> --- a/drivers/regulator/qcom_rpm-regulator.c
> +++ b/drivers/regulator/qcom_rpm-regulator.c
> @@ -604,16 +604,6 @@ static const struct qcom_rpm_reg pm8921_smps = {
>  	.supports_force_mode_bypass = false,
>  };
>  
> -static const struct qcom_rpm_reg pm8921_ftsmps = {
> -	.desc.linear_ranges = ftsmps_ranges,
> -	.desc.n_linear_ranges = ARRAY_SIZE(ftsmps_ranges),
> -	.desc.n_voltages = 101,
> -	.desc.ops = &uV_ops,
> -	.parts = &rpm8960_smps_parts,
> -	.supports_force_mode_auto = true,
> -	.supports_force_mode_bypass = false,
> -};
> -
>  static const struct qcom_rpm_reg pm8921_ncp = {
>  	.desc.linear_ranges = ncp_ranges,
>  	.desc.n_linear_ranges = ARRAY_SIZE(ncp_ranges),
> -- 
> 2.17.2
> 
