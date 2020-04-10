Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171E1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78982064A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDJJvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 05:51:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45344 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgDJJvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 05:51:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id 60so1345731otl.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 02:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ne1I5N3/wwuCfWlSTIbXPwHMGfTFfxhjkMy1Sgth4kw=;
        b=GCxr70EgnIaS4wOYLFrEFW1adtHs3PgidfK1oj5KD8FMo1vTBwWQly5nXkjuSeSmWF
         rbeMvRRU/MkzVJ8/1/QLBqSaSuwbjC+Ah/K6OpCLsZW0wi4D1I098mwees/yyx+EkN7P
         S76HIh2hUT53UR1Xmeb6OoziwN8oH/oQSDzDswn4RS5qAGCbu99x0XF7YK0Zbs7b/b1C
         T8uyzKHtbdY5cYuBeUTJqvSi1LCcQNE5EYCsRXyXvnHg/3dcDOSU8nVHEbzVhCs/tDFC
         QOGtMIH/Yxra42gckq8xlbdX3Ib2DwpOENp+uw289/JL3P+/GR8spS/oi2fv5WWYS4LO
         YI9g==
X-Gm-Message-State: AGi0PuZoBC72wxtHBNwPZaulP7XVC7TW/6T7fGynP+8MQQytzRUaeCK1
        40L2RmBuATUEPDZA+xfIXsoLqigo3dmiPVV/lkUruA==
X-Google-Smtp-Source: APiQypLelDB1zoePDN1AZwr/IomIMzDCxsIWWOt5sev9LXyBBr/1uuDSUDuLoi1OAti/KVSHWW08qdSrZW5MvcOcb9U=
X-Received: by 2002:a4a:a442:: with SMTP id w2mr3477255ool.90.1586512294559;
 Fri, 10 Apr 2020 02:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200405081355.2870-1-mst@redhat.com>
In-Reply-To: <20200405081355.2870-1-mst@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Apr 2020 11:51:22 +0200
Message-ID: <CAMuHMdXedy2knwgW7-tYB8-d=RaqpvQcoL-MQp3WAED-g1Xpkw@mail.gmail.com>
Subject: Re: [PATCH] vdpa-sim: depend on HAS_DMA
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Sun, Apr 5, 2020 at 10:17 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> set_dma_ops isn't available on all architectures:
>
>         make ARCH=um
> ...
>
>    drivers/vdpa/vdpa_sim/vdpa_sim.c: In function 'vdpasim_create':
> >> drivers/vdpa/vdpa_sim/vdpa_sim.c:324:2: error: implicit declaration of function 'set_dma_ops'; did you mean 'set_groups'?
> +[-Werror=implicit-function-declaration]
>      set_dma_ops(dev, &vdpasim_dma_ops);
>      ^~~~~~~~~~~
>      set_groups
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

As this fixes the Sun-3 all{mod,yes}-config build, which has NO_DMA=y:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

However, you may want to follow Christoph's suggestion instead.

> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -14,7 +14,7 @@ if VDPA_MENU
>
>  config VDPA_SIM
>         tristate "vDPA device simulator"
> -       depends on RUNTIME_TESTING_MENU
> +       depends on RUNTIME_TESTING_MENU && HAS_DMA
>         select VDPA
>         select VHOST_RING
>         select VHOST_IOTLB

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
