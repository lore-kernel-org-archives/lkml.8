Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD76C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 07:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05FF206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 07:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHIHiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 03:38:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41450 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgHIHiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 03:38:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id a65so4885364otc.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 00:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kl9VEf5ldM1YlPJARQPMBMKo35p5dIfFaxCFs5UVWBo=;
        b=UfbMtJYV31A0G4dQsZGWqXjmCGsc4rhdp3MnPl2YdYqrc3vkfaZU0vmh3tO9JlZ74r
         Qn13UceGHh4A7jC/Rprh4XZPqjjThEr+9Tssd2Zc0w1rpYUTyV9F8l0eAbFZG6tqHVL+
         JQl3HCrkcOtSWfZLZeaXf8j6DCv29BwxaSvo/Pppojql+RaKhm/u/8Lh3vOCm5iEPHnC
         ThbWdWfFWYfCcx1aOisoH2nmAxOiQ6iItf19HOZ+Wgm3WI5IE4VonRrJHG0qMcA+8MQb
         4DDTQoq53fNKhGdb4/9ra37ugaUZPUwagIHnWvAXa5qI7oh78l8snNCWl66qIZBcNdYl
         E4Zw==
X-Gm-Message-State: AOAM531ZgOONPl22muHpMC1wwsP3cmrXc7CeEAcVVThnuv7Br/Q9ixEi
        EoCaXjuIvO2ggry5ytG6OV36Ls2chPOlwP8SeR8=
X-Google-Smtp-Source: ABdhPJy1x/KnzpSV0eBQUMidxwNIj+tfW5AxOcHQmC58its6CxW1iNWznDPhEYu6i7saKqdEFxprrFqHcS95sKLHbY4=
X-Received: by 2002:a9d:7d8c:: with SMTP id j12mr19090034otn.250.1596958681967;
 Sun, 09 Aug 2020 00:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <202008090832.Fd08yQlD%lkp@intel.com>
In-Reply-To: <202008090832.Fd08yQlD%lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 9 Aug 2020 09:37:50 +0200
Message-ID: <CAMuHMdW7aq=oRTGiCW5CPFA+3ebJ5wEvJawxRuYvhgsp42ObeQ@mail.gmail.com>
Subject: Re: drivers/crypto/sa2ul.c:1349:33: warning: cast from pointer to
 integer of different size
To:     kernel test robot <lkp@intel.com>
Cc:     Keerthy <j-keerthy@ti.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 9, 2020 at 2:49 AM kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   06a81c1c7db9bd5de0bd38cd5acc44bb22b99150
> commit: 2dc53d0047458e28ed05b4548844ba78199857bf crypto: sa2ul - add sha1/sha256/sha512 support
> date:   2 weeks ago
> config: m68k-randconfig-r002-20200809 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 2dc53d0047458e28ed05b4548844ba78199857bf
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k

>    In file included from include/linux/device.h:15,
>                     from include/linux/dmaengine.h:8,
>                     from drivers/crypto/sa2ul.c:12:
>    drivers/crypto/sa2ul.c: In function 'sa_sha_init':
> >> drivers/crypto/sa2ul.c:1349:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     1349 |   crypto_ahash_digestsize(tfm), (u64)rctx);
>          |                                 ^
>    include/linux/dev_printk.h:123:47: note: in definition of macro 'dev_dbg'
>      123 |   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>          |                                               ^~~~~~~~~~~

Fix available since last Tuesday:
https://lore.kernel.org/linux-crypto/20200804092927.7417-1-geert@linux-m68k.org/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
