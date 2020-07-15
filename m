Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEF0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9DA20578
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgGOIHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:07:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35452 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgGOIHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:07:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id k4so1576827oik.2;
        Wed, 15 Jul 2020 01:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sauof/vb6IOuW55atrIP0mYmXT1gWS6elmR+jyNLUMo=;
        b=X6pyCAhh1uyQQcgg9W67UabyVodrfEakhXcGrdMNOxcXazsK8c8M+8laceg3IVwR5q
         UE6RYFjR2EHchBQWgzUeGVxdEpcfejficw3yHLDca3jO91fxO20VZFl5fjX7fZHLYxpX
         AX5xvH9VACWlXbwYJJm57EURqJuyL5CmvaDtmIZqjf5FpJwBt4AtvEA8ka32QvybN/Iz
         fbGlbNCs0InrxvqFXdPJJIcCsTu6t/u5AiEsUzlUGxegfQAJyeaT/7q5y9lyAlFlh888
         SD65dBNEdkq08VQRruR4xvU2XgI1sjX8cPjEWgeUiu2TO4jfPfQAtJG6zSZZb0/9joVy
         iERw==
X-Gm-Message-State: AOAM532z96eg2QB3XgeqrSHnx/ubuPOQGazmaj+MxAUs5yBc/V66ocr/
        YKuuDGkqkKqlZt8cDON0MvK7WJLDRi+57AZNxyU=
X-Google-Smtp-Source: ABdhPJwC30MLdI9lpt75jtSV5lYnVApaM78G3lFeuyP6mcmrH8+ZlQaz++tx6ja+w5GVE/iXRGo/1A7PmA037nCLgec=
X-Received: by 2002:aca:ac10:: with SMTP id v16mr6520168oie.153.1594800464032;
 Wed, 15 Jul 2020 01:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200714121856.955680-1-hch@lst.de> <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx> <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com> <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de>
In-Reply-To: <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jul 2020 10:07:32 +0200
Message-ID: <CAMuHMdVnj3Z2m5tQbXeGMSxxs56q+XxBkUwbw6W5ND50yK-1vQ@mail.gmail.com>
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Jul 15, 2020 at 9:46 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 7/15/20 9:27 AM, Geert Uytterhoeven wrote:
> >> [    5.464000] WARNING: CPU: 0 PID: 1 at mm/slab.c:2589 cache_alloc_refill+0x216/0x6a0
> >> [    5.464000] Modules linked in:
> >> [    5.464000]
> >> [    5.464000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-rc5-00026-g22b7a96ece82 #3
> >> [    5.464000] PC is at cache_alloc_refill+0x216/0x6a0
> >> [    5.464000] PR is at kmem_cache_alloc+0xd6/0x128
> >> [    5.464000] PC  : 800ec0d2 SP  : 9f445e68 SR  : 400080f0
> >> [    5.464000] TEA : c00c30d0
> >> [    5.464000] R0  : 8062724c R1  : 8000fee8 R2  : 9f403540 R3  : 00000100
> >> [    5.464000] R4  : 9f403500 R5  : 00000000 R6  : 8068d5b0 R7  : 007fffff
> >> [    5.464000] R8  : 0000000c R9  : 9f403500 R10 : 8096fc0c R11 : 80044410
> >> [    5.464000] R12 : 9f405060 R13 : 00000dc0 R14 : 9f445e68
> >> [    5.464000] MACH: 10623bba MACL: 00000cc0 GBR : 2957bd58 PR  : 800ec80a
> >> [    5.464000]
> >> [    5.464000] Call trace:
> >> [    5.464000]  [<(ptrval)>] _raw_spin_unlock_irqrestore+0x0/0x54
> >> [    5.464000]  [<(ptrval)>] _raw_spin_lock_irqsave+0x0/0x44
> >> [    5.464000]  [<(ptrval)>] kmem_cache_alloc+0xd6/0x128
> >> [    5.464000]  [<(ptrval)>] arch_local_irq_restore+0x0/0x2c
> >> [    5.464000]  [<(ptrval)>] __raw_spin_lock_init+0x0/0x1c
> >> [    5.464000]  [<(ptrval)>] pgd_alloc+0x10/0x24
> >
> > Does commit 73c348f31b63d28d ("sh: Fix unneeded constructor in page
> > table allocation") in next-20200710 and later fix that?
>
> Indeed, it does. This patch should be picked up as well.

It already has been picked up, as it is in linux-next.

> Kernel boots without any errors now.

Happy to hear that!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
