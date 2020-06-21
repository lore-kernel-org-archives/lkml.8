Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5132AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 08:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7C620732
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 08:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgFUIfb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 04:35:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46069 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbgFUIfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 04:35:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id m2so10655879otr.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 01:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hPqD5KPRADuy466IsAAiRxi638VjNc9fQS26UU0hUmk=;
        b=FOVJyJqMd3Lm2l5bqRCXhZY9urizJo/5JuUdg6EeoAXm0zLaNwpxlC078zt1vfi4QF
         DHWItpacLOzX2eSinMjByjztVHv+L4XKr3OlwcmNbSrR8PcOvHi2rwiDlFGouvT1irXk
         obgyB3e7CgdJjOw0iR7/Y5+aVJk29ughpSewWfjpGbiQI8SSntQ+jdVL3nzMCbqYDXXv
         G+4ZO/JHvLwAd6+uJSc8mYKpDk+Sq5E5LNM2j39gu8S+hrgj++Y9Hy/mcZvSarWyQzGu
         TWV3pzKZ52idJeSCKocXfq9BS4vxTZXgSOjFdX/IQ7JmYOVznm3AKzyGvO4CV9p4fMIR
         qB2w==
X-Gm-Message-State: AOAM530d6UevIEKau+Sn9VO5OUko80X5eoB6hx37NrKdai8wY0m/FwWX
        fbxYg8IYwLZn/jknZmUALSduO+0+Lff7FVLBD7g=
X-Google-Smtp-Source: ABdhPJyEazFpaahNB3/OkhcB4ZGAQIGHmYndLb0+IkITPgAwA50Mh/46VZdmRMb2aDNtSkqXc093NsdJnwdm2aGrl8c=
X-Received: by 2002:a05:6830:141a:: with SMTP id v26mr9756776otp.250.1592728529630;
 Sun, 21 Jun 2020 01:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200608132217.29945-1-geert@linux-m68k.org> <20200620200936.GA106151@roeck-us.net>
In-Reply-To: <20200620200936.GA106151@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 21 Jun 2020 10:35:18 +0200
Message-ID: <CAMuHMdX3mBDm9iHk+jhbGfmo+dbix=3tp5z2ewyddWxM1tdqGQ@mail.gmail.com>
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter,

On Sat, Jun 20, 2020 at 10:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Jun 08, 2020 at 03:22:17PM +0200, Geert Uytterhoeven wrote:
> > On systems with at least 32 MiB, but less than 32 GiB of RAM, the DMA
> > memory pools are much larger than intended (e.g. 2 MiB instead of 128
> > KiB on a 256 MiB system).
> >
> > Fix this by correcting the calculation of the number of GiBs of RAM in
> > the system.  Invert the order of the min/max operations, to keep on
> > calculating in pages until the last step, which aids readability.
> >
> > Fixes: 1d659236fb43c4d2 ("dma-pool: scale the default DMA coherent pool size with memory capacity")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Acked-by: David Rientjes <rientjes@google.com>
>
> This patch results in a boot failure in some of my powerpc boot tests,
> specifically those testing boots from mptsas1068 devices. Error message:
>
> mptsas 0000:00:02.0: enabling device (0000 -> 0002)
> mptbase: ioc0: Initiating bringup
> ioc0: LSISAS1068 A0: Capabilities={Initiator}
> mptbase: ioc0: ERROR - Unable to allocate Reply, Request, Chain Buffers!
> mptbase: ioc0: ERROR - didn't initialize properly! (-3)
> mptsas: probe of 0000:00:02.0 failed with error -3
>
> Configuration is bamboo:44x/bamboo_defconfig plus various added drivers.
> Qemu command line is
>
> qemu-system-ppc -kernel vmlinux -M bamboo \
>      -m 256 -no-reboot -snapshot -device mptsas1068,id=scsi \
>      -device scsi-hd,bus=scsi.0,drive=d0,wwn=0x5000c50015ea71ac -drive \
>      file=rootfs.ext2,format=raw,if=none,id=d0 \
>      --append "panic=-1 slub_debug=FZPUA root=/dev/sda  mem=256M console=ttyS0" \
>      -monitor none -nographic
>
> canyonlands_defconfig with sam460ex machine and otherwise similar command line
> fails as well.
>
> Reverting this patch fixes the problem.

This looks like the minimum value of 128 KiB is not sufficient, and the
bug is in the intention of 1d659236fb43c4d2 ("dma-pool: scale the
default DMA coherent pool size with memory capacity")?
Before, there was a single pool of (fixed) 256 KiB size, now there are
up to three coherent pools (DMA, DMA32, and kernel), albeit of smaller
size (128 KiB each).

Can you print the requested size in drivers/message/fusion/mptbase.c:
PrimeIocFifos()?
Does replacing all SZ_128K by SZ_256K in my patch help?
That would waste^H^H^H^H^Hallocate 256 KiB or 512 KiB more, though.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
