Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCDFC4346F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 06:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462F623124
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 06:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRRyrPdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHXGaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 02:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHXGaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 02:30:08 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75FBC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:30:07 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o21so7295942oie.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+NAtUDcN0xC1WEfs+U1vuvypI3QS1MQZK0Rodc/Xtyo=;
        b=GRRyrPdIWtz3KwwNq4/FSNlQW9CT3ZAOSqpcbZdzqm3gWhCZDmhzGpXZXQnLsZP1uB
         1mBuDVpeUNtOQeyBFBucdW+tfVYRIyj0+y5Nwsf20+N/ez1D+Q4UkN8zrY6f4lYeNw/p
         Vwb3U+X5rgJ0Cb3QSSKVBzuWjg0777p9fiajuChP6SaR0yamRsVeHlhXALYUh5bXZfqT
         v91ZvBP573M6urAz5BfW+FK62paUgTisguK7i4IcHTYUe5xbPWXLGHwnpadb+dmwDO4G
         cVeVNllTM3WEfSBuN6XiZIUZnCLGaeiBj+r46+JYOPjWyh/6xL3pvFRTYAmgKJfzFOd4
         Gr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+NAtUDcN0xC1WEfs+U1vuvypI3QS1MQZK0Rodc/Xtyo=;
        b=ueSKStiu1hQ7ovSX/383n+Xve1YPFmKLK2KzHHYQbhSHtD2s2G/hEjPr8UshOhpwxS
         9+dopqFe6mEdncvE7uWmNT9hyfwKfjHaw3StSS9RGblw8+zBTEYOeWa8Nqrges7JUf2T
         HO/XLi/zwX50beVoEpRcfEyxoJg6f3fwhEj+lFvrn9jtfDo55Eek2y1CDJYPeM6tvK1b
         /vxw8rulF5UlO1nlBVofMRMFpGmQPn+HDeYm9mGkg/dS8EkC7gYBIKWL2nlBTCbnVF7z
         DYGkVHJskamwCmV70OYr3lwx4NiBBpVwW/HIJYUO3RiSTRtYl17T5l91cAy/IygqnkIi
         FSgA==
X-Gm-Message-State: AOAM532E3L8kptkwou8IW9ZDGj9bk+gpTi6qlADVbg4p8t2H0OAc6coO
        OU0XzpPmT6VvxISoeF2k0TLHFRx06LOwa+kMZLJfjNL/
X-Google-Smtp-Source: ABdhPJyoz+xIrbbOd3U0ql1MuTYysNv/5OxLJXzYBsKbO2kCLPP6PA84UkCpxMpS2Dj89Ek/2KEv9zXad2ve7O4frmU=
X-Received: by 2002:a54:4703:: with SMTP id k3mr2152383oik.89.1598250606574;
 Sun, 23 Aug 2020 23:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rPKTarta5rfhNWSsLqa+Z6qo=FGFygfmT7kuZi11sr3VQ@mail.gmail.com>
 <20200823045559.GA25758@1wt.eu>
In-Reply-To: <20200823045559.GA25758@1wt.eu>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Mon, 24 Aug 2020 14:29:55 +0800
Message-ID: <CAJNi4rN=BdR25o2W6u_RZPY55_3vBq0srHM1j4rQ8u_UnwPh3A@mail.gmail.com>
Subject: Re: Why KASAN doesn't detect this stack oob fault?
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <w@1wt.eu> =E4=BA=8E2020=E5=B9=B48=E6=9C=8823=E6=97=A5=E5=91=
=A8=E6=97=A5 =E4=B8=8B=E5=8D=8812:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Aug 23, 2020 at 11:04:34AM +0800, richard clark wrote:
> > Hi guys,
> >
> > I ins a kmod with below code in a KASAN enabled kernel (
> > 5.7.0,
> > CONFIG_KASAN=3Dy
> > CONFIG_KASAN_GENERIC=3Dy
> > CONFIG_KASAN_OUTLINE=3Dy):
> >
> > static int kmod_init(void)
> > {
> >     int i;
> >     int arr[4];
> >
> >     for (i =3D 0; i < 20; i++) {
> >         arr[i] =3D i;
> >         printk("arr[%d] =3D %d\n", i, arr[i]);
> >     }
> >     return 0;
> > }
> >
> > The output is after insmod:
> >
> > [ 1511.800683] arr[0] =3D 0
> > [ 1511.800685] arr[1] =3D 1
> > [ 1511.800686] arr[2] =3D 2
> > [ 1511.800687] arr[3] =3D 3
> > [ 1511.800688] arr[4] =3D 4
> > [ 1511.800690] arr[5] =3D 5
> > [ 1511.800691] arr[6] =3D 6
> > [ 1511.800692] arr[7] =3D 7
> > [ 1511.800693] arr[8] =3D 8
> > [ 1511.800694] arr[9] =3D 9
> > [ 1511.800695] arr[10] =3D 10
> > [ 1511.800696] arr[11] =3D 11
> > [ 1511.800697] arr[12] =3D 12
> > [ 1511.800699] arr[13] =3D 13
> > [ 1511.800700] arr[14] =3D 14
> > [ 1511.800701] arr[15] =3D 15
> > [ 1511.800702] arr[16] =3D 16
> > [ 1511.800704] arr[17] =3D 17
> > [ 1511.800705] arr[18] =3D 18
> > [ 1511.800706] arr[19] =3D 19
> >
> > The kernel is not tainted and the gcc version is 7.5 used to build the =
kernel.
> > The question is:
> > 1. Why the stack out-of-bound can work?
> > 2. Why the KASAN doesn't detect this?
>
> Have you verified in the output code that the compiler didn't optimize
> the stack access away since it doesn't need it ?
>
yes, the compiler did optimize the stack access away with this code piece..=
.
> Just to make sure, do it in two distinct loops so that there are more
> chances for the stack to be really used:
>
Right, the KASAN stack oob will be triggered when I update the code to
a memory access with the stack address
>
>  static int kmod_init(void)
>  {
>      int i;
>      int arr[4];
>
>      for (i =3D 0; i < 20; i++)
>          arr[i] =3D i;
>
>      for (i =3D 0; i < 20; i++)
>          printk("arr[%d] =3D %d\n", i, arr[i]);
>
>      return 0;
>  }
>
> Willy
