Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37F8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8944920657
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgETLr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:47:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46138 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:47:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id b3so2597253oib.13;
        Wed, 20 May 2020 04:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGKgEc8JFQSK2cOGhTfN/cpJyk+jh7gfz8G43N9Kzzc=;
        b=cDXM+lI4BqskeTI+MTtD9mHJ+Zj+oT1oRrSAjHkP5bHECWbLfJ+NGxLU2AcacDs/op
         +lI14WGTd6F+/WNoxwmilrktqjMkJ9o8W2uxptNQDESdYSTG1K3oPumwwBGnOj7HFg1I
         RE762BJ6RvacwRfY25af6ynMiyXtseLx4D0p/gGEDW+qUjj4/unAD4GYoI9YY+d6OGXD
         M2qZCz8AnRVNo3Dwtwr0AKTQnnHMNeh+vthp6OVoylYrDGeEfB6AXa48AJRUtxFvoyP7
         q6YtqeTrDlLB2W5K5zP02Vtx1XXLGrKU/inYjUvb0qoRUeRaqwjqVqMxkSNMybSZkhf6
         UzpA==
X-Gm-Message-State: AOAM532yqDgjME3gYu4hVZqcMlf26BpAQPHG2iW935p2YBkLhk1LVRvn
        0b2hmAxI8VtAntqeTUtebPwmH6Nr4AfiwL3Cp6dZKw==
X-Google-Smtp-Source: ABdhPJxCwAPXRwC2Gghh4mWbgs1jlLKyh+c1OcmCEMOWi6+fZ/7AfNEOOZs8vDIeh1EJvdz0jC1m52WC6eQoJiOiAPQ=
X-Received: by 2002:aca:210a:: with SMTP id 10mr1403518oiz.153.1589975275508;
 Wed, 20 May 2020 04:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200519131327.1836482-1-arnd@arndb.de> <20200519181034.58c67eb5bea24aae24d33421@linux-foundation.org>
 <CAK8P3a281ZLKwkWCKkAdQvA6=XA4=+mKWbwEzK_BR4Uu1c5DNQ@mail.gmail.com>
In-Reply-To: <CAK8P3a281ZLKwkWCKkAdQvA6=XA4=+mKWbwEzK_BR4Uu1c5DNQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 May 2020 13:47:44 +0200
Message-ID: <CAMuHMdUx9zKbc7n164Gi+N9k-NhmbgXtU+Z4yZ9SvdxeCMtJKw@mail.gmail.com>
Subject: Re: [PATCH] sh: include linux/time_types.h for sockios
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
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

Hi Arnd, Andrew,

On Wed, May 20, 2020 at 10:32 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, May 20, 2020 at 3:10 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Tue, 19 May 2020 15:13:13 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > > Using the socket ioctls on arch/sh (and only there) causes build
> > > time problems when __kernel_old_timeval/__kernel_old_timespec are
> > > not already visible to the compiler.
> > >
> > > Add an explict include line for the header that defines these
> > > structures.
> >
> > I can grab this.
>
> Thanks!
>
> > > Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > Fixes: 8c709f9a0693 ("y2038: sh: remove timeval/timespec usage from headers")
> > > Fixes: 0768e17073dc ("net: socket: implement 64-bit timestamps")
> >
> > cc:stable?
>
> Yes, I missed that.

Doesn't matter, the stable bots will pick it up anyway, based on the Fixes tag.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
