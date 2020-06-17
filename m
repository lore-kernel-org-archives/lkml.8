Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D18C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B9F20810
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RLz03s2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgFQBXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgFQBXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 21:23:50 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC0C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:23:48 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n70so330007ota.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9AsgAnL6vhV5Xzd0aA3Mp0TLZjLw3nIiYuNuaNpuY8k=;
        b=RLz03s2u0fI8CB5UdDeXQMvATqUNPI6WWiN4AFysmNnCcBCxnO5dVpdHFsmGoecjeW
         zMeC/q2/KawWuuwNB7NPpbe/JfJ/a/F5qefEJ+mCwcM/yYzDV9vlkCTq0CJunb7ACB7i
         1Gn4qwHRG9mP/wqG7cNi7dmkZ93dr69qkKkSwQZ7nwfGlTf6ddDgQGnPqM/X2C1D35Rv
         SWIMXx0cPbBzC4o7JCpbFBNjCmKx3vOVlvQaVjE/ydcQcexR6PY7KeoHFlgLUHhRytZs
         oRef5WaFmtuRseJ8Y1Ad84Cr3OZ+m/sNK8Fo7mp9oMr61RAnCoxwOR82ZFk0ERayjtqZ
         B3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9AsgAnL6vhV5Xzd0aA3Mp0TLZjLw3nIiYuNuaNpuY8k=;
        b=IgubRRgDV1jT2suZdnKVMkcYvG3GoSsTSwhWdSUZJh6tAKoXaJSvBqMPPoAZ0iWJtu
         bTMFLdcHUk7kZmLIEyhsLClMoTMYNXx5Wi+4XSgvFJ7Tk3a8/pNSBy0wpEx0VXO/FC2b
         pUySU7cE5jss942rC5Ux5uYDwxdFQKsa/RQ2/sywhgSr5jAlsrU4enUaoXDuEyFW0ZjM
         3cdt/Ep7z90p0SgLsNsFDHF0+KucYFFi1OJafQWR8tgxP5KFqtwugfGN2h/kKtEy3TaI
         xIMJM7s6HQxUZjJhcmhP1FRU11NJ9EBQoi0q7o1UK1tK42YXmuyp3tHYDx6gvEGEF5fy
         ryKw==
X-Gm-Message-State: AOAM5338yTMtjO9gXW5nBpAmtsiJ1idlee3df/55DS2auRm/ovV7iiE4
        7hwccOnX3qrGY1TSDk/IyoHPmeBFI9SGa7btfPXAJQ==
X-Google-Smtp-Source: ABdhPJwqEJbTanzqtXQoNg8UHNHvITL3bc70fzv5gCn/Q2NV4ZxCqW+erY+msju9o1PgbmZJLuJ88DA0cWgPl5Ehb9A=
X-Received: by 2002:a9d:3a36:: with SMTP id j51mr4895144otc.129.1592357028048;
 Tue, 16 Jun 2020 18:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592292685.git.zong.li@sifive.com> <063fab26f4c15bf5b833b57fa818749afa7811d4.1592292685.git.zong.li@sifive.com>
 <0e1d7a917332b90666417ac0508f8a6d@mailhost.ics.forth.gr>
In-Reply-To: <0e1d7a917332b90666417ac0508f8a6d@mailhost.ics.forth.gr>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 17 Jun 2020 09:23:37 +0800
Message-ID: <CANXhq0o9pjDN9k1GZC-6Rve9taR7jA1bmZk4p61bZqZXSkdotw@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Register System RAM as iomem resources
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 7:52 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2020-06-16 10:45, Zong Li =CE=AD=CE=B3=CF=81=CE=
=B1=CF=88=CE=B5:
> > Add System RAM to /proc/iomem, various tools expect it such as kdump.
> > It is also needed for page_is_ram API which checks the specified
> > address
> > whether registered as System RAM in iomem_resource list.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/mm/init.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index f4adb3684f3d..bbe816e03b2f 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -517,6 +517,27 @@ void mark_rodata_ro(void)
> >  }
> >  #endif
> >
> > +void __init resource_init(void)
> > +{
> > +     struct memblock_region *region;
> > +
> > +     for_each_memblock(memory, region) {
> > +             struct resource *res;
> > +
> > +             res =3D memblock_alloc(sizeof(struct resource), SMP_CACHE=
_BYTES);
> > +             if (!res)
> > +                     panic("%s: Failed to allocate %zu bytes\n", __fun=
c__,
> > +                           sizeof(struct resource));
> > +
> > +             res->name =3D "System RAM";
> > +             res->start =3D __pfn_to_phys(memblock_region_memory_base_=
pfn(region));
> > +             res->end =3D __pfn_to_phys(memblock_region_memory_end_pfn=
(region)) -
> > 1;
> > +             res->flags =3D IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > +
> > +             request_resource(&iomem_resource, res);
> > +     }
> > +}
> > +
> >  void __init paging_init(void)
> >  {
> >       setup_vm_final();
> > @@ -524,6 +545,7 @@ void __init paging_init(void)
> >       sparse_init();
> >       setup_zero_page();
> >       zone_sizes_init();
> > +     resource_init();
> >  }
> >
> >  #ifdef CONFIG_SPARSEMEM_VMEMMAP
>
>
> I already have a patch for registering System RAM as an iomem resource
> on my kexec/kdump series. Since I don't care about System RAM regions
> being accurately exposed to userspace (I parse the current device tree
> instead) I just use memblock_start_of_DRAM/end_of_DRAM. This approach
> from arm64 codebase is better since it also handles the case of sparse
> memory regions but in order to be useful for kdump we need to add the
> various segments of the kernel image as child nodes to their respective
> region for kexec-tools. I'll re-spin my patchset anyway so I'll extend
> it to better handle System RAM regions.

OK, great, I would remove this patch here and only reserve the second
patch in the next version.
