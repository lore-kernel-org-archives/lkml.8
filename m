Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FADAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E3E207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9JZ4m4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgGBMbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbgGBMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:31:32 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215BAC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 05:31:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a1so29278167ejg.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJDlluxTLSLXcNldfEtH6HjyiRZsuJeHD76dawuaQLg=;
        b=Y9JZ4m4HY2a9lUTLrYd15UFdqyJ3pHCHtN4BfM1ajiwsuhvbLDPEX0QcW2jh9/xo8V
         m0IQnNh9DkZWdEUhGXcHn5u18QK+Nv+bNd92MypYXrQcQFgxGDgEpVLhcRZYmMnRnBH3
         yk9sq2EIM9HHTSUnzpB0P5MoVlFfLMSRF8XWMFm3ohsbDYCULcxZe5IkjnlCRyRxHEto
         c2TuG6voJd4vnLrCDOwdV28V3YYb2XR5sBN7a4kX9RNssH2oIUppaixQ0g79dFVjyf1P
         mQ4YHsnh+vVtn/4416B0Nku8gkjJ9H7eIEe6u8OXNcGwRK9aD8AsTyenhuAdOZ509bkh
         8gKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJDlluxTLSLXcNldfEtH6HjyiRZsuJeHD76dawuaQLg=;
        b=ijne6uOe1cSB2msjOyHBga1sGsYfXuew7zbGhYA2ZW9mI2/vvNgg8gZEG8zpk8B5+F
         4jsUi+Nkh1Uc6X5EmrAf8dHxKvbd8vu1MGwkcnpsIhl4GE0LBCPmQ6yj2BL20TnNVCOj
         QzKssyRYJ4CfcdDV4LMNI6Bor7YBd71Nj07HSGddvKMtdGU7q4rhcD0gBgNS/5Rd2FQn
         qa2nvwpLN7RnDYCGDYfTpC5jLSJPU9S+OkTknP6KhombdYoAAACQaFvuJ3H45rvdZ51M
         HKo0h81t0pbcRZhtuoLbs2lXbC6rcLRuetBrD+qlr6ORMyi+84U6LEqtAz50139rBWdf
         o8zA==
X-Gm-Message-State: AOAM533VrlN5dpbSthOoLzA58yIdqgXVvseRCSNRFgC/H/MePZNFiFVI
        66WH/EbTQkuMrVc+JX+ZbAyyG2IvbpHcGoPZxFiFKNPZuE0=
X-Google-Smtp-Source: ABdhPJw76LziEByb5QpEtjoazEb87/1e3MZnxrhrlDF+0L79YZh5IPKVQ9hiZaMrImDaCe0J8XZ839pEEIWYbt0X2tE=
X-Received: by 2002:a17:906:4c2:: with SMTP id g2mr25977222eja.299.1593693090755;
 Thu, 02 Jul 2020 05:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593615440.git.tammo.block@gmail.com> <167e1d106125e5401fd907d6febdec4273cfdd3e.1593615440.git.tammo.block@gmail.com>
 <db653724-2706-b2c1-8889-ebb60af80ab1@kernel.org>
In-Reply-To: <db653724-2706-b2c1-8889-ebb60af80ab1@kernel.org>
From:   Tammo Block <tammo.block@gmail.com>
Date:   Thu, 2 Jul 2020 14:31:20 +0200
Message-ID: <CAEHKo2npNTTBAFQbRbH6Nh8R6reJ2A7=CwZe_tu5wMmk_Pn6ew@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] vt/vt: Add SRG mouse reporting protocol
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

thanks for your patience ... ;-)

Am Do., 2. Juli 2020 um 10:48 Uhr schrieb Jiri Slaby <jirislaby@kernel.org>:
>
> On 01. 07. 20, 17:13, Tammo Block wrote:
> > The SRG protocol indicates a button release by appending a "m" to the
> > report. In this case the button number is not 3 (RELEASEEVENT) but
> > the number of the button that was released. As release event are only
> > reported for the first three buttons (LOWBUTTONMASK), we need to store
> > the number on click events because it is not sent to us from userspace.
> >
> > We also need to check for the case where no button state change occurred
> > at all (bit 6 set), in this case a value of 3 is OK even in SRG.
> >
> > Signed-off-by: Tammo Block <tammo.block@gmail.com>
> > ---
> >  drivers/tty/vt/vt.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 9abf2829b1d3..9aae3eac7989 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -1838,15 +1838,34 @@ static inline void respond_ID(struct tty_struct *tty)
> >       respond_string(vt102_id, strlen(vt102_id), tty->port);
> >  }
> >
> > +#define ANYBUTTONMASK        0xc3
> > +#define LOWBUTTONMASK        0x03
>
> Insert _ before MASK.
>
> > +#define RELEASEEVENT 0x03
> > +
> >  enum { Mouse_X10 = 0, Mouse_SRG, Mouse_URXVT};
>
> = 0 in unnecessary. And put one per line. And all capitals as
> CodingStyle says.
>

OK, I was just copying the style of other enums in vt.c.
But the code seems to be older than the coding style guide ... ;-)

> You should name the enum somehow and use it as a type for
> vc_protocol_mouse (you'd need a forward declaration of the enum in the
> header).
>

That would make vc_protocol_mouse an enum and vc_report_mouse a define.
As vc_report_mouse is visible from userspace those defines live in tiocl.h.

Wouldn't it be more consistent to make both of them the same type and also use
defines for vc_report_mouse? And if so: Where to place them?

They are only needed inside vt.c, so they could live in any of:
1.) Inside vt.c
2.) in vt.h
3.) in tiocl.h, although userspace does not need them.

> >  void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
> >  {
> > -     char buf[8];
> > +     static char last_btn = RELEASEEVENT;
> > +     char buf[20];
> > +     bool rel;
> >       int len;
> >
> > -     len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
> > -                     (char)('!' + mrx), (char)('!' + mry));
> > +     switch (vc_cons[fg_console].d->vc_protocol_mouse) {
> > +             case Mouse_SRG:
>
> This is not how we indent switch-case.
>
> > +                     rel = (butt & ANYBUTTONMASK) == RELEASEEVENT;
> > +                     if ((butt & ANYBUTTONMASK) < RELEASEEVENT)
> > +                             last_btn = butt & LOWBUTTONMASK;
> > +                     if ((butt & TIOCL_SELBUTTONMASK) == RELEASEEVENT)
> > +                             butt = (butt & ~LOWBUTTONMASK) | last_btn;
> > +                     len = sprintf(buf, "\033[<%d;%d;%d%c", butt,
> > +                                     mrx + 1, mry + 1, rel ? 'm' : 'M');
> > +                     break;
> > +             default:
> > +                     len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
> > +                                     (char)('!' + mrx), (char)('!' + mry));
> > +                     break;
> > +     }
> >       respond_string(buf, len, tty->port);
> >  }
>
> thanks,
> --
> js
> suse labs

Thanks again,
Tammo
