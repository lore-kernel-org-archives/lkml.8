Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978E4C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7335B20707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgAaIN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:13:59 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39850 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgAaIN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:13:59 -0500
Received: by mail-oi1-f194.google.com with SMTP id z2so6454064oih.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 00:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whAXdHdznYjIr0eEK/ikQOAsAYBnA7TNWNtods2FE2c=;
        b=aAhdhNpNAKMIPM9WM7XMji1dR8CxJ42lNqzLr/1esvQROKqEeiQtNlZpurb0A6WDNk
         auInN7dKbtLPKvxOgYNcTsUGbQ98mMS/Ildc2AW+D9AMu9Lcxjl9RyO8+TekezSuz52P
         wBNbotVmL3Mg3Oytjz74yxw+zrNa2JjItrVfqD25wR4EzzZbT0IB8slryUFZqrob3iqZ
         X4hqTO29xIrBZM0E+AHGuOAegAZfSJR9iGsLHKoZ676KrStFZAu6XOxx6S98IXcJvvVD
         Y1erWKhneHNQK5oLwgAQopahotTv7pEMnj8xJbX797tkIfErIY0JhR2dfO2590dhuUg6
         5cJQ==
X-Gm-Message-State: APjAAAXry/Z9eL4gb7oqQOTssGCMy8MkMCSmNvieef01/cJjAcUAlH4d
        K5o9LGZB18hg/z0YUuKaUy2j6apY0DjEVtMdgD0=
X-Google-Smtp-Source: APXvYqxVsELFIbYc2E/Dk5r14mT05UKx5Y5iElcBd1BjTk4T4kMv0zIzqRCoNBGqWWZoA1rxpFFIVrR1UIOSbIHgmLQ=
X-Received: by 2002:a54:4707:: with SMTP id k7mr5313336oik.153.1580458438520;
 Fri, 31 Jan 2020 00:13:58 -0800 (PST)
MIME-Version: 1.0
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be> <20200121103722.1781-4-geert+renesas@glider.be>
 <78f934a3-ec7a-479e-9f63-4df7c4428ae5@www.fastmail.com> <CACPK8XfUG08CmxK7_V=PGp1SBO2UE6CSyKPSi9Hiwz2td4Lq1w@mail.gmail.com>
In-Reply-To: <CACPK8XfUG08CmxK7_V=PGp1SBO2UE6CSyKPSi9Hiwz2td4Lq1w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 Jan 2020 09:13:47 +0100
Message-ID: <CAMuHMdXK0_5VbUe2Zo364YNx0kQzt+ESr2GcVSYZc_VW2tn36g@mail.gmail.com>
Subject: Re: [PATCH 04/20] ARM: aspeed: Drop unneeded select of HAVE_SMP
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Fri, Jan 31, 2020 at 4:50 AM Joel Stanley <joel@jms.id.au> wrote:
> On Tue, 28 Jan 2020 at 01:05, Andrew Jeffery <andrew@aj.id.au> wrote:
> > On Tue, 21 Jan 2020, at 21:07, Geert Uytterhoeven wrote:
> > > Support for the 6th generation Aspeed SoCs depends on ARCH_MULTI_V7.
> > > As the latter selects HAVE_SMP, there is no need for MACH_ASPEED_G6 to
> > > select HAVE_SMP.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Cc: Joel Stanley <joel@jms.id.au>
> > > Cc: Andrew Jeffery <andrew@aj.id.au>
> >
> > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>
> Acked-by: Joel Stanley <joel@jms.id.au>
>
> Geert, did you intend for these to be picked up by Arnd and Olof?

Feel free to pick it up.
I'll resend the remaining patches to the arm-soc maintainers later.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
