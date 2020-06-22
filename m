Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09924C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81962076A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUTzkLV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgFVV4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730754AbgFVV4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:56:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C408C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:56:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q22so6012265pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9I9qRX8KvmDS5ccLsxT82Nx/5Ew2oRyD2Q8ZPUqRkVE=;
        b=pUTzkLV+Bpsm5HSKAiolSNJuaihX6Em9e97ehc3BS8iR4BaeGB8xasQ+Ya08SRHq2d
         jbS2DEGcJQg915VLa0EsVflEhCkr6ql3wr342zETJHOxQOUZAwFxDOFfy5p4ip1e7Tix
         mcmrgVc3gAJXIruaXQg4ijc3QDvo2Wikz2LUV7wvtxx/iuL9Vg0CBg6Eem3YsB0Il/CL
         RO8Jt1Qe/K8oVRG1iqEtrBX4xa5ScVpsMN/A9ltJD+6PxIW+SchMh97Im7oUTiGYglQD
         XmGDtrlOlyICF8ctF4Z1WOvc4mM21z0mM46KupKLkikt13cl7pw6qMBGXeD1GcoovYV4
         Cxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9I9qRX8KvmDS5ccLsxT82Nx/5Ew2oRyD2Q8ZPUqRkVE=;
        b=hvEaa0yqLrZ3tpzNugz1t9vOJo4WpHIQUwr6omj4p2XlySTWr0zGi31REgFc32NUgb
         VFKp8rUlS6zwIvC3p2BLIwq7lwI7ux4oro6pFK86u77EYqah+Hnyw1wsIqJw0imYdXrj
         7HZucQ55zlpHiS54hyJA1QTyXZZTDCYr9Qmv1+HVYRp/jucNXmZKcMXdx30ti5z1bbJn
         lV7bXgQPUWkMr9uxnQwYP4B58LkhifbX/ypo4MgzWLh8Zvwuk6ysNy0LhyATrZntAqJe
         qsCmJJJmk7aSGoqOX6mxt6EmZSc426gchpMPgJ7bk+4eUuAUfaxB4o7lx+FhIC/ZwC1e
         7Lag==
X-Gm-Message-State: AOAM530Nzha755nxYP9giqdLQCxcW0lyQSV0L0fwVLGJCzbktDzOQRBo
        U84cAN6o8IyQMO2jUvoP50XOBgXcQjBJKnrM8bI=
X-Google-Smtp-Source: ABdhPJyENKWaqni5rW0iP7a2vaRIDH+NgbkoI5l146V+j98mq66lup8xPwbhQ0oHcRZKEfd9/fhic1Jb34HHnQkVpMs=
X-Received: by 2002:a62:1c46:: with SMTP id c67mr21552264pfc.170.1592862959879;
 Mon, 22 Jun 2020 14:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <202006230441.zXXGmJJO%lkp@intel.com> <CAHp75Vc-+NCA=1CX+0GQfUNK-Mn1Y6-aj8TdCvm+pNBKF-Ax1g@mail.gmail.com>
In-Reply-To: <CAHp75Vc-+NCA=1CX+0GQfUNK-Mn1Y6-aj8TdCvm+pNBKF-Ax1g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Jun 2020 00:55:43 +0300
Message-ID: <CAHp75VeE=BrT5haBt8EL+ARGKah6D48XznTPf8RGseyXi=jRcw@mail.gmail.com>
Subject: Re: arch/arm64/kernel/acpi.c:99:30: sparse: sparse: incorrect type in
 return expression (different address spaces)
To:     kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:42 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 22, 2020 at 11:53 PM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   dd0d718152e4c65b173070d48ea9dfc06894c3e5
> > commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
> > date:   4 days ago
> > config: arm64-randconfig-s031-20200622 (attached as .config)
> > compiler: aarch64-linux-gcc (GCC) 9.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.2-rc1-18-g27caae40-dirty
> >         git checkout 670d0a4b10704667765f7d18f7592993d02783aa
> >         # save the attached .config to linux build tree
> >         make W=1 C=1 ARCH=arm64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> >
> > sparse warnings: (new ones prefixed by >>)
> >
> > >> arch/arm64/kernel/acpi.c:99:30: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
> > >> arch/arm64/kernel/acpi.c:99:30: sparse:     expected void [noderef] __iomem *
> >    arch/arm64/kernel/acpi.c:99:30: sparse:     got void *
> > >> arch/arm64/kernel/acpi.c:107:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *map @@
> >    arch/arm64/kernel/acpi.c:107:24: sparse:     expected void *addr
> > >> arch/arm64/kernel/acpi.c:107:24: sparse:     got void [noderef] __iomem *map
>
> ...
>
> > 6c9a58e84e59a2 Andy Shevchenko 2017-07-18   94  void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
> > 6c9a58e84e59a2 Andy Shevchenko 2017-07-18  102  void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
>
> Seems like a new sparse fixed some sparse issues and reveals that the
> above was a mistake and should be reverted.

Either this patch
f7750a79568788473c5e8092ee58a52248f34329 x86, mpparse, x86/acpi,
x86/PCI, x86/dmi, SFI: Use memremap() for RAM mappings
shouldn't change to memremap(), or

void __iomem __ref *acpi_os_map_iomem(acpi_physical_address phys,
acpi_size size);
void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size);

Should be cleaned so they either not working with __iomem, or in
special cases force address space for above mentioned functions.

-- 
With Best Regards,
Andy Shevchenko
