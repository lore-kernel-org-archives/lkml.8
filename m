Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63E7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9B620838
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="haS8Xtlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgHLOF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgHLOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:05:55 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948B3C061384
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 07:05:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r2so2156578wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtilRrD53TAdMxjjX3JU/V35Hl/WvabSAv9hkR9mbIo=;
        b=haS8XtlzDKF65bhoMUOPOYBmQNDeRR4FP8YUEZmz147Szkwx5jyNHWh/mdYZ41ycwI
         uqSlTJO0Kn5Rpzh/SiEisSNWE5lifM7NYHue5MbbXLwrOA1OwYBYorokzGjrnd+uySHO
         8Ct3jIDQt9BJcVlJ+yi6fuchImDf4cT1H7fejBFiwLNnmUSwiEkkNvRN1w6pAy1p+nyk
         bcIk2OntG1j8Es3Zzw6QucVASC6RtQ1OArcoXxiOnQFndGu2e8NREIZzF5nYL2LL9hGm
         IhTwaeYtQUjA/Sat9cebHCaFRdVGkHZjptoY1I45YdW7aDpzbXpQOWEZILCffcKjZydL
         fkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtilRrD53TAdMxjjX3JU/V35Hl/WvabSAv9hkR9mbIo=;
        b=MqRAfoHA3Xbco3KVQ52fO/aqIcPQPG0l4GAZNjKUYQsqQytpvI2eJjKKyqn1/aD8sL
         gnwQLwu4RGrbWK7VpFMlzZBv++O65bKoqwYHOY3+bJT6DNsnmmMIKBDBJDzJDrhVsA2j
         uQR8OH8GlzFZUSV3QABEehx0UtuPZmx9QXN8njQiqQEFiazP6TS0snYz123EoTk1VrIQ
         sm9W0hCGI5gU59QzKJw6wkM9GUAdAtx6cI5qApzclZ/yRlKXNdtsp51fwAgkxo7UOAXr
         lH0uaFqsrKCzek7y2EBkLmcZBbekYNvkkSojIn0cCVYg0AS5MEps7M4IavJFiEgvr5Mn
         U6JQ==
X-Gm-Message-State: AOAM531SMDWLxZkWkQv3mKSVqIDqDsqKHTodP8XgV2Wz8ohpcnQvrbuV
        /GSPcFuhnV5zqsBenUVCloyz6Ae6Y4mga1DBVaLvrA==
X-Google-Smtp-Source: ABdhPJytQgXxWxig/9l09GRJvMEY7a6NgMxWo4zz8fCCadHTu8T6hXjIQHA8VANPfPFXBXQm826jc5M8rHkK1oxIaVg=
X-Received: by 2002:a05:6000:1203:: with SMTP id e3mr34708903wrx.324.1597241154142;
 Wed, 12 Aug 2020 07:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200806181932.2253-1-krzk@kernel.org> <20200806182059.2431-2-krzk@kernel.org>
In-Reply-To: <20200806182059.2431-2-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Aug 2020 16:05:17 +0200
Message-ID: <CAPDyKFpBYDrn9dFGSNw9vHjrvPaP5amxYdxjifLBEM2U+AdVTQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/41] mmc: s3cmci: Remove unneeded machine header include
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Ben Dooks <ben-linux@fluff.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 at 20:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The s3cmci driver does not use machine header mach/dma.h.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

If you want this to go through my mmc tree, then please tell me.

Otherwise:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/s3cmci.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index b5df948f8155..60fc3fc30fb4 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -26,7 +26,6 @@
>  #include <linux/mmc/slot-gpio.h>
>
>  #include <plat/gpio-cfg.h>
> -#include <mach/dma.h>
>  #include <mach/gpio-samsung.h>
>
>  #include <linux/platform_data/mmc-s3cmci.h>
> --
> 2.17.1
>
