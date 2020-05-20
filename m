Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F7CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C01C2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgETOvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:51:43 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39736 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETOvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:51:43 -0400
Received: by mail-ot1-f67.google.com with SMTP id d7so2666419ote.6;
        Wed, 20 May 2020 07:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXv+TNr2XiVo0uUaNtBITgiwBxKOFe0DS+6v0ILeFxI=;
        b=qA2G1xYPeumIbUQMqbvCcNdTi7mS0tvAl96pvwMVp7M/lxZp+XfpBsA3BzHLw88YVo
         DJ/tFKcOYPstuu8yVAndW3KEdtOPydhe3BavwmBPfDXCZL8oVlvHaiDsDFj83wGS8o7q
         j9xz3rxF4RQo1TcuWVE9wtwE1SelqY0lhI1tLkCXXg9Z0MsbMcbr2lpwBUWcwuztB718
         5lDDv4vxuHo95piBmUOUEIWORaB9L0xLcgf3a7kQXzgg4U6caqJ0s4mFkgKuKLzD/ool
         bUOybC8IWSEBn02/F34/aSJZl1xIh/mvbvLiKbnzwpDeM4//3DtSeir86Ssud1iRLF9r
         qOrg==
X-Gm-Message-State: AOAM531f6FeZ0FbLoA88RjwUcP6vicvVuAvUWMxg3Tc93y1Mp6YUj4rW
        gr/LeKqO7iwOuDt4aGeibA9QXMRgmUBFsajmU8U=
X-Google-Smtp-Source: ABdhPJxAwRThCmkc+DNYRZR+y7CAkXfsqNOLlqLFegX9/SaGSsgCmV+X0Gmarfvoyg/1Biw+kTnPoN6/bdmDpWCv4AQ=
X-Received: by 2002:a05:6830:18d9:: with SMTP id v25mr3214703ote.107.1589986302015;
 Wed, 20 May 2020 07:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200519131327.1836482-1-arnd@arndb.de> <20200519181034.58c67eb5bea24aae24d33421@linux-foundation.org>
 <CAK8P3a281ZLKwkWCKkAdQvA6=XA4=+mKWbwEzK_BR4Uu1c5DNQ@mail.gmail.com>
 <CAMuHMdUx9zKbc7n164Gi+N9k-NhmbgXtU+Z4yZ9SvdxeCMtJKw@mail.gmail.com> <CAK8P3a0+RWNUroSAtdVazxMV=o+FYpTX9Wvkbr5gODh4=zODkQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0+RWNUroSAtdVazxMV=o+FYpTX9Wvkbr5gODh4=zODkQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 May 2020 16:51:30 +0200
Message-ID: <CAMuHMdWKOZMn-pMpE6MgKo1ArL701fp4ZR65sa5yGfozf7Yu4Q@mail.gmail.com>
Subject: Re: [PATCH] sh: include linux/time_types.h for sockios
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, May 20, 2020 at 4:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, May 20, 2020 at 1:47 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, May 20, 2020 at 10:32 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, May 20, 2020 at 3:10 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > On Tue, 19 May 2020 15:13:13 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > Using the socket ioctls on arch/sh (and only there) causes build
> > > > > time problems when __kernel_old_timeval/__kernel_old_timespec are
> > > > > not already visible to the compiler.
> > > > >
> > > > > Add an explict include line for the header that defines these
> > > > > structures.
> > > >
> > > > I can grab this.
> > >
> > > Thanks!
> > >
> > > > > Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > > > Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > > > Fixes: 8c709f9a0693 ("y2038: sh: remove timeval/timespec usage from headers")
> > > > > Fixes: 0768e17073dc ("net: socket: implement 64-bit timestamps")
> > > >
> > > > cc:stable?
> > >
> > > Yes, I missed that.
> >
> > Doesn't matter, the stable bots will pick it up anyway, based on the Fixes tag.
>
> I normally prefer to be explicit, as some bug fixes may address
> something that has been caused by an earlier commit, but should not
> be backported for some reason.

Which means that with the current "intelligent' backporting, you need a
Not-for-stable tag instead...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
