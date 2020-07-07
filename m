Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7880C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C497C20773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FgAys2nN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgGGRe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgGGRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:34:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6443C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 10:34:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so43080270wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ITreFSF3QwB0kHeLsgLwmjRqxc7iMrP7mMrAbIuhNUU=;
        b=FgAys2nNA7C9G59JR2094Dn1BI10+vaU1RGrdY3HbiFXgeubNKu7Qi5fHE7DqvFI58
         V4VtDi210MNlIp2kmbfEU4Cr1JqcdQS/JhjfjNhghH8yQnqQgHZ65gMO8VZM/z/Szz+1
         eSKtRG5Dl18VIInxkT6IbeXAy26ssTJUNLU9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ITreFSF3QwB0kHeLsgLwmjRqxc7iMrP7mMrAbIuhNUU=;
        b=tp0P6VSKzSrvRVNpNIgFqNj8Dr3/6n8DHvYJA8aVdo0Ejw3GvY/06+22jnDAg8dXsE
         ELgUDa3v8vsHOAL8X0p0s3QjX9RlBCMhlojsqqKNTJvVU7DWhV/XcBqQ3gXveGDCAyjR
         S3nPWoZKXu1zg+y8h72nXCLSWjkLIkHjffGx57hM/RYI5KUs1vOH+LmuoMtxk5mkZnm7
         uJIR1s17CtSn1u5zBqs48pSuUOj+VrbwPgYx8aD3nYXHZ70VsgzAXQ3RTaKjJCocVfYM
         Xu1rwsCpxAVljwAtP0wGAdFXAqHQbzwtELJFsmZ6h7LzXbEwfiQ8Dzgbp41QtJQoMd4n
         0f4A==
X-Gm-Message-State: AOAM530Tl9z5lTr108IY1I0i7tMFkHfdO13LFkK/QktPSufZU/bwDcmw
        0G0qBYYcBja8fo8ayecQsRDXyw==
X-Google-Smtp-Source: ABdhPJwHYhg0CvN95fbCzB2YKA5y0Ej4SSs/h2hUyk34tRNvM1SJJ+fd0GK7wdywTV7GzQxoVx6gCA==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr53889112wrr.325.1594143264656;
        Tue, 07 Jul 2020 10:34:24 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id n16sm1860378wrq.39.2020.07.07.10.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:34:24 -0700 (PDT)
Date:   Tue, 7 Jul 2020 17:34:22 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kyungmin.park@samsung.com, s.nawrocki@samsung.com,
        mchehab@kernel.org, kgene@kernel.org, krzk@kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 02/11] media: exynos4-is: Request syscon only if ISP
 writeback is present
Message-ID: <20200707173422.GB2621465@chromium.org>
References: <20200426022650.10355-1-xc-racer2@live.ca>
 <BN6PR04MB066006C199A43996C0502B62A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB066006C199A43996C0502B62A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 07:26:41PM -0700, Jonathan Bakker wrote:
> From: Tomasz Figa <tomasz.figa@gmail.com>
> 
> On FIMC variants which don't have writeback channel, there is no need to
> access system registers. This patch makes the driver request sysreg
> regmap conditionally depending on whether writeback is supported.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  drivers/media/platform/exynos4-is/fimc-core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
