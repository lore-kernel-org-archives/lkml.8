Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CABEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B1B920874
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjRRJpp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbgFWXBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388099AbgFWXBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:01:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD289C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:01:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j4so125479plk.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SUKYA/zx+5E8AfDw1a6xG4cepErgkB5iNhcXF52h2ZE=;
        b=CjRRJpp7O4KrJBdChXmFiWMm9EG6yH/eap519k/lQPjDkL7zy/FrkSIRCr1qyPBV5W
         csuHCIvUQAygk7FdSASPC++PgXKy6aAVjHkFwKqW446qbCde6rXaDT9dKWJEAfY01Lru
         GLIAQYX0rSyFwpz0swDlJXEFomHt6iTgJ9iZV5ZJKh8REKH6hpGu2LEm+ZF86Sd9JCKn
         4YdrpUjSZUKoO3ATN5vL4adWFhFNf6+HA14FhjfssQdPhKUx5PR5J2mB7KqKo3PRlBZH
         8hKnocdyoaAI5Fdjl3Q8ovP06z0ZAXn8PEQuC2B0IbkzMK7evUilC0A5f71fLvl/HZS5
         6SyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SUKYA/zx+5E8AfDw1a6xG4cepErgkB5iNhcXF52h2ZE=;
        b=X/Ln/NVJYjWwvrJhZaHVrpJOPhG821lMzuzKBrytAhAHAfs3E+/SHxvfOVFShSmGu7
         gF1wAOtphd+LFBNJuOnNameQzC783Z4uXGUAWKztqgCPP7ParNcn9ZM8PzyY3/0tTqJu
         vXMyqaocqjM95jcT9+wi1v3RLLb2PRtsNqW1ougDRg76YxzTSaOzA23W7XwQGD2+7ryx
         EvybUeKRTgrUti6wFkVmC+MZV9vEO/2SyhOozS54McFs07pXQJ6w7FiFpivuZiDMk5WA
         0gI4UsgxqFDX/R90JOTZjS2Mm4hhpCjg2/sAdwaGNHby+AFhvyJnDdk1gW2XrXdwmB2G
         e7pA==
X-Gm-Message-State: AOAM5310W+7ivygjZsC6igoq3aZsPQ/uUcZz/ApV9ip8h/1KjMhzB+ew
        f7Wk3kyJp2bphfT2XydJHWrPSQ==
X-Google-Smtp-Source: ABdhPJzgybR8vzFqX5nxfCrcmfJGlJ4QJ2rFl/bsaxFeggSSpxVo+uVXdeAJm0Uv3jij0Amg8K3HFg==
X-Received: by 2002:a17:902:74c6:: with SMTP id f6mr26218114plt.121.1592953296227;
        Tue, 23 Jun 2020 16:01:36 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s1sm3238410pjp.14.2020.06.23.16.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 16:01:35 -0700 (PDT)
Date:   Tue, 23 Jun 2020 15:58:53 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] soc: qcom: smd-rpm: Add msm8994 compatible
Message-ID: <20200623225853.GF128451@builder.lan>
References: <20200602200407.320908-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602200407.320908-1-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02 Jun 13:04 PDT 2020, Konrad Dybcio wrote:

> Add the compatible for the RPM in msm8994.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

Applied

Thanks,
Bjorn

> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt | 1 +
>  drivers/soc/qcom/smd-rpm.c                                  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
> index 616fddcd09fd..25541a475ead 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
> @@ -23,6 +23,7 @@ resources.
>  		    "qcom,rpm-msm8916"
>  		    "qcom,rpm-msm8974"
>  		    "qcom,rpm-msm8976"
> +		    "qcom,rpm-msm8994"
>  		    "qcom,rpm-msm8998"
>  		    "qcom,rpm-sdm660"
>  		    "qcom,rpm-qcs404"
> diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> index 005dd30c58fa..54eb5cbc05fd 100644
> --- a/drivers/soc/qcom/smd-rpm.c
> +++ b/drivers/soc/qcom/smd-rpm.c
> @@ -233,6 +233,7 @@ static const struct of_device_id qcom_smd_rpm_of_match[] = {
>  	{ .compatible = "qcom,rpm-msm8916" },
>  	{ .compatible = "qcom,rpm-msm8974" },
>  	{ .compatible = "qcom,rpm-msm8976" },
> +	{ .compatible = "qcom,rpm-msm8994" },
>  	{ .compatible = "qcom,rpm-msm8996" },
>  	{ .compatible = "qcom,rpm-msm8998" },
>  	{ .compatible = "qcom,rpm-sdm660" },
> -- 
> 2.26.2
> 
