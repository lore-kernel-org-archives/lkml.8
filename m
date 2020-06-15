Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1115BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E993020707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbgFOV1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:27:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36157 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgFOV1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:27:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id 97so14325280otg.3;
        Mon, 15 Jun 2020 14:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKk9UUE7zWHt2Qbqb1KWLAlQZOdKvtSR2tBzDwT+0k8=;
        b=aqNOM0mQKzPDbG0gAokGukOEjNluXdCD2AzvFKWZXXV2WkoNmCEvFIxC+5C01MLyjy
         aI5RVlLcAdS8s7nxM/l4EP2Yuc1BYQw3P5u+OEvZY4TKtCYEBGmruyovDvSb5bvTg+fB
         +BWyUI2clit9xI+rerpDZuQ3rcAagbObrifxXdXH2g4InvJ1cl+xA3O52gOqPphQvbRK
         nrtX3oV3XIpdxX6HO961GqT4n1EIuncJF+DWCC5sV8Y5X7ivuTwrQT/DwQnFMvd9VRcf
         QpCb7wKy6nz2vh+WduREoBdaQHtuPRDU+Bl+Ph4ubdTSKmrBtnFGn5Ej2I0ZHBcwW3cY
         Ay8g==
X-Gm-Message-State: AOAM533ow5y7gMy0k4hNcJCDnupHB8OKcUA1ZTW3rsXoqGyTKwlqD0Zn
        LtCYGS5eBIRjqkx6rUlbENpph+KzHMHsfnY08hS0TA==
X-Google-Smtp-Source: ABdhPJwKxe804YeQ//bJYzoHJeWs8CG/0trTL80DIjWDkyez4zqA0qZwYwo00/BGcss3dh2WBXmGGTuL56+epTo47PI=
X-Received: by 2002:a9d:c29:: with SMTP id 38mr21760685otr.107.1592256429423;
 Mon, 15 Jun 2020 14:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
 <839133dd-8ed4-5fec-c311-ce9f8abf3d5f@samsung.com> <CACvgo50HieMRRb1kK3X0XWXtNmgidYi_OWW9DGCrxT+1q14RWQ@mail.gmail.com>
In-Reply-To: <CACvgo50HieMRRb1kK3X0XWXtNmgidYi_OWW9DGCrxT+1q14RWQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Jun 2020 23:26:58 +0200
Message-ID: <CAMuHMdVpT1oCg0LuQXHdoZg-nQTFfk7ZUs=qm+S2oARaPb5DTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] video: fbdev: amifb: remove dead APUS support
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

On Mon, Jun 15, 2020 at 10:38 PM Emil Velikov <emil.l.velikov@gmail.com> wrote:
> On Tue, 2 Jun 2020 at 11:37, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > On 5/14/20 10:21 PM, Geert Uytterhoeven wrote:
> > > These #ifdefs are relics from APUS (Amiga Power-Up System), which
> > > added a PPC board.  APUS support was killed off a long time ago,
> > > when arch/ppc/ was still king, but these #ifdefs were missed, because
> > > they didn't test for CONFIG_APUS.
> >
> > Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/video/fbdev/amifb.c |   63 --------------------------------------------
> >  1 file changed, 63 deletions(-)
> >
> A quick look through my checkout (drm-misc/next aka 5.8 ish), shows
> multiple other places which check for the define.
> And a single place where it's being set - the Makefile below.
>
> Should those be addressed as well? Or perhaps they are and I've got an old tree.

Only the above apply to APUS support.
All other below are probably legitimate.

> $ git grep -c __mc68000__
> arch/m68k/Makefile:1
> drivers/block/floppy.c:2
> drivers/ide/ide-probe.c:2
> drivers/input/misc/hp_sdc_rtc.c:1
> drivers/input/serio/hp_sdc.c:3
> drivers/input/serio/hp_sdc_mlc.c:1
> drivers/net/ethernet/i825xx/82596.c:8
> drivers/tty/vt/keyboard.c:1
> drivers/video/fbdev/amifb.c:11
> include/linux/a.out.h:1
> include/linux/hp_sdc.h:1
> include/uapi/linux/a.out.h:1
> lib/fonts/fonts.c:2
> lib/mpi/longlong.h:1

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
