Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54638C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3493C20678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHCKBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:01:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46964 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHCKBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:01:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id v6so16699365ota.13;
        Mon, 03 Aug 2020 03:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRL/NSrOTXGW5tVFZP1w9ujyG9ApelIKXaN1/erg484=;
        b=dhZFlWmSf+Uwo+vFIlvnlPA/fV85bK0xUZDSngLpTNfrQNAuI2SGAky9rt1PX8Js4A
         UJyMjXx/qGlYhtdgpAu/p4NES2wcCiYw2AkN70TbwUiuMrukzhyrz+zCe7iK/dO5ZcQp
         sd3rAZvjFQDyPA0a6B1eB/Kic93w0Y/AsRmWTp+x+D6OdreAAre6ugKbUm8S8eoa71yx
         7Ed/AOo+QKzqUzZVv7UXeWNgkyRGouTnIaZGVZ3qNoK2DqDaTKoFID++oqeYs7TL42O1
         41jTG+eivjAOMyf7/uFhMHUM04wLVl2waKWpuf/WZXe3fzPzYRXkLn+qPl/YH5wxTjKW
         9qig==
X-Gm-Message-State: AOAM530w5nk3Vx6E2T5rmFjf/k2p1eybUYJzdfvkJwAbdWDuIovJJ2QM
        /uxVGxxjlv5KC/qxn5+gfpaSzOrXskWWVE8QE9WUs98e
X-Google-Smtp-Source: ABdhPJwlDuinaynFGJMz+BX1NkzN1mj7ncnxIYpvjq4x0l0CyuS1Qg7VFTYWsRmoQKZkLoUyUXV5w5bszIyg49+V37w=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr12244586ote.107.1596448900646;
 Mon, 03 Aug 2020 03:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
 <20200722023840.GA55317@roeck-us.net> <20200722225239.GX14669@brightrain.aerifal.cx>
 <fa0456c9-cef0-45e7-59d7-ad652734b1d5@roeck-us.net>
In-Reply-To: <fa0456c9-cef0-45e7-59d7-ad652734b1d5@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Aug 2020 12:01:29 +0200
Message-ID: <CAMuHMdUvSVs7vQ7GDhHx4Rp-DJZuSU2xtPVtX86+p9GptHfBhQ@mail.gmail.com>
Subject: Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rich Felker <dalias@libc.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 1:53 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 7/22/20 3:52 PM, Rich Felker wrote:
> > On Tue, Jul 21, 2020 at 07:38:40PM -0700, Guenter Roeck wrote:
> >> On Thu, Dec 12, 2019 at 11:38:43AM +0900, Kuninori Morimoto wrote:
> >>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>>
> >>> __delay() is used from kernel module.
> >>> We need EXPORT_SYMBOL(), otherwise we will get compile error.
> >>>
> >>> ERROR: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!
> >>>
> >>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>
> >> I must admit that this patch completely baffles me. __delay was
> >> already exported, only elsewhere in the file. With this patch
> >> in place, it is exported twice, and all sh builds in -next fail
> >> with
> >>
> >> In file included from include/linux/linkage.h:7,
> >>                  from arch/sh/include/asm/bug.h:5,
> >>                  from include/linux/bug.h:5,
> >>                  from include/linux/thread_info.h:12,
> >>                  from include/asm-generic/current.h:5,
> >>                  from ./arch/sh/include/generated/asm/current.h:1,
> >>                  from include/linux/sched.h:12,
> >>                  from arch/sh/lib/delay.c:8:
> >> include/linux/export.h:67:36: error: redefinition of '__ksymtab___delay'
> >>
> >> Guenter
> >>
> >>> ---
> >>>  arch/sh/lib/delay.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/arch/sh/lib/delay.c b/arch/sh/lib/delay.c
> >>> index dad8e6a..540e670 100644
> >>> --- a/arch/sh/lib/delay.c
> >>> +++ b/arch/sh/lib/delay.c
> >>> @@ -29,6 +29,7 @@ void __delay(unsigned long loops)
> >>>             : "0" (loops)
> >>>             : "t");
> >>>  }
> >>> +EXPORT_SYMBOL(__delay);
> >>>
> >>>  inline void __const_udelay(unsigned long xloops)
> >>>  {
> >
> > I presently have a revert of this commit in queue for next. If it's
> > sufficiently breaking (and especially if there are other regressions
> > that need to be fixed, see the pmd_free thing) I could try to get it
> > in for 5.8 still but that's getting a bit late.
> >
>
> The patch in mainline is ok. It appears that it has been applied
> again in -next.
>
> "git log --oneline v5.7.. arch/sh/lib/delay.c" on top of next-20200721
> reports:
>
> ee0e4f15dfd4 (origin/akpm) sh: add missing EXPORT_SYMBOL() for __delay
> d1f56f318d23 sh: add missing EXPORT_SYMBOL() for __delay
>
> Maybe it just needs to be dropped from the akpm tree in -next ?

IMHO all of them should be dropped/reverted.
__delay is an internal implementation detail, not to be used by drivers.

See also include/asm-generic/delay.h:

    /* Undefined functions to get compile-time errors */
    ...
    extern void __delay(unsigned long loops);

Cfr. '[PATCH] Revert "sh: add missing EXPORT_SYMBOL() for __delay"'
https://lore.kernel.org/lkml/20200608080636.27862-1-geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
