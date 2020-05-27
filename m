Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DE4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B81D2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcsXCq7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbgE0PHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388922AbgE0PHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:07:36 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7943DC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:07:36 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id a68so19382912otb.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SsXlV/rgDTFrrXUJalPoVNZ98n5hnsjngLAn1tfFekY=;
        b=AcsXCq7EwHG1N0+0SWRUVIFbk/3NquQOmx4a/VcmD9Kbs/o1OQvhsENf9RS9TKSzju
         Z5nWYb4Zrz4xWteLMgJXRz922wxXPVXHjq1V2lVpdnUdSyrdXsx4kfrTOE+SZEenSeT1
         +5MOdOcCEbY4O/NTk2mh586DXiQ1wKskpXEy/j7uoikthAfDBapueCIgAq00HabOzECV
         wMsHfbIasxiURozNytRXIe+IUgCOUo0vLyy8k+VUvuLBwAVqz4DoWLvgKCI6rHlEZwk3
         a+TODCdzzH7bOJMRZTLcGnEkDqQSM7VMzelWERhBNd0O8JRRoShz2tuJuzHN9kN5gURn
         bl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsXlV/rgDTFrrXUJalPoVNZ98n5hnsjngLAn1tfFekY=;
        b=aQ7P3D+7XMv8LuNA7m2Flk0WQp1MfRMYvOv50AofgYZfNInxUKXd0cb+PIGLjmKZtc
         gxyxeYWVDSUJQIeWMFoMqVYd0GgsJEdkqL1ZRYh8oFKWZ7YVdayIoSHXSEm61HxrqVy4
         fER0y/5blpvANTQRH3w4ibIgRXxjymqL69AJtDCabDajR/tUACakVGijNj2o8GA/gsm1
         GyPY+A1u1c29iNFJ1/QAvNiG23a7+mGpOQwFGJq+ryrXd3drdGhzUzyCn35ZX2EtX2Uj
         XEGqn7NV3EbKx2xfR8hjEzkCoDbKNnwLX63j7lI0hCSr6eAP26lzSWi7VtLnerMkpEag
         Iwsg==
X-Gm-Message-State: AOAM531t6IHZKw1GFM1qHO4wcxB7CnaQhVIanJKl6pqBsuk3ntWH1ynR
        fqEKFPI5LR/DUQ61+5q91xeXs89yGT8lMiLYpDBpNe8j
X-Google-Smtp-Source: ABdhPJz6QCF43Ex91tz2mf4ojnxH1DbpxzrwT4fGB5YwXhv3sr1URktkYtF11ji4FnNC/gs4S4WhAQEQkrFw6OUyia4=
X-Received: by 2002:a9d:6d03:: with SMTP id o3mr5047748otp.283.1590592055454;
 Wed, 27 May 2020 08:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200527133924.724819-1-arnd@arndb.de>
In-Reply-To: <20200527133924.724819-1-arnd@arndb.de>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 27 May 2020 17:07:24 +0200
Message-ID: <CAHUa44HXs_h5ZBizHXDtYWa9Ubk=64AgiM5zj7rGx0CxVcSbTA@mail.gmail.com>
Subject: Re: [PATCH] tee: fix crypto select
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org,
        =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Gary R Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, May 27, 2020 at 3:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When selecting a crypto cipher, we also need to select the
> subsystem itself:
>
> WARNING: unmet direct dependencies detected for CRYPTO_SHA1
>   Depends on [m]: CRYPTO [=m]
>   Selected by [y]:
>   - TEE [=y] && (HAVE_ARM_SMCCC [=n] || COMPILE_TEST [=y] || CPU_SUP_AMD [=y])
>   Selected by [m]:
>   - CRYPTO_DEV_QAT [=m] && CRYPTO [=m] && CRYPTO_HW [=y]
>   - CRYPTO_DEV_MEDIATEK [=m] && CRYPTO [=m] && CRYPTO_HW [=y] && (ARM && ARCH_MEDIATEK || COMPILE_TEST [=y])
>   - CRYPTO_DEV_SAFEXCEL [=m] && CRYPTO [=m] && CRYPTO_HW [=y] && (OF [=y] || PCI [=y] || COMPILE_TEST [=y]) && HAS_IOMEM [=y]
>   - CRYPTO_DEV_CCREE [=m] && CRYPTO [=m] && CRYPTO_HW [=y] && OF [=y] && HAS_DMA [=y]
>   - CRYPTO_DEV_SP_CCP [=y] && CRYPTO [=m] && CRYPTO_HW [=y] && CRYPTO_DEV_CCP [=y] && CRYPTO_DEV_CCP_DD [=m] && DMADEVICES [=y]
>
> Fixes: e33bcbab16d1 ("tee: add support for session's client UUID generation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The regression was introduced in the soc tree, I'd pick this patch
> up directly into that unless someone sees a problem

Thanks for taking care of this, please go ahead.

Cheers,
Jens

> ---
>  drivers/tee/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
> index 806eb87d4da0..e99d840c2511 100644
> --- a/drivers/tee/Kconfig
> +++ b/drivers/tee/Kconfig
> @@ -3,6 +3,7 @@
>  config TEE
>         tristate "Trusted Execution Environment support"
>         depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD
> +       select CRYPTO
>         select CRYPTO_SHA1
>         select DMA_SHARED_BUFFER
>         select GENERIC_ALLOCATOR
> --
> 2.26.2
>
