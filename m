Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A02C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CC12075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgHSNuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:50:32 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35359 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgHSNuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:50:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id 93so19103997otx.2;
        Wed, 19 Aug 2020 06:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltWJt4HdLmLy75qog/vuWz53dqbAkrcied3ipKYJOts=;
        b=bVmck4MJWRgHrDbCdf3RFLXkq+Orq0ysSqmvqqeFkP4tAf9NiBoSMWNmRr8q3pt1x9
         my6bow/lmgMTSE4NKfCN0Kk7N4eISsRdUjarIPgK3/AqE9xy0i1x9/urZ6fB1SN7lKCY
         9ZMVdakuurWaIKyxb4BZi+0oq3b+wm6jLpaa8OziSM71os6QwVlaSkMLhF2rQBnFXERP
         7DeawOcdmXmi+oTNv9LnwlwTJ8by2rIpSwQ38cpvgQs7BkAIlomS9Dk4LZ5UyEBr51Oc
         nbZwWHeaf20mMbPndUfDy3V4CPVcF9dWgyE91xRUcKY73802kXM4pWKjG/6L7ig0WjZN
         mL9g==
X-Gm-Message-State: AOAM531fxhR151swEvKSdSD4jDj0YcWlWIDSM8r8slrznGTO2rY7rY4F
        5h60I4QCG0gVAPHmDautOUGOl8INHCeU3pvKla5pGwvT
X-Google-Smtp-Source: ABdhPJzIFo9ftVZ5exRaJgb85LrLFmcU/cyPWegojIrEVqvJP7c+174rQwTKYLYBC6FPf08eWpDqlfCWQ+IWdAotbRQ=
X-Received: by 2002:a9d:1b62:: with SMTP id l89mr18095280otl.145.1597845022803;
 Wed, 19 Aug 2020 06:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdVYeAqLHuW2fjQk7HQbnGJhY7YJcksMddn_6Cp61cd-AQ@mail.gmail.com>
 <C510813DTTYI.1PZXLO9Y2FRLM@atris>
In-Reply-To: <C510813DTTYI.1PZXLO9Y2FRLM@atris>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Aug 2020 15:50:11 +0200
Message-ID: <CAMuHMdWAeccfEbZ=7MFgR=2SyC_1zRNGXG5G6VL5qY=d0HW37A@mail.gmail.com>
Subject: Re: [PATCH 1/1] sh: add support for cmpxchg on u8 and u16 pointers
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Wed, Aug 19, 2020 at 3:34 PM Liam Beguin <liambeguin@gmail.com> wrote:
> On Wed Aug 19, 2020 at 5:09 AM EDT, Geert Uytterhoeven wrote:
> > On Wed, Aug 19, 2020 at 5:07 AM Liam Beguin <liambeguin@gmail.com>
> > wrote:
> > > The kernel test bot reported[1] that using set_mask_bits on a u8 causes
> > > the following issue on SuperH:
> > >
> > >     >> ERROR: modpost: "__cmpxchg_called_with_bad_pointer" [drivers/phy/ti/phy-tusb1210.ko] undefined!
> > >
> > > Add support for cmpxchg on u8 and u16 pointers.
> > >
> > > [1] https://lore.kernel.org/patchwork/patch/1288894/#1485536
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> > > ---
> > >
> > > Hi,
> > >
> > > This was reported by the kernel test bot on an architecture I can't
> > > really test on. I was only able to make sure the build succeeds, but
> > > nothing more.
> > > This patch is based on the __cmpxchg_u32 impletmentation and seems
> > > incomplete based on the different cmpxchg headers I can find.
> >
> > Indeed. This version is suitable for non-SMP machines only.
> > BTW, it looks like this version can be replaced by the one in
> > asm-generic?
> >
>
> Thanks for your feedback I'll have a look at the asm-generic functions
> and try to use those instead.
>
> > >
> > > Do these function need to be impletmented in each header
> > > simulataneously?
> >
> > Yes, we need them for all variants.
> >
>
> Okay, I'll look into that. Would you recommend a good way to test these
> changes?

That's gonna be harder, I'm afraid.
Who has suitable hardware?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
