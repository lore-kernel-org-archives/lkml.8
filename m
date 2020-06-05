Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36BBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A662074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgFESXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:23:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42892 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgFESXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:23:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id s21so9006148oic.9;
        Fri, 05 Jun 2020 11:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gb254b1X6F7Ls1+G3k4/QLgVUlE6UJXZeb6kyJbHzoY=;
        b=PW8tRNEi0xcde/5jaOcxHX2yhoRgHRcHzkFCSgAmmBRrfGb0V4sXsNTN/GYU1THY/x
         gY8hxgXfQta8st4OAlC4MJIYdb8kg2OKtwgRzXXmqjSeGbNqOp1zzWA04ZOL50h+QslN
         jhUEHhGxvegFVOSfQhg/kaplf73kkR8CHFZLVjCHdFsC7EBCINSDZ0Bo+hFUGz0cNyjA
         o36D65JhmCxZbJ5+7OKU3K+OTIx5RFE10heDYUTXVGv2tH/FAOLi2/ukehCUCFkW20vR
         XnuCvVWLz64NCYUNMh6lxhyghobukaNs8iXSqM7+8xLNB0EOXXpyniSxjxzKwMR4Om48
         oBdw==
X-Gm-Message-State: AOAM530T6FWE9F1dp+88VgMhbi9Vkijslp890xQz3IOLpvQL3v9KH/Uy
        NOfZ3kdfSy5rcjczvnD/jmRt26ihu7LLt798XNo=
X-Google-Smtp-Source: ABdhPJxDSNMwwLluNUB0ILKSAWVhxzo+nLE84x4RmO9GWGCGZVD7D+sRAie0oKyRL3I0ibHUrn5XX9hf4UfSXajHreA=
X-Received: by 2002:aca:1a19:: with SMTP id a25mr2748673oia.54.1591381399173;
 Fri, 05 Jun 2020 11:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200528054600.GA29717@infradead.org> <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org> <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
 <20200601181259.GV1079@brightrain.aerifal.cx> <20200602013332.GY1079@brightrain.aerifal.cx>
 <0af28795-b27a-2dd9-0d0f-c2a8d4b8d512@physik.fu-berlin.de>
 <20200605154343.GU1079@brightrain.aerifal.cx> <c4900bf6-99b3-c9b9-4fd0-7f491bd46de6@physik.fu-berlin.de>
 <20200605155954.GV1079@brightrain.aerifal.cx> <25e0729d-8158-94a4-f081-ccdfa50ecb1d@physik.fu-berlin.de>
In-Reply-To: <25e0729d-8158-94a4-f081-ccdfa50ecb1d@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 5 Jun 2020 20:23:07 +0200
Message-ID: <CAMuHMdVTWz33sbn2PPvcNW8KnAcNFvv31yj-z5V3VJ87Xv=tjQ@mail.gmail.com>
Subject: Re: [GIT PULL] sh: remove sh5 support
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rich Felker <dalias@libc.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rob Landley <rob@landley.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Fri, Jun 5, 2020 at 7:58 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 6/5/20 5:59 PM, Rich Felker wrote:
> >> Ah, sorry, I missed that. You're right, it should probably go through
> >> someone else's tree then.
> >
> > Do you know if it's needed to un-break sh4? If so we should push to
> > get whoever has jurisdiction over it to include it; otherwise I'm
> > indifferent.

I think the above is about the asm-generic/vmlinux.lds.h patch?
https://marc.info/?l=linux-sh&m=158429470221261&w=2

That one falls under Arnd's jurisdiction.
And AFAIUC, it matters for recent binutils only? So Arnd should know.

> No, the patch is only necessary when enabling Infiniband support with
> CONFIG_INFINIBAND_USER_ACCESS enabled.
>
> However, according to Geert, every architecture is supposed to have
> 64-bit get_user() these days, therefore my patch is required anyways,
> but it's not an acute problem.

This is about a different patch.  Still a build failure, but who cares about
Infiniband? (I still care more about SH ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
