Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8E8C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 10:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616A3206F5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 10:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7gzhoNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgDDKNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 06:13:02 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43261 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgDDKNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 06:13:01 -0400
Received: by mail-il1-f194.google.com with SMTP id g15so9898255ilj.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GeMTzbF7LlzouObWVay/AAQeo7tCBHQVlLGpcudAPw4=;
        b=W7gzhoNa6lSOkNbi2S8HbpSz1C5WigOTOVJ/BvtvJYOEFBeWuBavlY0k+exQp5lz0s
         yrsyeypoL6tsIeYs80/dCGIax4jJLd0mCInB20dh2xEgunwMyHJoTS7y7+zLNlzQWTXE
         PZwhh4Z28bJon0G/ntEy6KS8nWzLVi3lwGrqnqxJd8MpYpalrRjUUEQTHE9NBg40C6Mf
         /tHAHZW/64PFrUYI9WRk1tMMEPaZarxOIYyd+Oe21NwijsMGClLtWUs1BmK2LnM+VpF+
         gaa9odvKLo+aUUd6T2F/YBAtxzx26kcW51YHbvQaXBGK8r9DWOjhh7mY7kjop0N3BC1y
         n/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GeMTzbF7LlzouObWVay/AAQeo7tCBHQVlLGpcudAPw4=;
        b=dBthGTpj5GkHnkc8bEaSo0tm5+MSzKTHcUcuX8So/+FXDkvC0djIn7VWnY6IpGaTIY
         Tp0sASmJCSeyQ40JNdPCTIbvv7zgWraA4dWOy2NUdDQep/ey3bHuM1x5TsXxRm0gJ0WY
         ZqC4sUIWJhVvGv3C5rBYKQlczv1s5av+J3oO5TPRMmtXU2bJnUaZ+IMqbWarfeJyY4gK
         ZvMda7WrqLW0m5g/rtmrJw9mfp6+yypAGrWDyouZX2BjUpzimPuZm0fP6Rx8xKTIwy2k
         OyStiDS81WbLI/2XpfqSi0ZS5+HFPRiHMZtBChzaLzehdgUPtQELJwpOvHguKgONI7RT
         UM+g==
X-Gm-Message-State: AGi0Pub+d2MALYVJiXBc1Y0KE423/dIzD5HKSWG0aOywSIbzcZaKcf+1
        Z3jamzws2IrvdnOXXbSdVRR+5zbzzLEVVhYyamc=
X-Google-Smtp-Source: APiQypIANL81JSp1JYeRrnTUAddTFq4Vt67bdnqTbdIVaAcqOOKV9d0J4lwHEcXY8L539FSc+z2hB1WKF1M+jfD5SrY=
X-Received: by 2002:a92:ba01:: with SMTP id o1mr12361820ili.217.1585995180647;
 Sat, 04 Apr 2020 03:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLWMB8rr0x4KKfqruCcTLVq4dH6nZ365auMqA1arZ57J7g@mail.gmail.com>
 <CAOkhzLVvmoB0TgS4bioP4PnxwmnT_+h0LbCya2=KkcHu1UT_Zw@mail.gmail.com>
 <CAKb7UvgLr2A88jbx9Zvi3SjXoKbk4iZEg7LNQ4aL3VZhKVQu3A@mail.gmail.com>
 <CAOkhzLU+buL3J3XUbzC6JUAfbnMR-27qwS3Vm7ofrAPPCipXuw@mail.gmail.com>
 <CAKb7UvhvBG49P7t6XD==26q70YywmhUHvP=hW=wj8mT6V0gpHA@mail.gmail.com>
 <CAOkhzLW42a66wNL7Pz8+d+yO_oyZZJBEps=8WPHaXXFjb54dTQ@mail.gmail.com> <CAKb7Uvh=44_S_EAfma+JX9j_igaE3CSWws_TUqLWwJ50zcmA9Q@mail.gmail.com>
In-Reply-To: <CAKb7Uvh=44_S_EAfma+JX9j_igaE3CSWws_TUqLWwJ50zcmA9Q@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Sat, 4 Apr 2020 12:12:49 +0200
Message-ID: <CAOkhzLXV-nsy=B32iLZt48EW6ufDG6ESmX_ZKU5bA0-7G+U9jQ@mail.gmail.com>
Subject: Re: acr: failed to load firmware with Kernel 5.6. Kernel 5.5 works
 just fine.
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ilia

FYI:

On Fri, Apr 3, 2020 at 8:31 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:

> Depends on distro specifics. Also the firmware has to be available at
> the time that nouveau loads. The corollary to this is:
>
> If it's built into the kernel, then the firmware must also be included
> in the kernel (since this happens before any FS stuff)
> If it's loaded as a module from initrd, then initrd must contain the firm=
ware
>
> If you need help including firmware in the right place, a distro
> support channel is probably your best shot.

https://forums.developer.nvidia.com/t/nvidia-driver-does-not-work-for-kerne=
l-5-6-nvidia-gp107/118413/6

/usr/src/linux> dmesg | grep nvidia
[    3.203080] nvidia: loading out-of-tree module taints kernel.
[    3.203088] nvidia: module license 'NVIDIA' taints kernel.
[    3.218324] nvidia-nvlink: Nvlink Core is being initialized, major
device number 248
[    3.218640] nvidia 0000:05:00.0: vgaarb: changed VGA decodes:
olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio+mem
[    3.431032] nvidia-modeset: Loading NVIDIA Kernel Mode Setting
Driver for UNIX platforms  440.64  Fri Feb 21 00:43:19 UTC 2020
[    3.451954] [drm] [nvidia-drm] [GPU ID 0x00000500] Loading driver
[    3.451956] [drm] Initialized nvidia-drm 0.0.0 20160202 for
0000:05:00.0 on minor 1

Best
Zeno

On Fri, Apr 3, 2020 at 8:31 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> On Fri, Apr 3, 2020 at 1:59 PM Zeno Davatz <zdavatz@gmail.com> wrote:
> >
> > On Fri, Apr 3, 2020 at 7:23 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote=
:
> > >
> > > On Fri, Apr 3, 2020 at 1:21 PM Zeno Davatz <zdavatz@gmail.com> wrote:
> > > >
> > > > On Fri, Apr 3, 2020 at 6:59 PM Ilia Mirkin <imirkin@alum.mit.edu> w=
rote:
> > > > >
> > > > > Ben -- probably the ACR changes in 5.6 don't fall back nicely any=
more
> > > > > when there's no firmware? The load shouldn't be failed, just GR
> > > > > disabled...
> > > > >
> > > > > Zeno -- if you grab linux-firmware, it should be all better. Not =
sure
> > > > > if you're missing it on purpose or by accident.
> > > >
> > > > Thank you, Ilia
> > > >
> > > > I will try that on my Gentoo/Funtoo machine now. So far linux-firmw=
are
> > > > was not needed with Kernel 5.5, so it was not installed on my machi=
ne.
> > >
> > > It was needed on 5.5 as well. It's just that it fell back gracefully
> > > without firmware, and you didn't get any acceleration features.
> >
> > Do I need any of these enabled for linux-firmware to load properly in
> > Kernel 5.6?
> >
> >  -*- Firmware loading facility
> >   =E2=94=82 =E2=94=82                                      ()    Build =
named firmware
> > blobs into the kernel binary
> >   =E2=94=82 =E2=94=82                                      [ ]   Enable=
 the firmware
> > sysfs fallback mechanism
> >   =E2=94=82 =E2=94=82                                      [ ]   Enable=
 compressed
> > firmware support
>
> Depends on distro specifics. Also the firmware has to be available at
> the time that nouveau loads. The corollary to this is:
>
> If it's built into the kernel, then the firmware must also be included
> in the kernel (since this happens before any FS stuff)
> If it's loaded as a module from initrd, then initrd must contain the firm=
ware
>
> If you need help including firmware in the right place, a distro
> support channel is probably your best shot.
>
> Cheers,
>
>   -ilia
