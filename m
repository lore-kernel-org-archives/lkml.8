Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1F6C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE28206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IGcm/dET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgELAf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 20:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725855AbgELAf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:35:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC68C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 17:35:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x2so5523824pfx.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 17:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T83vTCwaOu/l7IbXH3GIrZ2sebndH8AtIbOjOcFOKiw=;
        b=IGcm/dET1rxwKVDQcmNORUppFub7U7i7TpLGJxT7aftq6PLsHo3Q2kpuu256Ik+gTm
         4U7FaWV6JVtZDdwTqn5KnqHIrDMze42Qyr3hD2akrj8wZI7Znjh9EDzhAodCUIWYyADu
         askH6eHWoJk8KBBGBHi9UL8yQ2GCrhFvyNuPPiykmSOB1Tkish/jGf8PNdEFC9lzKvP7
         I9TsuaHhBKXB/lr+nbFyVJeTv7AbkAJMpsJMYCRCnTTTT1mmqDEMkHvCvIDWuP38+2TI
         KOe/GPvkYm0ShiY5vhvlMyve5EcutfFiLSKouzgRcYtR2ebA1aodeGuxVYGZn3ciKrZH
         f3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T83vTCwaOu/l7IbXH3GIrZ2sebndH8AtIbOjOcFOKiw=;
        b=K7nd7uAOlAEs+yZnDI0bVx/y14B6JvER2qAsjAigXbgG1lkcm+QZxMv2iA7pI2D6FQ
         wSiTGtu621JQFBzkYNS0+NxJBN6N72soTbFXNVxypIJfuv6r8tQAHgaBUHgrwiFbWDHk
         d+W7j7OefAxsWkurhb5Jmxjde08ba+pHS9gcHLJMS4JCWega4phdQqFJ4R4cXPoSBcvp
         XEa1vt8Sv10uzToeC40XPxj5snGynjqslMddsIk3VgUC4rSgPXsbS4RjEKQPx3jvAf1t
         RKM53eX2kvMvo2FDOKh6V3j41yohepAiy7zLVvwlG+MCCfA5NsNIpK+F9mOKl2s8U/bW
         Uypg==
X-Gm-Message-State: AGi0PuZ4m7g+vqLe/gEGlfe7XJ/akIKzCQC84vidYIk8L/CYfkLY5cej
        U1PBZMbj6cWWHFp4z2cO5lH5lg==
X-Google-Smtp-Source: APiQypIlsInVbpMwAmAv0PBIrdW08DiGTGVAB7QYuaz3l5TaQnx80WTzLSic+Ae5WHDcMvsqJympTA==
X-Received: by 2002:a62:764b:: with SMTP id r72mr18585601pfc.207.1589243726915;
        Mon, 11 May 2020 17:35:26 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u5sm10434247pfu.198.2020.05.11.17.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 17:35:26 -0700 (PDT)
Date:   Mon, 11 May 2020 17:33:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: qcom: socinfo: add msm8936/39 and apq8036/39 soc
 ids
Message-ID: <20200512003352.GC5349@builder.lan>
References: <20200511212733.214464-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511212733.214464-1-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 May 14:27 PDT 2020, Konrad Dybcio wrote:

> From: Vincent Knecht <vincent.knecht@mailoo.org>
> 
> This patch adds missing SoC IDs for MSM8936/39 and
> their APQ variants.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

Applied, thank you.

> ---
> Changes since v1:
> 	- Add a proper commit log
> 	- Add a missing sign-off
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
> 2.26.2
> 
