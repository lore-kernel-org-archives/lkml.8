Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64307C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4BD205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQYZducC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgD1Px1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728083AbgD1Px0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:53:26 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC8EC03C1AB;
        Tue, 28 Apr 2020 08:53:26 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so10855243pfx.6;
        Tue, 28 Apr 2020 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4Dhg0+RCUg11ejc9Q1N+f7+gMXXeAVYfvKm1BhfoLmA=;
        b=JQYZducCGPFz2N8/fn4DsjPaw5tXH7cerckhDV74yHRZ6tAj5g+UQBXcvjLrXCjGmb
         +11lZ0NeiQXAC6/lWBsC2aJemHrcgUywTQuV3JiNe8dShink+PnjdqCViJNwhBh26coD
         8Pmd1dfvsdYIwWenuU1fKuOH5/tXjkjclCA+xme9q7IzL/XdrtP1dEsKOXttJx3wde3e
         KeMIJd1BOZU03/sBg1GQW9qZocKAk4dkGGTPNu08zaZYgx/OLJEB4yGGBjp9+GStrCrG
         NLUbwkJopSgh9V5LZFdMJN2SI+e5i03Aq3kglchAlXoK6L8seVUVBbcx4peeDImXPE59
         F3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4Dhg0+RCUg11ejc9Q1N+f7+gMXXeAVYfvKm1BhfoLmA=;
        b=Kerv7oHyngeTaJnLXEA1/dXydGNKMNAooAUTS4+zIZTDqcHjuDquQXlwo+hHGwoH+q
         135gOLYWU6HKWcVETMT0lBw6P714DmdTJ/jMxD/gJILbBdkKFDQ3k63/Vb1fCLk/kbig
         8mzyBopTGp7aY7zSl8Q5wd0ELGMX5v4Urh0KtK3YiKI+2xBTmbftNKSmrk6BI4+jzHKv
         NUH9ZmF2wkEP6s7FlvyTZ8D5MzofGC4pNCcPse8YVlf1w3maSN8iIvYtwhGEe8OMU4Pw
         D+K58p/HXH2I2sTFaPyOKExR7P4VSX2+gtHNc3aVeWbX03UV215hvB0ZquncU2sErVZt
         yu2Q==
X-Gm-Message-State: AGi0PuZIbQcnnzhFNkqpQvrzTGfheoTmDA/1XArMX32l+KKpyjH93xbr
        sXBMkS4TEtYL/33ptYZGMptrYLezIIDMnUc0GN0FNKbX
X-Google-Smtp-Source: APiQypKFWwHJLH6rk36Yj9+OOyvIsOtqeqDNnRaG86QWUlI8Ip6WptGnO9jj24PozbAY27uk1GCjwktDh8vWj8HQwaI=
X-Received: by 2002:a63:5511:: with SMTP id j17mr28068937pgb.4.1588089206109;
 Tue, 28 Apr 2020 08:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200320093125.23092-1-brgl@bgdev.pl> <CACRpkdZgWUwmmuXn12DS3TsQS0yQxcweqK6HGxBm=V_2LBLBMw@mail.gmail.com>
 <CAMpxmJUb09KGreHw6Bdz79rbnQE7oZnWg_5qN_FhzoS2-XccFA@mail.gmail.com>
In-Reply-To: <CAMpxmJUb09KGreHw6Bdz79rbnQE7oZnWg_5qN_FhzoS2-XccFA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Apr 2020 18:53:19 +0300
Message-ID: <CAHp75Vdpb=hNiR3c7G_yTeSt70Vcy3DWHin0B5+WYV1hbRMBJQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: don't call sleeping functions with a spinlock taken
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 6:35 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> wt., 14 kwi 2020 o 14:00 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
> >
> > On Fri, Mar 20, 2020 at 10:31 AM Bartosz Golaszewski <brgl@bgdev.pl> wr=
ote:
> >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > We must not call pinctrl_gpio_can_use_line() with the gpio_lock taken
> > > as it takes a mutex internally. Let's move the call before taking the
> > > spinlock and store the return value.
> > >
> > > This isn't perfect - there's a moment between calling
> > > pinctrl_gpio_can_use_line() and taking the spinlock where the situati=
on
> > > can change but it isn't a regression either: previously this part was=
n't
> > > protected at all and it only affects the information user-space is
> > > seeing.

It seems I have no original at hand, so, commenting here.

It looks like we need a mutex less function which can be used here and
in the call you are considering racy.
Note, mutex followed by spin lock is fine, other way around is not.

So, here you should have something like

mutex_lock
ok_for_gpio =3D ...
spin_lock
...
spin_unlock
mutex_unlock.


--=20
With Best Regards,
Andy Shevchenko
