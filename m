Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775B1C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B942064B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbgGOJhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:37:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38536 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbgGOJhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:37:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id t18so968623otq.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWp7nWgHjnZaqCpFQfZuC5eqi869KUC7JN5+uHQNEnY=;
        b=EiWSgARTJj6pZpYTPcO3PL9hvL0ab0VKPGONDdAsMZn0D8U6bEDTK9rI5o107NFwa9
         a9Jkty58uAcmy5zeiewy28Z2kPVx06mEzqJXypXqndP64iInYDQCTMMaYIm/tyoTWsly
         KE3YllcWqHOAUKoyfPkUDW3AWShFzpg4PPUxeA9DkHHEaw5s00Stt7t3ytxBKmuTbYXM
         zWqxNJ17v+vdtLALTSPj6eXyKawG4jjQEpOpnW4WgD9QhJx0GZY2v6pxSReFXKBuP+An
         psZ8TbdeqLdcVwyUaiLBsq4ZpkUz8+eVu+KLrVoPdANDTrXigGuxKnbtEXx72rPbnjiT
         G1gA==
X-Gm-Message-State: AOAM530r4y7rPKA/XmRBkbFOSCI+a/C0h8tiFPpCVnwP9xOifVABi0BE
        uLVqaomaW1rtR29NQFObSsttoF8gIJENpLQcJS4=
X-Google-Smtp-Source: ABdhPJwfowNirhlLmiSJKaAj1mLc/o1S7QZdxHWP3yfsmLS2or0kjB8TvuxOXCPnQCicB7JXMvkD656N8EMG2EDeS8w=
X-Received: by 2002:a05:6830:1451:: with SMTP id w17mr7982898otp.250.1594805870335;
 Wed, 15 Jul 2020 02:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <1594234423-30914-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594234423-30914-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jul 2020 11:37:39 +0200
Message-ID: <CAMuHMdUohbEmw2g23OOTxNyTxU8t8TySuBo9q075H1eG9gOApQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable R-Car PCIe endpoint driver
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

CC Arnd

On Wed, Jul 8, 2020 at 8:54 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Enable R-Car PCIe endpoint driver on RZ/G2E board, including enabling
> endpoint configurations CONFIG_PCI_ENDPOINT, CONFIG_PCI_ENDPOINT_CONFIGFS,
> CONFIG_PCI_EPF_TEST and CONFIG_PCI_ENDPOINT_TEST required to use and test
> the driver.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -196,6 +196,7 @@ CONFIG_HOTPLUG_PCI_ACPI=y
>  CONFIG_PCI_AARDVARK=y
>  CONFIG_PCI_TEGRA=y
>  CONFIG_PCIE_RCAR_HOST=y
> +CONFIG_PCIE_RCAR_EP=y
>  CONFIG_PCI_HOST_GENERIC=y
>  CONFIG_PCI_XGENE=y
>  CONFIG_PCIE_ALTERA=y
> @@ -212,6 +213,9 @@ CONFIG_PCIE_ARMADA_8K=y
>  CONFIG_PCIE_KIRIN=y
>  CONFIG_PCIE_HISI_STB=y
>  CONFIG_PCIE_TEGRA194_HOST=m
> +CONFIG_PCI_ENDPOINT=y
> +CONFIG_PCI_ENDPOINT_CONFIGFS=y

It's a pity the above can't be modular.

> +CONFIG_PCI_EPF_TEST=y

But at least this one can, and should, IMHO.

>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_FW_LOADER_USER_HELPER=y
> @@ -242,6 +246,7 @@ CONFIG_BLK_DEV_NBD=m
>  CONFIG_VIRTIO_BLK=y
>  CONFIG_BLK_DEV_NVME=m
>  CONFIG_SRAM=y
> +CONFIG_PCI_ENDPOINT_TEST=y

Same here.

>  CONFIG_EEPROM_AT24=m
>  CONFIG_EEPROM_AT25=m
>  CONFIG_UACCE=m

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
