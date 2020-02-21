Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAF6C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D3424650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWp3YZG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgBUOcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:32:25 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33214 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbgBUOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:32:25 -0500
Received: by mail-vs1-f68.google.com with SMTP id n27so1338008vsa.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 06:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+T/nTWLVypJORJXCwa4ga2EPqUEuusIhThd5QwEDQx8=;
        b=DWp3YZG8XfF7W2prVBJFn5HThD5MWoDpKktRNcwWcpCqIKD8lelQAFToMLxIa0olSE
         vBsASDg+j005oqdt0G1etW5BGqLH3l2UgNQFOsZ4XfNzgkNg5g1bQZznAjREwP4wmsig
         m8tjoAiLNpMK9CFQzF42YuwT1D93Xk+aGBztwPDfmWPwYuLge7pNAOzhzx3N6v/+tpqu
         +2LRnCCXR8DrRCRJH6BhBT0zX0Zn4lFjD4EOteoj0lMY7s4fsaAv6dCxHYnfPp9He/kp
         zwStf447IOANO9O15VrzRk0q+8GIHFppzGinr0DEUgrNxJnj+3VgHax1qA4N13D/vR5j
         ttTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+T/nTWLVypJORJXCwa4ga2EPqUEuusIhThd5QwEDQx8=;
        b=c5G8ovqkvt8on4s68FGmE13N33PsFcCWlf2RfiegBhjm9nsQ4lySI8GyoLFxGpb9IE
         nkEHvoZtnEcWBAbQhtQnSKx0WD/Pj1uX871UV1gktpQIcuH0JS/yqVXcsyBrYN8A1Do7
         VuAtP6f4ZeSNuJNMGaVandbw+N1IpAxBHG+w0Ym3KcxgLozfsXiD/Eu2pNstN60CclqH
         znTnqCSMxuDGHtZSR0HU0/texDf0BHkqXy5lql6CAg7W66YX6w2xnIDsWgygVG6POn1H
         OWy9dCyOKC3wLc8DwDv20GJ5WuurKFbHis9C4hiZ03etOXE0NwfB7vhuCl0M1Q21qrH3
         6avQ==
X-Gm-Message-State: APjAAAVMIZNbCVoI6wOdPih+IVqu/Mnt3AAR7Rt2joKJo1+0nHXv9BHW
        14rxFYQCmMjaONMlwpRY2BSaDHxGYNdmaG/qDfHlsrDa
X-Google-Smtp-Source: APXvYqwLbEtXvUZZ7ZM9CPw45EAOE34hAzqT0GbPWeSsCuzxil/wD30auUF1dvD2oftm+PT4KM4ou9K4GK6TZgakSws=
X-Received: by 2002:a67:5e45:: with SMTP id s66mr20602876vsb.200.1582295543699;
 Fri, 21 Feb 2020 06:32:23 -0800 (PST)
MIME-Version: 1.0
References: <98ce471185f037fce57520763621590588766381.1582161803.git.baolin.wang7@gmail.com>
In-Reply-To: <98ce471185f037fce57520763621590588766381.1582161803.git.baolin.wang7@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Feb 2020 15:31:47 +0100
Message-ID: <CAPDyKFrKe9vRpx6mKze98oM50Ux3JnHa-_2GL3PXdU=c_M1uZg@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: hsq: Add missing MODULE_LICENSE() and MODULE_DESCRIPTION()
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 at 02:31, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Add missing MODULE_LICENSE() and MODULE_DESCRIPTION() in hsq driver to
> fix below warning when compiling the hsq as a module.
>
> "WARNING: modpost: missing MODULE_LICENSE() in drivers/mmc/host/mmc_hsq.o".
>
> Fixes: eb1814dd49d5 ("mmc: Add MMC host software queue support")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmc_hsq.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index 2011988..59d2776 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
> +#include <linux/module.h>
>
>  #include "mmc_hsq.h"
>
> @@ -341,3 +342,6 @@ int mmc_hsq_resume(struct mmc_host *mmc)
>         return mmc_hsq_enable(mmc, NULL);
>  }
>  EXPORT_SYMBOL_GPL(mmc_hsq_resume);
> +
> +MODULE_DESCRIPTION("MMC Host Software Queue support");
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.9.5
>
