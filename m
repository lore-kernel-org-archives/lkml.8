Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E206AC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA18A208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="WOEeBQJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBJCsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 21:48:30 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46723 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgBJCs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 21:48:29 -0500
Received: by mail-qk1-f194.google.com with SMTP id g195so5108522qke.13;
        Sun, 09 Feb 2020 18:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KhNOBWw692sW7TLm9JHYqZ1FYMPS0CnqLtLM69UIajg=;
        b=WOEeBQJ0t4o7kDPXaLRu2aiMGXa9fWpVN/m5JJSOjmwXl7Q2FdrY09xHs+kchDgXNs
         CkiFINK0K96swqWpkyUXYEeNGIfRuDlGs9agaZPvrJrN/8ArqvluPjUd5mGk8PP/BZde
         hmwlVX4z4biZzsRlWmJEelEq+bmi9W6kRHULM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KhNOBWw692sW7TLm9JHYqZ1FYMPS0CnqLtLM69UIajg=;
        b=ZiAF3Z2UNWDFqquXB/OhPkiRoOW9SXDbTsXXUO0tx1UOykm7ZkrkwpD9Qbkebi+y0k
         rTQuRezTQRb55CcppCINRPn3PHOzWUMCNaR6u4OLq1Qr7BlFRj7Esnq2R45p4nNVkqfL
         AEy3dx7is17GxY7rIzeaaBrFzaa9hIVztetjZRPulbbKe+tuH5uu9pMylpqcHwU/S59+
         wXJTLxe0vVEeD5EJF8EvZsSe1zTDimdJsVDOsDrKhlh0LMmhZ9WzR75UP0kts8YohUmI
         IVpRU7mtu78i5qeFFAQGlZ+xpJJpILx+DeHc6uDyE8msx3jMGx+Y2u/xthGe2UOoYFnf
         n+hg==
X-Gm-Message-State: APjAAAUQ01enXlY3uqkFlHef2h58zkipR9OpZ/3/pytKlkpgZkchBewB
        jZbIDX0f86xbEjz9A9JekP616pOTwc4HC53S6P0eq/SG
X-Google-Smtp-Source: APXvYqwi4wpb+TDqKMc2Iotgad5SAilC7344vZRaKVrhKX1IL3F/3MiUz7/wpQomKlkUZEydEsGijhtRhBVNloF/UGs=
X-Received: by 2002:a37:9dc8:: with SMTP id g191mr8766106qke.171.1581302908581;
 Sun, 09 Feb 2020 18:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20200131222157.20849-1-rentao.bupt@gmail.com> <20200131222157.20849-3-rentao.bupt@gmail.com>
In-Reply-To: <20200131222157.20849-3-rentao.bupt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 10 Feb 2020 02:48:17 +0000
Message-ID: <CACPK8XcmUYhnePr1AG2M9P-oGvOM=zCM+r44jWUzPYGxUEGOGw@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: gadget: aspeed: add ast2600 vhub support
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 at 22:22, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> Add AST2600 support in aspeed-vhub driver. There are 3 major differences
> between AST2500 and AST2600 vhub:
>   - AST2600 supports 7 downstream ports while AST2500 supports 5.
>   - AST2600 supports 21 generic endpoints while AST2500 supports 15.
>   - EP0 data buffer's 8-byte DMA alignment restriction is removed from
>     AST2600.
>
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/usb/gadget/udc/aspeed-vhub/Kconfig | 4 ++--
>  drivers/usb/gadget/udc/aspeed-vhub/core.c  | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> index 83ba8a2eb6af..605500b19cf3 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> @@ -4,5 +4,5 @@ config USB_ASPEED_VHUB
>         depends on ARCH_ASPEED || COMPILE_TEST
>         depends on USB_LIBCOMPOSITE
>         help
> -         USB peripheral controller for the Aspeed AST2500 family
> -         SoCs supporting the "vHub" functionality and USB2.0
> +         USB peripheral controller for the Aspeed AST2400, AST2500 and
> +         AST2600 family SoCs supporting the "vHub" functionality and USB2.0
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> index 94081cc04113..c827bf420278 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> @@ -42,6 +42,11 @@ static const struct ast_vhub_config ast2400_config = {
>         .max_epns = 15,
>  };
>
> +static const struct ast_vhub_config ast2600_config = {
> +       .max_ports = 7,
> +       .max_epns = 21,
> +};
> +
>  static const struct of_device_id ast_vhub_dt_ids[] = {
>         {
>                 .compatible = "aspeed,ast2400-usb-vhub",
> @@ -51,6 +56,10 @@ static const struct of_device_id ast_vhub_dt_ids[] = {
>                 .compatible = "aspeed,ast2500-usb-vhub",
>                 .data = &ast2400_config,
>         },
> +       {
> +               .compatible = "aspeed,ast2600-usb-vhub",
> +               .data = &ast2600_config,
> +       },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, ast_vhub_dt_ids);
> --
> 2.17.1
>
