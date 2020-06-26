Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F19FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AE920768
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgFZOn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:43:56 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46135 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFZOnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:43:55 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N79dk-1imBjZ2qPk-017XgT; Fri, 26 Jun 2020 16:43:53 +0200
Received: by mail-qt1-f174.google.com with SMTP id d27so7626478qtg.4;
        Fri, 26 Jun 2020 07:43:53 -0700 (PDT)
X-Gm-Message-State: AOAM532epSrTpQeBMtaXM/aJMQ7SQsatYJfGBHk6fVBXKtz+rAZisDhu
        Fs1c1dIkj06PkJlVoffmZw5UTWcQDTeXtFrmv9A=
X-Google-Smtp-Source: ABdhPJxA6PkdKGh0KA/DT2IS/lBs/pI8NJAJLRQeAyCjLUdwxEkqkF4bSQcq+oTI0Dgokdmj/CNL0WUgqGbPAdWQ6E0=
X-Received: by 2002:ac8:4ccb:: with SMTP id l11mr3080469qtv.18.1593182632492;
 Fri, 26 Jun 2020 07:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200625202807.b630829d6fa55388148bee7d@linux-foundation.org>
 <20200626032946._LJ_E6G66%akpm@linux-foundation.org> <CAHk-=wiZrhVUq3N17=GVzMQNQUKi65x=-djTM2A+fz8UdQxgEg@mail.gmail.com>
 <CADRDgG6SXwngT5gS2EY1Y0xnPdYth-FicQyTnPyqiwpmw52eQg@mail.gmail.com>
 <CAHp75Ve2x9dEqaHSue5UAftsJw+U3n8K9YEXBy5QFGJHgkQ3DA@mail.gmail.com>
 <CAK8P3a3doveL3DxjcyiAqxNve07WfXYNTXK77Pbm70Dvyowg2w@mail.gmail.com> <CAHp75Vfr8sFydbH=G7U+wXoUftT9RnsfSSLi4RXNyR-3sApR3w@mail.gmail.com>
In-Reply-To: <CAHp75Vfr8sFydbH=G7U+wXoUftT9RnsfSSLi4RXNyR-3sApR3w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jun 2020 16:43:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2bCyO6xV+tCynjVXpgH-wkQ7=N5pfa8oax9BKWL+a7ig@mail.gmail.com>
Message-ID: <CAK8P3a2bCyO6xV+tCynjVXpgH-wkQ7=N5pfa8oax9BKWL+a7ig@mail.gmail.com>
Subject: Re: [patch 10/32] linux/bits.h: fix unsigned less than zero warnings
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        mm-commits@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:u2Wd2KwN1fnhp5xGG3VB1Ykr9h6Ts6TP5XzvcIHgH+rksEjiydE
 mUyMpViGJ72gbajSxTjkhwWo8U94VTOkuQvcbAOwxYNKHJ4Hl65WfOKH2P9TQztdY0OYEUu
 x/eqeTh+9GAiOqWX2Af6FXX0P8SqGBjaK6UzDFJX07NGGTA5c4RUSDY8k/QubJIkF7q9aFc
 unM0hs+25qcEUT/rKNPmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yypcDeO9YGI=:yd19hbR+CwrvU9dsjaM1TJ
 ATHKgOU8aw/ELoxjqeJIGwaK5Wy9jPCG3oj6bAiQg4RFCJ+gClm9bMG9z+jOhdOHZcwAQHcH6
 nfDzD72SZMcNzAKoSMePvxjoLyvkMdgZfPHvmBCVy3lqg+m0lLhrSak3UVQ6MxPajbyGTnICF
 d0bVA1qFzdv9xjiPC6g4QBH9OZwRK1qT85oPCAjH4dTmc3726rELAY9ACtIlBmR6ywbaSbizm
 jIurP3hTIhyFL1HUF30yfE+skVpc0z1yOBV8sLi1AgeQcOhP6jYxb/txgdQrbXGn6WG6mstwV
 Vmhb0DEL/WOKbqo+gccGrv9sl7sq5wr15VOYEzUdKcBtEbu0xVXc0j4KNUPpBPwpuO1lpE50c
 EZ4GZaSGsAuB+t8FMHVJ7Br/wAikOYPXisKkTyjEg/y738BnnM0kxqz8VYpylNjJnGODNFIij
 Ysu37lCErTljBWyKXV6N5YsY1+hEVYfY0NgKwQSv0VN5gjHv84gO1A+R8kswqzrACapjhskvD
 FtxdmtZgaydpeKByvkt6qidoTV9ne3AGn00mYx8MqrM0wIaBBAs6XWCGteyXwUSnR65EiahrL
 pjHlXOKjEPrx9HJUA4LqaAL/HbAc/2MNR2wAOLV5eRKJFCzXCs8kEr51USYk5+HdPDVGV1R5f
 GOXe7fuLI0ymwrmJm5UcqDzv/Q3WdIpzlJVfVW39kt33chLui/+lmQo3Sdh+M1V0AU5jeo2iS
 DGbuQyMRD93VnMq8+yIsNr82HemqpZM3Y2EqzFJ2hXaT6eaa4bqWTf/8sQaGIVQ3lu0rCLSRZ
 K7Xv08Cr2byjJ+Hp9B0UAvJ2NB5tNUvsjyeBauYITcFkO8Vh38=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 4:09 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jun 26, 2020 at 5:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Jun 26, 2020 at 3:24 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Jun 26, 2020 at 2:37 PM Rikard Falkeborn
> > > <rikard.falkeborn@gmail.com> wrote:
> > > > Den fre 26 juni 2020 08:32Linus Torvalds <torvalds@linux-foundation.org> skrev:
> > >
> > > ...
> > >
> > > > I'll just say no and point to this email next time someone complains instead.
> > >
> > > "No" is not constructive here. People can be annoyed with warning
> > > messages, but the real issue here are the various CI systems which
> > > send a lot of spam because of that. As a maintainer I would need to
> > > drop CI in order to see a good patch. If Linus considers that warning
> > > useless, then probably you can change your patch to do what he
> > > proposed.
> >
> > How about moving that warning from W=1 to W=2? Generally speaking
> > I'd expect W=1 warnings to be in a category of "it's generally better to
> > address this in the code, but we can't turn it on by default because the
> > output gets too noisy", as opposed to W=2 meaning "this sometimes
> > finds a real problem, but fixing the warning often makes code worse."
>
> It would work for me if it had been
> a) documented (I didn't check if it had been already done, though);
> b) understood by all CIs in the same way (see a) as well :-).

I checked the 'make help' output, which describes them as

make W=n   [targets] Enable extra build checks, n=1,2,3 where
   1: warnings which may be relevant and do not occur too often
   2: warnings which occur quite often but may still be relevant
   3: more obscure warnings, can most likely be ignored
   Multiple levels can be combined with W=12 or W=123

which is less specific than the interpretation I had in mind but
I think still fits a).

      Arnd
