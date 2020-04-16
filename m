Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1742C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A28208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehWs7uC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504083AbgDPJob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503597AbgDPJo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:44:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6257DC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:44:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so3980511wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eQoYM2pLQO1XrZmokhZkQFFYS9SMIAVF7rMVFneBkec=;
        b=ehWs7uC292kKEl7gjluXQedNxfQJ7V1i2Gs7FeoOLiMr1/nAzMdwA36hsXNWyCuNog
         qO4j0f7GHcgKG6F18w7u/wHuf5m0mcLS7duTHupaW0OTBH/+TlGWNrw608nEHl/KLQat
         yFLuCBLPtJiuDKOkRP5ASkZinZKoC6c0dFPcJfcs0P5/QquqMca2qbKPbvVNUjSM+AFM
         4HVRsHqmu+gDK5cblHSkyDwMBXzQAhyqtSv+EsDVESeZiHcSXkzxetI1mTAvGSYpYtrd
         SssOs+srOQKDORPoMRtdjGtJlOE3tabBZOkfqdhQibS+i0SKqBe/C+wgC7Vzb7bn7BLk
         MTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eQoYM2pLQO1XrZmokhZkQFFYS9SMIAVF7rMVFneBkec=;
        b=s6j/mSUjWflm9s2chDWCKKELazU3hCyGoAWEEsdR5lDlylWH9KuIUGr8MT7JlccXPr
         TshOHj40bg3LcOK5aEFhJhFLeV5+zkRxRZOlpZn1Cf7t6t4PxjFWAFnewUayfLms0dft
         Q7VdpliPg4wAZq5ZeEao7M48vYdh5HcUP//M6fpy3BHjg2ea0ictg4H+0/oNNxc+7/g6
         dJUJ5WVK/evb7ZzV+zqfgtqu/Ta/Dwer6r16znnKqiYB0Pl39l9lXqAUPb8sH3UJXfrt
         AAvOAkOr34fKMACrR3ivKx/fxMAeZTcx4Hy+rOFRdejwObxWXbCALZX8LZjZAHQb9vGV
         5Prw==
X-Gm-Message-State: AGi0Puab/sULl2vaMf7NijqfIIqtk/x9UKamHIC+4jfQxNAndSn4XMkT
        GTQG2dTyDNKTLjpCT+AMl1/UfCK2JII=
X-Google-Smtp-Source: APiQypJ2YUsUUdUM/XrgPFwutQFkpFRJstjqY0JphX96phVZ7rvntEP6QlkjZL8xuc6XNcFK/09AKA==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr24132302wrw.318.1587030265162;
        Thu, 16 Apr 2020 02:44:25 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id k17sm1789621wmi.10.2020.04.16.02.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 02:44:24 -0700 (PDT)
Date:   Thu, 16 Apr 2020 10:45:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mfd: stpmic1: Make stpmic1_regmap_config static
Message-ID: <20200416094525.GC2167633@dell>
References: <20200410115514.41916-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200410115514.41916-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020, YueHaibing wrote:

> Fix sparse warning:
> 
> drivers/mfd/stpmic1.c:62:28: warning:
>  symbol 'stpmic1_regmap_config' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/mfd/stpmic1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
