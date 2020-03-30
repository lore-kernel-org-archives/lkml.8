Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C447C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C8620733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgC3VWv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:22:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37833 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgC3VWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:22:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id g23so19791690otq.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 14:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vyl+JushNUhxQR9kB/ILsOGZBSYFhnFHl07ojWx3Yr0=;
        b=efW108/gNjOWQIoe8/cRLDJjOa1jGyXH7uomSmhBbrLNsRWb5tHYYBOKeUYg1LnlyL
         dRAhFHVXcfLrmcz2H7u/9HyAnhkQ87RCKSC+UyPP60lMf9hDSFo9LdJegnwc4mmCQgPI
         LQj24Czd+bg9HLipgQiFCOLC4k6zF4c6gPLQLipfrbZA1ECN4e/FaipMuPYTj1Q1DFg5
         r6X7LsRjDy0EconQ6xDJLholTN020wEIXClHq+KELZT+iHRGXzsZqnBCqL1azNs6HEBX
         0iD2URcVF/o6K5wU5Vk5JdQn8vwNq269UmShk+n6cA0uDLbzohWYCpANc3ikkP/xp+uM
         ivnw==
X-Gm-Message-State: ANhLgQ1PD2evoRJvVlHiFAPuq++3+5gAiA9f5qbc2ne33+sjI0xkJKb2
        ehAl/O9IFKlly00vlbClG8nUOrDdhV20t9TGzCM=
X-Google-Smtp-Source: ADFU+vuatsYFQyzw7KGCdnpaDr1LX96t9W2MKuazQT8eQzMhRM3meDvFmKUJz35yCx0cVZmZIt0zxUQD3IpYwuMtlZQ=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr10645908otk.145.1585603368284;
 Mon, 30 Mar 2020 14:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200330085854.19774-1-geert@linux-m68k.org> <CAHp75Vc1gW2FnRpTNm6uu4gY3bSmccSkCFkAKqYraLincK29yA@mail.gmail.com>
 <CAMuHMdXDBtOo_deXsmX=zA9_va0O5j8XydxoigmS35+Tj7xDDA@mail.gmail.com>
 <CAHp75VfsfBD7djyB=S8QtQPdKTkpU5gFzyRYr8FshavoWgT0CA@mail.gmail.com>
 <CY4PR1201MB01204FB968A6661FB8B295ACA1CB0@CY4PR1201MB0120.namprd12.prod.outlook.com>
 <c8447243-98c6-d545-9766-e6b3f33f4d13@synopsys.com>
In-Reply-To: <c8447243-98c6-d545-9766-e6b3f33f4d13@synopsys.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Mar 2020 23:22:36 +0200
Message-ID: <CAMuHMdWJ22zUkvMXBPBLoNhUkf0bnFBxa_WZAhiUWzA3r4eDkA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.6
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,

On Mon, Mar 30, 2020 at 11:18 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
> On 3/30/20 1:40 PM, Alexey Brodkin wrote:
> >> -----Original Message-----
> >> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> >> Sent: Monday, March 30, 2020 4:28 PM
> >> To: Geert Uytterhoeven <geert@linux-m68k.org>; Alexey Brodkin <abrodkin@synopsys.com>
> >> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> >> Subject: Re: Build regressions/improvements in v5.6
> >>
> >> On Mon, Mar 30, 2020 at 4:26 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>>
> >>> Hi Andy,
> >>>
> >>> On Mon, Mar 30, 2020 at 3:08 PM Andy Shevchenko
> >>> <andy.shevchenko@gmail.com> wrote:
> >>>> On Mon, Mar 30, 2020 at 12:00 PM Geert Uytterhoeven
> >>>> <geert@linux-m68k.org> wrote:
> >>>>> Below is the list of build error/warning regressions/improvements in
> >>>>> v5.6[1] compared to v5.5[2].
> >>>>
> >>>>>   + /kisskb/src/include/linux/dev_printk.h: warning: format '%zu' expects argument of type
> >> 'size_t', but argument 8 has type 'unsigned int' [-Wformat=]:  => 232:23
> >>>>
> >>>> This is interesting... I checked all dev_WARN_ONCE() and didn't find an issue.
> >>>
> >>> arcv2/axs103_smp_defconfig
> >>>
> >>> It's probably due to a broken configuration for the arc toolchain.
> >>
> >> Alexey, do have any insight?
> >
> > I think I do have some but first I'd like to get it reproduced myself.
> > I just built v5.6 with help of both GCC 8.3.1- & 9.3.1-based toolchains
> > and didn't see a single warning. So I guess I was doing something wrong.
> >
> > FWIW
> >
> > 1. My GCC 8.3.1 toolchain was exactly this:
> > https://github.com/foss-for-synopsys-dwc-arc-processors/toolchain/releases/download/arc-2019.09-release/arc_gnu_2019.09_prebuilt_uclibc_le_archs_linux_install.tar.gz
> >
> > 2. Linux kernel is vanilla v5.6.0
> >
> > 3. Configured and built as simple as:
> >    make axs103_smp_defconfig && make
>
> It seems the build service is using a arc toolchain built in 2016 :-)
>
> # < /opt/cross/kisskb/br-arcle-hs38-full-2016.08-613-ge98b4dd/bin/arc-linux-gcc
>
> Call it Murphy's law, same year a little later I'd fixed the same issue in gcc [1]
>
> [1] http://lists.infradead.org/pipermail/linux-snps-arc/2016-October/001661.html
>
> @Guenter could you please consider updating the ARC tools. FWIW you can build
> stuff off upstream gcc/binutils using build system of your choice.

This is not Günter's toolchain, but Michael's.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
