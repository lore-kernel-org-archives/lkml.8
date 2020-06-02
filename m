Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE52C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F13620734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmnR1WvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgFBKAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 06:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFBKAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 06:00:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94601C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 03:00:00 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d66so4825036pfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zp5PU9Twd2i2tzFPrLrjXtcDPzTLivpIOOvbhmocsuo=;
        b=dmnR1WvZuRPZ/6Vpb+2SuZ+t+QRjmdnWP4ZzKF3uTHDv6g1pEoMDEDg0XZp1RQS4Rc
         PcdwQZ29rNPnq3l2fjwqhuF7j/2HX+rBmez4tAy8HbfuXFzxbKgiqrjW/bkv/yD58r1Q
         RIPnaU6YMZn5W47hiL5Cwf7GTc+8XvqW2lhYOl2l6y2WsJw0EDbx5auoVaKZRGYT/MrW
         65P2sOwN8DsDt4Wk/Hj4ZI7jftv3djCsQ51f81pX/h2RYakYDO5iyWeC2mruTm4m/oAt
         spMKkoM1c0u9+ks+AAa++E4S2fyAHS2aD1Hvrb5vDAG2sKTV79mdr4NuETxL7Y2knUFA
         aapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zp5PU9Twd2i2tzFPrLrjXtcDPzTLivpIOOvbhmocsuo=;
        b=qBMSsI1bn7m6/gw0Xqjbg2TKizTFQoaeyfEU7Eaiid0gp6X/J0TXLBt9sYEwXIV9Kd
         Ox7y63b2MSpNSp8dxMXnYg2gz6NeQWTmTDPQA/8n2PlFBTlKdK/thWbTkSm2noTgiNws
         pZVG+MrHPR+d5wrlXxSu/nr+cHklB7FBgfQhykZgQKeiYWm+/8llq5ESgaNkl//S5Dt1
         xoY9wGLuwVSkI6JWNpXj8uixbCgsM/Ja625jjVShHV8fPFSfnAbuXiZVUC6Q9swvtB7c
         8CJ2bVJTEA2lvFgf2a3FvVczvx9J2cthLuSidg3ZR3kApw6nHmCk9pzFzDmbsI0ebcBn
         EGNQ==
X-Gm-Message-State: AOAM532NgoI/Shpw1QtDOTFhdnSIdTmP0pcUNKAF7fSKIIcEtywvaptZ
        ItXPJgYXqK2914LedqyP9e1BkhT/eoYN1R073Oc=
X-Google-Smtp-Source: ABdhPJyDp8msT2DNgjzkwwVUe+Cx8nDbX/Gkz2pS3jjzG2aw72oIk/YYF9TBdmXcCF3WA4qheLl5NIP1f08J9GZZI+k=
X-Received: by 2002:a63:545a:: with SMTP id e26mr22863595pgm.4.1591092000175;
 Tue, 02 Jun 2020 03:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200602092030.31966-1-piotr.stankiewicz@intel.com>
 <CAHp75Ve9tdNB7s+gybsg-OUjA3HiZBgzxeOzw=qkx8t1Ybbmsg@mail.gmail.com> <CY4PR11MB1528E8F05A738675B0DC1A59F98B0@CY4PR11MB1528.namprd11.prod.outlook.com>
In-Reply-To: <CY4PR11MB1528E8F05A738675B0DC1A59F98B0@CY4PR11MB1528.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jun 2020 12:59:48 +0300
Message-ID: <CAHp75VdmaGchzGCQ1ch4-9nj=5EKFAndUCKRZKhhiSRrbTwnnA@mail.gmail.com>
Subject: Re: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where appropriate
To:     "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 12:58 PM Stankiewicz, Piotr
<piotr.stankiewicz@intel.com> wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Tuesday, June 2, 2020 11:49 AM
> > To: Stankiewicz, Piotr <piotr.stankiewicz@intel.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>; Christian K=C3=B6nig
> > <christian.koenig@amd.com>; David Zhou <David1.Zhou@amd.com>; David
> > Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; amd-
> > gfx@lists.freedesktop.org; dri-devel <dri-devel@lists.freedesktop.org>;=
 Linux
> > Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where
> > appropriate
> > On Tue, Jun 2, 2020 at 12:24 PM Piotr Stankiewicz
> > <piotr.stankiewicz@intel.com> wrote:

...

> > >                 int nvec =3D pci_msix_vec_count(adev->pdev);
> > >                 unsigned int flags;
> > >
> > > -               if (nvec <=3D 0) {
> > > +               if (nvec > 0)
> > > +                       flags =3D PCI_IRQ_MSI_TYPES;
> > > +               else
> > >                         flags =3D PCI_IRQ_MSI;
> > > -               } else {
> > > -                       flags =3D PCI_IRQ_MSI | PCI_IRQ_MSIX;
> > > -               }
> > > +
> > >                 /* we only need one vector */
> > >                 nvec =3D pci_alloc_irq_vectors(adev->pdev, 1, 1, flag=
s);
> >
> > I'm not sure if you have seen my last comment internally about this pat=
ch.
> >
> > I don't understand why we need these pci_msix_vec_count() followed by
> > conditional at all.
> > Perhaps we may simple drop all these and supply flag directly?
> >
> > But OTOH, I don't know the initial motivation, so, the above patch is
> > non-intrusive and keeps original logic.
> >
>
> Sorry, I must have misunderstood or missed that comment. I am happy
> to do a V2 if dropping the conditional is preferable.

Let's wait for AMD people to confirm either.

--=20
With Best Regards,
Andy Shevchenko
