Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94859C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F9420814
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx9OGy4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgEUXgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbgEUXgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:36:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08C8C061A0E;
        Thu, 21 May 2020 16:36:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z13so753939ljn.7;
        Thu, 21 May 2020 16:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lr98ZQrqyjyq4YHmrbVhJM5II0MqsnvpDjt/afn5t4w=;
        b=Tx9OGy4vx9rzTEcQprCyaNrtSKHDyMYRHrN8sRzHXQEHGsaC+B14RHS6W9MjWn8cmX
         g8CXGw4xQuLxNoZ/FGTQ75h7G4swvyBhbnuuZzayKF8panIezpxzup+QEkyhnF8NtsLU
         FTL5uKKqRqrshrgxadtEVlSTwuWysfK9KO9hBXkYmHdq9FpbJS9QwcXF9IGxQGbcd+as
         YzA+mznjebmM5wQOrxvbJWroQDWEFBkPNueQKEQkqLD1wEqXYRV99jym1Zk6No519M3M
         0n1x8XFF5pbcXebFYqWQCUc7uZjVIdj/qEF4UWURM44k4X6o72Fzg6JgoJNx2aN/DkFE
         Vz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lr98ZQrqyjyq4YHmrbVhJM5II0MqsnvpDjt/afn5t4w=;
        b=HZ6jO+JeRIaKSmHW7nGGYz//SDE5neWDrNg/5tD1HOQ+4L66fc3hPd7pPrkaOCdCGn
         tb+Vs81YAEHWGLBPySY79exsXr4CQsg3mGT7+PPXZFZ+FI4ymLPFLz4RiuY8AHFGL2wu
         Xz3DmPB3ShEkiwXc1BHYIGKcNxLSiE08qdiBXEMv3XN/E7LuDinTiUyGfTD+v9zRAR0o
         qWS1nVh3KhhHgeEcQrNGc93xFB3XDhieCDMrSDbf7IqfNDLQHzRu1T4BuOyo7sRDIUPJ
         Rgs4rJDCICYXGO+dXrOGy7aaaCg7No28UJE38gIvLxhaBiUFguaOdRUl2JnrmBoeEGk2
         Vd6w==
X-Gm-Message-State: AOAM532ft0KR3CqPpFk0t7+BYgnnXK1WjSt6i1St0N2o1ouJ9bchWBOm
        D8lbwVX565LPrbLPGSJeGJ6WFpTA/rq3TGNvK28=
X-Google-Smtp-Source: ABdhPJzzEPWtdHrxKa1zWAlgpwgZrqVYi188fUIWDzPZ1tyBFlk45BTjUFICGicQhkSH8FJVbgziH2Uzbta/Fl26OPU=
X-Received: by 2002:a05:651c:11d1:: with SMTP id z17mr3816234ljo.211.1590104196355;
 Thu, 21 May 2020 16:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200521073925.19633-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200521073925.19633-1-dinghao.liu@zju.edu.cn>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Fri, 22 May 2020 07:36:24 +0800
Message-ID: <CAL411-qb5nCqGF77vpcM=+kPm30ORg_aTxRoy5P-wEFPsqJBKA@mail.gmail.com>
Subject: Re: [PATCH] usb: cdns3: Fix runtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Colin Ian King <colin.king@canonical.com>,
        Roger Quadros <rogerq@ti.com>,
        USB list <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 3:42 PM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/usb/cdns3/cdns3-ti.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index 5685ba11480b..e701ab56b0a7 100644
> --- a/drivers/usb/cdns3/cdns3-ti.c
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -138,7 +138,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
>         error = pm_runtime_get_sync(dev);
>         if (error < 0) {
>                 dev_err(dev, "pm_runtime_get_sync failed: %d\n", error);
> -               goto err_get;
> +               goto err;
>         }
>
>         /* assert RESET */
> @@ -185,7 +185,6 @@ static int cdns_ti_probe(struct platform_device *pdev)
>
>  err:
>         pm_runtime_put_sync(data->dev);
> -err_get:
>         pm_runtime_disable(data->dev);
>
>         return error;
> --

Reviewed-by: Peter Chen <peter.chen@nxp.com>
