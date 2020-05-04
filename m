Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ECDC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 06:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A3D20735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 06:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgEDGzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 02:55:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37923 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgEDGzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 02:55:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id r66so5807656oie.5;
        Sun, 03 May 2020 23:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n04eELBIPelMDy2ab4QYmrK5OKBO0UuNd+i4rb5iItw=;
        b=sGIaStzE35t41EqXEofGLDreOXAbH2p1RBNNUMaRAYlW+SyDh03o5D2/ZQPKWL+kWK
         1Yoc/DJkx+9wAGnBzDwAQiUw4/sU09u+eHZY2gsSvo9BfWHPbRi4Z0+e+3p8xiJSbHIw
         O1RcnWWtb8+UPZCVLi5FOxAVhUQ57JWDGF2lCJRmK5equfOgfs4Y+sXJGMRYOpySSEf8
         Ils1/fPePXfMV3friQEGGkvsSQdrvVsf3hJhVPlPCkwqenQTAt3YB+0PegrbDfDbh4rf
         F9TVCdwmaV0tA4YWZfI0VkqWwXyG3TLDYTcZ3gGx956HKMLNhgYSNaRKmZSw7o9Kqf9f
         R3IA==
X-Gm-Message-State: AGi0PuYQXwJppm+3caqYOSPU+lKqtxc8YOStIeTwGFk636ayR7uAsB1W
        w7cbaGpg+7vSYhye8Zfslyg8nABEJGCK/JAWoYXRc0U8
X-Google-Smtp-Source: APiQypJhpcxIq2GTWYdddOh4F/hHQeK+HiW8v4m/V4Y7CPtjOecHENkixTlgaoN4Xj1JaTW+i6FLuTUokNkrEnEqfcI=
X-Received: by 2002:aca:f541:: with SMTP id t62mr7653085oih.148.1588575304969;
 Sun, 03 May 2020 23:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <1588393643-31499-1-git-send-email-bmeng.cn@gmail.com>
 <CAMuHMdVd3s46o5VXZqAHuQt5qYsbDMOonVWjEqd2nu8OON97Xw@mail.gmail.com> <CAEUhbmWjrnRLXUd3Au2f7fnZtRVgdYzMvFn-RrdOodfFq4r=Lg@mail.gmail.com>
In-Reply-To: <CAEUhbmWjrnRLXUd3Au2f7fnZtRVgdYzMvFn-RrdOodfFq4r=Lg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 May 2020 08:54:53 +0200
Message-ID: <CAMuHMdXhCdCmXMc=JFRsP-HfUwF-RK57A+ftjg0Y9qREKd+3ig@mail.gmail.com>
Subject: Re: [PATCH] sh: Drop CONFIG_MTD_M25P80 in sh7757lcr_defconfig
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On Sat, May 2, 2020 at 1:05 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> On Sat, May 2, 2020 at 6:09 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sat, May 2, 2020 at 6:27 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > From: Bin Meng <bin.meng@windriver.com>
> > >
> > > Drop CONFIG_MTD_M25P80 that was removed in
> > > commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
> > >
> > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> >
> > Thanks for your patch!
> >
> > Blindly removing config options from defconfig files that haven't
> > received much love for a while is IMHO not such a good idea, as it makes
> > it harder to see what the affected platform needs, or needed.
> >
> > > --- a/arch/sh/configs/sh7757lcr_defconfig
> > > +++ b/arch/sh/configs/sh7757lcr_defconfig
> > > @@ -36,7 +36,6 @@ CONFIG_IPV6=y
> > >  # CONFIG_FW_LOADER is not set
> > >  CONFIG_MTD=y
> > >  CONFIG_MTD_BLOCK=y
> > > -CONFIG_MTD_M25P80=y
> > >  CONFIG_BLK_DEV_RAM=y
> > >  CONFIG_SCSI=y
> > >  CONFIG_BLK_DEV_SD=y
> >
> > MTD_SPI_NOR became a dependency for MTD_M25P80 since commit
> > 03e296f613affcc2671c1e86d8c25ecad867204e ("mtd: m25p80: use the SPI nor
> > framework") and commit e43b20619bdb6c851dd7b49cbd15e52875a785d4 ("mtd:
> > spi-nor: shorten Kconfig naming").  Hence CONFIG_MTD_SPI_NOR=y should be
> > added to avoid breaking the platform's SPI FLASH support.
> >
> > Just removing CONFIG_MTD_M25P80=y from the defconfig makes this less
> > visible for someone who wants to build a kernel for this platform using
> > "make sh7757lcr_defconfig": it can no longer be seen that
> > CONFIG_MTD_M25P80=y won't be present in the resulting .config file.
> >
>
> Thank you for the review! Sorry I missed that.
>
> > I think the platform would be better served with a proper refresh of the
> > defconfig file.
>
> I am not sure if doing a defconfig refresh should be a separate patch.

OK.

> I felt mixing the refresh with the real changes makes the code review
> a little bit hard. I just sent v2 without the refresh. Please let me
> know if it is okay.

Thank you, that's fine. It turns out sh7757lcr_defconfig has less bitrotted
than I had feared.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
