Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB851C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EA42064C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caEOUEWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgFILny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgFILnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:43:50 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE3BC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 04:43:50 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e11so14831746ilr.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hIZcde/O0lhQt+tclxIsnIomOUROmtIJB8oligd0v60=;
        b=caEOUEWgCiTp1X9TY7aGflhD7i0tcXSAIXQwLHWDNIT8wViqQCEMUwbMUZN79zv0Yy
         GJ6L25DJhiobGcDXStzcaGBSBL7JjhRMq8VVf7UG0TKdnN3kMiwm9OEH6SumeYuSIL4b
         8IKyshulsfGdrx1DanUewpue+NbzNnbFBMbc+B1EMkcnD7vA0M53fTmZTYzTvRKo5Fa4
         XPRj83VkH75J/rhe8g6B5u7D/k7bhYedqyWVvgy/X3qCFH/Lv6tC3SMYzQxfjZ/0+PMf
         YffhKelf7OXkZsUmub9VENBfP7LO6CmhJnegxzmRfWg7wl7i6ZdbeRufsclRhfSzLf3r
         Ay0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hIZcde/O0lhQt+tclxIsnIomOUROmtIJB8oligd0v60=;
        b=JZ6lTA7ZN5F48y0HoQACOcfaJG3tOGGKRhbdM2iyDAGDxOnfgL/sgSsZqZ9yMDZq3z
         OhLWX1CP4vTW3AQKV/37n9xxmef4BsWilnlKYVbARRCn9IuRMuVpBA+fhujkyIsOlW8h
         yWZU/mG/vxS5ClYjH5I/+adp7Bs9d0dpnhI0c1ZFr/swkNEe3GwCLVWYGLRtodgZEIOK
         iH5KW2ROI7lyQlRo8dITlFKVo/Ib+Zat8IHUMxhrq3Bfi8Oc2YdqBwyyXnmpwJMwcltI
         QrpfpR/hKm4wduiGxizduOhMHrgSNcnaUNf0t+Y8mxieEuHls4y09i3ITBctzN/tBH3s
         lPFQ==
X-Gm-Message-State: AOAM530OHTI0zFt7NGI5qlQGSLZwWq7JdZW77XiUHB3wH9baEjZwS+iV
        z6jXNB9RsZB9RUSjaIYYRPNz9+ZnAch+fQlQL20=
X-Google-Smtp-Source: ABdhPJzFYa1v7Pfs5GXW2MgOgJ+zvbsMZxjpmoT6A8GN/KqiUr3V0+OQQnD6tP1yjfm9+DD7zgMyU4xq8IyQ1U0x9Ug=
X-Received: by 2002:a92:1904:: with SMTP id 4mr13037156ilz.212.1591703029556;
 Tue, 09 Jun 2020 04:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <1591609125-3761-1-git-send-email-gene.chen.richtek@gmail.com> <20200608192829.GG4106@dell>
In-Reply-To: <20200608192829.GG4106@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 9 Jun 2020 19:43:38 +0800
Message-ID: <CAE+NS36mxw-FpQhJ4qV=_+r2CXVi_PaGaZo2m3jXAGFuOO252Q@mail.gmail.com>
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

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=889=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 08 Jun 2020, Gene Chen wrote:
>
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > accidentally remove driver name when
> > replace probe by probe_new in add mt6360 mfd driver patch v4
> >
> > [  121.243012] EAX: c2a8bc64 EBX: 00000000 ECX: 00000000 EDX: 00000000
> > [  121.243012] ESI: c2a8bc79 EDI: 00000000 EBP: e54bdea8 ESP: e54bdea0
> > [  121.243012] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 000=
10286
> > [  121.243012] CR0: 80050033 CR2: 00000000 CR3: 02ec3000 CR4: 000006b0
> > [  121.243012] Call Trace:
> > [  121.243012]  kset_find_obj+0x3d/0xc0
> > [  121.243012]  driver_find+0x16/0x40
> > [  121.243012]  driver_register+0x49/0x100
> > [  121.243012]  ? i2c_for_each_dev+0x39/0x50
> > [  121.243012]  ? __process_new_adapter+0x20/0x20
> > [  121.243012]  ? cht_wc_driver_init+0x11/0x11
> > [  121.243012]  i2c_register_driver+0x30/0x80
> > [  121.243012]  ? intel_lpss_pci_driver_init+0x16/0x16
> > [  121.243012]  mt6360_pmu_driver_init+0xf/0x11
> > [  121.243012]  do_one_initcall+0x33/0x1a0
> > [  121.243012]  ? parse_args+0x1eb/0x3d0
> > [  121.243012]  ? __might_sleep+0x31/0x90
> > [  121.243012]  ? kernel_init_freeable+0x10a/0x17f
> > [  121.243012]  kernel_init_freeable+0x12c/0x17f
> > [  121.243012]  ? rest_init+0x110/0x110
> > [  121.243012]  kernel_init+0xb/0x100
> > [  121.243012]  ? schedule_tail_wrapper+0x9/0xc
> > [  121.243012]  ret_from_fork+0x19/0x24
> > [  121.243012] Modules linked in:
> > [  121.243012] CR2: 0000000000000000
> > [  121.243012] random: get_random_bytes called from init_oops_id+0x3a/0=
x40 with crng_init=3D0
> > [  121.243012] ---[ end trace 38a803400f1a2bee ]---
> > [  121.243012] EIP: strcmp+0x11/0x30
>
> How did this driver ever work for you?
>

i ask my coworker help me verify.
i will check the patch myself, sincerely apologies for this.

> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >  drivers/mfd/mt6360-core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > index db8cdf5..e9cacc2 100644
> > --- a/drivers/mfd/mt6360-core.c
> > +++ b/drivers/mfd/mt6360-core.c
> > @@ -412,6 +412,7 @@ MODULE_DEVICE_TABLE(of, mt6360_pmu_of_id);
> >
> >  static struct i2c_driver mt6360_pmu_driver =3D {
> >       .driver =3D {
> > +             .name =3D "mt6360_pmu",
> >               .pm =3D &mt6360_pmu_pm_ops,
> >               .of_match_table =3D of_match_ptr(mt6360_pmu_of_id),
> >       },
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
