Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044A3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C722067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH17I2he"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgFOG5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgFOG5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:57:31 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F424C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:57:31 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r2so16696190ioo.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=prTw8COlP0YawtaeVf0HJDCuQeY7haR6XjvMZVeDwlQ=;
        b=gH17I2hedonyS691+W+6fep+3TY2IXaj+WglcDlC4uQCnGNqbuuK/7lyqoLAnsWn3g
         x2Ah5LgH+8DHm7Pne9IQxpIpOXRgBdtuZ70LctwowboPEGiRtKl7X0CXO9/0c52j0t3z
         AlhBaH7/hfN1Rluumj9XQNvR6H4dLCTgI8wN3t6LOXKmu6//ZWxLRGWsIQKybkGqEits
         ymTOoXUd+zMG7KP80pm6qMiKu11Nz2Fqb7mTQ4c1eRj04F0IdpI7b4Pj4FDVjs8gDKEB
         X1PQ4tyOMcC4e/C7KpZnTdCzqyf+EJRozJmNbrhCqN2SMCCejsQfW1l0r0kS94GVokzH
         bLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=prTw8COlP0YawtaeVf0HJDCuQeY7haR6XjvMZVeDwlQ=;
        b=flvWR0Ub1S8ZG3bJoWzeMWgWgt2DyFy8PoW1Y3dBqZyYmrey285frP3dfO54ms2e9a
         I00C9BXuQacE/LegnYOBr5AxPYtcQUm6l18D1GiICCRiVXGLlwh2oTuu+llSr89Z3Z/i
         SKBfBEMRwFlB0YWBZoH0d4ZWe1l5tM0T0aFUwICkMq+DWxo+d8NF4Mja79XEY11FrGbf
         EdE1lOzSPNReUqvE4JP+ZqAlGiVtrus6WAPalgUlDj9XhKWAFyWsvjOoXA3I1i+bn+r0
         WsyFKULvUdOa6PzwjRg2nfBdI0C7IdvuiTBq9gVHszz/eFbJPjBQ11k/3mYwdH/SR7DC
         TzmQ==
X-Gm-Message-State: AOAM533/uXE0l5SB4Kon3u9eX7jSE5tVitFIafrA8ps3fGaWCm8OZo5D
        4BJHUR9p4aTlpKQW0lmBY2N4WjEFFooSvqbx51f4Z4/CQts=
X-Google-Smtp-Source: ABdhPJx+23o2l20XfKG7SyHZUNrf9US3cZjYRnOb+N5AUOux9SiMesGnHU/4N6bPSWQvtmT67O+1T8aFvEYB+jPDyas=
X-Received: by 2002:a02:9a03:: with SMTP id b3mr19918046jal.76.1592204250795;
 Sun, 14 Jun 2020 23:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <1591609125-3761-1-git-send-email-gene.chen.richtek@gmail.com>
 <20200608192829.GG4106@dell> <CAE+NS36mxw-FpQhJ4qV=_+r2CXVi_PaGaZo2m3jXAGFuOO252Q@mail.gmail.com>
 <20200609125305.GL4106@dell> <CAE+NS36b8fV2JnSEJpky+0ES3KTYmQzC0MRTfRUf8yRsJh_bpQ@mail.gmail.com>
 <20200612111717.GA2311694@dell>
In-Reply-To: <20200612111717.GA2311694@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 15 Jun 2020 14:57:19 +0800
Message-ID: <CAE+NS34gf+my16b8dGCBWy0rXjT-5ObcvQiMVWHqsGehb_yR4Q@mail.gmail.com>
Subject: Re: [PATCH] mfd: mt6360: Fix register driver NULL pointer by add
 driver name
To:     Lee Jones <lee.jones@linaro.org>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=8812=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:17=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 12 Jun 2020, Gene Chen wrote:
>
> > Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=889=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:53=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Tue, 09 Jun 2020, Gene Chen wrote:
> > >
> > > > Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=889=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:28=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On Mon, 08 Jun 2020, Gene Chen wrote:
> > > > >
> > > > > > From: Gene Chen <gene_chen@richtek.com>
> > > > > >
> > > > > > accidentally remove driver name when
> > > > > > replace probe by probe_new in add mt6360 mfd driver patch v4
> > > > > >
> > > > > > [  121.243012] EAX: c2a8bc64 EBX: 00000000 ECX: 00000000 EDX: 0=
0000000
> > > > > > [  121.243012] ESI: c2a8bc79 EDI: 00000000 EBP: e54bdea8 ESP: e=
54bdea0
> > > > > > [  121.243012] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFL=
AGS: 00010286
> > > > > > [  121.243012] CR0: 80050033 CR2: 00000000 CR3: 02ec3000 CR4: 0=
00006b0
> > > > > > [  121.243012] Call Trace:
> > > > > > [  121.243012]  kset_find_obj+0x3d/0xc0
> > > > > > [  121.243012]  driver_find+0x16/0x40
> > > > > > [  121.243012]  driver_register+0x49/0x100
> > > > > > [  121.243012]  ? i2c_for_each_dev+0x39/0x50
> > > > > > [  121.243012]  ? __process_new_adapter+0x20/0x20
> > > > > > [  121.243012]  ? cht_wc_driver_init+0x11/0x11
> > > > > > [  121.243012]  i2c_register_driver+0x30/0x80
> > > > > > [  121.243012]  ? intel_lpss_pci_driver_init+0x16/0x16
> > > > > > [  121.243012]  mt6360_pmu_driver_init+0xf/0x11
> > > > > > [  121.243012]  do_one_initcall+0x33/0x1a0
> > > > > > [  121.243012]  ? parse_args+0x1eb/0x3d0
> > > > > > [  121.243012]  ? __might_sleep+0x31/0x90
> > > > > > [  121.243012]  ? kernel_init_freeable+0x10a/0x17f
> > > > > > [  121.243012]  kernel_init_freeable+0x12c/0x17f
> > > > > > [  121.243012]  ? rest_init+0x110/0x110
> > > > > > [  121.243012]  kernel_init+0xb/0x100
> > > > > > [  121.243012]  ? schedule_tail_wrapper+0x9/0xc
> > > > > > [  121.243012]  ret_from_fork+0x19/0x24
> > > > > > [  121.243012] Modules linked in:
> > > > > > [  121.243012] CR2: 0000000000000000
> > > > > > [  121.243012] random: get_random_bytes called from init_oops_i=
d+0x3a/0x40 with crng_init=3D0
> > > > > > [  121.243012] ---[ end trace 38a803400f1a2bee ]---
> > > > > > [  121.243012] EIP: strcmp+0x11/0x30
> > > > >
> > > > > How did this driver ever work for you?
> > > >
> > > > i ask my coworker help me verify.
> > > > i will check the patch myself, sincerely apologies for this.
> > >
> > > What does this mean?
> > >
> > > Are you saying that for all 10 versions of this patch submission, it
> > > has never been tested?  And despite being authored by you and
> > > submitted by you, you have never actually boot tested the driver
> > > yourself?  Relying instead on your co-worker to conduct the testing,
> > > who failed to do so.  Is that really correct?
> > >
> >
> > On carefully reading to the document how to upstream, I find that I
> > had full duty for verify patch i sent.
> > The fault is entirely mine and I deeply regret that it should have occu=
rred.
> > I will always verify patch by meself before sending it.
> > I have already verfied sub-device adc/led/regulator done in Mediatek
> > phone and Hikey960 development board
>
> I'm not looking for someone to blame.  Instead, I would like to
> ascertain how this happened.  How was this driver ever
> tested/verified?  If you're not going to run/use it, does it even need
> to exist?
>

There is difference between upstream and commerical driver.
We will sync upstream version after upstream done, in order to become
common driver everyone can easy to use

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
