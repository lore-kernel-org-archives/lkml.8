Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B48C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFFD206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGwCpSa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgGUOcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbgGUOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:32:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960AC0619DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:32:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j11so24288844ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ccCSIZDNTg+p8llAxmwk1xbTQUtctPkb4u7L4YN3FhU=;
        b=YGwCpSa9uQHZlKOTp3ggSWPmLN4wu9gdo/R7JrLQSOS/mmgN3z/6CzAhrrvqIuWLKB
         wKaEHpo6LNzr8ww1zPupQtgrDxErj9iN3hqFocryOaHY4O7nRyWYT6AsXZv5VirphXdy
         KgTIOiHBJT6QIFoYxbqMMnesDW4+T/wquWY68zp6UQwi3eCehrGE+rZmG6jWbkLDWG8/
         GmAsfDDjRQOsCQgbfPDDCYkVkGF7BaGAQbjAXpWjEPgz/C2xAk7Y9C3EwYR3B8GCsFY5
         a2ytAf4onEOomoa62ltrjKvTgdC+AjhDEldbX8PM6wS+/koRCB7UvsusERgQCBrZBS++
         smSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ccCSIZDNTg+p8llAxmwk1xbTQUtctPkb4u7L4YN3FhU=;
        b=Q+ypZkQ4o7J9xyaJ7264k/7Oht8f6hULnrcXzUfgjV83mNl5SOnToHeRnezWfsbFqe
         4i/G5DLvxZiwSjgoPe1ibaIcYogAsIi9W8LRKEwZkvwEKj7+jxc2Gp+pD5tfHhrA5xfv
         zGBzT+AD8WmtDmx2gwOh+eKjM8A0ZJ1InCnR24IbAjQxGmVBqOiXsBSl2uJER2vOUYV5
         Pv5hn463TyVAGBoFdArGoANVNwpQnifKwoseOFl1a/uxyUmc8eqaMoOnb1cNvNlixLbe
         /PhV7j4mwTrce8FADUU2Yfeh8ovmwjFTaRASDHmfdtN62mcNK/Z0XpKCUmYTF8g/2B2K
         zj9w==
X-Gm-Message-State: AOAM5301RA89KoWT7TwfhLdGbkOCHpb+NQPraSyW/1OT9Z1n6vr/F2GM
        abe1AfFcNg+DN38cyQUIqxsbXg==
X-Google-Smtp-Source: ABdhPJzCfrnizMtMlg10UOHgQpLbdnlHhI/Gla/f8xk+Qm4TB60yz7n7cAdIV7DxBsDp6NOvE28mKQ==
X-Received: by 2002:a2e:9006:: with SMTP id h6mr12308130ljg.148.1595341919986;
        Tue, 21 Jul 2020 07:31:59 -0700 (PDT)
Received: from [192.168.1.211] ([94.25.229.9])
        by smtp.gmail.com with ESMTPSA id d6sm4537941lja.77.2020.07.21.07.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 07:31:59 -0700 (PDT)
Subject: Re: [PATCH v0] clk: qcom: gcc: Update disp gpll0 branch for 7180/845
To:     Taniya Das <tdas@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        evgreen@google.com
References: <1594796050-14511-1-git-send-email-tdas@codeaurora.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <69dccde9-f577-6266-07cb-820930bace68@linaro.org>
Date:   Tue, 21 Jul 2020 17:31:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594796050-14511-1-git-send-email-tdas@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2020 09:54, Taniya Das wrote:
> The display gpll0 branch clock needs to be always left enabled, thus
> move the clock ops to _aon branch ops.

Does this also apply to sm8250/sm8150?

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>   drivers/clk/qcom/gcc-sc7180.c | 2 +-
>   drivers/clk/qcom/gcc-sdm845.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
> index ca4383e..538677b 100644
> --- a/drivers/clk/qcom/gcc-sc7180.c
> +++ b/drivers/clk/qcom/gcc-sc7180.c
> @@ -1061,7 +1061,7 @@ static struct clk_branch gcc_disp_gpll0_clk_src = {
>   				.hw = &gpll0.clkr.hw,
>   			},
>   			.num_parents = 1,
> -			.ops = &clk_branch2_ops,
> +			.ops = &clk_branch2_aon_ops,
>   		},
>   	},
>   };
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index f6ce888..90f7feb 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2018, 2020, The Linux Foundation. All rights reserved.
>    */
> 
>   #include <linux/kernel.h>
> @@ -1344,7 +1344,7 @@ static struct clk_branch gcc_disp_gpll0_clk_src = {
>   				"gpll0",
>   			},
>   			.num_parents = 1,
> -			.ops = &clk_branch2_ops,
> +			.ops = &clk_branch2_aon_ops,
>   		},
>   	},
>   };
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 


-- 
With best wishes
Dmitry
