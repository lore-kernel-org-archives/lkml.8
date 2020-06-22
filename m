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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1712C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52FA2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnS0XeMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgFVVmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgFVVmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:42:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDC1C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:42:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so6165432pgh.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJAq20feXv/CGmVFySfDdNWa2qGqgw8XeGtuERJWTNc=;
        b=lnS0XeMZXzgaC5daKU6PyAoRxetWWKoy2gkka9WwHYDer68xjxolwdUfDH9iJxsc5J
         wh3hL2sjNDUV8KaTBJnTrhxvXZ7h1PJk69x8MrCyewFLjCEq8rNiOsMUIVdJXjB+089a
         0JKgpfpy8ZtbIrA5F0r3YOZWsHqmNOg6qjM6B7DTJtJyZAqbe1W6RyQiWJ1PKntRl/HC
         8TCYppybE+p90kBGi58ckHl9plVLLOpAs4F9icSTwId2AlCzLp384/Ff78YFpMxVcXiX
         g5fI28WFb07Uai/OljSpW/CZMk5HYqvTEw/YTeg6z0ccn2vZduN7dUC3cdJmQBtQ1/bu
         L1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJAq20feXv/CGmVFySfDdNWa2qGqgw8XeGtuERJWTNc=;
        b=mTl/in3ZpVCwCNDbLjKmDpwTz9i7gjyANu51cipLjUw0ar1HiVMUd6Yz8d2rw82WaH
         Mghx1U1kMXUBPMYOeleqezenGPYUgS2R2ZtvDdCtQTyPfhI/uRwD1BKH4y5Lb6a4pgqr
         WSfy30AD63nRsqKj5TMJh67RXVzLm2J1Bc8tEehJSlnWdxPlTEzYjQSn923FFdvaoBxs
         bF4rXeS+SNUmEhyEBKOsAyiwr989YuLg883CGvf1Y5VfQDZ7UPwd4Ej4Wc2gyGv+ZFzB
         txDKnL0fRv7+69IkZUL71Sh3jC9R3KvbpvFuYE4SGxDTJ26dXWTmpWuFFcanVFUaUZ0q
         KsPg==
X-Gm-Message-State: AOAM5302ftbO/rS4OdEKhJDAgM7kbthQiCxUrjX4FXkGMKZJnEsI7eLM
        gC//OpmyI4llZ54herNFOA7CsqoCnhLqgE3YHsk=
X-Google-Smtp-Source: ABdhPJxhCwXnFc9kfbXvw6YNRIvvoKHwGdRZ3VsJsRv/IcDMdbn9mzEamlqfO4aQ3VmQeofgy5DDCrXUfY/yFILpzH4=
X-Received: by 2002:a62:5284:: with SMTP id g126mr22628197pfb.36.1592862159021;
 Mon, 22 Jun 2020 14:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <202006230441.zXXGmJJO%lkp@intel.com>
In-Reply-To: <202006230441.zXXGmJJO%lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Jun 2020 00:42:22 +0300
Message-ID: <CAHp75Vc-+NCA=1CX+0GQfUNK-Mn1Y6-aj8TdCvm+pNBKF-Ax1g@mail.gmail.com>
Subject: Re: arch/arm64/kernel/acpi.c:99:30: sparse: sparse: incorrect type in
 return expression (different address spaces)
To:     kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:53 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dd0d718152e4c65b173070d48ea9dfc06894c3e5
> commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
> date:   4 days ago
> config: arm64-randconfig-s031-20200622 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.2-rc1-18-g27caae40-dirty
>         git checkout 670d0a4b10704667765f7d18f7592993d02783aa
>         # save the attached .config to linux build tree
>         make W=1 C=1 ARCH=arm64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
> >> arch/arm64/kernel/acpi.c:99:30: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
> >> arch/arm64/kernel/acpi.c:99:30: sparse:     expected void [noderef] __iomem *
>    arch/arm64/kernel/acpi.c:99:30: sparse:     got void *
> >> arch/arm64/kernel/acpi.c:107:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *map @@
>    arch/arm64/kernel/acpi.c:107:24: sparse:     expected void *addr
> >> arch/arm64/kernel/acpi.c:107:24: sparse:     got void [noderef] __iomem *map

...

> 6c9a58e84e59a2 Andy Shevchenko 2017-07-18   94  void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
> 6c9a58e84e59a2 Andy Shevchenko 2017-07-18  102  void __init __acpi_unmap_table(void __iomem *map, unsigned long size)

Seems like a new sparse fixed some sparse issues and reveals that the
above was a mistake and should be reverted.

-- 
With Best Regards,
Andy Shevchenko
