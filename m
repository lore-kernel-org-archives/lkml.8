Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD62C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4722072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+Zzc+a9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbgFIPXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgFIPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:23:02 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26F7C05BD1E;
        Tue,  9 Jun 2020 08:23:02 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m81so23201144ioa.1;
        Tue, 09 Jun 2020 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tm2L6wHDp3vnilQA0CPW6PPlVERzEGHmJnGxVxjkT7E=;
        b=T+Zzc+a927fTmCQYyxa3HRIQOfzwB1rlff67AJQPfhedtRBsi15M7hvfbqDBXLIz2Q
         4KRSTB9cKCGWi5zszA165U7802EQ1b74v54j3AsREkXTLXlxzSrced4LqVHdtgrT1BQ9
         icKt9YViOgQcAKVNZjPcxK88gttpktYPeUNKqPo0gT68ATxzhYHzokNHc6pQNtrlY3IB
         KLlyZtOGJ7375RmWBKPKHCsRXSeqb8bmjuZkdeSsCP5k1BIfCRczdUBF+5569MGYmO+T
         9qN0v9U3DtCz4Hj+aIgzbWRsAMWfOM1PmMsRZr4OhT+ygqb8U0vc40a1PdHjSqLm2//i
         88sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tm2L6wHDp3vnilQA0CPW6PPlVERzEGHmJnGxVxjkT7E=;
        b=Z00A6fa/fFA0XEYYPSwjY//jtmBNL+jQFDxM54Ued2khmGn/rh+d2B6+XPF04zJCx6
         TvlKHr+zBzkXmE3bf2blhsJxPbt5ujR3trz72JZWxrofG3062Uz3SimglGzTaWHZHFNQ
         OrwT4ni7eKkBzoQ8Km5XaPsETdPXlCPQpAYa5slLueYgGT5qBDbJQNctaus3dyHjoxr/
         E2wWfKsqHqjv0XByhfBMjzL/SI6t6nn2rvC3EPiqeUeNkNQkSxbCVpMpPvb/22k0PcXM
         tHJjNCuvZlUcL4JFQEN4q4ODxlIul4BeqQ8+r9CEMhSqDNQiES34GdLclbQdPw8K12ly
         M8hg==
X-Gm-Message-State: AOAM532Kp0Gqo6rqP52Xzo2Oa0lZ/iwjKZ8+S0fjvT8NW1IZlVCo5aqd
        UrecXt6BsXnuEANlWFP+TVykLUJXAk95+i+sSLE=
X-Google-Smtp-Source: ABdhPJzVZNaa7SnqUFgCpq6WJTUKH4jHLaYl37zbFlWb1E6BwdaMRDZEkUg9vCMO67A149eiG/aXayH1ph7RpIU/MNM=
X-Received: by 2002:a05:6638:d05:: with SMTP id q5mr26413027jaj.2.1591716182166;
 Tue, 09 Jun 2020 08:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
 <1591605038-8682-3-git-send-email-dillon.minfei@gmail.com> <90df5646-e0c4-fcac-d934-4cc922230dd2@arm.com>
In-Reply-To: <90df5646-e0c4-fcac-d934-4cc922230dd2@arm.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Tue, 9 Jun 2020 23:22:24 +0800
Message-ID: <CAL9mu0+__0Z3R3TcSrj9-kPxsyQHKS9WqK1u58P0dEZ+Jd-wbQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm-nommu: Add use_reserved_mem() to check if device
 support reserved memory
To:     Vladimir Murzin <vladimir.murzin@arm.com>, hch@lst.de
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux@armlinux.org.uk, Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

Thanks for reviewing.

Hi Christoph Hellwig,

I just want to know if kernel dma mapping/direct is focused on
platforms with MMU.
leave arch code to handle dma coherent memory management themself for
no-MMU platform.

so, you just return error code in kernel/dma/mapping.c,direct.c
without CONFIG_MMU defined ?
which means dma-direct mapping doesn't support !CONFIG_MMU is not a
bug, but design as it's.
or, just return error code currently, will add dma direct mapping
support for !CONFIG_MMU in the
future?

As Vladimir Murzin's suggestion has changes in kernel code, I need
your input to get
the design goal about dma-direct mapping, thanks.

On Tue, Jun 9, 2020 at 10:07 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>
> On 6/8/20 9:30 AM, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > Currently, we use dma direct to request coherent memory for driver on armv7m
> > platform if 'cacheid' is zero, but dma_direct_can_mmap() is return false,
> > dma_direct_mmap() return -ENXIO for CONFIG_MMU undefined platform.
> >
> > so we have to back to use 'arm_nommu_dma_ops', add use_reserved_mem() to check
> > if device support global or device corherent memory. if yes, then call
> > set_dma_ops()
> >
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> >  arch/arm/mm/dma-mapping-nommu.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> > index 287ef898a55e..e1c213fec152 100644
> > --- a/arch/arm/mm/dma-mapping-nommu.c
> > +++ b/arch/arm/mm/dma-mapping-nommu.c
> > @@ -14,6 +14,7 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/outercache.h>
> >  #include <asm/cp15.h>
> > +#include <linux/of.h>
> >
> >  #include "dma.h"
> >
> > @@ -188,6 +189,31 @@ const struct dma_map_ops arm_nommu_dma_ops = {
> >  };
> >  EXPORT_SYMBOL(arm_nommu_dma_ops);
> >
> > +static bool use_reserved_mem(struct device *dev)
> > +{
> > +     struct device_node *np;
> > +
> > +     np = of_find_node_by_path("/reserved-memory/linux,dma");
> > +
> > +     if (np &&
> > +             of_device_is_compatible(np, "shared-dma-pool") &&
> > +             of_property_read_bool(np, "no-map") &&
> > +             of_property_read_bool(np, "linux,dma-default")) {
> > +             /* has global corherent mem support */
> > +             of_node_put(np);
> > +             return true;
> > +     }
> > +
> > +     np = of_parse_phandle(dev->of_node, "memory-region", 0);
> > +     if (np) {
> > +             /* has dev corherent mem support */
> > +             of_node_put(np);
> > +             return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >                       const struct iommu_ops *iommu, bool coherent)
> >  {
> > @@ -206,6 +232,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >               dev->archdata.dma_coherent = (get_cr() & CR_M) ? coherent : true;
> >       }
> >
> > -     if (!dev->archdata.dma_coherent)
> > +     if (!dev->archdata.dma_coherent || use_reserved_mem(dev))
> >               set_dma_ops(dev, &arm_nommu_dma_ops);
> >  }
> >
>
> Sorry I have to NAK this hack :(
>
> Digging git history reveled 79964a1c2972 ("ARM: 8633/1: nommu: allow mmap when !CONFIG_MMU")
> which make me wonder if diff below does the trick for you
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 8f4bbda..8623b9e 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -456,14 +456,14 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>  #else /* CONFIG_MMU */
>  bool dma_direct_can_mmap(struct device *dev)
>  {
> -       return false;
> +       return true;
>  }
>
>  int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>                 void *cpu_addr, dma_addr_t dma_addr, size_t size,
>                 unsigned long attrs)
>  {
> -       return -ENXIO;
> +       return vm_iomap_memory(vma, vma->vm_start, (vma->vm_end - vma->vm_start));;
>  }
>  #endif /* CONFIG_MMU */
Yes, this is a quite nice way to support !CONFIG_MMU without cache on
platforms. I will try your suggestion.
thanks

>
> Cheers
> Vladimir
