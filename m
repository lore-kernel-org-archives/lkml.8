Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B150DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885E620575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IVemlTcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406510AbgDNHSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406487AbgDNHS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:18:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18B2C0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:18:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id ay1so4354078plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kNViunjrcbq+TCGIf8cu9QtKaO+3xTAUy0wJQn1ojcQ=;
        b=IVemlTcnko/cPbxzqvhtow7GfBpe8N+UfiS/+WJAiYuDAO9TR8QlmMLhPqcWuB/Zcq
         DNzDDGS3SVVkzGlngPr2k1KI44zQ0QLJfpQcZOGYZG8XpMXST1mHCLL1aX7vJgIM6WCw
         hI/B/BIJpgiZZfEM4HavK5fyyxi2+TUBM3HXc9Nkay8EK2PLxbRrH9HqUkBlxqwLE+FN
         zTD1/HKEEq9Md5SQRyvg/91FKsr5ZC8Gz/3Lvpu6MnIY8VDXkm9VT2E6wkqF9NPZ1oPZ
         RBZmdSZdKP14Kk3B6DUKgD7e/coCQCN1hwbgyMw4W9D87l8zyu7XpntDHTaP6UnpnDtD
         4HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kNViunjrcbq+TCGIf8cu9QtKaO+3xTAUy0wJQn1ojcQ=;
        b=PhW0x43hZd7jR6TwmaAXuel/VNPVZ2wO2R0SivQ/dHQVL0Qjx4oBT9HBfGRgJKHu4W
         XdLcj1L3ruaozk7HgjwfBW6TACmBiauYGg13NZgnWa2DdRTxMsSoKCI03GAuqiSDfKs/
         JHZH7N84AEZvZ1RneI6p5l+RZLe3cRwLtxs2HS7ikRQ09upWK/ZXL4fIzFohN3sbcw0x
         9MKKOPuQB5VRLNyFtJtauSKIl3kIJP4Kf2ReZYY1FzE2HFl2OsV1/R7ksyyypX81kx8q
         2u8CBdobLepVRbSoz1q5kqvfS69ZvV5ayk0YW579FGrl8RxdDw4/8l7nRUp8bxVbC0Sh
         qP6Q==
X-Gm-Message-State: AGi0PuYWHyZa1p2bG1CoTlWHr0flCQlVC0Ha9Fos+meLwf8DLjCzIabK
        9ZgACUnwuaxDW8cvH55rK+nPRIHVULg=
X-Google-Smtp-Source: APiQypI3fTWE+FPRvCAJqw6z2WSdNHQeKfFfKIqQ8O7d9HwUxLT3/sWipQtXaZhfpOWgSY5bXuGyjQ==
X-Received: by 2002:a17:90b:23ce:: with SMTP id md14mr12280363pjb.164.1586848706084;
        Tue, 14 Apr 2020 00:18:26 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id c201sm10480026pfc.73.2020.04.14.00.18.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 00:18:25 -0700 (PDT)
Date:   Tue, 14 Apr 2020 12:48:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] opp: Fixup release of clock when using set/put clkname
Message-ID: <20200414071823.jdhkprtkizyeua23@vireshk-i7>
References: <1586848508-1320-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586848508-1320-1-git-send-email-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-04-20, 12:45, Rajendra Nayak wrote:
> Fixup dev_pm_opp_put_clkname() to check for a valid clock pointer
> before it does a clk_put, since its likely that
> _opp_table_kref_release() has already done a clk_put. Also fixup

kref release is the last thing that happens on the table, it can't get
called after dev_pm_opp_put_clkname().

> _opp_table_kref_release() to set the clock pointer to ERR_PTR(-EINVAL)
> after its done doing a clk_put so dev_pm_opp_put_clkname() can then
> catch it.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/opp/core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e4f01e7..6d064a8 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1061,8 +1061,10 @@ static void _opp_table_kref_release(struct kref *kref)
>  	_of_clear_opp_table(opp_table);
>  
>  	/* Release clk */
> -	if (!IS_ERR(opp_table->clk))
> +	if (!IS_ERR(opp_table->clk)) {
>  		clk_put(opp_table->clk);
> +		opp_table->clk = ERR_PTR(-EINVAL);
> +	}
>  
>  	WARN_ON(!list_empty(&opp_table->opp_list));
>  
> @@ -1744,8 +1746,10 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
>  	/* Make sure there are no concurrent readers while updating opp_table */
>  	WARN_ON(!list_empty(&opp_table->opp_list));
>  
> -	clk_put(opp_table->clk);
> -	opp_table->clk = ERR_PTR(-EINVAL);
> +	if (!IS_ERR(opp_table->clk)) {
> +		clk_put(opp_table->clk);
> +		opp_table->clk = ERR_PTR(-EINVAL);
> +	}
>  
>  	dev_pm_opp_put_opp_table(opp_table);
>  }
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

-- 
viresh
