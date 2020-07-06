Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30E2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3102070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="if9HBlA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgGFHM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgGFHM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:12:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96962C08C5E0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 00:12:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f2so11635012wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 00:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FoSjIG3VRw8M9fOU/dfLMuLezeTkp5UAh0BxNMHAjSU=;
        b=if9HBlA9VQz/DooWA8KmSxJ1gwN0Z/+q/abPRsudszDLAPA5Sax63WJuxR/o0W7YRW
         pY3+BOTmv9n1glV/nSTkzluey/r9TND8/Um1sbKlF7gaOJyxNkt3qpbkSHwhnPt2fgvA
         PrhvSA8l2QPunnrnOJDw73eRQ+4iGvqYbzEDWJziNcpx3AH93pN474NFD5hNkR34Avfq
         L4BIuECug2LTD7En9WA6bmt9HuCDKrCzb2FwCrCAH3wEUGUiENhaLPGCX2fuvKxC0OD9
         s5DsLrUA93+Of8tTSSH4UjB1bRwCruHx5RgHBrpx2bvmK3cJDhrrequ1c+JCNU6MxS2u
         EJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FoSjIG3VRw8M9fOU/dfLMuLezeTkp5UAh0BxNMHAjSU=;
        b=fygCgyfbhlRb21dLHTrydKVCQMXTNoJsNe40wy1yFu5hXn+Y4do6VDBFkhbL2vHGMI
         hzNnkU4Gxpp3fOd8n9NZVJWoDiVjcE1RdLzCWlPFTbg2Rxy9m1DhA0Y5LSvJameajPX1
         Gd0w4V40ITeZipX66GhY1ANPG5a8mViAg1+nBEDYiXHMlE1MC2rwcLcrXCRtS+f43XS+
         9cqu/L9S28O0JMjnh/hZareGJL5l1b6InbG2M+q38953nFXfDWVE8/eLLN/5P5lK8R7k
         7fkVcshP1feRAk/XsDGl8pZSLfIFu7Bj+XHjDsinYFOxPVipxlRs/xdx+b3y84xKeNpM
         LnCw==
X-Gm-Message-State: AOAM531Okbs6FIFSvZ8WRSd+eP7qkhEIRV15FOKMTCQiBejj8qe6zuo9
        lZZaZXUWn4KhBs0VzCQvquOhcQ==
X-Google-Smtp-Source: ABdhPJwLhBlFAKN26FXGsrKJ2/3ld4/TUj5IudfdjzM/ZuZS/dr7xAKMChCzQ/pTpQ6ikPiMmParcw==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr46895795wrt.108.1594019576099;
        Mon, 06 Jul 2020 00:12:56 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id 65sm22090235wmd.20.2020.07.06.00.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 00:12:55 -0700 (PDT)
Date:   Mon, 6 Jul 2020 08:12:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     jingoohan1@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Software Engineering <sbabic@denx.de>
Subject: Re: [PATCH 3/8] backlight: ili922x: Add missing kerneldoc
 descriptions for CHECK_FREQ_REG() args
Message-ID: <20200706071253.GA2821869@dell>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-4-lee.jones@linaro.org>
 <20200625094051.u4hanl3rycczlwiy@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625094051.u4hanl3rycczlwiy@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020, Daniel Thompson wrote:

> On Wed, Jun 24, 2020 at 03:57:16PM +0100, Lee Jones wrote:
> > Kerneldoc syntax is used, but not complete.  Descriptions required.
> > 
> > Prevents warnings like:
> > 
> >  drivers/video/backlight/ili922x.c:116: warning: Function parameter or member 's' not described in 'CHECK_FREQ_REG'
> >  drivers/video/backlight/ili922x.c:116: warning: Function parameter or member 'x' not described in 'CHECK_FREQ_REG'
> > 
> > Cc: <stable@vger.kernel.org>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Software Engineering <sbabic@denx.de>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/video/backlight/ili922x.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
> > index 9c5aa3fbb2842..8cb4b9d3c3bba 100644
> > --- a/drivers/video/backlight/ili922x.c
> > +++ b/drivers/video/backlight/ili922x.c
> > @@ -107,6 +107,8 @@
> >   *	lower frequency when the registers are read/written.
> >   *	The macro sets the frequency in the spi_transfer structure if
> >   *	the frequency exceeds the maximum value.
> > + * @s: pointer to controller side proxy for an SPI slave device
> 
> What's wrong with "a pointer to an SPI device"?

I've fixed this and applied the patch.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
