Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34235C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 132622075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gR3uh2Rk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgDXFhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726647AbgDXFhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:37:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515F2C09B046
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 22:37:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id ay1so3356534plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 22:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+pEdo7FoT+8rIIkf67cF+HbAagDt9BJysxaSwF5QNvI=;
        b=gR3uh2RkgZKafzMCtjDQgnqKxzdnSwbnGNph9VqDIc/5TxuFkOOEJRxo4ROgDp9fBt
         ckFtsizxYOVyfPkrK0T5q0UqsHxQhw0zgvepKKwYISEPP0vf2Un5lffLleYF8cFhUjIE
         FcFjXC7wcfQG3RkWX0Q4JfBvBOCd0081cZ5kQHaryCSewd5sn+3oVB47VZdY6WLcggz5
         WSeB2QeKjI4Ow11xC6aHyW6cSGnV7gapAFi5e+Lm1VlFgPYwuB2otw1d6zB1wrAMrtN+
         AVBBQRIYP1jaFtefFOQoXBYsUbtWN2N3mYMY2o52yQHvtpLfeucCdMxga5+bk5Dwl9cc
         LSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+pEdo7FoT+8rIIkf67cF+HbAagDt9BJysxaSwF5QNvI=;
        b=lpQmlkJX+TXRVFsDEmROHkL/B1r96OAWKASs0cSfxV+w2Mf9QRarfbkt0xoER97bNP
         fgo/rT98KP59wudDfaTE5MaEnYLljJw5eFVCuQo4sj3hGsspNVHDtJf+15Or6kXZrIJT
         KORKPkQ2b6Q5weNIZXa8NQ3eWNHwicD3COHr9CAHNgW5kNNt08fD0iuYGA92r2k+gms2
         jVRbKX6IEevkV7UyEvy8eZse6QC1Y2v9HxLp5sgO6d/drZKlm9eSnpP1NQMZtNBqJiEA
         Uk+J0+N0kGq6icJmUvsdSHUZb2LNszB/sh5jX6/C4hz+DwgUKMRZdOXSBx1I4TpqDS6e
         ZMFA==
X-Gm-Message-State: AGi0PuaVsAdQfGocAH/VZrG+vn069vqWklIC3s94RTRdjHGppeB41Gjf
        aDpRk8PDxj/lDuhGj49Xmq/ynQ==
X-Google-Smtp-Source: APiQypLEmG4Dhpgbc96eigaH0M+6gvJ2ml+eyScVCRhE0VcMxKP0oupLYOgy/Qsurk5KtHG5Wqy7xQ==
X-Received: by 2002:a17:90a:37a3:: with SMTP id v32mr4764052pjb.2.1587706639783;
        Thu, 23 Apr 2020 22:37:19 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y21sm4424636pfm.219.2020.04.23.22.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 22:37:19 -0700 (PDT)
Date:   Thu, 23 Apr 2020 22:37:48 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 3/3] soc: qcom: rpmh-rsc: Fold WARN_ON() into if condition
Message-ID: <20200424053748.GX20625@builder.lan>
References: <20200424045414.133381-1-swboyd@chromium.org>
 <20200424045414.133381-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424045414.133381-4-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23 Apr 21:54 PDT 2020, Stephen Boyd wrote:

> Move the WARN_ON() into the if condition so the compiler can see that
> the branch is unlikely() and possibly optimize it better.
> 
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/soc/qcom/rpmh-rsc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 462dd267afef..f7763f008e03 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -373,10 +373,8 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
>  
>  	for_each_set_bit(i, &irq_status, BITS_PER_TYPE(u32)) {
>  		req = get_req_from_tcs(drv, i);
> -		if (!req) {
> -			WARN_ON(1);
> +		if (WARN_ON(!req))
>  			goto skip;
> -		}
>  
>  		err = 0;
>  		for (j = 0; j < req->num_cmds; j++) {
> -- 
> Sent by a computer, using git, on the internet
> 
