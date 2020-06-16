Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F5CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE27B206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PdXRsKHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgFPIBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgFPIBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:01:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0006DC05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:01:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u26so1668433wmn.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XCQQkMTQ5i0LzzLAqMYj0ZlgAAMCYhAeRgmSTuVWpiU=;
        b=PdXRsKHo2oCz/8hxGQBkQV8rA1aKo0OTp0h9+96o15ErtKc6f16Dd3ycbRN9NSfsOq
         iti334NTjzMW1HZaX5zFGaJPnp6eF9xhGXLsQL4EQsl4xP5777sVMLoWyyIMEtKY7bHo
         pBIXbAprivzwyVYgJ+fMg56w16n3AvK+BoNuzfWnOJrfxn08Un9j3nB9uC+X5G6w6V3O
         QcYaHk+fX6PRb7luMATq9n1ffCWBohaF5fA9MilLPGdpyIJev2j06pnn7rvrYHpJ/jra
         j/bVTWH81cmWaMMambEOSwqklgHbl1Q3BbMPe9+vR2FYZGrIygWRrEwBFt3r68FoRxA6
         AVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XCQQkMTQ5i0LzzLAqMYj0ZlgAAMCYhAeRgmSTuVWpiU=;
        b=aDsdexk/Wxn0mDw9SOAt3dsjkSfEFugVL6vsLzsD6NzrubM1sE3YIz4aFJo4uka2h3
         f8i+axeTz62qMcGCCdywyofMw9UTwFxqis2ANeyjl1nJqE5HuLxVnSeRfoSS7rOH0jWy
         /ff/sK4QnsPgECeznFRD3dnSusHtBkgZsio1kLEVvurIgUJH6SAiBPqADab5gLM5HiZI
         AFRtX7PkvzLgEECxYaIQ9hrS9s2W8ePdNvZgihxJlyJwUgEVclcV/9DiLrn0Z92O11n+
         +fxddqqlgEF65r+OW7+2otw2rLLm014itwIibRKlY6nIEoPcLp84/uhDn8tfNVYzkIws
         kLqA==
X-Gm-Message-State: AOAM530FWjN+/Q3LEv+V5SPRh8huI+o0COtdiq6w/oy+Wo2SgxJGOI8O
        FEQ3jP9WlAHvGjNT7JcPtud9eg==
X-Google-Smtp-Source: ABdhPJwtczraf1q3fNGZhkclduNYNYI8K+xijJ86be2Gc7A4wCaDONGmmmpE6dQq3Anyi1FZCmAJ1w==
X-Received: by 2002:a1c:6509:: with SMTP id z9mr1993858wmb.144.1592294474761;
        Tue, 16 Jun 2020 01:01:14 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id j16sm33254269wre.21.2020.06.16.01.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:01:14 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:01:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     s.nawrocki@samsung.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 1/4] mfd: arizona: Remove BUG_ON usage
Message-ID: <20200616080112.GH2608702@dell>
References: <20200615135323.15215-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615135323.15215-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020, Charles Keepax wrote:

> BUG_ON macros are generally frowned upon when the issue isn't super
> critical, the kernel can certainly carry on with the 32k clock on the
> CODEC in a bad state so change the BUG_ON to a WARN_ON.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No changes since v1.
> 
> Thanks,
> Charles
> 
>  drivers/mfd/arizona-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
