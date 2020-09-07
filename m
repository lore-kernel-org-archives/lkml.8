Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E952C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F67206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4t7VR+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgIGPr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730087AbgIGPmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:42:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76936C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 08:42:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j7so1804042plk.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scYv+JiFixkFWNYkQzmkDbHirjVb4zjS1yIiBjdW4yA=;
        b=X4t7VR+h7AagjcBWbmhb0jnKlXvURPYz7YSJmTKjUwm7bFWt2LgutX+e83J0pfqCSb
         nTTmdDTxb2Ob2OknduMdc0YIKYBDtl65Q8FsbrrxLcuHpGVM/YizFBsiIk1v9ikdywhR
         hupAqKClEFc0eoLcANc+LwEpkUqT8Mb3J3U11OhaQ4lvpqNd8b1jIi51dBSTwdMkYKw7
         2gQN7nAESE0fLfwhsYYa1YzQSQlg5HGvcP5wWYzS3qOCoSry/lhDeiiq4PEoQXO/zpsC
         pyfbEQA3xpXbYYFYcvf6jLAAQUwThJUBCAal1XCyYQAHnwUooKFoFw0Z61LySM0GU/TM
         jQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scYv+JiFixkFWNYkQzmkDbHirjVb4zjS1yIiBjdW4yA=;
        b=YUnRb1oTKaiEznV7vUPpwtDtpFy+gEtfSMe7hoH36Z7SlfHiEzl7DsaJIGa9b/lRW7
         tL++/C56JyypUgtKaLicanlsZ5fNiHkxvP8jZBBSDBHA4nuvVvKCYc2JCugs046BRwNo
         K/QJt089t8BAVWjC99bW2wJG0/D6kv3UbCZkGrBLH/ILI0Gb+PoieOI4kWwuZz/pQNK2
         XTQU7gpWsva7z0sxnca/aRg6Qxr51+J2DFLVS+tUpGJnEaiz/1ujQw8nU2N7cqKqTON6
         PNBmwM0OygOMnziN5/AaRWlQRK6XJXSSkv/VdoxjvK8ghn0falKLyKn7DFQKPoI+T4/G
         egXg==
X-Gm-Message-State: AOAM533I7xTZuAE2ZEgPDpMm45iu49D7mDn28wtOPFanjqA/3zmAlIQt
        d64Vm0lcCktX8beobwxZsXy/8baS3QqfK+JmHGYcDQ==
X-Google-Smtp-Source: ABdhPJyn1CGlaUUZP/OxCa11KPVLeBGwzD2x9GxEkg5Jp5TSxt7TuYgXrPjqnwr4M89Zttc+Z8bwxN+z1VJCvRB/Kbw=
X-Received: by 2002:a17:90a:19d1:: with SMTP id 17mr20268147pjj.93.1599493365374;
 Mon, 07 Sep 2020 08:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155025.55718-1-xypron.glpk@gmx.de> <CAD8XO3ZLqkuajo3GVRdvXiFXMH9P-vp-PX5s6idgA51ouVDpKQ@mail.gmail.com>
 <fec7e55e-154c-5348-5181-6d9efdc0245a@gmx.de> <CAD8XO3YGKwqbt6cYZQgauioeywLFg56tm+PFM6_nGhuJwSk4Jg@mail.gmail.com>
In-Reply-To: <CAD8XO3YGKwqbt6cYZQgauioeywLFg56tm+PFM6_nGhuJwSk4Jg@mail.gmail.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 7 Sep 2020 18:42:34 +0300
Message-ID: <CAD8XO3a+TtYciQR4UmprvxHcN8E9wNABEVdt0JsN-GDhJeZJzA@mail.gmail.com>
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

Tested both original and (md->type == EFI_CONVENTIONAL_MEMORY)
versions - they fix qemu v7 boot under qemu. I think the second
version is more correct.

Regards,
Maxim.

On Mon, 7 Sep 2020 at 13:21, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> On Mon, 7 Sep 2020 at 11:31, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 07.09.20 09:00, Maxim Uvarov wrote:
> > > On Fri, 4 Sep 2020 at 18:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >>
> > >> In the memory map the regions with the lowest addresses may be of type
> > >> EFI_RESERVED_TYPE. The reserved areas may be discontinuous relative to the
> > >> rest of the memory. So for calculating the maximum loading address for the
> > >> device tree and the initial ramdisk image these reserved areas should not
> > >> be taken into account.
> > >>
> > >> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > >> ---
> > >>  drivers/firmware/efi/libstub/efi-stub.c | 3 ++-
> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> > >> index c2484bf75c5d..13058ac75765 100644
> > >> --- a/drivers/firmware/efi/libstub/efi-stub.c
> > >> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > >> @@ -106,7 +106,8 @@ static unsigned long get_dram_base(void)
> > >>         map.map_end = map.map + map_size;
> > >>
> > >>         for_each_efi_memory_desc_in_map(&map, md) {
> > >> -               if (md->attribute & EFI_MEMORY_WB) {
> > >> +               if (md->attribute & EFI_MEMORY_WB &&
> > >> +                   md->type != EFI_RESERVED_TYPE) {
> > >
> > > shouldn't the type here be CONVENTIONAL?
> >
> > In 32bit ARM reserve_kernel_base() the following are considered:
> >
> > * EFI_LOADER_CODE
> > * EFI_LOADER_DATA
> > * EFI_BOOT_SERVICES_CODE
> > * EFI_BOOT_SERVICES_DATA
> > * EFI_CONVENTIONAL_MEMORY
> >
> > What I have not yet fully understood is why Linux on ARM 32bit tries to
> > put the kernel into the first 128 MiB. Cf. handle_kernel_image() in
> > drivers/firmware/efi/libstub/arm32-stub.c.
> >
>
> Are you looking to the latest kernel?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/efi/libstub/arm32-stub.c?h=v5.9-rc4#n211
> efi_bs_call(allocate_pages,..) is only for EFI_CONVENTIONAL_MEMORY.
>
> > According to the comments this is due to some implementation detail in
> > the Linux zImage decompressor and not required by UEFI or the hardware:
> >
> >          Verify that the DRAM base address is compatible with the ARM
> >          boot protocol, which determines the base of DRAM by masking
> >          off the low 27 bits of the address at which the zImage is
> >          loaded. These assumptions are made by the decompressor,
> >          before any memory map is available.
>
> I think that is also fixed with:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/firmware/efi/libstub/arm32-stub.c?h=v5.9-rc4&id=d0f9ca9be11f25ef4151195eab7ea36d136084f6
>
> Maxim.
>
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > >>                         if (membase > md->phys_addr)
> > >>                                 membase = md->phys_addr;
> > >>                 }
> > >> --
> > >> 2.28.0
> > >>
> >
