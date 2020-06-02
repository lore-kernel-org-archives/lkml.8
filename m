Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADD6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF284206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgFBLEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:04:48 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:44234 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgFBLEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:04:47 -0400
Received: by mail-oo1-f68.google.com with SMTP id e8so1632751ooi.11;
        Tue, 02 Jun 2020 04:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnU67PM5tYuOxOQ+ffnEXx7IP/EaDf221A3j8p4Bihs=;
        b=TZfncMOjIFrBbaZ31JJa1FvBWRjbJUH8oifaOiq7nQowyup+3lWbN2xdrz7AeqUloV
         PKalo02TpG5AAwmjcWrmPwVj0x0CEUwfPHbpqVwLi3iCcoW/7e3Hb8HcMUieiN0iZTY2
         S15uZR43Jw6J8Hc7+D8c+NbB7EqJc9ebsow6TT/ZuWfFfGyR6t4MEW0nh+ZL2Ecsfz1E
         iEU8lHzAAb4bM80vZpJryLB5GupO9xAX7oT6DjgI1iwYS52ud9hqo8jB7csR/hKmPfSQ
         PL3wG8fSQrW5DxzugA/LyhmM1eSqs0V20P+mHt1B4Em+RowYW/jhqX0T3F3kZUrIEa3t
         9bIg==
X-Gm-Message-State: AOAM533YoHfZ5+Iqq7eZAOvlspirNN4zYA88IZz0buk3xLgjgrcN2133
        /rSxmEOvzZ/18QVf+wNDY/MiDoV/d5g3TTwpZjc=
X-Google-Smtp-Source: ABdhPJx5LJM1BuqsyoFrXnT/JqbG5sPPQGLYtu772FLIRUMwlABs9hqY840TLSR+IxcpPBkOXCjVdX5M39D3Q54TX0I=
X-Received: by 2002:a4a:e295:: with SMTP id k21mr20587446oot.11.1591095884883;
 Tue, 02 Jun 2020 04:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
 <839133dd-8ed4-5fec-c311-ce9f8abf3d5f@samsung.com> <72e0871c-d4bb-4887-4d6f-a60fd905bec1@physik.fu-berlin.de>
In-Reply-To: <72e0871c-d4bb-4887-4d6f-a60fd905bec1@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Jun 2020 13:04:33 +0200
Message-ID: <CAMuHMdXUD4PNndjtxz84pYMdXaM68g7vWiRd+Gf18a35T-oA=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] video: fbdev: amifb: remove dead APUS support
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Jun 2, 2020 at 12:41 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 6/2/20 12:37 PM, Bartlomiej Zolnierkiewicz wrote:
> >> These #ifdefs are relics from APUS (Amiga Power-Up System), which
> >> added a PPC board.  APUS support was killed off a long time ago,
> >> when arch/ppc/ was still king, but these #ifdefs were missed, because
> >> they didn't test for CONFIG_APUS.
> >
> > Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/video/fbdev/amifb.c |   63 --------------------------------------------
> >  1 file changed, 63 deletions(-)
>
> What do you mean with the sentence "when arch/ppc/ was still king"?

Ah, Bartl copied that from my email ;-)

There used to be APUS support under arch/ppc/.
Later, 32-bit arch/ppc/ and 64-bit arch/ppc64/ were merged in a new\
architecture port under arch/powerpc/, and the old ones were dropped.
APUS was never converted, and thus dropped.

> Does that mean - in the case we would re-add APUS support in the future, that
> these particular changes would not be necessary?

They would still be necessary, as PowerPC doesn't grok m68k instructions.
Alternatively, we could just drop the m68k inline asm, and retain the C
version instead?  I have no idea how big of a difference that would make
on m68k, using a more modern compiler than when the code was written
originally.

Note that all of this is used only for cursor handling, which I doubt is
actually used by any user space application. The only exception is the
DIVUL() macro, which is used once during initialization, thus also not
performance critical.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
