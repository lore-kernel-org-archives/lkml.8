Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C13FC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC7820717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j1JlfT0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgGQOso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgGQOsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:48:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990C6C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:48:43 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ls15so6629916pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ewvwyHvp26GZfk5BoEXKNgXoneae17wh39OwVygHCtk=;
        b=j1JlfT0dQrrehzWUtqL3fMmgijzf1zxgG/p0HNrf2EMYGBuZRt85chGztPox9gZTAo
         6qTgm5lLQXEBKku8a0cfZiLXNSuzkCo0QxJD4P9iaj0H45+LRpWy/07y1Y9n8V7Fm/fg
         zfjuvMgfNW+/l77czGDQTcCquJ7294wJRhVqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ewvwyHvp26GZfk5BoEXKNgXoneae17wh39OwVygHCtk=;
        b=BnynFxZPgjEa3/oNJoFiLitG0RkueDV1Wg42s1dL06Wt0ZIGshKA2K/AnGQ9ZRv/Np
         eyk2y3+rguhJmWe79WlVhDT3oNPWflDmLHfBBLTkCjJfR6dTOWzgBwz+nUo/+D7r58tB
         OMLHrPC3jVBghjDNono+U4rWHU1Ko7K6iOaLeZVJxBwDumWZX3rDh4qVM0rdeT2DseQu
         fXYXvlu/Z7bAeCMaIZHorXyOswjxHwQNpI+ykvtX8cmFoh9a50WoYt+3RjN3jACHk9vA
         Vl7W3XdqDjZM5sRrNQaShupoSDkUFETrSI59Wttrit3rZOTrqOC6yRH0XpqE5Dy+Q5+T
         s3oA==
X-Gm-Message-State: AOAM533QcrHBgPg+pJT2+Aj6SLEtqvCuMFBhpJ4nbI2pBDozvZ79jtRK
        bPkc6xortoixsdcrhQLHaa19+FLfucQ=
X-Google-Smtp-Source: ABdhPJyBymL2TvYwSzvu5/XlM023+DQRyP1gkp9WgFxpkvmJ0wr0fjBfGMkTSaR45FqesXO5DWBclA==
X-Received: by 2002:a17:902:9a94:: with SMTP id w20mr8412403plp.59.1594997323140;
        Fri, 17 Jul 2020 07:48:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id ml8sm3076451pjb.47.2020.07.17.07.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 07:48:42 -0700 (PDT)
Date:   Fri, 17 Jul 2020 07:48:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        saipraka@codeaurora.org, msavaliy@codeaurora.org
Subject: Re: [PATCH] soc: qcom: geni: Fix NULL pointer dereference
Message-ID: <20200717144840.GT3191083@google.com>
References: <1594996342-26964-1-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1594996342-26964-1-git-send-email-akashast@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please make sure to cc the linux-arm-msm@vger list for patches of
Qualcomm code.

On Fri, Jul 17, 2020 at 08:02:22PM +0530, Akash Asthana wrote:
> pdev struct doesn't exits for the devices whose status are disabled

s/exits/exist/

> from DT node, in such cases NULL is returned from 'of_find_device_by_node'
> Later when we try to get drvdata from pdev struct NULL pointer dereference
> is triggered.
> 
> Add a NULL check for return values to fix the issue.
> 
> We were hitting this issue when one of QUP is disabled.
> 
> Fixes: 048eb908a1f2 ("soc: qcom-geni-se: Add interconnect support to fix earlycon crash")
> Reported-by: Sai Prakash Ranjan <saipraka@codeaurora.org>
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 355d503..6e5fe65 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -820,6 +820,7 @@ void geni_remove_earlycon_icc_vote(void)
>  	struct geni_wrapper *wrapper;
>  	struct device_node *parent;
>  	struct device_node *child;
> +	struct platform_device *wrapper_pdev;

nit: since there is no other 'pdev' in this function you could just name
it 'pdev', which is less clunky. The variable is only used immediately
after it is assigned, so it's clear from the context that it refers to
the 'wrapper'.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
