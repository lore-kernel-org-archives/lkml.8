Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B482C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E4DA21473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4FKmT75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgIGKWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgIGKVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:21:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2DAC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:21:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b16so6531141pjp.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlZMhc8hmWDX2ZWHISagSA2inr2CmIbaM90rLlkkX2Y=;
        b=z4FKmT751iwYNJDVxUHuh97VQixOoKqshuVLVSk+A66nwKitSyLHJHdlsOrueqQ9xZ
         CrtM4r5aXM8/jnhXkOv5DZ2iB0654KyAgU+sLOb8JllNfE9PWGkHTqOi9TVswABW9NI0
         qijj1z8rRtSjFbvxtcF++oL4Ce/HqJ+jpVoS96UgtiXoPBwS0Q4cqetFSJcJnNu46W5q
         qT8ewTf0WSVfNPuuiavDKzpD5xNHE9PVgnJCUYeFXiyfM9dTr1BvL5FyhchNDVYKYdTu
         kvXxkOLGP92pkE5vpjy30sc3HXoyzYZdo8BwY6uTICTrrm8acD4PbwXbT5cHwrksoxE3
         ccqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlZMhc8hmWDX2ZWHISagSA2inr2CmIbaM90rLlkkX2Y=;
        b=fnAfhxTYa2q61xM72iK2T4Zg46EtWcflL29VkCe1DfgsgVoOpJc++nkV46R3I/gvk4
         +US09ub0J/GVk+biwV9NFF9473LePE8346m7Mgv8n5SRPhtVvHkqGrWHccAo2ZZe+bHe
         f+L9vgs2R4iTwzj2bzr7ysDLWjZtzSONVl9Mg0kKuL9te2vKFwELNAW7VVqrdtCETaRV
         thDjJt7xHFbvPX99aWajSVq0KPmFWCukfDlH5wlhTJjY2I8GdDJL6UHffqpVyc9r+a3Y
         R2nGWA4Br1NiytJXAVH0JippZrCg/TTi5wJbXOFM/ZF9p7zhjAnsjufh4Mq8s7bebJP9
         dpfA==
X-Gm-Message-State: AOAM5306qpgnZG7sPE88aBlz0ygulL4IHxJ7TlJoc1tJAGhoUgyWMX46
        Vd2TnIjlub6SHSmfQ6I962rzhKPJp5y2mn0eAHM8Yg==
X-Google-Smtp-Source: ABdhPJwwvPyxHgWhevcGPZDwDAqnJ75Hv8xCmd648Yuwz0t6G4giWyAT3J/aElkEVJfc4WxZqGTC9KDOPdn0l8DU0Xk=
X-Received: by 2002:a17:90a:d596:: with SMTP id v22mr7666482pju.146.1599474114280;
 Mon, 07 Sep 2020 03:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155025.55718-1-xypron.glpk@gmx.de> <CAD8XO3ZLqkuajo3GVRdvXiFXMH9P-vp-PX5s6idgA51ouVDpKQ@mail.gmail.com>
 <fec7e55e-154c-5348-5181-6d9efdc0245a@gmx.de>
In-Reply-To: <fec7e55e-154c-5348-5181-6d9efdc0245a@gmx.de>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 7 Sep 2020 13:21:43 +0300
Message-ID: <CAD8XO3YGKwqbt6cYZQgauioeywLFg56tm+PFM6_nGhuJwSk4Jg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: DRAM base calculation
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Sep 2020 at 11:31, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 07.09.20 09:00, Maxim Uvarov wrote:
> > On Fri, 4 Sep 2020 at 18:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> In the memory map the regions with the lowest addresses may be of type
> >> EFI_RESERVED_TYPE. The reserved areas may be discontinuous relative to the
> >> rest of the memory. So for calculating the maximum loading address for the
> >> device tree and the initial ramdisk image these reserved areas should not
> >> be taken into account.
> >>
> >> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> ---
> >>  drivers/firmware/efi/libstub/efi-stub.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> >> index c2484bf75c5d..13058ac75765 100644
> >> --- a/drivers/firmware/efi/libstub/efi-stub.c
> >> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> >> @@ -106,7 +106,8 @@ static unsigned long get_dram_base(void)
> >>         map.map_end = map.map + map_size;
> >>
> >>         for_each_efi_memory_desc_in_map(&map, md) {
> >> -               if (md->attribute & EFI_MEMORY_WB) {
> >> +               if (md->attribute & EFI_MEMORY_WB &&
> >> +                   md->type != EFI_RESERVED_TYPE) {
> >
> > shouldn't the type here be CONVENTIONAL?
>
> In 32bit ARM reserve_kernel_base() the following are considered:
>
> * EFI_LOADER_CODE
> * EFI_LOADER_DATA
> * EFI_BOOT_SERVICES_CODE
> * EFI_BOOT_SERVICES_DATA
> * EFI_CONVENTIONAL_MEMORY
>
> What I have not yet fully understood is why Linux on ARM 32bit tries to
> put the kernel into the first 128 MiB. Cf. handle_kernel_image() in
> drivers/firmware/efi/libstub/arm32-stub.c.
>

Are you looking to the latest kernel?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/efi/libstub/arm32-stub.c?h=v5.9-rc4#n211
efi_bs_call(allocate_pages,..) is only for EFI_CONVENTIONAL_MEMORY.

> According to the comments this is due to some implementation detail in
> the Linux zImage decompressor and not required by UEFI or the hardware:
>
>          Verify that the DRAM base address is compatible with the ARM
>          boot protocol, which determines the base of DRAM by masking
>          off the low 27 bits of the address at which the zImage is
>          loaded. These assumptions are made by the decompressor,
>          before any memory map is available.

I think that is also fixed with:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/firmware/efi/libstub/arm32-stub.c?h=v5.9-rc4&id=d0f9ca9be11f25ef4151195eab7ea36d136084f6

Maxim.

>
> Best regards
>
> Heinrich
>
> >
> >>                         if (membase > md->phys_addr)
> >>                                 membase = md->phys_addr;
> >>                 }
> >> --
> >> 2.28.0
> >>
>
