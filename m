Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2FDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256052073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgEVTjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 15:39:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39742 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbgEVTjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 15:39:12 -0400
Received: by mail-io1-f68.google.com with SMTP id q129so3436199iod.6;
        Fri, 22 May 2020 12:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8n27llGBeVRgfd979EvYTTRTeep7XY/1kt8A/YmuXc=;
        b=hCAebyAUbE8DZwFiN3wWkIW2exfkDrv89JhSn/eHGnSFikemNEU6nXsHTLg7jeLIhL
         r/xLXT3mh7sZWl3MoBSeaDkCdBG7FOkCnCYDHhMO2e/gJpBBH4HihCOnUkAB4pN43d3g
         Tt5gx0mPwaSg6RNlC1SK+4i0560xBSQykmO76RQihvvlRtscWH49sF0Xm/gId5XVnYYZ
         KwPZ53eOef0hXy4rKs9HH8k9V4UfYUS2yB4KezCx6AbznQth4r4lEJ5QsncKIRyv4RkH
         3prxpH0s/WVzoNR8NLrS0bzp89YNOhKwVVApUevxbo3TuZKUpN3cmIUWCnlDoxaRbVu6
         q5bQ==
X-Gm-Message-State: AOAM532UWtLMZRGIR0g03M8mrpxK9q78Tj1QCb906uqdMjhkqd7gOFdX
        y2sk+nKLCyivK2kLsOhYCUa9qTfT
X-Google-Smtp-Source: ABdhPJwB9KGA8IFLJiCDzBO67AJ49jL9ehoxyoQUUr7/LFEDadS344KBn077HMRzIZKQtLYuY5jAHA==
X-Received: by 2002:a05:6602:2c88:: with SMTP id i8mr4522773iow.74.1590176350736;
        Fri, 22 May 2020 12:39:10 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id x13sm4907320ilq.48.2020.05.22.12.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 12:39:10 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id j2so11817091ilr.5;
        Fri, 22 May 2020 12:39:10 -0700 (PDT)
X-Received: by 2002:a05:6e02:f:: with SMTP id h15mr14323365ilr.90.1590176350216;
 Fri, 22 May 2020 12:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200520040221.10536-1-qiang.zhao@nxp.com> <20200520040221.10536-2-qiang.zhao@nxp.com>
In-Reply-To: <20200520040221.10536-2-qiang.zhao@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 22 May 2020 14:38:47 -0500
X-Gmail-Original-Message-ID: <CADRPPNQEA1R6Ef=2r1w+KhUsKi2=_aJtFqrKO+Nj+b0WAyEVeQ@mail.gmail.com>
Message-ID: <CADRPPNQEA1R6Ef=2r1w+KhUsKi2=_aJtFqrKO+Nj+b0WAyEVeQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: Add ds26522 node to dts to ls1043ardb
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:08 PM Qiang Zhao <qiang.zhao@nxp.com> wrote:
>
> From: Zhao Qiang <qiang.zhao@nxp.com>

Maybe remove the duplicated dts in the title?

>
> Add ds26522 node to fsl-ls1043a-rdb.dts
>
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> v3:
>  - use "arm64: dts:" format for subject
>
> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> index 44d9343..1cb265f 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> @@ -94,6 +94,22 @@
>                 reg = <0>;
>                 spi-max-frequency = <1000000>; /* input clock */
>         };
> +
> +       slic@2 {

If this is a plugin card for the board, will this cause any problem
when the card is not plugged in?

> +               compatible = "maxim,ds26522";
> +               reg = <2>;
> +               spi-max-frequency = <2000000>;
> +               fsl,spi-cs-sck-delay = <100>;
> +               fsl,spi-sck-cs-delay = <50>;
> +       };
> +
> +       slic@3 {
> +               compatible = "maxim,ds26522";
> +               reg = <3>;
> +               spi-max-frequency = <2000000>;
> +               fsl,spi-cs-sck-delay = <100>;
> +               fsl,spi-sck-cs-delay = <50>;
> +       };
>  };
>
>  &duart0 {
> --
> 2.7.4
>
