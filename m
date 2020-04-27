Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C915C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1924206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588000673;
	bh=GAViimdK4fDnDt6xwfFThdx7LtwYD225IliGLg41saw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l3Z2EMHzV3uG9kcvmyWcfQtN7cRyM2U3SfitJYFuRZxfgO+RqJCrFm84lNJT6P7Mk
	 0shGvkR8BTbp+G4i41hGaunm1re+ccskGyIwPWRUm2dNzIYztWY8CsHlFL+e9Dwuld
	 zprv6PUsdBa0Cgg/AQsOlXIxgpjfMRu2bC3xQ3FM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgD0PRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD0PRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:17:51 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4147D206E9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588000671;
        bh=GAViimdK4fDnDt6xwfFThdx7LtwYD225IliGLg41saw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d9vkwjdTTR1LayfIUQrZuuh0K8KI99nJUoUy105Kssj/DAN830gEcpyL3PBNgNSqd
         LzDFnZXBB+KXfYurOZEnrJo9s3Li/U6qtBlzToQnjeH0pqXNOA+fdrFTHa2tD7TP4R
         BlYkUFvg+kwbDXojJlh2j4Ft7aQn2rxhe+asm4y0=
Received: by mail-qk1-f178.google.com with SMTP id q7so6214121qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 08:17:51 -0700 (PDT)
X-Gm-Message-State: AGi0PubQHOhdV86cncq9JnrDi8c08i00W5yKKqn23PH56PUMPik2Mut8
        VyHY2xyEyxL+QJMmCevKXt2JhYRn37jBoUmzFQ==
X-Google-Smtp-Source: APiQypJ8mFL+gjW5lKQgC6uwov2MJioYazUfFzUC1Buo0mAtWaA7rKgJG7DMRtEDKmm77diSPGR4BCMAcO05vMTTojk=
X-Received: by 2002:a37:61cd:: with SMTP id v196mr22311959qkb.393.1588000670247;
 Mon, 27 Apr 2020 08:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200424222740.16259-1-afd@ti.com>
In-Reply-To: <20200424222740.16259-1-afd@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Apr 2020 10:17:37 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+4mf6QHX27knoHTXA4vnsC3swuvAH7zK1DpyaV-p_qbw@mail.gmail.com>
Message-ID: <CAL_Jsq+4mf6QHX27knoHTXA4vnsC3swuvAH7zK1DpyaV-p_qbw@mail.gmail.com>
Subject: Re: [PATCH] misc: sram: Add dma-heap-export reserved SRAM area type
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 5:27 PM Andrew F. Davis <afd@ti.com> wrote:
>
> This new export type exposes to userspace the SRAM area as a DMA-Heap,
> this allows for allocations as DMA-BUFs that can be consumed by various
> DMA-BUF supporting devices.
>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  .../devicetree/bindings/sram/sram.yaml        |   8 +

Separate patch and needs to go to DT list...

>  drivers/misc/Kconfig                          |   7 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/sram-dma-heap.c                  | 243 ++++++++++++++++++
>  drivers/misc/sram.c                           |  20 +-
>  drivers/misc/sram.h                           |  17 ++
>  6 files changed, 292 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/misc/sram-dma-heap.c
>
> diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
> index 7b83cc6c9bfa..b8e33c8d205d 100644
> --- a/Documentation/devicetree/bindings/sram/sram.yaml
> +++ b/Documentation/devicetree/bindings/sram/sram.yaml
> @@ -105,6 +105,14 @@ patternProperties:
>            manipulation of the page attributes.
>          type: boolean
>
> +      dma-heap-export:
> +        description:
> +          Similar to 'pool' and 'export' this region will be exported for use
> +          by drivers, devices, and userspace using the DMA-Heaps framework.
> +          NOTE: This region must be page aligned on start and end in order to
> +          properly allow manipulation of the page attributes.
> +        type: boolean

Though I'm not sure this should be in DT. You have to change your
firmware to enable a new kernel feature? We also already have 'export'
which sounds like the same function. Or 'pool' though reading the
description, I don't really understand it's use.

What combination of all 3 of these options would be valid?

Rob
