Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02DEC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C032723129
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rzUIJD94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgEMIAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgEMIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:00:30 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394FDC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:00:30 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id i13so20672132oie.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=752wX5EL8J2MRxEP0ymF9v/OZ2YrwmsmZn47Ie44qaI=;
        b=rzUIJD94/+BI+arzuqPTef71Q93uEKSOMWuAnxcmv9nKtHkQIlFHhdNukmUsmEjezD
         noFfDehSBiDBkirx1JC4NtgDWLrxYS+nk1EmTAZFFQHv6sTCiMrB23SsRcCNb9JxrD07
         0cLVsqVNcdoKX10ph/+LGflRjgp9RDdIJEZrjTHBuy90fIHqZpNfBTGeleaaMWAmcZ9x
         Z8UlW6OuhZ2Pjtx0w4JDtqFA7JZIWCoZJ93CNtnVCHLc063nUBhr+sWhYnjLsOsi3nup
         Csj+3W12eMKWOHjF0bQj2Kdvs+gKHEI5euCCqkhqVCC2KKMnLyuw+MmKbZ9IVbk435E5
         CMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=752wX5EL8J2MRxEP0ymF9v/OZ2YrwmsmZn47Ie44qaI=;
        b=J9SeVq8M77+CX4lPBMaVP0qHrR26VydlYNnvlOQyCI8YI9SJePIkjTplkCQOXVulxN
         HCqPlm9KFAWW/ts/T6c0lyoQQUW42T7sxiIu5LTOrXpeW4X91na64HcP10khaUkHfche
         /bAMIJAUR/Ywfx9Rjr2oo/JmjXZA/QVeqHHuWWd6aNB4kkz5T+THjiqjJDj8laWT+Hzz
         tRds7sbHv5LwPmV2oVmdDdeHwW7erbG/uMv4iaa8MjMmm/TXjaeTf/fP1C7sO4h9URPW
         aZZdjyKT+x5+xt5Lsl7IDosufUbKXJXLVWXuZVAsX1sW04pHZS3EoMbYcA//8lBwOFD9
         KkAA==
X-Gm-Message-State: AGi0PuZnHlPgGjMl6l8Z/LOoYZJteGXwD+KyylhQvwkI7IYgG7U6PN4N
        0E3SHO2qSw3XXg9xnScKmheUGDUnsSJfeThfD1sfRQ==
X-Google-Smtp-Source: APiQypLlDtfgGysKdFrRZ95hIF3ftkqPIEsBxExRDL70Znd/vlLUJ+VwEcQ9tnouQ5uobjqR6eTTQwWdl8yMlKry5qM=
X-Received: by 2002:aca:d50c:: with SMTP id m12mr27228872oig.149.1589356829004;
 Wed, 13 May 2020 01:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200513003430.651232-1-vlad.babchuk@gmail.com> <20200513003625.651340-1-vlad.babchuk@gmail.com>
In-Reply-To: <20200513003625.651340-1-vlad.babchuk@gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 13 May 2020 10:00:18 +0200
Message-ID: <CAHUa44E968nR1toCGn0_k6ABw_By7Z8EqB2rGSgiTmseo8oL-Q@mail.gmail.com>
Subject: Re: [PATCH] optee: don't fail on unsuccessful device enumeration
To:     Volodymyr Babchuk <vlad.babchuk@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jerome Forissier <jerome@forissier.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Volodymyr,

On Wed, May 13, 2020 at 2:36 AM Volodymyr Babchuk
<vlad.babchuk@gmail.com> wrote:
>
> optee_enumerate_devices() can fail for multiple of reasons. For
> example, I encountered issue when Xen OP-TEE mediator NACKed
> PTA_CMD_GET_DEVICES call. This should not result in driver
> initialization error because this is an optional feature.
>
> Thus, it is better to print warning, instead of termination driver
> initialization.
>
> Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
> ---

Looks good. Didn't apply directly at latest, but the conflict was easy
enough to resolve.

I'll pick up this in a day unless someone objects.

I'll add a
    Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
Line.

Thanks,
Jens

>
> resend: fixed email in s-o-b tag. Sorry for the noise
>
> drivers/tee/optee/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 34409c916882..a053930032f2 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -728,10 +728,8 @@ static int __init optee_driver_init(void)
>                 return PTR_ERR(optee);
>
>         rc = optee_enumerate_devices();
> -       if (rc) {
> -               optee_remove(optee);
> -               return rc;
> -       }
> +       if (rc)
> +               pr_warn("can't enumerate optee devices: %d\n", rc);
>
>         pr_info("initialized driver\n");
>
> --
> 2.26.2
>
