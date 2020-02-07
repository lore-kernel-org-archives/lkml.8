Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554A5C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359E5217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgBGItP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:49:15 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46859 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGItP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:49:15 -0500
Received: by mail-ot1-f67.google.com with SMTP id g64so1418203otb.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 00:49:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9Rmru5NVQH7N8jpo6ScswectNj9KG8uBCEy9qo5JK4=;
        b=dNO/HigLQkAv73XumWM8++St5nYFPV2paqhLGHGg3ij9FsZiM6TpyJDUMvmXLPYOBm
         sGb1/VHKkbTf4JfFiJnNkNzJZt1802qkhVvEvOJtAefdk9lHr3nyC05vUb4f2caPelMw
         GNSvVIO1+/T/NqddNOnmBo+BEr9Ew76gDQo6T2sdnTwdfqeOlTORI3ns+/dWPUlKGVn0
         xwR30qNaOaeiHzZRkQjTiFKDttO4RNYBQ8Poz/SzZNF1Ec8QmYd4rrypX2AP29CmqtSq
         +bjH9mYDi2RHQ3Hgt5KvsBCsyUQdUknZQ1/C89WA+ykrLGxut3BLmTeNOBVvJd+nHSXb
         liBQ==
X-Gm-Message-State: APjAAAWfWFFYOqI3AOLLIyEbfTQz+BBSK9ZWx4gEnDg2qPR3JUWLXPc+
        3WSb73Fvnu/K4rpVkRIfdzt1JR7WiYMByyWxwNc=
X-Google-Smtp-Source: APXvYqwJmevkjeY3oVdRIFFsx1oNxWtErLno/CIWEu2mNWOyg5bnBu2R6DlW1sOqBJBEfc/MES354UwNpN+hLL1c9zQ=
X-Received: by 2002:a05:6830:1d55:: with SMTP id p21mr1842361oth.145.1581065353870;
 Fri, 07 Feb 2020 00:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20200114210316.450821675@goodmis.org> <20200114210336.259202220@goodmis.org>
 <20200206115405.GA22608@zn.tnic> <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
 <CAMuHMdVq1FFBV+XBq-BkLbCb-ZmkKvVMQ4xACxF-+2Wc3mnnNg@mail.gmail.com> <20200207093003.93711310cfafae98bb2a62f6@kernel.org>
In-Reply-To: <20200207093003.93711310cfafae98bb2a62f6@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Feb 2020 09:49:02 +0100
Message-ID: <CAMuHMdVW74CKL-HYJS1YcK2KDew5db6TudC3O7vxk6mjmHxAvg@mail.gmail.com>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config support
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hiramatsu-san,

On Fri, Feb 7, 2020 at 1:30 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Thu, 6 Feb 2020 18:20:15 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Feb 6, 2020 at 3:42 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > On Thu, 6 Feb 2020 12:54:05 +0100
> > > Borislav Petkov <bp@alien8.de> wrote:
> > > > On Tue, Jan 14, 2020 at 04:03:20PM -0500, Steven Rostedt wrote:
> > > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > > index a34064a031a5..63450d3bbf12 100644
> > > > > --- a/init/Kconfig
> > > > > +++ b/init/Kconfig
> > > > > @@ -1215,6 +1215,17 @@ source "usr/Kconfig"
> > > > >
> > > > >  endif
> > > > >
> > > > > +config BOOT_CONFIG
> > > > > +   bool "Boot config support"
> > > > > +   select LIBXBC
> > > > > +   default y
> > > >
> > > > Any particular reason this is default y? Why should it be enabled by
> > > > default on all boxes?
> > >
> > > Oh, you are not the first person asked that :)
> > >
> > > https://lkml.org/lkml/2019/12/9/563
> > >
> > > And yes, I think this is important that will useful for most developers
> > > and admins. Since the bootconfig already covers kernel and init options,
> > > this can be a new standard way to pass args to kernel boot.
> > >
> > > And as I reported above thread, the memory footpoint of view, most code
> > > and working memory are released after boot. Also, as Linus's suggested,
> > > now this feature is enabled only if user gives "bootconfig" on the kernel
> > > command line. So the side effect is minimized.
> >
> > With m68k/atari_defconfig, bloat-o-meter says:
> >
> >     add/remove: 39/0 grow/shrink: 2/0 up/down: 13086/0 (13086)
> >
> > which is IMHO not that small for a "default y" option that may or may not
> > be used.
> >
> > Especially:
> >
> >         Function                                     old     new   delta
> >     xbc_nodes                                      -    8192   +8192
> >
> > Any chance xbc_nodes can be allocated dynamically, and only when needed?
>
> Yes, I think we can use memblock to allocate it. However, this xbc_nodes is

Good.

> __init_data, which is released right after boot. So I think it should be
> OK except for your system doesn't have user space...

__initdata is still part of the kernel image (note that we no longer
have __initbss) and consumes RAM early on, and is thus subject to e.g.
bootloader[1] and platform limitations (e.g. the kernel must fit in the
first block of physical memory).
So trying to avoid large static arrays is useful.

> > Yes, there are industrial products running Linux on a current ARM SoC
> > using the builtin 8 or 10 MiB of SRAM (+ XIP for the kernel), so these
> > definitely want to say CONFIG_BOOT_CONFIG=n.
>
> I think for such products the kernel must be tuned with custom config,
> and you can say CONFIG_BOOT_CONFIG=n. That is a configurable feature.

I do not dispute that.

[1] Re: [PATCH] dma-debug: dynamic allocation of hash table
    https://lore.kernel.org/lkml/CAMuHMdVSyD62nvRmN-v6CbJ2UyqH=d7xdVeCD8_X5us+mvCXUQ@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
