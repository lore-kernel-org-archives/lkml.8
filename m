Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9FDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE2520723
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="XapPMAEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390066AbgF3RLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729963AbgF3RLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:11:45 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89C2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:11:45 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id r8so18106133oij.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6lSgVeA93DCHghp99iRZTr3CJQ2lDjyf7D10bnB+3k=;
        b=XapPMAEZS4jVctBmBZKJ8vCZ/i7L2ArM2qhXywE0k7b3PIebPTicElaNmHrU6W9qP9
         KryFgnIsW3mIajUuQTWIANDkKsxjraFzxOXjENAPYxn9E9LNlBU7rVdVrXL9aeO07daw
         NgA7TdbDqL3gfOgHer+ux7BsiunM7luK3x1hK+cEq6++OtzPQlLvu9cuFhbdqZdxvM61
         q4AvOI+Sj5+Np4trqhtHcODJbI9Bzpx0qzwA6NgBcjBy3EdT7LrmKJ2yXXQjMxh6+hi/
         ARhEcdhI3B1pheABqRHIwfyyoFkdUrkOQUWIZvPSdebim7NQ4fPXVXMxQPjJNtwOcFcm
         XFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6lSgVeA93DCHghp99iRZTr3CJQ2lDjyf7D10bnB+3k=;
        b=da+EO+zlL7uhAesVRzNsqDq6z/WBdBk0egC7LbvbFTkATbNqSbIfr/BQXO8ExUZYiB
         0tAjhdRbX3DTWEwQLLbL4/mPB+bSnOcP8BakF68EEm8QityiTjhJCRxHSRyrH2NxtWWt
         4cF+wJ3abd8XqArnhV2W5BrEtEcYnEMsEPtZWk41oOdIEbzZxiaL59NLawJYlgOBmEA9
         E+ZswSutAA4BrBEikUj+Iz/Nyc5LUxg+YbT2NeMJQ91ghsCzJT0GZiibJLHJhCl+OJfP
         IB6EOSlMenClgCe24QV2CF8qdhuf39ekanReHMlSs2u210dqIM1kHfqEhkODt4fm8zUX
         KenQ==
X-Gm-Message-State: AOAM5315A6UKaha7k8eLar8yP1w0ZaM9dpAgxAYsZNsJaKBHG3KiDcdT
        IcyhHB/Gi+SSKp2+kSeZDuRCWMi/r6niEm7meQsHPg==
X-Google-Smtp-Source: ABdhPJwHLEvL13OlN1nVnjnXqgKuzVl9BoGBJtcpUVch4pSGN04fvG8FxhoUt07tRL3aiCftdAEvDahNYUF5Q+8jts4=
X-Received: by 2002:aca:c0d5:: with SMTP id q204mr6340821oif.142.1593537104734;
 Tue, 30 Jun 2020 10:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <1590679677-2678-1-git-send-email-tharvey@gateworks.com>
In-Reply-To: <1590679677-2678-1-git-send-email-tharvey@gateworks.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 30 Jun 2020 10:11:33 -0700
Message-ID: <CAJ+vNU1sEqo4ty68-9LeKFd4oY-qKiEt7_unp-1oCjX=+XQr7g@mail.gmail.com>
Subject: Re: [PATCH] can: mcp251x: add support for half duplex controllers
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Sean Nyekjaer <sean@geanix.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?VGltbyBTY2hsw7zDn2xlcg==?= <schluessler@krause.de>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 8:28 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> Some SPI host controllers do not support full-duplex SPI and are
> marked as such via the SPI_CONTROLLER_HALF_DUPLEX controller flag.
>
> For such controllers use half duplex transactions but retain full
> duplex transactions for the controllers that can handle those.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/net/can/spi/mcp251x.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index 5009ff2..203ef20 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -290,8 +290,12 @@ static u8 mcp251x_read_reg(struct spi_device *spi, u8 reg)
>         priv->spi_tx_buf[0] = INSTRUCTION_READ;
>         priv->spi_tx_buf[1] = reg;
>
> -       mcp251x_spi_trans(spi, 3);
> -       val = priv->spi_rx_buf[2];
> +       if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
> +               spi_write_then_read(spi, priv->spi_tx_buf, 2, &val, 1);
> +       } else {
> +               mcp251x_spi_trans(spi, 3);
> +               val = priv->spi_rx_buf[2];
> +       }
>
>         return val;
>  }
> @@ -303,10 +307,18 @@ static void mcp251x_read_2regs(struct spi_device *spi, u8 reg, u8 *v1, u8 *v2)
>         priv->spi_tx_buf[0] = INSTRUCTION_READ;
>         priv->spi_tx_buf[1] = reg;
>
> -       mcp251x_spi_trans(spi, 4);
> +       if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
> +               u8 val[2] = { 0 };
>
> -       *v1 = priv->spi_rx_buf[2];
> -       *v2 = priv->spi_rx_buf[3];
> +               spi_write_then_read(spi, priv->spi_tx_buf, 2, val, 2);
> +               *v1 = val[0];
> +               *v2 = val[1];
> +       } else {
> +               mcp251x_spi_trans(spi, 4);
> +
> +               *v1 = priv->spi_rx_buf[2];
> +               *v2 = priv->spi_rx_buf[3];
> +       }
>  }
>
>  static void mcp251x_write_reg(struct spi_device *spi, u8 reg, u8 val)
> @@ -409,8 +421,16 @@ static void mcp251x_hw_rx_frame(struct spi_device *spi, u8 *buf,
>                         buf[i] = mcp251x_read_reg(spi, RXBCTRL(buf_idx) + i);
>         } else {
>                 priv->spi_tx_buf[RXBCTRL_OFF] = INSTRUCTION_READ_RXB(buf_idx);
> -               mcp251x_spi_trans(spi, SPI_TRANSFER_BUF_LEN);
> -               memcpy(buf, priv->spi_rx_buf, SPI_TRANSFER_BUF_LEN);
> +               if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
> +                       spi_write_then_read(spi, priv->spi_tx_buf, 1,
> +                                           priv->spi_rx_buf,
> +                                           SPI_TRANSFER_BUF_LEN);
> +                       memcpy(buf + 1, priv->spi_rx_buf,
> +                              SPI_TRANSFER_BUF_LEN - 1);
> +               } else {
> +                       mcp251x_spi_trans(spi, SPI_TRANSFER_BUF_LEN);
> +                       memcpy(buf, priv->spi_rx_buf, SPI_TRANSFER_BUF_LEN);
> +               }
>         }
>  }
>
> --
> 2.7.4
>

Marc / Wolfgang,

Any feedback on this?

Best Regards,

Tim
