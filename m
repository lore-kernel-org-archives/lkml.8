Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B955C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B25206F0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGNHWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:22:51 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45232 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgGNHWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:22:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id h1so12255340otq.12;
        Tue, 14 Jul 2020 00:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQc3b3cEG4qoV3UIOktn0Ijwe/EIk3WLKFZosqYyBVs=;
        b=PsmL6a9oltMwdBJvv7Gv+u2qO9gVFjcGaGIXPgWk9S0BEgiXmg4/MzyGV9DG5a+hmy
         rkAwwv0Gxz5S6Va1Vp0IbBhJosKfGbrWGp6zBMKP0scPMVe2dxi5WET7QFoIwTIw6hCX
         hhZ31JeNdMqOsn0jFJ2cZpTavrnOzgOw5i6G8tAK1XMJt5V+etAgdlXQKlFicCI/J/3X
         iAfcCaUvovjWfhlGMxC4bVyr5LAq0BYofBIwo7FFfXBwtvkjYRAYnAi8Q2dMikRcY0Bq
         tI74zliDqqxqdqp0xc4/D76iU8uQwwBbs7Y8mGgxnM1WvUMP9tNonPoSbIh5cAk3oSgQ
         /6HA==
X-Gm-Message-State: AOAM5319VQea9YC73jhQnB+rjH63HdnPlWrR8hOxpiO6qpsUuaUgZaTT
        nv1//mnKwO+umToMbyTCOEl/adlYNTG7Bt3PAI4=
X-Google-Smtp-Source: ABdhPJz1sAOdS6D9PESw3CKqn8GGA2iUl9nNfnBianI8jxVmwEadGYyk0M5nb2M82d5LxVc36lQQSerNhEHLzoOzfSM=
X-Received: by 2002:a9d:1b0d:: with SMTP id l13mr2887577otl.145.1594711370357;
 Tue, 14 Jul 2020 00:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200710062019.28755-1-grandmaster@al2klimov.de> <20200713113430.1c1777bb@lwn.net>
In-Reply-To: <20200713113430.1c1777bb@lwn.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jul 2020 09:22:39 +0200
Message-ID: <CAMuHMdXoUME_dCOZP1N0tXyMv61edfNECM4-n4NPa56YbBCncw@mail.gmail.com>
Subject: Re: [PATCH] OPENRISC ARCHITECTURE: Replace HTTP links with HTTPS ones
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Openrisc <openrisc@lists.librecores.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 7:37 PM Jonathan Corbet <corbet@lwn.net> wrote:
> On Fri, 10 Jul 2020 08:20:19 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> >  Documentation/openrisc/openrisc_port.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/openrisc/openrisc_port.rst b/Documentation/openrisc/openrisc_port.rst
> > index 4b2c437942a0..657ac4af7be6 100644
> > --- a/Documentation/openrisc/openrisc_port.rst
> > +++ b/Documentation/openrisc/openrisc_port.rst
> > @@ -8,7 +8,7 @@ target architecture, specifically, is the 32-bit OpenRISC 1000 family (or1k).
> >  For information about OpenRISC processors and ongoing development:
> >
> >       =======         =============================
> > -     website         http://openrisc.io
> > +     website         https://openrisc.io
> >       email           openrisc@lists.librecores.org
> >       =======         =============================
>
> Applied, thanks.

Is that site accessible for anyone? It times out for me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
