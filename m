Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E7EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA9420870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CF4q0AcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgEHNCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729028AbgEHNB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:01:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94053C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:01:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so4269092pjw.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kGzbyp4Kjfdk0C7XAI34MTmYL3nwyLfAJVV51p0QRQQ=;
        b=CF4q0AcAWs+gNm/BRV8XXJuYXEshbcdx4waTzNsl6f8XC/ObC2lT3BNSbf4XFQWfud
         sNOMw1dGhOaqC+moTrFmh9zxj0WCOCKaorsb0MjAj/aZ91SS2dMG8+bGbjl/8fHRZGT2
         koylbEyxvqVHw9jfcb6Tl1TpEsCt3tI3XnEonL9EYb4cxA7x9GWXPOvc5hwfNqEuSDV8
         eiiDAshP3JjOtvVVubQGeexp4BZurXK9fxJyucj+7GbiApJ6VrDDQT13jL/LHx0AGSSK
         jlRAGzq8r68eegSuYMe4GiQHnnKsMrxupn0X7lR/I8B5nthY+r0eIkQscYNdOXroQAkl
         Krsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kGzbyp4Kjfdk0C7XAI34MTmYL3nwyLfAJVV51p0QRQQ=;
        b=CwcmgCn/rr6jBcLIqxJW7GNEka5h/bydlnZGPRSkFPld1qWMYEvc3G4gakoL3/TMYB
         F/cm5E/hGR5tUeyqCtQXG4G9EwvE07HXcUm7fTZWLAUJmHfOYJdhv62HYnVkHOy1iUJa
         +8LvU24uGVz+zB20PsEJaeIG/S3yJiSzYPA1yKZCOElAt+Vr4kzuHEpXzRr13X6afjf4
         sGCUb8OMV4HG4+Dz3pZDVG3lGhit07kiuYjciMkLKEP1YXLkCVvCiXD+5IR8vycgIDLc
         IkB+iunr+FWNC9BoqzVeV4jjSWO6fYLcsXDS2QnRsz7bacXxrCK9+QGXy61cgtTKR4fy
         v7uw==
X-Gm-Message-State: AGi0PuZuigWo2Q7mwLyMNwvrlNJREnqX32iiYbGVr7FbIYjHMV/mepgo
        VNNJpJL0Sk5geShhfg9dAJxB5g==
X-Google-Smtp-Source: APiQypLRMfczMLb83FfQL3CpbR7x4VwRtVYZWrJBkdljoWqkQTCekuduvqRRETs6ReWunf8OBAmmuw==
X-Received: by 2002:a17:90b:34c:: with SMTP id fh12mr5492480pjb.134.1588942914984;
        Fri, 08 May 2020 06:01:54 -0700 (PDT)
Received: from dragon ([80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 141sm1828359pfz.171.2020.05.08.06.01.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 06:01:54 -0700 (PDT)
Date:   Fri, 8 May 2020 21:01:44 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: socinfo: add msm8936/39 and apq8036/39 soc ids
Message-ID: <20200508130143.GC30486@dragon>
References: <20200501205546.151575-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501205546.151575-1-konradybcio@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On Fri, May 01, 2020 at 10:55:46PM +0200, Konrad Dybcio wrote:
> From: Vincent Knecht <vincent.knecht@mailoo.org>
> 

Please write up some commit log.

> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>

When you forward a patch from someone else, you need to add your
Signed-off-by.

Shawn

> ---
>  drivers/soc/qcom/socinfo.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index ebb49aee179bb..14831ed392e28 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -188,6 +188,10 @@ static const struct soc_id soc_id[] = {
>  	{ 216, "MSM8674PRO" },
>  	{ 217, "MSM8974-AA" },
>  	{ 218, "MSM8974-AB" },
> +	{ 233, "MSM8936" },
> +	{ 239, "MSM8939" },
> +	{ 240, "APQ8036" },
> +	{ 241, "APQ8039" },
>  	{ 246, "MSM8996" },
>  	{ 247, "APQ8016" },
>  	{ 248, "MSM8216" },
> -- 
> 2.26.1
> 
