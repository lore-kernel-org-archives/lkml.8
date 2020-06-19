Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2ACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149E520771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y7rVoh+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgFSAlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 20:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgFSAlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 20:41:13 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD019C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:41:12 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id g129so4666724vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uy5QSqrLYmnNfM/E3HqOfk0DC/EqnnxRUjL0YSZ6WgA=;
        b=Y7rVoh+ec4gvOWgtKpj1Vsh0QvK0RKO04loIzF9Re5iG2Mn3PaMhiKaKhmQ4K89iQX
         J4y+p2BKyyFUI702a+LS9XzNcrElaD7ju6TRYuaV67aduc1HkNeWl8LB7KG/FwgZP0Lh
         P9C0n/RxLEFHwvxs46VLMJ74VyFL9/O7576nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uy5QSqrLYmnNfM/E3HqOfk0DC/EqnnxRUjL0YSZ6WgA=;
        b=c7pjbfNJmescSP/DhcjgqK2KeIVWn9YxZwefkbVyWO64sww6X+yRhuiwi+SBZEjde3
         VwnSZgfARSWmvokjivUmrzoUeX28N0BHqb2D+HVqb/2l5LuITjcfU6UlzQ9wZJoD4U9X
         0iyhhwsVz7O3TRSj9jiNqDjsYQfYxBZU+je+SjNOTydtSHeEqTe08TUW5jinLDlHbx/f
         co82rcVyWF1aW4tj/xa6ZCdXtz0SQZIBquMVgJicpIVrdoGpu0l9u1W/Ds/2cqt0syu2
         UZZoMRwipeEm0/h6z6OwQ78opBB92ToMQ5gmW7qZjiQadeFaJ1UiCg93uit2dAVQ0jDy
         giVQ==
X-Gm-Message-State: AOAM531gcIUav+f8Bc+l2WinusSW82FTt3ExuaAiD38LHCtdmDFDGh7c
        AFz3MQp/QrSVR/F8XNec/F640CsXHaY=
X-Google-Smtp-Source: ABdhPJxhB76buZ96Qubv4GhOuzOj3+LwBt3NMdPo7Q9qjpDABMAwRdlkhgyb8UJELF1wWc0VHIpMGA==
X-Received: by 2002:a67:e148:: with SMTP id o8mr5784021vsl.134.1592527271642;
        Thu, 18 Jun 2020 17:41:11 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id b69sm544344vkf.46.2020.06.18.17.41.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 17:41:11 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id o15so4631609vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:41:10 -0700 (PDT)
X-Received: by 2002:a67:e445:: with SMTP id n5mr5773162vsm.73.1592527270545;
 Thu, 18 Jun 2020 17:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200618150626.237027-1-dianders@chromium.org> <20200618233959.160032-1-swboyd@chromium.org>
In-Reply-To: <20200618233959.160032-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Jun 2020 17:40:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UwXKQcDPhqb0j+x-+kU1ZdBjVx52aY1JHx6oJRMLUPrg@mail.gmail.com>
Message-ID: <CAD=FV=UwXKQcDPhqb0j+x-+kU1ZdBjVx52aY1JHx6oJRMLUPrg@mail.gmail.com>
Subject: Re: [PATCH 6/5] spi: spi-geni-qcom: Simplify setup_fifo_xfer()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 18, 2020 at 4:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The definition of SPI_FULL_DUPLEX (3) is really SPI_TX_ONLY (1) ORed
> with SPI_RX_ONLY (2). Let's drop the define and simplify the code here a
> bit by collapsing the setting of 'm_cmd' into conditions that are the
> same.
>
> This is a non-functional change, just cleanup to consolidate code.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 636c3da15db0..670f83793aa4 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -51,7 +51,6 @@
>  /* M_CMD OP codes for SPI */
>  #define SPI_TX_ONLY            1
>  #define SPI_RX_ONLY            2
> -#define SPI_FULL_DUPLEX                3
>  #define SPI_TX_RX              7
>  #define SPI_CS_ASSERT          8
>  #define SPI_CS_DEASSERT                9
> @@ -357,12 +356,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>
>         mas->tx_rem_bytes = 0;
>         mas->rx_rem_bytes = 0;
> -       if (xfer->tx_buf && xfer->rx_buf)
> -               m_cmd = SPI_FULL_DUPLEX;
> -       else if (xfer->tx_buf)
> -               m_cmd = SPI_TX_ONLY;
> -       else if (xfer->rx_buf)
> -               m_cmd = SPI_RX_ONLY;
>
>         spi_tx_cfg &= ~CS_TOGGLE;
>
> @@ -373,12 +366,14 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>         len &= TRANS_LEN_MSK;
>
>         mas->cur_xfer = xfer;
> -       if (m_cmd & SPI_TX_ONLY) {
> +       if (xfer->tx_buf) {
> +               m_cmd |= SPI_TX_ONLY;
>                 mas->tx_rem_bytes = xfer->len;
>                 writel(len, se->base + SE_SPI_TX_TRANS_LEN);
>         }
>
> -       if (m_cmd & SPI_RX_ONLY) {
> +       if (xfer->rx_buf) {
> +               m_cmd |= SPI_RX_ONLY;

If you're going to touch this, could you change "SPI_TX_ONLY" to
"SPI_TX_ENABLED" and "SPI_RX_ONLY" to 'SPI_RX_ENABLED".  It felt
really weird to me that if you had full duplex you were setting
"RX_ONLY" and "TX_ONLY".

Other than that, your change is nice and cleans things up a bit, so
even if you don't do the extra cleanup:

Reviewed-by: Douglas Anderson <dianders@chromium.org>



-Doug
