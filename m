Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE02C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0AD20716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWGfIOh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbgFWMaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729611AbgFWMaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:30:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01926C061573;
        Tue, 23 Jun 2020 05:30:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id u12so4752612qth.12;
        Tue, 23 Jun 2020 05:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hRrEey8Gnzl8K1ZpPYEbizHK74dAXBtjus76fCoxht0=;
        b=cWGfIOh/rnqXFQBkkob13gFIctDjmYHP6M6sybFTtTw3ke+TrW/D3bnHeFd6TX1+AS
         6/9/Pg5tAysIKQj5utZnqzCeBWJLF8x2zQhiLUS+YByxSNzgMgAVxeKtEOCMOFw4OG9Y
         mjQ5y5acS2ZFOMfN4nr5EU/dlW754RefLImfaTPzAKYbEn1QY5uUpdinj4Pz4L8SCRol
         NwNK+XJDijMfAxEpdIFxeVy/S34KbrL0FFMBNgaliOMEEsUATOrvq16nlmlQiQId8dpd
         JCQmQ8fpS9YiDnzJUAhflCO2M5KdzryHxpyYgw+k40kR62uOdyVIOvfhaLzMSAjzVb/T
         h5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hRrEey8Gnzl8K1ZpPYEbizHK74dAXBtjus76fCoxht0=;
        b=fi9+MMZfVuvnEGKVJy9GVfPwXvOaPfIaHma4xjnz6JQ9kiSa7lnt23P22KC+PoO9Os
         UYpJyK/tkhKVkmGDj/yrtXNm3Mu4vWch6qJcIbWt+x0isq95EO2s1lIshhu1he5cWueY
         7C9rBSb5/wBCOWWPboFDPnkVrQao1sAac9Gs8NO5mpfJKZm/jEUWIU+2KjdX56pD/Uqx
         7WqavDYx9zVjoBZHeAOWWxPhRqRgIjmy7/FP7YwvyHINM2PhuP53sbMDWT0Br3nAtf9p
         PWKYjVSNp7+sT4XU9/xv4+6S0U1IwqeUfjR33cTJVrFLIrLGbHHgr5gQk1OLGNshq0JC
         ARJg==
X-Gm-Message-State: AOAM532vfeo1scQOZVzQIljL7XfosGul2pk8vWdwAG9yKbazmWLy9xp1
        0R++zg4OyY3XwaQG8u+Z575RjFVegmMgkw0paiQI++Om
X-Google-Smtp-Source: ABdhPJzh9j7xAgrjSNewg6VqZFbG/uDyIid/gQcYXoKCo1NLYreg1tki5DV2kTh69Y5ey0eR5Lqc4k4mIluLICiSPE0=
X-Received: by 2002:ac8:4143:: with SMTP id e3mr20751737qtm.28.1592915421127;
 Tue, 23 Jun 2020 05:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200212101651.9010-1-geert+renesas@glider.be>
 <CAEbi=3fMRq++Eot+BEtCedeyhM65kTc+nS7=inCTR8MkT5srww@mail.gmail.com>
 <CAMuHMdU+VLpg5Yezo2Ea9v2vmvbA=nEcKObBgZYwjSV10OkY=A@mail.gmail.com> <CAMuHMdWaRw+61y4Ykk4niagPOtY3dL28fhtB=3jdR16ZODGgfg@mail.gmail.com>
In-Reply-To: <CAMuHMdWaRw+61y4Ykk4niagPOtY3dL28fhtB=3jdR16ZODGgfg@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 23 Jun 2020 20:29:43 +0800
Message-ID: <CAEbi=3ck8-p_HZ_mkMFEcWUnZOyFXM9NuYHDrXB9uj4GwmWZtg@mail.gmail.com>
Subject: Re: [PATCH] nds32: Replace <linux/clk-provider.h> by <linux/of_clk.h>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Hu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=88=
23=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:49=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Greentime,
>
> On Wed, Feb 12, 2020 at 1:25 PM Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
> > On Wed, Feb 12, 2020 at 11:52 AM Greentime Hu <green.hu@gmail.com> wrot=
e:
> > > Geert Uytterhoeven <geert+renesas@glider.be> =E6=96=BC 2020=E5=B9=B42=
=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:16=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > The Andes platform code is not a clock provider, and just needs to =
call
> > > > of_clk_init().
> > > >
> > > > Hence it can include <linux/of_clk.h> instead of <linux/clk-provide=
r.h>.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > >  arch/nds32/kernel/time.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/nds32/kernel/time.c b/arch/nds32/kernel/time.c
> > > > index ac9d78ce3a818926..574a3d0a853980a9 100644
> > > > --- a/arch/nds32/kernel/time.c
> > > > +++ b/arch/nds32/kernel/time.c
> > > > @@ -2,7 +2,7 @@
> > > >  // Copyright (C) 2005-2017 Andes Technology Corporation
> > > >
> > > >  #include <linux/clocksource.h>
> > > > -#include <linux/clk-provider.h>
> > > > +#include <linux/of_clk.h>
> > > >
> > > >  void __init time_init(void)
> > > >  {
> > >
> > > Thank you, Geert.
> > >
> > > Let me know if you like to put in your tree or nds32's.
> > > Acked-by: Greentime Hu <green.hu@gmail.com>
> >
> > Please take it in the nds32 tree.
> > Thanks!
>
> And so you did. But it disappeared after June 12, when the nds32 tree
> was reset to v5.7, losing the following 2 commits:
>
> de9a5650b611014c52b1ad994f63253593d8eddf nds32: Replace
> <linux/clk-provider.h> by <linux/of_clk.h>
> d785c5a324cd8812720a409dc85050558281a567 nds32: configs: Cleanup
> CONFIG_CROSS_COMPILE
>

Thank you, Geert. It must be my mistake when I try to clean the next branch=
.
I just put these 2 commits back.
