Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5B4C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A864206E3
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldTYVU87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgHaJPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgHaJPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:15:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A868C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:15:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mm21so310130pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jOsH1xveMhMjoIwok15XcPwN4RVnMVHn8XuBwbA02ow=;
        b=ldTYVU87XmQJRhEDLkn6zGfy2h2O6NFevgUPbsxyMEIL+Xn26+t76gllLG5LkaWyCJ
         1KFHoj9F6PDd3DBYJFaMifYFhKSBnW8Dj6pd29bLICluNT5F/h3DA8oANDvY7ONkDUyM
         uXg8SCzlmXQKhQpClWUf6Kvj2pd0bRyyPm+satR4imv9FG3ZXkW0DGpMZ+VRkRb/8Dmi
         izuwHOEkwHapb6gkS7qshXUH3uEQup7T8UuGlfDHP3hdQhRkHVIIwzUwUa0DQ8ruY4Qs
         3XHEzA638XNy7PSrZh9Qhq4ldbjkJZ2DbRS6CrtwbduBZF1y5yWBM8Yep4f9wyoGyAkK
         zMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jOsH1xveMhMjoIwok15XcPwN4RVnMVHn8XuBwbA02ow=;
        b=JTLhomlO1H4OVYc0d8ewgDpj+Yi/mDOfE7yLS2aDCvHsqobRqHSRSRYrA+NyfS7OfM
         qSBVlks0kos31BCXFp25jWC0wyh530fSHvrqz5UWd918KWKjumlWUbEriE38ghEyFQWx
         jQAWK+eVvD4UAw0pt0iRllluNbzrqHnnmvsFiLWyY0nt9bwfwOvpbCcWNQZVvHy9vouJ
         Ol9FgK9NkELa1xkAjP2Ik+gLDT1pR4KYmIVYwIg+Pwuewld9A8jkS1IEQKdXqtQeNj3l
         COV/SoP5RYUMX+yMLXAFqQRtCdL2rbfokeW9z3zEG6E8cPWvdod/HLdHO16zQ/jVKxSi
         Ucdw==
X-Gm-Message-State: AOAM532RLUlWvcdhCTZuLkh6PnQAmPZoO/zHaJYfzESHDMdx8nfz021I
        UWFw963LsmdUr+R9wu0ree4a
X-Google-Smtp-Source: ABdhPJxPn8geeNBDo1sZvZ4GwlWTHSLh8tnqHQfqdF2oJbs9EIbUNTA1H+iVufXeuzR1hCrNqbDeMw==
X-Received: by 2002:a17:902:16b:: with SMTP id 98mr386051plb.23.1598865333684;
        Mon, 31 Aug 2020 02:15:33 -0700 (PDT)
Received: from mani ([2409:4072:70f:fdfa:1d6f:524d:c4d3:917e])
        by smtp.gmail.com with ESMTPSA id u62sm7196663pfb.4.2020.08.31.02.15.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Aug 2020 02:15:32 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:45:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] pinctrl/actions: Constify static variables
Message-ID: <20200831091526.GA4154@mani>
References: <20200830224311.36994-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830224311.36994-1-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 0831, Rikard Falkeborn wrote:
> Constify a couple of static variables which are not modified to allow
> the compiler to put them in read-only memory. Patch 1/3 is probably
> the most important one since those structs contain function pointer.
> The patches are independent, and can be applied in any order. 
> Compile-tested only.
> 

For the series,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Rikard Falkeborn (3):
>   pinctrl: actions: pinctrl-owl: Constify owl_pinctrl_ops and
>     owl_pinmux_ops
>   pinctrl: actions: pinctrl-s700: Constify s700_padinfo[]
>   pinctrl: actions: pinctrl-s900: Constify s900_padinfo[]
> 
>  drivers/pinctrl/actions/pinctrl-owl.c  | 4 ++--
>  drivers/pinctrl/actions/pinctrl-s700.c | 2 +-
>  drivers/pinctrl/actions/pinctrl-s900.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> -- 
> 2.28.0
> 
