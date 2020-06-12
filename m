Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D2BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 02:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95D220823
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 02:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSvZe25C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFLCPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 22:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgFLCPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 22:15:47 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369F6C03E96F;
        Thu, 11 Jun 2020 19:15:46 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o5so8650394iow.8;
        Thu, 11 Jun 2020 19:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBuImNZJUOHAcMdNirnqNdfxcsQ2t26UAs7QUyiyLrA=;
        b=CSvZe25C2fwv4G8CtuJ5LGADD7XH1+hw3iXV3UPdybI2Wn5uesXsz6c2ZXa8XqBuNu
         9MUqBYO00T1Dlka13KaqXswvqCfxqtdF14PATYtXoQkymTy4LobTZZujA+y65BQXu6Vt
         IyFvDgL+E97bi2woUM6AIIy6coqRYOvjJnLFKXvWNREnlN0DiowuGK87YtfmPgB5ibRK
         /thKJEo3PcrmOyiF6jn3hMYxeLEiAJLnNc2XKn5suQGDqeR7nKzoLqk3Xntbh3ERpFNN
         7ytP9nTB8B4Q3ZYCpDFA8HEzYAmQ46D6slN1tB+7XqzPPcbzTFrGTDuamjgrj7UG8qCp
         WMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBuImNZJUOHAcMdNirnqNdfxcsQ2t26UAs7QUyiyLrA=;
        b=NvnR04LFS9ON8vcQa1xIH5Y6EtIp3irB/EppnaNwha9NxD/3G3q2SBvvu2UfxoRtjg
         juhnT8AEtBsHJUWEEK0Kg6Pf772iw3gn1tAxxWRmSmeC1TgLQFYcv1aDRGAWiw1L4eOy
         OMSR1+y3fBgGXgRxhwBZ1wfvJwbwPwQiEPOL6sf78CVlvY4WA5i9KRerxIGICBlDW2dA
         Oc2r61j2lbvP5eqTLs5TxaYKt+zasfJw88RqmBH7NhGXQVXnrPR3yzLgC6SIBCZVruxg
         J1kjyxJdasPRqBdCpfxulWSQIcTCf/U2F1HRKhQ1K6GO1vtn1s13hkwcY5yqjes7oPUZ
         ySGA==
X-Gm-Message-State: AOAM531HimVGrFN8dA6j2piPaBn+4ZQuVR82h6V1PuCLConJYklQ/c/T
        VnRu3o6uSYNjOelQ573JTHkoR2T6gXFRwLOMS4k=
X-Google-Smtp-Source: ABdhPJxMBOHc52GKXGY4KZd1zNrgtQTD0ozbXNYiuxbWME1ZaP5hoURzRjxVunisuqPjhbSGemzXmgIgilN6zmmjmP0=
X-Received: by 2002:a05:6602:2ac9:: with SMTP id m9mr11505755iov.68.1591928145464;
 Thu, 11 Jun 2020 19:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
 <1591605038-8682-3-git-send-email-dillon.minfei@gmail.com>
 <90df5646-e0c4-fcac-d934-4cc922230dd2@arm.com> <20200610072444.GA6293@infradead.org>
 <9c3a7b4e-0190-e9bb-91fe-6d5692559888@arm.com> <27881ee0-dc40-e8c6-34f6-712f9acc3fbc@arm.com>
In-Reply-To: <27881ee0-dc40-e8c6-34f6-712f9acc3fbc@arm.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Fri, 12 Jun 2020 10:15:08 +0800
Message-ID: <CAL9mu0+ZfW-DoO-DvhvGO-KeGMA+vuHga3FOxN_Ce7uStGPoqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm-nommu: Add use_reserved_mem() to check if device
 support reserved memory
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>, info@metux.net,
        linux@armlinux.org.uk,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        tglx@linutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        allison@lohutok.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 11:45 PM Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
>
> On 6/10/20 9:19 AM, Vladimir Murzin wrote:
> > On 6/10/20 8:24 AM, Christoph Hellwig wrote:
> >> Ok, I finally found the original patch from Vladimir.  Comments below:
> >>
> >>> +++ b/kernel/dma/direct.c
> >>> @@ -456,14 +456,14 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
> >>>  #else /* CONFIG_MMU */
> >>>  bool dma_direct_can_mmap(struct device *dev)
> >>>  {
> >>> -   return false;
> >>> +   return true;
> >>>  }
> >>>
> >>>  int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
> >>>             void *cpu_addr, dma_addr_t dma_addr, size_t size,
> >>>             unsigned long attrs)
> >>>  {
> >>> -   return -ENXIO;
> >>> +   return vm_iomap_memory(vma, vma->vm_start, (vma->vm_end - vma->vm_start));;
> >>
> >> I think we should try to reuse the mmu dma_direct_mmap implementation,
> >> which does about the same.  This version has been compile tested on
> >> arm-nommu only, let me know what you think: (btw, a nommu_defconfig of
> >> some kind for arm would be nice..)
> >
> > Catch-all nommu_defconfig is not easy for ARM, AFAIK folk carry few hacks
> > for randconfig...
> >
> > Meanwhile, known working NOMMU configs
> >
> > $ git grep "# CONFIG_MMU is not set" arch/arm/configs/
> > arch/arm/configs/efm32_defconfig:# CONFIG_MMU is not set
> > arch/arm/configs/lpc18xx_defconfig:# CONFIG_MMU is not set
> > arch/arm/configs/mps2_defconfig:# CONFIG_MMU is not set
> > arch/arm/configs/stm32_defconfig:# CONFIG_MMU is not set
> > arch/arm/configs/vf610m4_defconfig:# CONFIG_MMU is not set
> >
> >>
> >> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> >> index d006668c0027d2..e0dae570a51530 100644
> >> --- a/kernel/dma/Kconfig
> >> +++ b/kernel/dma/Kconfig
> >> @@ -71,6 +71,7 @@ config SWIOTLB
> >>  # in the pagetables
> >>  #
> >>  config DMA_NONCOHERENT_MMAP
> >> +    default y if !MMU
> >>      bool
> >
> > Nit: def_bool !MMU
> >
> >>
> >>  config DMA_REMAP
> >> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> >> index 0a4881e59aa7d6..9ec6a5c3fc578c 100644
> >> --- a/kernel/dma/direct.c
> >> +++ b/kernel/dma/direct.c
> >> @@ -459,7 +459,6 @@ int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
> >>      return ret;
> >>  }
> >>
> >> -#ifdef CONFIG_MMU
> >>  bool dma_direct_can_mmap(struct device *dev)
> >>  {
> >>      return dev_is_dma_coherent(dev) ||
> >> @@ -485,19 +484,6 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
> >>      return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
> >>                      user_count << PAGE_SHIFT, vma->vm_page_prot);
> >>  }
> >> -#else /* CONFIG_MMU */
> >> -bool dma_direct_can_mmap(struct device *dev)
> >> -{
> >> -    return false;
> >> -}
> >> -
> >> -int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
> >> -            void *cpu_addr, dma_addr_t dma_addr, size_t size,
> >> -            unsigned long attrs)
> >> -{
> >> -    return -ENXIO;
> >> -}
> >> -#endif /* CONFIG_MMU */
> >>
> >>  int dma_direct_supported(struct device *dev, u64 mask)
> >>  {
> >>
> >
> > LGTM. FWIW:
> >
> > Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
> >
> >
>
> @dillon, can you give it a try?
>
> I think Christoph would appreciate your Tested-by and that might speed up
> getting fix mainline.
>
sorry for the late response. Yes, it's working

Thanks Christoph

index 8f4bbdaf965e..3e0ecf0b5fb3 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -427,7 +427,6 @@ int dma_direct_get_sgtable(struct device *dev,
struct sg_table *sgt,
        return ret;
 }

-#ifdef CONFIG_MMU
 bool dma_direct_can_mmap(struct device *dev)
 {
        return dev_is_dma_coherent(dev) ||
@@ -453,19 +452,6 @@ int dma_direct_mmap(struct device *dev, struct
vm_area_struct *vma,
        return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
                        user_count << PAGE_SHIFT, vma->vm_page_prot);
 }
-#else /* CONFIG_MMU */
-bool dma_direct_can_mmap(struct device *dev)
-{
-       return false;
-}
-
-int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
-               void *cpu_addr, dma_addr_t dma_addr, size_t size,
-               unsigned long attrs)
-{
-       return -ENXIO;
-}
-#endif /* CONFIG_MMU */

Tested-by:  dillon min <dillon.minfei@gmail.com>

>
> Cheers
> Vladimir
>
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>
