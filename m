Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D131C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF312075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNv6T2Oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgDXFf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726586AbgDXFf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:35:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC45C09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 22:35:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so4272972pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 22:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dqig/XiGz6oT5fWLHEXeMBJ/eQ9XUL/AW33WV/oOKxg=;
        b=KNv6T2OiqKrnPO4YQNWL1XDTyopOqUxnMhJfKYP5y8qML+U7mBJ1zLAVrDXnPqb1f7
         xNi7j4Rajhrebj4O6XR1Eguq/aUJ/MXj+BzH6PJzF3zDrlp9oyqMu0c+pNBaV7yjAz9c
         ZTrdGb/cjoIjm8HU59QMDIt9dKhfH2CgdVlsHH56y0uArXOz1pSFPhs5iaIE2YgrqeB5
         Plyjmx6C9JdSpnuy9PyLJ6tHzXKxg/IWGBrlo1LNlA2WIj6bFgNKJf9vjAzBVwNcmXBG
         +oLbIZB8Kw0+8Wyzxj2e1lYBbaPds3tNysdEQ85rRhrcfoBJfEPVnjpawhGDP4E7VP4Z
         Mo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dqig/XiGz6oT5fWLHEXeMBJ/eQ9XUL/AW33WV/oOKxg=;
        b=B1TqXz079WtEq8tb7mQE1LCRP9i3ocAHGbc2hU8EOJyaRsdIFvhjPwoYXil0buvJmz
         itpi5WSoXFLFVszsJYafQGLyNfVIe518OKX5E7PtgN1lPbLMiwFKLf5P57BbCTJIAiui
         0LA1UUTS2ZXqWln3izjoh1aSZwA1fkDgmsaY+spf+/UCDDheKuT17U8Rn3E2InvKyL6+
         wdtLYke6mEMSvPw9MR4GIC68PN3aQp0FFuCXNQ8MpCsXrijr+docxrP/OR/mqR3w0ph0
         nvD+OLpLPbdXKr6irvlsuFYkgHGAd2+mDAR1stYivrdrXBeSDLBSaieaB1ZdNU7pLTHd
         L4YA==
X-Gm-Message-State: AGi0Pua14At/jmP2QgZasGYq/XQKgs/kXMg1E5Ylhxv0NDpQsURGrTvE
        exHiAie60689TujRLfpxlPSFPQ==
X-Google-Smtp-Source: APiQypJQcY8gkBpJbRvI1oKpLHbp9dlCRrYLr4knvswvyn1V27N2KSyhTlTtJWQsxSYFzxa9wdA8mA==
X-Received: by 2002:a63:fd4a:: with SMTP id m10mr1460347pgj.28.1587706557937;
        Thu, 23 Apr 2020 22:35:57 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t3sm4411982pfq.110.2020.04.23.22.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 22:35:57 -0700 (PDT)
Date:   Thu, 23 Apr 2020 22:36:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/3] soc: qcom: rpmh-rsc: Remove tcs_is_free() API
Message-ID: <20200424053626.GV20625@builder.lan>
References: <20200424045414.133381-1-swboyd@chromium.org>
 <20200424045414.133381-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424045414.133381-2-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23 Apr 21:54 PDT 2020, Stephen Boyd wrote:
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
[..]
>  static int find_free_tcs(struct tcs_group *tcs)
>  {
> -	int i;
> +	const struct rsc_drv *drv = tcs->drv;
> +	unsigned long i;
>  
> -	for (i = 0; i < tcs->num_tcs; i++) {
> -		if (tcs_is_free(tcs->drv, tcs->offset + i))
> -			return tcs->offset + i;
> -	}
> +	i = find_next_zero_bit(drv->tcs_in_use, MAX_TCS_NR, tcs->offset);
> +	if (i > tcs->offset + tcs->num_tcs)

Afaict this should be >=

Regards,
Bjorn
