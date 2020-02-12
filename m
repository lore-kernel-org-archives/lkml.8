Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30A5C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B0320714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgBLJ5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:57:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37059 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgBLJ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:57:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id d3so1326259otp.4;
        Wed, 12 Feb 2020 01:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eeNTMzOet6YbJZM6KBXk+480ZyC+Oan10p6vM7BqSvg=;
        b=qPr0yf12vizdIR77cFbjmKKStY6ioQTvgEUJY1K5EHi+/67GRD+hgCptLAa4H4OODF
         DjyCJgoPvYFdfZg7sbDM+oWGFUDbHxO/C1B/kYoY44qfUrYgz3eecVkYnunWpl21eT3p
         sUHfJnw3g04tzhAHXrcdw79BGpZ2UM4CqgAtyrgk4+tfZquZuVt0vTMxTNhAI5F7WXhQ
         Jkb5XGvTh7q3MkIvi+QrxADxsXyBLpgPXMsS843rN1CACaayRWP8q2JVTrAJCMzulV8g
         srFjQEH74c3NkkiWdNfsT+UEvp0m4e5j4UK+2bQOYLlk3Yu59r/rmiQB8X1Dcw6rErko
         KlSQ==
X-Gm-Message-State: APjAAAVikZFq0UOY3GA0PWHFEEc2Jfr7szUtIjGkwAvgLEZepbVF/OY+
        nN+YDxfcrUj2iUpjT9fTwVSae//5EgmZ9PQckuc=
X-Google-Smtp-Source: APXvYqxMDwVz0mamGWk/u7qbUkHdewv3+BvLrju7oQjjc9kcCPfjwC7rRallUsgMAYlyjHnrBSwrbGBRblWAlqXOwe8=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr8766923otm.297.1581501470937;
 Wed, 12 Feb 2020 01:57:50 -0800 (PST)
MIME-Version: 1.0
References: <dcdd615f77dacf8a98e18950b66fb5a675277f38.1581498987.git.michal.simek@xilinx.com>
 <CAMo8BfLYM-_SbqmMUCVjwqL7MpA2W7toTg_F6HTY4Sg5QxGzfw@mail.gmail.com>
 <CAMuHMdUZ_e9JsF0fuLxBwdoy7YVLarH6E98z5nKUZ2CccSkV-Q@mail.gmail.com>
 <6128aa3a-a99c-2ab0-82d1-d5c419e4f5b9@xilinx.com> <CAMuHMdX3O6aL_yGSfqrbdfPf-HHqqdkMwPHS=Y0WxMRTYOtJ4w@mail.gmail.com>
 <1d006656-bd48-0b8e-b893-cddaa5f8f8bc@xilinx.com> <CAMuHMdXaOD5kL+Cg0L=YeX_DqdVgUJXEA8LF-NiHbmkMuXKTaA@mail.gmail.com>
 <d93646fa-c844-693c-07a7-7075d0fcf2c9@xilinx.com>
In-Reply-To: <d93646fa-c844-693c-07a7-7075d0fcf2c9@xilinx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Feb 2020 10:57:39 +0100
Message-ID: <CAMuHMdXQqEYsL4KfDb4EkS+P+6qW=E4m3wunx_LXZddXVZMd4g@mail.gmail.com>
Subject: Re: [PATCH v2] asm-generic: Fix unistd_32.h generation format
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matt Turner <mattst88@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <rth@twiddle.net>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, Feb 12, 2020 at 10:42 AM Michal Simek <michal.simek@xilinx.com> wrote:
> On 12. 02. 20 10:40, Geert Uytterhoeven wrote:
> > On Wed, Feb 12, 2020 at 10:38 AM Michal Simek <michal.simek@xilinx.com> wrote:
> >> On 12. 02. 20 10:32, Geert Uytterhoeven wrote:
> >>> On Wed, Feb 12, 2020 at 10:27 AM Michal Simek <michal.simek@xilinx.com> wrote:
> >>>> On 12. 02. 20 10:25, Geert Uytterhoeven wrote:
> >>>>> On Wed, Feb 12, 2020 at 10:23 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
> >>>>>> On Wed, Feb 12, 2020 at 1:16 AM Michal Simek <michal.simek@xilinx.com> wrote:
> >>>>>>>
> >>>>>>> Generated files are also checked by sparse that's why add newline
> >>>>>>> to remove sparse (C=1) warning.
> >>>>>>>
> >>>>>>> The issue was found on Microblaze and reported like this:
> >>>>>>> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
> >>>>>>> warning: no newline at end of file
> >>>>>>>
> >>>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >>>>>>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
> >>>>>
> >>>>>>> --- a/arch/m68k/kernel/syscalls/syscallhdr.sh
> >>>>>>> +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
> >>>>>>> @@ -33,4 +33,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> >>>>>>>         printf "#endif\n"
> >>>>>>>         printf "\n"
> >>>>>>>         printf "#endif /* %s */\n" "${fileguard}"
> >>>>>>
> >>>>>> Here there's already \n at the end, so no need for another one?
> >>>>>
> >>>>> Thanks! I completely missed that.
> >>>>> So I did fix the original while applying ;-)
> >>>>
> >>>> I can drop m68k or align with with others. I would prefer to have the
> >>>> same solution in all these scripts.
> >>>
> >>> Yeah, it makes sense to align as much as possible.
> >>> IIRC, the original plan was to consolidate more later.
> >>>
> >>> Note that all other lines are terminated with a "\n" at the end.
> >>> The separate 'printf "\n"' is an extra blank line, not the terminator for the
> >>> previous line.
> >>
> >> Should we also get rid of 'printf "\n"' lines or just keep them as they
> >> are today?
> >
> > Usually there is a blank line above the include guard terminator, so IMHO
> > it makes sense to have that in generated files, too.
>
> I meant more not to get rid of \n just include them in current prints.
> It means like this 'printf "\n#endif /* %s */\n" "${fileguard}"'

I think having a "\n" at the start of a string makes the code harder to read.

You could move it to the end of the previous string, but that is not always
possible (e.g. after the loop), so I'd keep the separate prints for blank
lines.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
