Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10530C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53DB207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="INS/lYCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgE3JVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgE3JU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:20:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CC4C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 02:20:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q8so1053693pfu.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tFqkLWC2pY58NUrIUJD/QvnAc/AFJ0vbxV6JYXJ+5Jc=;
        b=INS/lYCR2yuP/7lJfdbXSqTPYRANMke3tOVlOeqe8yKCjKTYx9PyI12EiLNKh17Drd
         X3awrenwazzQhc3XH2hlRSQfkBtYIjOxyBtSjN+UNkBaVwbUsMnrq9H/jGcEr8Idw256
         gRADSjFRve8uDJW5GVraPgPuMSfOMdnBIP/4BTX/XwK8VEHXxG6IKBDnEh1lTa4697+o
         YYjZiV1EK+90ud5kW5lycFnNWCXCQkfbYMokF0Q+ttfNy2MEXGVPv4x24sQbzA4kbpUT
         no5MMLsgI31unUK2mBnu3ukuM+xgN6CntN0JY3vKugSnrJJIZTsUgq3J5AdT+NyLyegn
         L2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tFqkLWC2pY58NUrIUJD/QvnAc/AFJ0vbxV6JYXJ+5Jc=;
        b=RFHWls14A6ddaVCiZoNhkNkCHvPVnr/Zy+i0rlYYlW1NrTvVo+EQS8rAC8y3RyFogg
         x1NR6CmRQO1OHOLJWN1K1QxOyLqnSm3TT4dDSp7/htwmrWpl8mAWaFbyvQEPlUQEEQ2e
         JS29lXCMor2b5U41USIaUgDatHlE35HvsyxIHVxGj7WfR9SfALIXLHVUvL8t1350CFhL
         ixmkccW/YYcROMdMiFu8G2xYNXL+8YyiBNhIZCdIJIS+9jHA/HBNKaB2tM7kE0i6F3lB
         vA05MV2O6k+pvD1pszkSmkc7/Y63fzr3YGBMPNwUJV+XOhOXi86enVSC81hX3mtdmfkJ
         ZtqQ==
X-Gm-Message-State: AOAM53364V8r+DXt8FnsXUVEu2/D66DCE9vIUmnmXMfwMernoFsyUHi7
        LTX7A5a5gLKECnZxMtTyuYbGwg==
X-Google-Smtp-Source: ABdhPJyb2NA/vQHCkzHJpBs8Uk/oiz03G2N8vnGHJxnceaSY49hm6wSxb9RTHv26cT8L/AI0gFGljw==
X-Received: by 2002:a63:c848:: with SMTP id l8mr11545514pgi.180.1590830458641;
        Sat, 30 May 2020 02:20:58 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id c12sm1769766pjm.46.2020.05.30.02.20.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 02:20:57 -0700 (PDT)
Date:   Sat, 30 May 2020 14:50:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: avoid uninitialized-variable use
Message-ID: <20200530092052.ksuncmgx3cahokzo@vireshk-i7>
References: <20200529201731.545859-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529201731.545859-1-arnd@arndb.de>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-05-20, 22:17, Arnd Bergmann wrote:
> An uninitialized pointer is passed into another function but
> ignored there:
> 
> drivers/opp/core.c:875:32: error: variable 'opp' is uninitialized when used here [-Werror,-Wuninitialized]
>                 ret = _set_opp_bw(opp_table, opp, dev, true);
>                                              ^~~
> drivers/opp/core.c:849:34: note: initialize the variable 'opp' to silence this warning
>         struct dev_pm_opp *old_opp, *opp;
>                                         ^
> 
> gcc no longer warns about this, but it seems it really should,
> so change the code to just pass a NULL pointer here.
> 
> See-also: 78a5255ffb6a ("Stop the ad-hoc games with -Wno-maybe-initialized")
> Fixes: c57afacc9270 ("opp: Remove bandwidth votes when target_freq is zero")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index df12c3804533..7302f2631f8d 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -872,7 +872,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  			goto put_opp_table;
>  		}
>  
> -		ret = _set_opp_bw(opp_table, opp, dev, true);
> +		ret = _set_opp_bw(opp_table, NULL, dev, true);
>  		if (ret)
>  			return ret;
>  

Not sure why people are still seeing this, I pushed a fix for this 2
days back.

-- 
viresh
