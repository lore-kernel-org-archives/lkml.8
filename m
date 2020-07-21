Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1F6C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26758207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595290925;
	bh=Da6qbEX+o6uaMHJDmFF0770XklkhAChY4ArFWsyOmmA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kzdLo9jJNuF/ubHYL6DcXzcAlclLnX+OyS6AlIuSxwWXJJeLd9/M2JambVEWuU5vA
	 MkqxJ8EBM3YSJKpZ0tx+inplxyFGjf3NkbffX+UNB6Ljl/zkeIKR+KM7nB3PBnmMAa
	 U/p8/i2b1xMHxkkCxmlEbnxDNSxmFU2ObeGaAu3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgGUAWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbgGUAWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:22:00 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05CB2080D;
        Tue, 21 Jul 2020 00:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595290919;
        bh=Da6qbEX+o6uaMHJDmFF0770XklkhAChY4ArFWsyOmmA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1piYj1C1iwDOdLUDzd1rpVvo9vemkWJsXS8URCuVmBS46JfALaTtF4CFjYAEuenRx
         +jMlCMyHpvZDdEsGvJ0CoPXR8b32rY/c1OXxwFthmAOfQxQUS1g7q7jovgKBJmLiqa
         /VmUOqCuAFq6Ad4vUGlG3bwxJWvcFC5mEinDh5Sk=
Received: by mail-ot1-f47.google.com with SMTP id e90so13752181ote.1;
        Mon, 20 Jul 2020 17:21:58 -0700 (PDT)
X-Gm-Message-State: AOAM531mxw6kpiBRe6xAK/ysT9gbXsjp7ak6UMiyQulUgoTufzuQRdlL
        L71u1+Gtl+MyPb0EgsCIDOraPBcST6XfuSQK+w==
X-Google-Smtp-Source: ABdhPJwGHRLkI27jNoNgF7ILMZHHY4pXlB5JpjB75m22H4vcQUfZq0NMhHBlUVhvdM2QlsP4dOjhti/AnlshASjzvYo=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr20938572otb.107.1595290918250;
 Mon, 20 Jul 2020 17:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200720074249.596364-1-jiaxun.yang@flygoat.com> <20200720074249.596364-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20200720074249.596364-2-jiaxun.yang@flygoat.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 20 Jul 2020 18:21:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKhs=m=q9YcdxFz8XPcn4KUOum3U_XwcLoxMs4FqjptXQ@mail.gmail.com>
Message-ID: <CAL_JsqKhs=m=q9YcdxFz8XPcn4KUOum3U_XwcLoxMs4FqjptXQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] of_address: Add bus type match for pci ranges parser
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paul Burton <paulburton@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 1:49 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> So the parser can be used to parse range property of different bus
> types, such as ISA bus.

Regular MMIO buses are actually already supported, but not ISA.

>
> As they're all using PCI-like method of range property, there is no need
> start a new parser.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/of/address.c       | 15 +++++++++++----
>  include/linux/of_address.h |  3 +++
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 8eea3f6e29a4..250c91767648 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -702,6 +702,10 @@ static int parser_init(struct of_pci_range_parser *parser,
>         parser->ns = of_bus_n_size_cells(node);
>         parser->dma = !strcmp(name, "dma-ranges");
>
> +       parser->bus = of_match_bus(node);
> +       if (!parser->bus)
> +               return -ENOENT;

You'll hit BUG() before you get here, so you can assume success.

> +
>         parser->range = of_get_property(node, name, &rlen);
>         if (parser->range == NULL)
>                 return -ENOENT;
> @@ -732,6 +736,7 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>         int na = parser->na;
>         int ns = parser->ns;
>         int np = parser->pna + na + ns;
> +       int bus_na = 0;
>
>         if (!range)
>                 return NULL;
> @@ -739,8 +744,10 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>         if (!parser->range || parser->range + np > parser->end)
>                 return NULL;
>
> -       if (parser->na == 3)
> -               range->flags = of_bus_pci_get_flags(parser->range);
> +       parser->bus->count_cells(parser->node, &bus_na, NULL);
> +
> +       if (parser->na == bus_na)
> +               range->flags = parser->bus->get_flags(parser->range);

I think you can just unconditionally call this and drop the else. For
plain MMIO bus, we'd just return IORESOURCE_MEM, but I think the flags
are ignored in that case.

>         else
>                 range->flags = 0;
>
> @@ -761,8 +768,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>                 u32 flags = 0;
>                 u64 pci_addr, cpu_addr, size;
>
> -               if (parser->na == 3)
> -                       flags = of_bus_pci_get_flags(parser->range);
> +               if (parser->na == bus_na)

This too can be unconditional.

> +                       flags = parser->bus->get_flags(parser->range);
>                 pci_addr = of_read_number(parser->range, na);

Perhaps rename pci_addr to child_addr and cpu_addr to parent_addr.

>                 if (parser->dma)
>                         cpu_addr = of_translate_dma_address(parser->node,
> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 763022ed3456..3929b4637033 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -6,8 +6,11 @@
>  #include <linux/of.h>
>  #include <linux/io.h>
>
> +struct of_bus;
> +
>  struct of_pci_range_parser {
>         struct device_node *node;
> +       struct of_bus *bus;
>         const __be32 *range;
>         const __be32 *end;
>         int na;
> --
> 2.28.0.rc1
>
