Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4979DC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A18920776
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lRAgf2/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgDQJb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbgDQJb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:31:28 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B57C061A10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:31:28 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id b5so778513vsb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0DhfyrheLxlm64HysXnEP/oVk+ltHF14up7W9jwtxhE=;
        b=lRAgf2/Bnpu2lykOzQs3F063/lNbfp+Cv6oHIsGRQ+rHDzwagnMciX5ErpIVeWyZlR
         xaDIoPsB6CDvbCvYko+CiA/QO06lGnL1kuEQZAitTjAK6tKrZ4L7pwWHiDKL0TtRWhET
         +tLK4WLk9qaJ5znN/CNYFnuISQqDVdyberPQsDOQOOelA7+YDPzsTkUBhlzFdaKMgQRj
         bh95PvcMW1cZE5xDBeU5iZ6IbGXdippth6/neIS8M0zKfWJ0EPLPlTsnSUCrMOD7sRFA
         mCIXZSX+l22OYHO1jRKgutQ7f9u+NLeWnBcvI5cDjg5h3hoJtlfmljq7QEh8aTiKpE07
         YZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DhfyrheLxlm64HysXnEP/oVk+ltHF14up7W9jwtxhE=;
        b=Pfnok3RfAw4lAkfGzHXdZl+OSEZ7pYWPhjK0YPPQSaQEqXLVMs+XvuJos1ijlXekTt
         zTMvLjH2l2TTEhPsipKep93wGJej1MoyNVesOSCs7dK/5ObkFP4CW5dbZ1pBlf30LgNq
         bMU3cUW71Ekl5833Ehqlo1u8H4OLDHd5OV2kEV0JO9BYqRRVTXrkdzXrsh9X3Lw2fIOb
         umsiwUTDJyAS3h5bDpm3x3EgBC24Z5cd2t6CvPaTw2DEX7gkXTcyQMgI7EBViP7p7Irq
         iZrVaKzTB5XxKTY8OdK7Lz7FSG9LiQpOvDjbogWReBg+8HlzTMIGl/+4tMW34UM4tlWC
         uxmQ==
X-Gm-Message-State: AGi0PuZELlm89P5MjfBjOBwZiz9QrA8dmqcJmlA2yv2Kc7z1JurTj1Aj
        1IqTHkLvpyT+koyeadIDqhkH2MY0C7Uo+JRg0KQcmA==
X-Google-Smtp-Source: APiQypJFpluAtonYOz7KEkFYaq6sAXwzGMK54pnlbluzocgJFaP8Z2VGGgHHo1RAOcCOlj2KGfMDe9mEhtqqe5bCTd8=
X-Received: by 2002:a67:ead1:: with SMTP id s17mr1470684vso.200.1587115887252;
 Fri, 17 Apr 2020 02:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200413162717.1.Idece266f5c8793193b57a1ddb1066d030c6af8e0@changeid>
In-Reply-To: <20200413162717.1.Idece266f5c8793193b57a1ddb1066d030c6af8e0@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Apr 2020 11:30:51 +0200
Message-ID: <CAPDyKFog4f1GuZC3BpY-P4yX_FNogGi3x5M3KQmhoO7OQsdQVw@mail.gmail.com>
Subject: Re: [PATCH] mmc: cqhci: Avoid false "cqhci: CQE stuck on" by not
 open-coding timeout loop
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Konstantin Dorfman <kdorfman@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 at 01:27, Douglas Anderson <dianders@chromium.org> wrote:
>
> Open-coding a timeout loop invariably leads to errors with handling
> the timeout properly in one corner case or another.  In the case of
> cqhci we might report "CQE stuck on" even if it wasn't stuck on.
> You'd just need this sequence of events to happen in cqhci_off():
>
> 1. Call ktime_get().
> 2. Something happens to interrupt the CPU for > 100 us (context switch
>    or interrupt).
> 3. Check time and; set "timed_out" to true since > 100 us.
> 4. Read CQHCI_CTL.
> 5. Both "reg & CQHCI_HALT" and "timed_out" are true, so break.
> 6. Since "timed_out" is true, falsely print the error message.
>
> Rather than fixing the polling loop, use readx_poll_timeout() like
> many people do.  This has been time tested to handle the corner cases.
>
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Applied for fixes, and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/cqhci.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index c2239ee2c0ef..75934f3c117e 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -5,6 +5,7 @@
>  #include <linux/delay.h>
>  #include <linux/highmem.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
> @@ -349,12 +350,16 @@ static int cqhci_enable(struct mmc_host *mmc, struct mmc_card *card)
>  /* CQHCI is idle and should halt immediately, so set a small timeout */
>  #define CQHCI_OFF_TIMEOUT 100
>
> +static u32 cqhci_read_ctl(struct cqhci_host *cq_host)
> +{
> +       return cqhci_readl(cq_host, CQHCI_CTL);
> +}
> +
>  static void cqhci_off(struct mmc_host *mmc)
>  {
>         struct cqhci_host *cq_host = mmc->cqe_private;
> -       ktime_t timeout;
> -       bool timed_out;
>         u32 reg;
> +       int err;
>
>         if (!cq_host->enabled || !mmc->cqe_on || cq_host->recovery_halt)
>                 return;
> @@ -364,15 +369,9 @@ static void cqhci_off(struct mmc_host *mmc)
>
>         cqhci_writel(cq_host, CQHCI_HALT, CQHCI_CTL);
>
> -       timeout = ktime_add_us(ktime_get(), CQHCI_OFF_TIMEOUT);
> -       while (1) {
> -               timed_out = ktime_compare(ktime_get(), timeout) > 0;
> -               reg = cqhci_readl(cq_host, CQHCI_CTL);
> -               if ((reg & CQHCI_HALT) || timed_out)
> -                       break;
> -       }
> -
> -       if (timed_out)
> +       err = readx_poll_timeout(cqhci_read_ctl, cq_host, reg,
> +                                reg & CQHCI_HALT, 0, CQHCI_OFF_TIMEOUT);
> +       if (err < 0)
>                 pr_err("%s: cqhci: CQE stuck on\n", mmc_hostname(mmc));
>         else
>                 pr_debug("%s: cqhci: CQE off\n", mmc_hostname(mmc));
> --
> 2.26.0.110.g2183baf09c-goog
>
