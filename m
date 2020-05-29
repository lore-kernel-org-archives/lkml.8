Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA61CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB93A2067B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgE2UYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:24:15 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59801 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2UYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:24:14 -0400
Received: from mail-qv1-f43.google.com ([209.85.219.43]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MzQTm-1ijeiy1TQO-00vQTy; Fri, 29 May 2020 22:24:12 +0200
Received: by mail-qv1-f43.google.com with SMTP id g7so1696470qvx.11;
        Fri, 29 May 2020 13:24:12 -0700 (PDT)
X-Gm-Message-State: AOAM5325luuq+AtpINf3nNxIfnEAR1l+D+iHpVQFy2YNG0X7V9uP2sIO
        nGIB0yDQ9vvPomohy9bxUXKODmJ1bChql5IEFX8=
X-Google-Smtp-Source: ABdhPJx7GHTTCfCGhussY+Eplzfo//0UkInYh6OmR/xMj6EDE6gnVnUEnrdJF8J+cDpIA5731Omdb8TsCeIGZfpOSvY=
X-Received: by 2002:a05:6214:1842:: with SMTP id d2mr5946816qvy.197.1590783851109;
 Fri, 29 May 2020 13:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200529200031.4117841-1-arnd@arndb.de> <CAKwvOdnND7XFgr7W9PvZAikJB1nKxB4K5N-oP0YrBT74oX_C9g@mail.gmail.com>
In-Reply-To: <CAKwvOdnND7XFgr7W9PvZAikJB1nKxB4K5N-oP0YrBT74oX_C9g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 May 2020 22:23:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2UKC=s7re2P+qfxz8eqeC+yCcPGuYKkgji9N_ugdgWhg@mail.gmail.com>
Message-ID: <CAK8P3a2UKC=s7re2P+qfxz8eqeC+yCcPGuYKkgji9N_ugdgWhg@mail.gmail.com>
Subject: Re: [PATCH 1/9] staging: media: atomisp: fix incorrect NULL pointer check
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5ZiodbsObCJPTEeIXzD6tySoA6XWPIcAgUvi8XVSt77ZOMDswZh
 R7re4PXFyHDOxjGFetYK4UZ+g/i1g3kijkmRV/ttiwoTl06j5vde4jIq7lfzoKZdsOrDuBD
 gkEwp+vyysOC4ol1qzTC7kF0H4Wh5h6c8GL7xcmfBmC+6dWyPkg6x90LvF/oFFuTHe2tcer
 Lald9kWxAw23uJXF2tulg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AU6BC5TXA70=:gXXVkoyjnARvhHeRuWY6ma
 6t0DlnkcjOJufD54JjrE6pg39ec0L/LOIXJo7ASPPAe5AKexMI1va7hfror3+KWxMwGodRceL
 Hgaago70NRXrOP5me37A4G2LHbwstvQLuBhg0LgGmQrxuajZpHl9thmU4759kvQejpF3tsepU
 PYMqbd76jj6WAt3EvzRVM+y753/yzjJ3kodGCwK9+fyHTKlzty6EqxYLIMwClxEvluvuyBeWs
 X2ylVDRntOdbtiFdp3yz/secfgqtEgDlN+/IpqLrmwZrh2nrOPM1aWT2pmmvNlIZ5PbSVtQfz
 eLsN4vUsu7dls+JvBN+lVlo9lzpCeZTijamnfDtfbuIQ4fV2j4bHA83D1113ZTR7lXWVUQkZS
 ZvGLx/isB4fRbKJNbNknjJGAoBJ5KXuaVIlJiro/C2IgUex48h9BqzyJRks9w7qd3o6BMw6i/
 Zr75iYNfchrtDwQd4lCwk3qspxzCyYbFs8MW5FnlpNhBFuvaX/oiv1rZwFNoxJzYyo9dZ0H+l
 m3KcF23M530IH6DeEkDwsvcdnYjqEaPXAi0b2W5lpa8nV9Zkag4MiiTmeEGfFQ1+n9Aq0C3he
 L6ncPGh29RDj24n/buNZEq4IhkJlGGepIOG48KXVlFe7f6mkPQ3QnQw5lPziuKU6pocf9WYGT
 GIr8VlKpq76QnIryAge05FXY4eLLwLAFTpisXA8kt4oyFdVlL0spYri64jXfVuuDxHCsdlshJ
 ibh9xsOWuR/DNn4MsktyeqjAruPU2h9ax41g9RejTuGF/FJB7d9tB1uzgL4AcFlPYYrGTFIhy
 KgxneL+pykfOrFGekOPjdkZICNXpQlwbBvWJW1mKxznxKYvEhg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 10:04 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> See also Nathan's 7 patch series.
> https://lore.kernel.org/lkml/20200527071150.3381228-1-natechancellor@gmail.com/
>
> Might be some overlap between series?
>

Probably. I really should have checked when I saw the number of warnings.

At least this gives Mauro a chance to double-check the changes and see if
Nathan and I came to different conclusions on any of them.

      Arnd
