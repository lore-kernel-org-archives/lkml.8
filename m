Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44763C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2256320738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gv+dojyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGGFO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgGGFO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:14:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6449DC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 22:14:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j20so2250601pfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 22:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VC1qC/chpLuPrnCtnXydy4WQQAWd7iJ2FZlZimJ5b6I=;
        b=Gv+dojyI7QQfxRcDCRu4q8/4u57qSHg/i5SDWki0XXKBc1Py5nVmTLUtVcuZJ7KlyX
         AZLx563OpopGbbMqB23Kln56ys2+XVKQUzE/ENalHLS05+08nhfGEbCcMrCjKDtw0V7l
         qkg+0GKFNaVVnrpLHBidGE9EN3VE/fm8oBOpykwn/e1fU59Zr7oRNxWoLlYMuot/JKyI
         3hiTggjRTXkbCAdF4kQ/P5DI90BFjq0CqHgafB0Nb7EDqR86xxQg+Jf7GX+cqA+USTk3
         WImdsqv+VPPCBI+HTAAEfZsr/nAugjsUYl56q1b2uzcjIbDRlq74eireq2bXGezHT/np
         Mh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VC1qC/chpLuPrnCtnXydy4WQQAWd7iJ2FZlZimJ5b6I=;
        b=HRU2rdhVNSr5sBdYfjo4o9Yqb4Ur2MO/9yJ0ugRIDMKpuQaGkwST/YQzvlFz9qMzt6
         woako+3qITAJpixpZYxuV7AxsdgRif3h3+uzURm2QjbNVoAga1L7J2+wE2+gUOg0hiE3
         uNjnP9y1oBJmQep/bz8yGW4EQeeYGTEuMBdRyW+ShYy5e0VbEzFXAJBG4i1Yq578a6W1
         WF8K0JP1szQT5DFfTQdtvpENNuWMEWWeJ758Z72UbmdtFNrw/FWxVuM8OSBIg7ByyKUw
         f2oC3NT5jx/ON3NVHUASjfIA/pigIrPmsuul4FpvYn1MC8Qne5KmcjEiqshWgvF4xag6
         6Zow==
X-Gm-Message-State: AOAM533e5DU0pRt73GeLUlGZcJOuYx+cqqVOnAQdyBQRGAJI0JIHCrGH
        K10vZef9Zi7ZyFsqhuJ7iZ3OLw==
X-Google-Smtp-Source: ABdhPJwBny1F67hBfUTcgvlntD95n8W52l3BO+5OX0uP6ElEwFRCGpsB+Nbv9jE3lXqwkCkrImEHNA==
X-Received: by 2002:a63:515a:: with SMTP id r26mr46032087pgl.204.1594098895865;
        Mon, 06 Jul 2020 22:14:55 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m1sm1097166pjy.0.2020.07.06.22.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 22:14:55 -0700 (PDT)
Date:   Mon, 6 Jul 2020 22:14:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kathiravan T <kathirav@codeaurora.org>
Cc:     agross@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaprak@codeaurora.org,
        sricharan@codeaurora.org,
        Rajkumar Ayyasamy <arajkuma@codeaurora.org>
Subject: Re: [PATCH] pinctrl: qcom: ipq8074: route gpio interrupts to APPS
Message-ID: <20200707051452.GO11847@yoga>
References: <1594097915-26725-1-git-send-email-kathirav@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594097915-26725-1-git-send-email-kathirav@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 Jul 21:58 PDT 2020, Kathiravan T wrote:

> set target proc as APPS to route the gpio interrupts to APPS
> 
> Signed-off-by: Rajkumar Ayyasamy <arajkuma@codeaurora.org>
> Signed-off-by: Kathiravan T <kathirav@codeaurora.org>

This says "first Rajkumar certified the patch's origin, then you picked
it up and certified its origin". As such I would expect that Rajkumar is
the author of the patch.

If you both came up with the patch add a Co-developed-by: tag.

Regards,
Bjorn

> ---
>  drivers/pinctrl/qcom/pinctrl-ipq8074.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-ipq8074.c b/drivers/pinctrl/qcom/pinctrl-ipq8074.c
> index 0edd41c..aec68b1 100644
> --- a/drivers/pinctrl/qcom/pinctrl-ipq8074.c
> +++ b/drivers/pinctrl/qcom/pinctrl-ipq8074.c
> @@ -50,6 +50,7 @@
>  		.intr_enable_bit = 0,		\
>  		.intr_status_bit = 0,		\
>  		.intr_target_bit = 5,		\
> +		.intr_target_kpss_val = 3,	\
>  		.intr_raw_status_bit = 4,	\
>  		.intr_polarity_bit = 1,		\
>  		.intr_detection_bit = 2,	\
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
