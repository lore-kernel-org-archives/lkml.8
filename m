Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8B3C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE45216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgEAUHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:07:09 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60405 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgEAUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:07:08 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MZTVu-1jhO1d035q-00WTo7; Fri, 01 May 2020 22:07:07 +0200
Received: by mail-qk1-f172.google.com with SMTP id h124so10343955qke.11;
        Fri, 01 May 2020 13:07:06 -0700 (PDT)
X-Gm-Message-State: AGi0PuaUr4imBaFb+wj3UVDiugtu4c4l8W4PjBfKNyerS4dXiHoQMHgf
        iTl/9OfepIb5xRMRaWYmwoSYf6F4+BfGQV1QFqw=
X-Google-Smtp-Source: APiQypIQL/PdnZHF8Wfz7ADpsLFsjVjLgWbRjmn9o8MDCsMnGYznSEI15n8DEv1cRiNlskgjAH1LuTuIBw3NFxtqVHM=
X-Received: by 2002:a37:a492:: with SMTP id n140mr5418238qke.352.1588363625776;
 Fri, 01 May 2020 13:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200430213101.135134-9-arnd@arndb.de> <Pine.LNX.4.44L0.2004302231290.19755-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2004302231290.19755-100000@netrider.rowland.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 May 2020 22:06:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a19DSnyvzSRCFr6fQGAMudQwhZY7Wy2yS6HL8y3TsfoLw@mail.gmail.com>
Message-ID: <CAK8P3a19DSnyvzSRCFr6fQGAMudQwhZY7Wy2yS6HL8y3TsfoLw@mail.gmail.com>
Subject: Re: [PATCH 08/15] usb: ehci: avoid gcc-10 zero-length-bounds warning
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xMHR+/oei8shEKjqO2aNZ3xjz7BHk5Lj/8vXQYotfGOzvKiM/Ju
 zUpHkZvLjluojzxBfkVkt4+ioG52jT/EMBrClBCgMWTp0aYCQsF7w+4fb2PfLq63xymPPBe
 n8fL27ToK5K2gkD85t0/WlbME7mHfDmt1Ws7LDFD0R4+83epSd0lT789VLjk2BCxCv0PTNc
 nSgI4Fg6fMDFmwNA+iAwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KVV7I/FEbdY=:XDUZ0FkiqS+pGR+84WeAxd
 /hPXVKblcwFzPxol83ZdkPDHbw5eGn6Q01XhSrVuiKKEs1OymiuwYXAkd3QCvh7ZUXd6WZ0yS
 oIH02jeZfCbH0QvBwrGUF5i+wegJXtxCJ7TuH8COsphQ8pZUHZfnK7Rf5mD3v5pnOmvBmTgO8
 D0waHvE+pOeynLKUnqDPZWKm2gb3wIyZnvpgX5EyEfrK6Ge1+YcwPYuiqbmZS1zGkdSAjV9rp
 VpurKtwFjMZjC7hw+Up/kG4YJvIZ66zUYRJOzhjPwenE6C7P44H9kFogxWxWcnPQEuoyGKzhN
 tZnKNrAmzGxE+xhSt9BdiasECTBlWprzQKm7KGSNb96FZoWZi3liUs5YbXu06VqmseVzF+NKE
 vmqmHnaAdo7yRWqz6zKa5wVti77ZRDI8H9PKcADoInFxxPmaRxHKf7w2xYgppP8A85AjpRUL7
 6WgenLbje7FFAXsL0ER+3sy2WG9CtZQ2SGWJFevJq6h3FUv5d2daR1+L0QgSTm1T/U74oRKt5
 TkYw/myo+GT4tjTkHZVgXQsT4mFsz5CyDtpFA8Ohbjx7eKhJURG6g2VdzSi7mlkwDsFwgcNZ2
 z+NoRYrgy3x7vfO9kmfNCNJ55ObHeNkZ2Xak79e3oMwmAXp5uKgNFMWXHw1czZIDtDSq/jPKd
 1WL9tXeHQJDEhYjGl5g6FWIre2r6boYoi48geZDyLO0k+9sQggIk+4POVz9UNw8gOygSZ1dgK
 oah47pvlixF9A8rcNvDEr7cIdmkTmJIT3Fw0HyLG9Mwm/enObWKfnuCbauH2m6rYH470PsHMx
 ewoAAKQS+nQ9fUv39e/sHLLf+7s7VK0TQr4uCRbCpAuZ3bUHIA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 4:42 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 30 Apr 2020, Arnd Bergmann wrote:

>
> No, they don't.

> >       /* PORTSC: offset 0x44 */
> > -     u32             port_status[0]; /* up to N_PORTS */
> > +     union {
> > +             u32             port_status[9]; /* up to N_PORTS */
>
> This array can have up to 15 elements, meaning that it can extend out
> to offset 0x80.

Ok, thanks for the clarification!

> >  /* EHCI 1.1 addendum */
> >  #define PORTSC_SUSPEND_STS_ACK 0
> >  #define PORTSC_SUSPEND_STS_NYET 1
> > @@ -165,7 +166,8 @@ struct ehci_regs {
> >  #define PORT_CONNECT (1<<0)          /* device connected */
> >  #define PORT_RWC_BITS   (PORT_CSC | PORT_PEC | PORT_OCC)
> >
> > -     u32             reserved3[9];
> > +             u32             reserved3[9];
> > +     };
> >
> >       /* USBMODE: offset 0x68 */
> >       u32             usbmode;        /* USB Device mode */
>
> As you see, this next field actually lies inside the preceding array.
> It's not a real conflict; any hardware which supports the usbmode field
> uses only the first element of the port_status array.
>
> I don't know how you want to handle this.  Doing
>
> #define usbmode port_status[9]
>
> doesn't seem like a very good approach, but I can't think of anything
> better at the moment.  Maybe just set the array size to 9, as you did,
> but with a comment explaining what's really going on.

The easiest change would be to use an anonymous struct like this

        /* PORTSC: offset 0x44 */
        union {
                u32             port_status[15]; /* up to N_PORTS */
/* EHCI 1.1 addendum */
#define PORTSC_SUSPEND_STS_ACK 0
...
#define PORT_RWC_BITS   (PORT_CSC | PORT_PEC | PORT_OCC)
                struct {
                        u32             reserved3[9];

        /* USBMODE: offset 0x68 */
                        u32             usbmode;        /* USB Device mode */
#define USBMODE_SDIS    (1<<3)          /* Stream disable */
#define USBMODE_BE      (1<<2)          /* BE/LE endianness select */
#define USBMODE_CM_HC   (3<<0)          /* host controller mode */
#define USBMODE_CM_IDLE (0<<0)          /* idle state */

                        u32             reserved4[5];
                };
        };
        u32             reserved5;

It doesn't really improve readability, but it should correctly
reflect the layout as you described it.

       Arnd
