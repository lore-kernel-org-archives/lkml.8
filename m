Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5349C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9681920674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFCHf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:35:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44523 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCHf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:35:26 -0400
Received: by mail-ot1-f66.google.com with SMTP id e5so1100573ote.11;
        Wed, 03 Jun 2020 00:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7JMkOvhZUqwiu+SF/Awh2jlIp2xHt9TluszajmhLw4=;
        b=kw2QWv8B31u0abvbBHAvVs+9AZQcphbQzmdggdkyBoukg2I+NjHn9JFdubXGeH7PdC
         ShWyq/eOUuF5V1pkdbJ3MRSzEI5D543rkl3Nvja/r0eT1tdIHL9H6rcjVekpQ+qnwb7W
         co3KVXKu5jzrclX1IkHDHrYbEywKI6S4Tl7opMaUEEk4NFXj73S6C4ywWVA/4QP7m6Sv
         OTNGmMlLtkZtXgx18t7WFjeX1rJ5S/GX6EIEvWBcA/aKaNWKZQsJ0XpCNGYL02vxvxRK
         Ijh9WFwIRzzM+J43Ge9ms3RIoUmNTD5KLwoSxXq6/sa8aSM5aEzoJyi1VrJeXPJ+NygV
         U1CQ==
X-Gm-Message-State: AOAM5324SFNUF7dx7uNhbCsDt0geOsHpHwXeMncOqIytbmGMlLIuXwyG
        zUvAr+BSu/1IIRUZcQh8ez9J7PhLuBJfk2V/cxcVxA==
X-Google-Smtp-Source: ABdhPJwU2+fB3PiD4AxJMNargOcVzctUQtjcagMYjySGTXjUm3Tf3KsLK/TZQKrzdMIs7+K/adcy9MbWExNzVqyZpcM=
X-Received: by 2002:a05:6830:141a:: with SMTP id v26mr2278620otp.250.1591169724039;
 Wed, 03 Jun 2020 00:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200531104715.2512247-1-glaubitz@physik.fu-berlin.de> <b6271c7a-1eaf-61d9-9eb6-061aa8a13ac8@physik.fu-berlin.de>
In-Reply-To: <b6271c7a-1eaf-61d9-9eb6-061aa8a13ac8@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Jun 2020 09:35:12 +0200
Message-ID: <CAMuHMdV-Par79SYe75HzJsEd2cwEDhGPK+Nj0zUD8eAy9aDj1A@mail.gmail.com>
Subject: Re: [PATCH v2] sh: Implement __get_user_u64() required for 64-bit get_user()
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Jun 3, 2020 at 9:20 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 5/31/20 12:47 PM, John Paul Adrian Glaubitz wrote:
> >  Changes since v1:
> >  - Replace single mov instruction for exception handling
> >    in case of invalid load
>
> Yutaka Niibe has had a look at my patch and he says, we might have to add
> an entry for the fault handling of the upper word.
>
> Quote:
>
> > (1) I think that there is possibility that the second access to user
> > space fails (while the first access succeeds).  IIUC, it's good have
> > an entry in __ex_tables for the second access too, like:
> >     ".long 1b+2, 3b\n\t"
> > I don't know if the expression "1b+2" is correct, my intention is
> > detecting the failure in the seccond access.

So just add another numeric label, like is done on m68k.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
