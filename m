Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E76C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC752071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0ZBKrpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAXWEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:04:08 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37003 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXWEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 17:04:07 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so431154pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Tu7fGYxh1w4JI5oDptrBZjDZV6uO5rpMw55TTrHWyY=;
        b=J0ZBKrpgdlEKx7+rWEjWYTdZEwl9eqo6un876ziIUM+oZmGL7XmzfNWKx/+R3kGMxa
         zO8U1tvFEW8q7rv4LRGGu2D/nUy/RpxDMypBdT5li6xFrLAIn/qmPyiR+u6qe/ILuLLe
         uYILmbciBmATh272eNyXXe0kbM5oRQhOOGudkMoVkkcIfPxSRdepajsuiGdh0Jyyy7/x
         rO7edwM0bdQSKTpd/K6QRvSLH/bsU9v4KEbYZB+Ak4GFR+/TgkAveltib29sxlJHs91q
         2NY0183yD3ZaK8K1lJPvMzbXc9w569CdAqLaWw6iT1LmWw7tdsRrH75AZHOZrWw+EQck
         Ym8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Tu7fGYxh1w4JI5oDptrBZjDZV6uO5rpMw55TTrHWyY=;
        b=T3g4sUNW1VKMMshdvE5Gd7L5R46pcTEVCMBGunnL/Oqe5LGqcUduOAxOHu7HAXU/w9
         sAEV+sMBuSkI0tITRLKerGnZHA1QF7L9+/Px1Bff003P4dpIf7T+FfKp0603KDbZ6Md/
         dvBpIjPFM0qqieronHjIWWJZ1mlc4JvM1xcs+0qsJ2/sEwXCk9h15WxF1QXrc4VYij6w
         nOmmrDCzdHFYQj3U+fegKYN/ylplkbfIjTLVnoOj+Dc1uom2XVsJ+W8ycrbOo5WaDL+3
         IQBnnpsm/t6xsu94Hw5gPXvucWsHGTY/TqgzZtZQmqXybeUd3V5oijHH25e1qq/xCzO0
         YhXg==
X-Gm-Message-State: APjAAAUEqvFX9iCoBcqGfD3OGP04wDUH6OluTA0BwK5MUkMwhvj/MwFk
        +Oco+J3Oa/sXcC7nmmmSKC2aPmddjo4pNYrklNmOZA==
X-Google-Smtp-Source: APXvYqxikH2q9A9mI6BFV5t+A/NdFiPPF/6168Oe1eoKJTtNWNvwqFN3FH2sGFO2somKD5beBz0zzVsBTH/2ZEp1m70=
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr5540413plv.297.1579903446870;
 Fri, 24 Jan 2020 14:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20200123235914.223178-1-brendanhiggins@google.com> <CAMuHMdVLcMXyxnoFvoqkt3KbdmXXk+6Swveez9+A_yowFsWRAg@mail.gmail.com>
In-Reply-To: <CAMuHMdVLcMXyxnoFvoqkt3KbdmXXk+6Swveez9+A_yowFsWRAg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 24 Jan 2020 14:03:55 -0800
Message-ID: <CAFd5g44u4CYg7RM4EqRhawMCu0FydemeD5akLn_kwWN+4nqWPA@mail.gmail.com>
Subject: Re: [PATCH v2] uml: make CONFIG_STATIC_LINK actually static
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        James McMechan <james_mcmechan@hotmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 11:51 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Brendan,
>
> On Fri, Jan 24, 2020 at 12:59 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> > Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
> > be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
> > UML_NET_PCAP; this is because glibc tries to load NSS which does not
> > support being statically linked. So make CONFIG_STATIC_LINK depend on
> > !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.
> >
> > Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> > Changes since last revision:
> >
> > Incorporated Geert Uytterhoeven's suggestion of using a separate
> > FORBID_STATIC_LINK config option that each driver incompatible with
> > static linking selects.
> > ---
> >  arch/um/Kconfig         | 7 +++++++
> >  arch/um/drivers/Kconfig | 3 +++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > index 0917f8443c285..27a51e7dd59c6 100644
> > --- a/arch/um/Kconfig
> > +++ b/arch/um/Kconfig
> > @@ -62,8 +62,12 @@ config NR_CPUS
> >
> >  source "arch/$(HEADER_ARCH)/um/Kconfig"
> >
> > +config FORBID_STATIC_LINK
> > +       def_bool n
>
>     bool
>
> ("n" is the default)

Whoops, I always forget that.

Thanks for catching that!

> > +
> >  config STATIC_LINK
> >         bool "Force a static link"
> > +       depends on !FORBID_STATIC_LINK
> >         default n
>
> "default n" is the default (preexisting)

I'll go ahead and fix that too, then.

Thanks!
