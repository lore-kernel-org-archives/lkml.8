Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDA6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C982072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3/X8UjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgFBGpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 02:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgFBGpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 02:45:12 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736C9C061A0E;
        Mon,  1 Jun 2020 23:45:12 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id k3so1428335vsg.2;
        Mon, 01 Jun 2020 23:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JTtqcI42kZoQ4pqZ0iGdWO8FuDZpGZIpcFCKECQZVRg=;
        b=J3/X8UjFlvBe7Q2A5uZR9L4W/TteQC3AnagfEUX/w8Xsup738R/zva6nzIGrVU1xmh
         MRMudh5N+k0D3uhBFrA+n/j1wfgdC5VEApk2mQLPKxPSZB0708zydhaN2/Ib9HnSggCR
         q+avFSLwHCrxILPGeJo3RpXUpdZf0S/OYOshMpLwCP5+dco1iIPrZR0UvzX6+HEjAV8s
         J8hCFYwYMLMmV4iWwAlLaOnIzesadY3LlPMuKaJLUZjhEmfEPir9XhchPinSm3gWCaRY
         sKpPHx/1T9BaW75Qpw1h9VtLja3X4inulnSbAXuDuB7HEv8bcSUDwMxyBTt2qPju87+f
         xtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JTtqcI42kZoQ4pqZ0iGdWO8FuDZpGZIpcFCKECQZVRg=;
        b=G47e4Bm3a5ckigcCf2UN3/AW4cjIAnUcvxVZgxuwHyVMbhfbAqRR3UFDqHWEZzAZvq
         VjPyoOSV7WG16xuepgn9Lh7+0xl4yGu9i8D2BSY8zcgQdpZP8MSa/B2qHPGbGP1dr5i5
         dTf1BPvcUT2EsWTHRu3U7gPwtjKHI7soDBKXRgbH+0HYrmu2c/Km75PvKWxs7KqnCNjt
         MQVWRR0jC3EieYTEHt+ZIIz73aiAOLsc3YEYjjwZZuwZYfTGp2NizsKouAWGJ5AjlQkU
         cLHl2qoJlfhjYUxnA4otrYDHWrIQ2VZkF+PmWdI/GyxQyKH/XEUkb8aKkPENTrv6lbTX
         M5GA==
X-Gm-Message-State: AOAM531HQ8fTrWZayQtqa4q1lb+MqrJNRrx5CzdQjuAlFy6PIyZTfIn4
        GXhD/a4OS0WJxf9y28zrUyKRfmH/FaxqKndeB/HaZg==
X-Google-Smtp-Source: ABdhPJwwh637dMMovv3QQMATe9/ruoSH6GcKbH2mvaz7xWRiGcY2pDjg+c7J8Ko+kKL7B6rMjA5dgJnwtdic6bNCGmk=
X-Received: by 2002:a67:1d07:: with SMTP id d7mr15466888vsd.185.1591080311369;
 Mon, 01 Jun 2020 23:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200530040157.31038-1-john.stultz@linaro.org>
 <CAKgpwJXU9uuT6C0NMGhZRYQMxZ9b_cCZ8=8=Yb8DwQn7aZcV7g@mail.gmail.com> <CALAqxLXmOjHvP2yB0nie8o7nCyT0xhVU+0+6DGiVaoDHwRr=ig@mail.gmail.com>
In-Reply-To: <CALAqxLXmOjHvP2yB0nie8o7nCyT0xhVU+0+6DGiVaoDHwRr=ig@mail.gmail.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Tue, 2 Jun 2020 14:45:00 +0800
Message-ID: <CAKgpwJUBvrTH768bRW0qbJ7y5Wiq4++XcXWENvLzXa_TExONaA@mail.gmail.com>
Subject: Re: [RFC][PATCH] usb: typec: tcpci_rt1711h: Try to avoid screaming
 irq causing boot hangs
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
John Stultz <john.stultz@linaro.org> =E4=BA=8E2020=E5=B9=B46=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=884:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, May 30, 2020 at 3:30 AM Jun Li <lijun.kernel@gmail.com> wrote:
> >
> > Hi John,
> >
> > John Stultz <john.stultz@linaro.org> =E4=BA=8E2020=E5=B9=B45=E6=9C=8830=
=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8812:02=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > I've recently (since 5.7-rc1) started noticing very rare hangs
> > > pretty early in bootup on my HiKey960 board.
> > >
> > > They have been particularly difficult to debug, as the system
> > > seems to not respond at all to sysrq- commands. However, the
> > > system is alive as I'll occaionally see firmware loading timeout
> > > errors after awhile. Adding changes like initcall_debug and
> > > lockdep weren't informative, as it tended to cause the problem
> > > to hide.
> > >
> > > I finally tried to dig in a bit more on this today, and noticed
> > > that the last dmesg output before the hang was usually:
> > >   "random: crng init done"
> > >
> > > So I dumped the stack at that point, and saw it was being called
> > > from the pl061 gpio irq, and the hang always occurred when the
> > > crng init finished on cpu 0. Instrumenting that more I could see
> > > that when the issue triggered, we were getting a stream of irqs.
> > >
> > > Chasing further, I found the screaming irq was for the rt1711h,
> > > and narrowed down that we were hitting the !chip->tcpci check
> > > which immediately returns IRQ_HANDLED, but does not stop the
> > > irq from triggering immediately afterwards.
> > >
> > > This patch slightly reworks the logic, so if we hit the irq
> > > before the chip->tcpci has been assigned, we still read and
> > > write the alert register, but just skip calling tcpci_irq().
> > >
> > > With this change, I haven't managed to trip over the problem
> > > (though it hasn't been super long - but I did confirm I hit
> > > the error case and it didn't hang the system).
> > >
> > > I still have some concern that I don't know why this cropped
> > > up since 5.7-rc, as there haven't been any changes to the
> > > driver since 5.4 (or before). It may just be the initialization
> > > timing has changed due to something else, and its just exposed
> > > this issue? I'm not sure, and that's not super re-assuring.
> > >
> > > Anyway, I'd love to hear your thoughts if this looks like a sane
> > > fix or not.
> >
> > I think a better solution may be move the irq request after port regist=
er,
> > we should fire the irq after everything is setup.
> > does below change works for you?
>
> Unfortunately the patch didn't seem to apply, but I recreated it by
> hand. I agree this looks like it should address the issue and I've not
> managed to trigger the problem in my (admittedly somewhat brief)
> attempts at testing.
>
> Thanks for sending it out. Do you want to submit the patch and I'll
> provide a Tested-by tag, or would it help for me to submit your
> suggested change?

OK, I will send out a patch against Greg's tree.

Li Jun
>
> thanks
> -john
