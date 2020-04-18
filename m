Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E5DC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 16:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD54206D9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 16:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AEV0Q8nz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgDRQQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726069AbgDRQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 12:16:00 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDD6C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 09:16:00 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 188so2736240pgj.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ynPs9yCTFEYeEFPuAm4M1vFpAEJsfkM86gMqu119GEg=;
        b=AEV0Q8nz4bM1mFjWrAqmRb5Uk76KbAox9kQ7IFQwCyOcg4niMOPIZarlOuziLxs9sT
         8eBlbsdiLAuvQaOOsmzd6Rd1IBXUTlnsU8eU+7EPHfuc1k+5NDECbQrewH26RG6Q+rEP
         DorsroP/2q/HaX3wOR3bvW5Icj2qS8Z6O1hCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ynPs9yCTFEYeEFPuAm4M1vFpAEJsfkM86gMqu119GEg=;
        b=PiZO7nRDx4yNBJrTlsSUDM1TkSY40Tky8GG24vR/pJM9FwqIYHnqtverxW5oeK5bWj
         948HTlwJyd4Hpa4SbkmYpgtFm30VLMfWxkhLas9sg1ti+wfu/lDfN6z0mjAWiWqmaMTx
         D5ueTJm54kRelJoP6YLacuRDXjFx9iMSxHmnra155KER0g7f0XcCdzq/rpzHAVd21M0u
         6iCDAJ3YWbsCgmH0I/dRZR14NzyAr9MwXV0JV/26OtQXqL/0n2I6Br1QKMNY3LOTIWTJ
         s1mQZcEi5tUxiBvO/gzDGBw4Yf0I175VgVtrBUg73PzSg0rMvp4lXSNorzjA1cjCXiCo
         CDPg==
X-Gm-Message-State: AGi0PubDsf89FJ6b/rLON2exa3kEE7tX4/xxMd24nhtucmLvmapJPQD3
        zDQEdFFGCB9Pf4k2fNn+/KrtXg==
X-Google-Smtp-Source: APiQypLAxdOBnUjU+81Bxrc2gydUAnUtyWqhVEM5QLe5VrX10ZsCZcUUMHZw/dppb11GOcsoMh27YA==
X-Received: by 2002:a65:6704:: with SMTP id u4mr8689747pgf.263.1587226559547;
        Sat, 18 Apr 2020 09:15:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id s129sm9456896pfb.3.2020.04.18.09.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 09:15:58 -0700 (PDT)
Date:   Sat, 18 Apr 2020 09:15:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, swboyd@chromium.org,
        mkshah@codeaurora.org, Evan Green <evgreen@chromium.org>,
        Srinivas Rao L <lsrao@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: rpmh: Dirt can only make you dirtier, not
 cleaner
Message-ID: <20200418161557.GF199755@google.com>
References: <20200417141531.1.Ia4b74158497213eabad7c3d474c50bfccb3f342e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200417141531.1.Ia4b74158497213eabad7c3d474c50bfccb3f342e@changeid>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 02:15:47PM -0700, Douglas Anderson wrote:
> Adding an item into the cache should never be able to make the cache
> cleaner.  Use "|=" rather than "=" to update the dirty flag.
> 
> Fixes: bb7000677a1b ("soc: qcom: rpmh: Update dirty flag only when data changes")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/soc/qcom/rpmh.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index 3abbb08cd6e1..d1626a1328d7 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -151,10 +151,10 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
>  		break;
>  	}
>  
> -	ctrlr->dirty = (req->sleep_val != old_sleep_val ||
> -			req->wake_val != old_wake_val) &&
> -			req->sleep_val != UINT_MAX &&
> -			req->wake_val != UINT_MAX;
> +	ctrlr->dirty |= (req->sleep_val != old_sleep_val ||
> +			 req->wake_val != old_wake_val) &&
> +			 req->sleep_val != UINT_MAX &&
> +			 req->wake_val != UINT_MAX;
>  
>  unlock:
>  	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
