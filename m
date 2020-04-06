Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE128C2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6AF20672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDFHfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 03:35:54 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46651 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgDFHfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 03:35:54 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MNtGq-1jf3wF3dea-00OHm3; Mon, 06 Apr 2020 09:35:52 +0200
Received: by mail-qt1-f179.google.com with SMTP id 14so11838145qtp.1;
        Mon, 06 Apr 2020 00:35:51 -0700 (PDT)
X-Gm-Message-State: AGi0PuYm2bnuPw6t6UOVgszpUf+in8zW0ZNzOo4Vbbb7oAA2crK1Hw7g
        ekFQQXZ5pN1ZioBtPzN1l+N0mv5aiaF1ZnXkaFg=
X-Google-Smtp-Source: APiQypJHJS0D0CuhIzouy0vALcYme6GTHL8o+M28QRpIRClyooISWprSWqp9Foh4IT+wMoCY0ggm3yzmP9kVRI43Jyk=
X-Received: by 2002:ac8:16b8:: with SMTP id r53mr19668234qtj.7.1586158550566;
 Mon, 06 Apr 2020 00:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200405025123.154688-1-sboyd@kernel.org> <20200405025123.154688-7-sboyd@kernel.org>
 <CAK8P3a2M54quhRNK4xvwjz9O9oZwgrobc_wtkGaeA2PMYwOUdg@mail.gmail.com> <158614207114.88454.6776609424163493475@swboyd.mtv.corp.google.com>
In-Reply-To: <158614207114.88454.6776609424163493475@swboyd.mtv.corp.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Apr 2020 09:35:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Yt2woG2LMcQ0jNPGuHdMtFbBmLvtBbrWFQ4J6x3v9aQ@mail.gmail.com>
Message-ID: <CAK8P3a3Yt2woG2LMcQ0jNPGuHdMtFbBmLvtBbrWFQ4J6x3v9aQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] clk: Allow the common clk framework to be selectable
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Russell King <linux@armlinux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER <linux-mips@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org, linux-m68k
        <linux-m68k@lists.linux-m68k.org>, Linux ARM
        <linux-arm-kernel@lists.infradead.org>, Linux-sh list" 
        <linux-sh@vger.kernel.org>, Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:guG4TD9/Uf+l6wsnYaEJi6Nf+tdBSE8+6uRQApQnKzvFjmypFrX
 hHWh3Ezp4uR2SgKdphNtOD2nV9veSIcm9XcGUZPF254KJA9ESrAw9usS6nBtgo/cJxc97yH
 vq4zyfZidFEcGJ1Y5+FS/diCSzvXVCU6NeRcSait6N76rznNCsnt+7iqn51qvT41OnUPZQk
 y8HewBkW2Otg0MGY0lFPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:COsle5nMj1M=:/4N0BpONBt12pFkaBZk9ZB
 KO75BcLWIs03zb0ydTySC2tUtTolL9/Ce3u0CxVriTJBz/Xqb0tmrpXL+WHab55MiiiCP3nfw
 uZFOLLvA5NjSLt/jQdPmLWsMh2AxaZMwrYSWerS/nUgQIhyE0y35qUSOBP70TCL2tpu03cv9G
 +5S57QZbOu2rQwITjWVQFpdY4hyNSQouC0kBJs8h1eAjV9/SULSJv43PCjSPP939u4jN88cAy
 TIGa4uZYFyObrTVb9R/kQfNGbN9W1rWDiJ0+jBeaU4qBkDJmCMnK3SGPIvI/AJXLnFiSi3j6E
 VV2ebVfYbH63BidI9UZihZDMhDtfVaxuxnNhnJmWMVzAP81M5FM3jCqO66+RZChPCB+gNC8qJ
 zbFePGTqKjFOaDX/Y0nxLdV8/mkLr0zcX0wJHxnwOpprFTAwlTSixrzqKucdxqFvtW3B31eDA
 Eg1rPQLhfyAR0WiBEaNMku5/h+LLaVzCRTVaGLWKqOUliXPwLCJ5zFxvMZX/KkRtnul+ERXZg
 lc3U0UPMvfZto+GLygDY8JaqcSJGLYXilWMyWFSslmc4iHapHTKiKviikcxllfRXUKh4K0a11
 iEomMmo5QjSPB5ETHwTLLJl+K8KqBrY3m/oV0gshlstSzQA8tc66tLGMXeMcxvPlZRLnSQNjs
 1S1/hlO2RhcE65SEAxp8jtXobjG2ooIARtO4wLWllcv4pdVM7u7ILqaVOp44BuGtqhfabsFS+
 7UGS3L1hnMc4Rf/03OyM/unsfb6RMxUUNSRA8pYpmdQmBjUiLzvwcSWhOXPFpCS0BYVEcS4Jq
 zfb7TWAAezh406LSfRBcSOhY3dpXGmXStJB10Miyk6mjMCTtg4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 5:01 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Arnd Bergmann (2020-04-05 05:45:20)
> > On Sun, Apr 5, 2020 at 4:51 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > > There's one snag with doing this, and that's making sure that randconfig
> > > builds don't select this option when some architecture or platform
> > > implements 'struct clk' outside of the common clk framework. Introduce a
> > > new config option 'HAVE_LEGACY_CLK' to indicate those platforms that
> > > haven't migrated to the common clk framework and therefore shouldn't be
> > > allowed to select this new config option. Also add a note that we hope
> > > one day to remove this config entirely.
> >
> > Good idea!
> >
> > I've looked through the individual ones and commented a bit on
> > what I think may or may not happen with them.
> >
> > ralink SOC_MT7621 is the only one that I think you got wrong,
> > as it already has common-clk support.
>
> Ah I missed that it was inside a big if RALINK. Thanks. I suppose I
> should just remove the select then for that config and not worry about
> the duplication of clkdev and common clk configs.

Won't that cause build failures in those configurations that have
both implementations?

According to the Makefile, the clk.c file is built whenever CONFIG_MIPS_GIC
is unset, so I think we need

         select HAVE_LEGACY_CLK if !MIPS_GIC

or maybe move the select into the per-chip configs that need it:
RT288X, RT305X, RT3883, and MT7620.

> > > diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> > > index 60ac1cd8b96f..bd2d29c22a10 100644
> > > --- a/arch/m68k/Kconfig.cpu
> > > +++ b/arch/m68k/Kconfig.cpu
> >
> >    text    data     bss     dec     hex filename
> > 1934726 263616   83284 2281626 22d09a obj/vmlinux-before
> > 1971989 266192   83308 2321489 236c51 obj/vmlinux-after
> >
> > The coldfire clock implementation looks rather simple compared
> > to chips from the 2010s: most chips have only fixed clocks,
> > and three of them have one of two registers of clock gates.
> >
> > It shouldn't be hard to convert, but enabling common-clk will
> > cause a noticeable kernel size increase on the fairly limited
> > hardware.
> >
> > Simply enabling COMMON_CLK in m5475evb_defconfig
> > results in a 1.7% or 40KB growth in kernel size, plus there
> > would be additional dynamic memory usage:
> There could certainly be some work done to reduce the code size of the
> CCF. I haven't looked but perhaps we could save some memory by making
> the basic types selectable too and then push a bunch of kconfig updates
> through for that.

Right, that might help. Another possibility would be to support both
the common clk layer and the custom clk implementation on coldfire
until we remove the other custom implementations, by which point
even fewer people will care about coldfire.

Let's see what Geert and Greg think would be the best path for coldfire,
maybe the added 40KB is less of a problem after all.

       Arnd
