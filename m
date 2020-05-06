Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998F2C38A24
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752EF20747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVg/KXxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgEFKIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728614AbgEFKIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:08:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916DC0610D6
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 03:08:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so1937528wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VzNe2ST4lz1BYAQ/p9YeE0kmmD4jLbs29p9J5C8f3PI=;
        b=lVg/KXxsQi9o5BFRkAdFAHJvM5az1noe+ABa8yeVzaBDNNCZTnPXEe6S/aOwqh/vkp
         8f0NhIcwAJ2PC/4vpwvKstSIXj0hfRFtrIeW0wcQYIan1lOdxvJyQqFAQfoII08sPkC4
         DGORLRfat4zBbEEmmc9MXkI3gjVEeqX+6hILIUTcqtnxODF/CSTLO5D+jI8mALONUf+L
         ikK7bGvxYlGDq4kzxRRF0d6+ObCh8KvLz/0bAVZgpwyprzBb9pD1uOu+cqtkevW0phpJ
         kzTkEGZKVK++p9qj8MHC5TvynAIpX+h0IbgOi9Tqyi9CmY91FSY9d8VpzwtWlO1tQvMq
         g81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VzNe2ST4lz1BYAQ/p9YeE0kmmD4jLbs29p9J5C8f3PI=;
        b=TNKutPIiST+oFipHkBKo7C6GqFPcQGNia7qwbqUD+L9NOVasbIZ7iGOCKjNbilywDa
         kTQ97Oos9L7NQFf7vP0DwlcNJxsUBlRyE9N+rJhtZjkuxuer3nYGiLEz/ceCPEalQiwy
         lTqIrOus9xiBzDAHXndMQlsljnip3LZs/e+A+699WFFzRXyrqWgie8aONBVh6aXiMyam
         xSYFOxldvbv1+xePqpJ3bIa6cYmcj4pwaI3VZcYeAnAqoVNLeH540SPx8CZ9iTT3QZ7B
         1SlEwTLptOgKq5id/1HmaK00cqPKSjTEhkuWrACfVL4X8l5tycitxpLCblwgnPlhe9Ac
         7ANA==
X-Gm-Message-State: AGi0PuZWGhGMSPaiLPFPfU3h8kfQdEx4Vv+qKLdzD6aysRIDDOwmqGEz
        GNhFoxtFDetOonhm2IYQNOTFBQ==
X-Google-Smtp-Source: APiQypInYHUDNrqEUITYN/4bNtu4Kh3BGLktqne+H6HDYbuGJNmorPX8kNclKs+5lI97bApQew2ZlQ==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr3332429wmi.182.1588759716943;
        Wed, 06 May 2020 03:08:36 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id 88sm2000910wrq.77.2020.05.06.03.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 03:08:36 -0700 (PDT)
Date:   Wed, 6 May 2020 11:08:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        robh@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH V6 4/4] backlight: qcom-wled: Add support for WLED5
 peripheral that is present on PM8150L PMICs
Message-ID: <20200506100834.GG823950@dell>
References: <1587656017-27911-1-git-send-email-kgunda@codeaurora.org>
 <1587656017-27911-5-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1587656017-27911-5-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020, Kiran Gunda wrote:

> From: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> 
> PM8150L WLED supports the following:
>     - Two modulators and each sink can use any of the modulator
>     - Multiple CABC selection options from which one can be selected/enabled
>     - Multiple brightness width selection (12 bits to 15 bits)
> 
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 378 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 376 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
