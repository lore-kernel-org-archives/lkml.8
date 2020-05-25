Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A3AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5563A2078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4lxaU9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389984AbgEYKyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgEYKyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:54:09 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B1DC061A0E;
        Mon, 25 May 2020 03:54:08 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h21so20053610ejq.5;
        Mon, 25 May 2020 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I2SbXHPPSfQYxydd3wzVxKM/dM5peIMZZus8bzRPuPo=;
        b=q4lxaU9CtOqrjY7oTsTXqky1nSVO0crs1fSCGfajCpOJOJEkhb2krEfjE2ivsNddo8
         LL4BA0vUQhaBvhZBsXjfN0SuYXpWeL6hFzInK8QZuSMOH1Faptdjtvz1+1xAQ/iJeOfS
         mgLaqeMgFHFopi+2y37hjqF4dvJMyaYHF3ZLqqoJNz3fXfxCCF+LsaTs+UvwPWEu2ITj
         Ifb2nW/EuqSEEyYkqf/KsmkKOp3oHVfzcMni37bT0PXZM3dVHQ/X8/lxkoj/VG9sf2YN
         0S+3RlGK64BfGVU2ykWHHZI1G6HExpHG3BoD9J+swJSzGUUPyY9QZ7BFj40CoeV11eIM
         YVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I2SbXHPPSfQYxydd3wzVxKM/dM5peIMZZus8bzRPuPo=;
        b=A8heldaB0QHhtqT6YTHvg88PoOY0EEO3vKvfjHgQUTKxZNnbdUTKpYatk6EWtdVKXQ
         PmYaPUg4uB6W8Pg+zKaBheEFv+QKxqgHD4TBJTUwXSEpHA/ElJH+7cqxspljJ5XrBjuw
         bXLTDzqv1N+39x7TuZeJm2ZyrXc/HM9hAcRplJFkTVE7q1PoTemkJIwHGNsgyZMOM1Hd
         uLbIQBUKf0gCQK+979FU7FFzWfLAb/97J0GnBX+gUn4HuR/cnm4XXG9xL/6jW/3m/3lK
         80puMKV4TIK9WC8BxjdwzUWVXKUBIzpOui99E+rusBuRpRUQARoSxReRMNRRPy/SGO+o
         CrGA==
X-Gm-Message-State: AOAM532x47u/Jzz5imQlE++ENFiaP3oZaBunHlwfKAUAOwsbwjFcVysk
        nDxsMsFlAc3lS4xpfLc9Yio=
X-Google-Smtp-Source: ABdhPJwi1ssc7Gtx/iriU4TwkE8NvmkswAIt2uL7Im8Q8vBREkBMDvgoet34z0Judn6oiPaJ9Kzewg==
X-Received: by 2002:a17:906:a0c2:: with SMTP id bh2mr19064586ejb.458.1590404047012;
        Mon, 25 May 2020 03:54:07 -0700 (PDT)
Received: from localhost (ip1f115f16.dynamic.kabel-deutschland.de. [31.17.95.22])
        by smtp.gmail.com with ESMTPSA id cm26sm15127731edb.87.2020.05.25.03.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 03:54:05 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
X-Google-Original-From: Oliver Graute <oliver.graute@kococonnector.com>
Date:   Mon, 25 May 2020 12:53:32 +0200
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_st7789v: make HSD20_IPS numeric and
 not a string
Message-ID: <20200525105332.GB12301@archlinux.localdomain>
References: <20200521135038.345878-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521135038.345878-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/20, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently HSD20_IPS is defined as "true" and will always result in a
> non-zero result even if it is defined as "false" because it is an array
> and that will never be zero. Fix this by defining it as an integer 1
> rather than a literal string.
> 
> Addessses-Coverity: ("Array compared against 0")
> Fixes: f03c9b788472 ("staging: fbtft: fb_st7789v: Initialize the Display")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/fbtft/fb_st7789v.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> index ebc17e05ecd0..3a280cc1892c 100644
> --- a/drivers/staging/fbtft/fb_st7789v.c
> +++ b/drivers/staging/fbtft/fb_st7789v.c
> @@ -24,7 +24,7 @@
>  	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
>  	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"
>  
> -#define HSD20_IPS "true"
> +#define HSD20_IPS 1
>  
>  /**
>   * enum st7789v_command - ST7789V display controller commands

Acked-by: Oliver Graute <oliver.graute@kococonnector.com>
