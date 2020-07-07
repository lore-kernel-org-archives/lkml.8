Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6A5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C876320738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNCRVKcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgGGHpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgGGHpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:45:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303F4C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:45:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k5so557437plk.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OdfdZpdNlsV+8LTmBqKkqZF5iyRO7Rci5zel+rmMCoM=;
        b=kNCRVKcZ9mjznF/w/m4aPSj+Mym7tEPuOKuif0DcypOHs4zb7snyDKk/NwvKsX5dUg
         +MsG+ychwHDm0EH9vXYVN+hzv01mZCTXkejxiME7LyK9xH4GQCyhqbhvD/B8xkqY0V4s
         ha/42bzDA3cT7CPuWoQxQSE01x/7kUcPgzvf/n5AI3J69epWaatvXaKBU2F9gpSXJiLO
         TjnOvQUVe5zxfeAmTW1FTA1BQXPp6oBI6EvqAXPAlmKxiv/AdLUVvZVHDqBxJDmTnsUr
         w8+gaXmhPaq5Uf8ooJX+jv2ZJ4zRBbOCuDd+NthaSnd5pnnEZ7vSakB/TTa8AdObqx7+
         XeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OdfdZpdNlsV+8LTmBqKkqZF5iyRO7Rci5zel+rmMCoM=;
        b=TKzcgJj3n9mVvhs9JWvlfUvRhbR6D4q5Qe330wsZbSyrN8pBz+KzGFPtOHIEkUFJft
         4Knn8oWhH/DaOlGg0LEZew0pPKW+u+9gZorNTkF2wFMV9u2xIHQDQahul5wKlsNgBDqC
         O9RuEOG3FGyQ/VvIE2acRFbu3u2xwXAkpNfbnUG0aMwdf43V1oRqJsA0M45G3vGmqUD1
         cVjmei6kIG5UWaY+58WFt5wIwCrVaxf1q8DQwsrzTi8rVVi1u5VGuZWVuGrHX7eKYuPE
         Nk3kfM9OX2/lFDw7sANBPoJtTxuGxRIw/0yCu50lmfyUsSGrEkpElqi9XMxJbnUaLSCF
         WWPA==
X-Gm-Message-State: AOAM531yergG3wTSkHH8B8stql1GCWziG2eu0j2OJ8y/Pn8IfY40azZp
        8JeDjwys5NhNNQLP6An+Rcwh9g==
X-Google-Smtp-Source: ABdhPJzA4pJfLWFX2jkVsjIUyDya1VaRc3xsb5pgU9v38c2IJFu6TU1M06feHzFjmbTZ9lKnVNppLw==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr19721531pld.151.1594107938544;
        Tue, 07 Jul 2020 00:45:38 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z8sm15986pgz.7.2020.07.07.00.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 00:45:37 -0700 (PDT)
Date:   Tue, 7 Jul 2020 00:43:18 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kathiravan T <kathirav@codeaurora.org>
Cc:     agross@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaprak@codeaurora.org,
        srichara@codeaurora.org,
        Rajkumar Ayyasamy <arajkuma@codeaurora.org>
Subject: Re: [PATCH V2] pinctrl: qcom: ipq8074: route gpio interrupts to APPS
Message-ID: <20200707074318.GT388985@builder.lan>
References: <1594107588-17055-1-git-send-email-kathirav@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594107588-17055-1-git-send-email-kathirav@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Jul 00:39 PDT 2020, Kathiravan T wrote:

> set target proc as APPS to route the gpio interrupts to APPS
> 
> Co-developed-by: Rajkumar Ayyasamy <arajkuma@codeaurora.org>
> Signed-off-by: Rajkumar Ayyasamy <arajkuma@codeaurora.org>
> Signed-off-by: Kathiravan T <kathirav@codeaurora.org>

Thanks for the quick respin.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

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
