Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6533BC3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403D220838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtX5C74m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgBCSOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:14:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43271 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbgBCSOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:14:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so7965387pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IVwPeQjWnavkYSmreRihBcQCqzcKg6GvGjN7vrooL6I=;
        b=DtX5C74mzvURRslkfhYTbEWniKOBw9KEJSR3cHSmYH69gU2PWjEz+geJRVgphNtLbk
         F6crXZWVvIdzHd6d4EfPrqX5UJROzbjwFQrlC+pCco5HrIMJbpSt/hyytkolvwhtzHls
         ldq23iqkmxJ99PzYXSMzkMqK4tpGoQ6IRRR3ogFKz1EO1FCjYrW0lEQf4+3jvUypIUGK
         Ldx1tW5YsUZQaFfqc7+xet3qac+Lxs3QEyJiqXdlNRR6m0hF3vQ1u3isU5mAevs3Zlo2
         UwN564q2bAIua7iFzbObi5cErmMrfSPIuGQjXotXeyxw5IRUtRDGEygMrHBh+HZ1GTBR
         6I5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IVwPeQjWnavkYSmreRihBcQCqzcKg6GvGjN7vrooL6I=;
        b=IMKGzRuZGhtmUo0dEpULrZSJt+VzeQNPT1fR184T1ADWY7NMhHWFol77iIQ+0xCEd7
         lVRAwsReMKpARKwbp3n820XFbNVdRBcQa4oW+D2hS8bE0QCefDfGLKLf1nFukw5uoifW
         VNhdi/8nCI79lWE78lINmyh0CRFmsoXPqD17OO5Ie2CAo6AF/zthnPT0uw4q2BC38ysz
         UmkpEe69jH8ApN9yLzvky1RRLkw1LZR8ky3d33NcthVihG/v0Vftpg6Va7Llh1HTEKZY
         IdJ8Ib+xUYimWRCSEcAFdDFHpxeO7+4veeJxKOMUwmF+FfOQSjweHajqU29I5ELftv9z
         H3jw==
X-Gm-Message-State: APjAAAU20qSEOc2VflRbI3vRtbDZ9Vez/Bn0uedACYlJozL0SvEIAvYG
        Mc8T846ZPGO0p8tYXgOVTpttYw==
X-Google-Smtp-Source: APXvYqxkgpl/cr1CnUuiWJNV7TN7ZP1AWB4FhxD0zzu8YMafzUAWo/WgGlqMypt9vpgwtQ17L8/NPg==
X-Received: by 2002:a63:7949:: with SMTP id u70mr25980401pgc.233.1580753656675;
        Mon, 03 Feb 2020 10:14:16 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z14sm19775106pgj.43.2020.02.03.10.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:14:15 -0800 (PST)
Date:   Mon, 3 Feb 2020 10:14:13 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/7] drivers: thermal: tsens: Add critical interrupt
 support
Message-ID: <20200203181413.GF3948@builder>
References: <cover.1580390127.git.amit.kucheria@linaro.org>
 <932e07a83fed192678b8f718bbae37d0dc83590d.1580390127.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932e07a83fed192678b8f718bbae37d0dc83590d.1580390127.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30 Jan 05:27 PST 2020, Amit Kucheria wrote:

> TSENS IP v2.x adds critical threshold interrupt support for each sensor
> in addition to the upper/lower threshold interrupt. Add support in the
> driver.
> 
> While the critical interrupts themselves aren't currently used by Linux,
> the HW line is also used by the TSENS watchdog. So this patch acts as
> infrastructure to enable watchdog functionality for the TSENS IP.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Please do provide a changelog when respinning your patches.

>  drivers/thermal/qcom/tsens-common.c | 120 ++++++++++++++++++++++++++--
>  drivers/thermal/qcom/tsens-v2.c     |   8 +-
>  drivers/thermal/qcom/tsens.c        |  24 +++++-
>  drivers/thermal/qcom/tsens.h        |  71 ++++++++++++++++
>  4 files changed, 212 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
[..]
> +irqreturn_t tsens_critical_irq_thread(int irq, void *data)
> +{
> +	struct tsens_priv *priv = data;
> +	struct tsens_irq_data d;
> +	unsigned long flags;
> +	int temp, ret, i;
> +
> +	for (i = 0; i < priv->num_sensors; i++) {
> +		const struct tsens_sensor *s = &priv->sensor[i];
> +		u32 hw_id = s->hw_id;
> +
> +		if (IS_ERR(s->tzd))
> +			continue;
> +		if (!tsens_threshold_violated(priv, hw_id, &d))
> +			continue;
> +		ret = get_temp_tsens_valid(s, &temp);
> +		if (ret) {
> +			dev_err(priv->dev, "[%u] %s: error reading sensor\n", hw_id, __func__);
> +			continue;
> +		}
> +
> +		spin_lock_irqsave(&priv->crit_lock, flags);
> +

I see that I failed to follow up on the discussion on the previous
revision. The handler is called from a single thread, so you don't need
a lock to protect the irq handler from itself.

Regards,
Bjorn
