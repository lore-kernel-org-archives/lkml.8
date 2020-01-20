Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3526C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45D122525
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgATTMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:12:45 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43908 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgATTMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:12:45 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so304462oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 11:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjq97LN7paeiNndMMU1ClIoeahA1RUutU+l84dotge4=;
        b=uFGXNyfNgrJ+upFgFfYunV6WO5EcN9VCh/V/DKbExjVb4WWlJ+Ehwmzu7hXQPaMh22
         xiaBKh7uBfuXwN+Hc3CyI+9woOO7pHmqowDajfH8mGi6SRDre4+QwjLxqbPkr8SWey/N
         gUYFBJc2jE6JuCbY5Ql3XJk7IiAUU1wC61oION3GXwbV6tbQMe89Tsk/jPmFG3TqJEOZ
         AyhWvXHlMuV7wv1d49iMb0zrURCvkkw3QL9jghe3y+maBEuVOlDcWzG5MXzpKVPir0iM
         Ge586IU3v0kPPJXQg6JDDHwJ7W9JHmGCFdnPltc16Af4V3fVj7rC2XW2cMAEEAXP+kN4
         bfNA==
X-Gm-Message-State: APjAAAWNJxntsIM8FYSRrhdX9K/6Bi4LTBOM9gJmbLQxwOSXfA01V6zk
        vQCZtORSgHgjw+x12n7soZfff+UND0uiu+tFaColYw==
X-Google-Smtp-Source: APXvYqx+QeBZerMZYsQXGnGVyHkqjvt/cNaN/+PihgCyBaDh1UaA25j/U0wI+4upj1pGyuPi7vWximhYHGkwDegIB+8=
X-Received: by 2002:aca:5905:: with SMTP id n5mr287272oib.54.1579547564535;
 Mon, 20 Jan 2020 11:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20180802193909.GA11443@ravnborg.org> <20180802194536.10820-2-sam@ravnborg.org>
 <CAMuHMdVP4UwGYuNcOphPO9F2pSCaHS1j-ODxYrv_LNOoo_4coA@mail.gmail.com> <20200120184804.GA7630@ravnborg.org>
In-Reply-To: <20200120184804.GA7630@ravnborg.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Jan 2020 20:12:23 +0100
Message-ID: <CAMuHMdWR-EY+yBaOu_pL=5mfwi=ra76YwTt5d+GZ3Qy-e7Evzw@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] pardata: new bus for parallel data access
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Noralf T <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Mon, Jan 20, 2020 at 7:48 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Mon, Jan 20, 2020 at 11:10:37AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Aug 2, 2018 at 9:46 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > > The pardata supports implement a simple bus for devices
> > > that are connected using a parallel bus driven by GPIOs.
> > > The is often used in combination with simple displays
> > > that is often seen in older embedded designs.
> > > There is a demand for this support also in the linux
> > > kernel for HW designs that uses these kind of displays.
> > >
> > > The pardata bus uses a platfrom_driver that when probed
> > > creates devices for all child nodes in the DT,
> > > which are then supposed to be handled by pardata_drivers.
> > >
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> >
> > > --- /dev/null
> > > +++ b/Documentation/driver-api/pardata.rst
> > > @@ -0,0 +1,60 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +=========================
> > > +Parallel Data Bus/Drivers
> > > +=========================
> > > +
> > > +Displays may be connected using a simple parallel bus.
> > > +This is often seen in embedded systems with a simple MCU, but is also
> > > +used in Linux based systems to a small extent.
> > > +
> > > +The bus looks like this:
> > > +
> > > +.. code-block:: none
> > > +
> > > +       ----+
> > > +           |  DB0-DB7 or DB4-DB7      +----
> > > +           ===/========================
> > > +           |  E - enable              |  D
> > > +           ----------------------------  I
> > > +        C  |  Reset                   |  S
> > > +        P  ----------------------------  P
> > > +        U  |  Read/Write (one or two) |  L
> > > +           ----------------------------  A
> > > +           |  RS - instruction/data   |  Y
> > > +           ----------------------------
> > > +           |                          +----
> > > +       ----+
> >
> > Oh, cool!  Looks like this can be used by the hd44780 driver.
> >
> >     Documentation/devicetree/bindings/auxdisplay/hit,hd44780.txt
> >     drivers/auxdisplay/hd44780.c
>
> This patchset was from a time when I knew next to nothing about DRM.
> Now I am just confused on a different level :-)

The more you know, the more you realize what you don't know ;-)

> It is on my TODO list to make a mipi-dbi driver that in the future
> replaces the auxdisplay driver for hd44780.

Please note that hd44780 is a character controller.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
