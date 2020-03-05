Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57BCC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD5420801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QiMaHeiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgCEQRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:17:04 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33387 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgCEQRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:17:03 -0500
Received: by mail-io1-f65.google.com with SMTP id r15so7126048iog.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 08:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKjzEJMa9fe0PK3n0GkSSdo/FdjChSUpIwJDlTYh97U=;
        b=QiMaHeiSTJFP6UFJmbCXKjB+4nX0XCEjJu+Rsrs6hvaZ9brVoePcMg71hYOmttDytV
         Dhk1MdOs+qEZGatjDQ4OlqOsagcAfN6ua+iOtlMCg4Vu25OgIbsoGMIkI+TWobK3/lz2
         o78biGJDirONtSS2xRidOq8Mq6L2qZ3tTogPcEaKZ+XxidOZqmPXMBScwoIS6xajXiBn
         MdnAXtKjreVO43RPngwPA8kFjwZfPAjIF/Cfu4tjSQZWDBHgMnCokRplyIQqtnNPKk3z
         v3Xy7ZlT8IAc789E7dXAto/cJFpLbHbSA0H7ZdET+f/HWzkny87uDeD9uBWle7cMAqni
         qjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKjzEJMa9fe0PK3n0GkSSdo/FdjChSUpIwJDlTYh97U=;
        b=dlwmznAAgOtsidQ8r7HFXEB9z7U+tJzGGLI7g/ryeuNtHlQNnzSFuyV52jkLKEgDd2
         qe1Utk4u405zdxyLwKp7WJvKJAAPPbvsIQDIDDBdwNGxKr3FgtDwSG3xSA33l5IuKXty
         7Q+HIY9k7lxrW2cXyzJxg1mL2Nq+Lr7y1Vp3xcwMSN3HAAQKE4UoiFxrZLAn/uc1HkxQ
         iTwx/zLUb6s1iKfCyWzw0dPMTgQmdBg5v785Cw9BqyT9kedlOnnLD4Exob4pYzBCZf51
         3MwG0hAHViZyH7xgLuKdfmbUzBn4SNxHAbxImq/QsnY+CAKDpxnSKwlkGZJcm2d7ZmPR
         EV9w==
X-Gm-Message-State: ANhLgQ2ArPjAQ2NiDEoOvl91ITD5WC2fK5T/0/zPF3IyRC5qJrLHrK+U
        QrjakLC46q+zf3Pn5kGTDNF90ziGBX523b32yGPcTg==
X-Google-Smtp-Source: ADFU+vs/EhZ+fp249v7LdQYx8Y8WWjr0qHKosDWHsPMEx9WRmNCCS8qpg2xo/DQYa5d00clxO7cglhbSPdx+Pwph6Us=
X-Received: by 2002:a5d:9b94:: with SMTP id r20mr7035294iom.140.1583425022687;
 Thu, 05 Mar 2020 08:17:02 -0800 (PST)
MIME-Version: 1.0
References: <20200304142628.8471-1-NShubin@topcon.com>
In-Reply-To: <20200304142628.8471-1-NShubin@topcon.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 5 Mar 2020 09:16:51 -0700
Message-ID: <CANLsYkzPROdphvmtpZ6YiajZ2dYLrojC-rGYkq4jK2yzTnAJ5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] remoteproc: imx_rproc: dummy kick method
To:     Nikita Shubin <NShubin@topcon.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 07:25, Nikita Shubin <NShubin@topcon.com> wrote:
>
> add kick method that does nothing, to avoid errors in rproc_virtio_notify.
>
> Signed-off-by: Nikita Shubin <NShubin@topcon.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 3e72b6f38d4b..796b6b86550a 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -240,9 +240,15 @@ static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
>         return va;
>  }
>
> +static void imx_rproc_kick(struct rproc *rproc, int vqid)
> +{
> +
> +}
> +

If rproc::kick() is empty, how does the MCU know there is packets to
fetch in the virtio queues?

>  static const struct rproc_ops imx_rproc_ops = {
>         .start          = imx_rproc_start,
>         .stop           = imx_rproc_stop,
> +       .kick           = imx_rproc_kick,
>         .da_to_va       = imx_rproc_da_to_va,
>  };
>
> --
> 2.24.1
>
