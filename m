Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6572BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45FB2207C3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IzYnAgcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFVIHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgFVIHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:07:51 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23738C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:07:50 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m2so12333215otr.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s/Z1KJBqPxAzU1XgEqeVVc6digaYa1vATfTaGO5Of4k=;
        b=IzYnAgcxm+xpe2QdoJiV1WLYry/jKp+aUcau2Htwx0SqiXCsVl8puTpiwvJU2tomPp
         gI87/rn9FgEiiOIAAiFW5Cf5p01dhmyviPMchpSQAfyiDJ2tflG8LxVXBN5vIImkdgLc
         Y6lXaX6ajm9dlaWwf2+xVX47m6XKhLl6FyIvrY5jTMUqXvTpymfUB9mJT5uOfHAnE7lh
         89I8Ku04hZOHNaf7cDNWhQnihP9hzOZoniCUwkc6GgdJRysAUNKVo5wr0LPc1l5BI84R
         aDfXLX4nGniF2ZcKansa+sYpnkMQQW6RzeTINilm/e9cowcR2pNo0LIiZd5UNxkC2C1K
         Wlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s/Z1KJBqPxAzU1XgEqeVVc6digaYa1vATfTaGO5Of4k=;
        b=n4lSDTQgrBfn70ZKVfzoe38IcPBBPVCdp2wvV05OFV0Cpps6kkjkHwS9b4l6DHr+en
         p9l6y1k5DPnVRQby+a5rb0/1UnlatEMRxAg86C/VTuh2QcGL6+nPdUrKKs86Q2UbdoNk
         xI8cJv6BB/jgHLQQBvyiAGVdL9D4RGDgL1DwLwzynQTZo06nHjPH6wSRqg8MArkhBChU
         cmffnSrTen2ANUtILb+fNWQgSsCbivbee3+Fbly4LOsFVfNA+PKQmSnDGh+otgRuVFOu
         CVIU/P1Sqru2eTlUXb4Kw4oyXSJRcSniSSPJXXJVZgdtyWYmktowZUHmWE9c1eqmsglr
         yvvA==
X-Gm-Message-State: AOAM533JMgRD1Ic32/I6AcnDsQH90SM5YzHunDz6eknguBb0+8frG5CH
        IlLKlsKRPKCczZSOr69LcCU19Q==
X-Google-Smtp-Source: ABdhPJxuIPLfMi3Tn0La+LJtRlI42WZAm5jHZEVxLV276qtbDnq4/rDsn3UqE9MZ+dKeEP1jO66wGQ==
X-Received: by 2002:a05:6830:1c7b:: with SMTP id s27mr2790946otg.194.1592813269518;
        Mon, 22 Jun 2020 01:07:49 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h23sm3274987oou.14.2020.06.22.01.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 01:07:48 -0700 (PDT)
Date:   Mon, 22 Jun 2020 01:05:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/8] soc: qcom: socinfo: Add socinfo entry for SDM630
Message-ID: <20200622080503.GQ128451@builder.lan>
References: <20200622075749.21925-1-konradybcio@gmail.com>
 <20200622075749.21925-4-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622075749.21925-4-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Jun 00:57 PDT 2020, Konrad Dybcio wrote:

> This patch adds missing soc ID for SDM630.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

Applied

Thanks,
Bjorn

> ---
>  drivers/soc/qcom/socinfo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 5983c6ffb078..705f142ee588 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -202,6 +202,7 @@ static const struct soc_id soc_id[] = {
>  	{ 310, "MSM8996AU" },
>  	{ 311, "APQ8096AU" },
>  	{ 312, "APQ8096SG" },
> +	{ 318, "SDM630" },
>  	{ 321, "SDM845" },
>  	{ 341, "SDA845" },
>  };
> -- 
> 2.27.0
> 
