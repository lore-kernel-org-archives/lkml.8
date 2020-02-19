Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A9BC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6BC20801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzniWRwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgBSK33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:29:29 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46145 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgBSK32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:29:28 -0500
Received: by mail-ua1-f65.google.com with SMTP id l6so8624351uap.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 02:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JMXibqU7pdFIdII16L/Y2AeVX/CI11svigC46gf8uU=;
        b=zzniWRwZoycxdKWo3bTAbQWaVxpy5CQGzW+0nidtIr77EZWl/cCZx19vDOZhjWvZRe
         p4t9rQ1ONJU2pZbwkIfSnLHNBeSyGflqKTLg2X+xxPUp2/fP9F7zjv+4f2KkizcjUDH7
         84nBCzOIfyHlHBLIQRPB0LIaTvdf4cW1Ojn5641hnjyoRgjm2haN6JfhhoBmIGU4WHcS
         gGuh6IZhW6sAQc0Csy727H0aAwHSk1cEjCFo3UdvwUH/ldH71Cm8rueaexzFTRgEjASO
         LLuaDLyLelIt7eXTO+LLbenQ/4CZCDhNSkkA3ZlWI9T68Xhm5+3UiGC+3QHkZyUwVhHZ
         jkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JMXibqU7pdFIdII16L/Y2AeVX/CI11svigC46gf8uU=;
        b=rQmEWe7tF/TZ7pNeJnBZ9F5Ron69IzdpOLNUHTdcQKVMhu2Zd7u7A8A1OB63FvP+f0
         zIT1h99D764AoU2dp26IhES0hFrIhWrcVzmj0XQt6DpzyIBiIYYsd4Rz2Q3vEPALv8lo
         SC3hGDHnEdrIWVMT62ukUsNQVyei0N8MXmY3ML8ab4J16cB7mj/s3mVFB48m2koTIWwz
         6cbEAUBoXXnnNKOKgoFAq7hDxvlFDB+Lzds51QePxrjx76i5Te39gtqSTxmBcYmJwWXE
         jPK4XdKrNePDecOl3ccbqMUsobOUJwLTZhglHck+EV9xSF5y3d3WLVXnQWIujlz7EKvm
         lnuA==
X-Gm-Message-State: APjAAAXubSxtigB/7f08GMn//eC81sjOUJTVfTBxzO+4mOHseP+AwCZw
        Lg0vd8z0xv05Vu2R+ZrGUO/VE8o0U6+LzjkEE7+xgw==
X-Google-Smtp-Source: APXvYqzltx18jQ/GN6j6y5PblztBh+anBxCtM5CqYz0EqlghKAvb6lvUng+oaF2oUU44zSaQHTDNiUkIX+LzpAamcAo=
X-Received: by 2002:a9f:3046:: with SMTP id i6mr12953039uab.15.1582108167823;
 Wed, 19 Feb 2020 02:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20200128090636.13689-1-ludovic.barre@st.com>
In-Reply-To: <20200128090636.13689-1-ludovic.barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Feb 2020 11:28:51 +0100
Message-ID: <CAPDyKFr+7SvRasPPjFDA2kwG0ERS-Qp3FGbVbRGLrscz5N=L2g@mail.gmail.com>
Subject: Re: [PATCH V2 0/9] mmc: mmci: sdmmc: add sdr104 support
To:     Ludovic Barre <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020 at 10:06, Ludovic Barre <ludovic.barre@st.com> wrote:
>
> To support the sdr104 mode, sdmmc variant needs:
> -Hardware delay block support for sdmmc variant
>  with tuning procedure
> -Voltage switch callbacks
> -sdmmc revision 2.0
>
> V2:
> -regroup host->mmc_ops & mmc->ops assignment
> -add timeout define
> -rename prep_volt_switch to pre_sig_volt_switch
> -rename volt_switch to post_sig_volt_switch
> -add 'why' comment for "mmc: mmci: add volt_switch callbacks"
>
> Ludovic Barre (9):
>   mmc: mmci: sdmmc: replace sg_dma_xxx macros
>   mmc: mmci: sdmmc: rename sdmmc_priv struct to sdmmc_idma
>   mmc: mmci: add a reference at mmc_host_ops in mmci struct
>   mmc: mmci: add private pointer for variant
>   dt-bindings: mmc: mmci: add delay block base register for sdmmc
>   mmc: mmci: sdmmc: add execute tuning with delay block
>   mmc: mmci: add volt_switch callbacks
>   mmc: mmci: sdmmc: add voltage switch functions
>   mmc: mmci: add sdmmc variant revision 2.0
>
>  .../devicetree/bindings/mmc/mmci.txt          |   2 +
>  drivers/mmc/host/mmci.c                       |  42 +++-
>  drivers/mmc/host/mmci.h                       |   8 +
>  drivers/mmc/host/mmci_stm32_sdmmc.c           | 204 +++++++++++++++++-
>  4 files changed, 248 insertions(+), 8 deletions(-)
>
> --
> 2.17.1
>

Applied for next, thanks!

I took the liberty to do minor amendments to some of the changelogs,
but in particular I have change some of prefixes for the commit
message headers into "mmc: mmci_sdmmc:".

Please tell, if there is anything that you want me to update.

Kind regards
Uffe
