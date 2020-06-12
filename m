Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C56C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0352081A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1VXmpAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgFLJzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgFLJzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:55:14 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D92C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 02:55:13 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i25so9630837iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZS9PVjZ5Jb+4QYevpE16v5sDYFxNKXeLDNvqBCj9BNE=;
        b=s1VXmpArUmAQAoLjT8NM+4wAzfoVBOBj7OFVr4bOMd5d3jQZHAmVTbzlwZWXEc+Q22
         UGgHTf8/ivZwK+TP97yOPLRH6sxvC6dXkxXcMtBmbWLUGGCE2wZ2nelzPwYwIL9Ozf5a
         CXgkmnPA6heILULlzSne8Z//SDHw9gyeMx6BBVYeyAO2WYp3Xko9//FiK9Lm/klEXJ2W
         xfiXWHfkcJzRpAgOk98WlYdPfd091y2Aa3HOAr+f8cQ3Ey7poU2wk09pW64eITonIf3z
         yqzgtb5wiHco57IAmAfuAobH4I2Fz6SvNud6/xtvfc3MTmiORAB3yO7Bupp2Ckh69FZ5
         i+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZS9PVjZ5Jb+4QYevpE16v5sDYFxNKXeLDNvqBCj9BNE=;
        b=Enu/SktS3KbUELzS/leDcj8uzT+a/T6l9ItKxKV1J7bpmEhvWCIFBZ3KU9AznlmpC2
         q9q0ccVnHkNULkw3dRO3xncLknb3lfkzMaNzOnxV7iAF5wfxB/SQjwDqqDCLnUUJdPoK
         m0Br3y+IgM4Iw2tTEskAfYfqoAJi67ugb/MgzwWkE3BSPHXYMho8ckkWJGrQpJjwcg+R
         wKziU0ulw2Y5UmFXaDAu33Bz0v6PJe0MHf3a2zwjMLjhVAbvwOa9EQH7lKmcrZXqN31S
         09MHagkzmZ/VNvrmA1uavsoYFhbIurA3hz2OWYnOFbVdjfds7DVApwJdQA5K6cuwW4vs
         2hFg==
X-Gm-Message-State: AOAM53361wkb8/IwDg+14d4v3dzcVcch2anvd217rqflYT3bK6WT1E/u
        wkcXjVOtAc6kxJe5j3w+GIgf07tiJipBDbMxjF8=
X-Google-Smtp-Source: ABdhPJzxxVxpqjp2Aicg0ipBh3PMBt3CryWdtwrucaesiyOv/PSfKpfbrhtbLDx4y4OB80XPrypx66ART8fiaUz42IA=
X-Received: by 2002:a02:cccd:: with SMTP id k13mr7508035jaq.53.1591955712819;
 Fri, 12 Jun 2020 02:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <1591609125-3761-1-git-send-email-gene.chen.richtek@gmail.com>
 <20200608192829.GG4106@dell> <CAE+NS36mxw-FpQhJ4qV=_+r2CXVi_PaGaZo2m3jXAGFuOO252Q@mail.gmail.com>
 <20200609125305.GL4106@dell>
In-Reply-To: <20200609125305.GL4106@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Fri, 12 Jun 2020 17:55:02 +0800
Message-ID: <CAE+NS36b8fV2JnSEJpky+0ES3KTYmQzC0MRTfRUf8yRsJh_bpQ@mail.gmail.com>
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
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:53=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 09 Jun 2020, Gene Chen wrote:
>
> > Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=889=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:28=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Mon, 08 Jun 2020, Gene Chen wrote:
> > >
> > > > From: Gene Chen <gene_chen@richtek.com>
> > > >
> > > > accidentally remove driver name when
> > > > replace probe by probe_new in add mt6360 mfd driver patch v4
> > > >
> > > > [  121.243012] EAX: c2a8bc64 EBX: 00000000 ECX: 00000000 EDX: 00000=
000
> > > > [  121.243012] ESI: c2a8bc79 EDI: 00000000 EBP: e54bdea8 ESP: e54bd=
ea0
> > > > [  121.243012] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS:=
 00010286
> > > > [  121.243012] CR0: 80050033 CR2: 00000000 CR3: 02ec3000 CR4: 00000=
6b0
> > > > [  121.243012] Call Trace:
> > > > [  121.243012]  kset_find_obj+0x3d/0xc0
> > > > [  121.243012]  driver_find+0x16/0x40
> > > > [  121.243012]  driver_register+0x49/0x100
> > > > [  121.243012]  ? i2c_for_each_dev+0x39/0x50
> > > > [  121.243012]  ? __process_new_adapter+0x20/0x20
> > > > [  121.243012]  ? cht_wc_driver_init+0x11/0x11
> > > > [  121.243012]  i2c_register_driver+0x30/0x80
> > > > [  121.243012]  ? intel_lpss_pci_driver_init+0x16/0x16
> > > > [  121.243012]  mt6360_pmu_driver_init+0xf/0x11
> > > > [  121.243012]  do_one_initcall+0x33/0x1a0
> > > > [  121.243012]  ? parse_args+0x1eb/0x3d0
> > > > [  121.243012]  ? __might_sleep+0x31/0x90
> > > > [  121.243012]  ? kernel_init_freeable+0x10a/0x17f
> > > > [  121.243012]  kernel_init_freeable+0x12c/0x17f
> > > > [  121.243012]  ? rest_init+0x110/0x110
> > > > [  121.243012]  kernel_init+0xb/0x100
> > > > [  121.243012]  ? schedule_tail_wrapper+0x9/0xc
> > > > [  121.243012]  ret_from_fork+0x19/0x24
> > > > [  121.243012] Modules linked in:
> > > > [  121.243012] CR2: 0000000000000000
> > > > [  121.243012] random: get_random_bytes called from init_oops_id+0x=
3a/0x40 with crng_init=3D0
> > > > [  121.243012] ---[ end trace 38a803400f1a2bee ]---
> > > > [  121.243012] EIP: strcmp+0x11/0x30
> > >
> > > How did this driver ever work for you?
> >
> > i ask my coworker help me verify.
> > i will check the patch myself, sincerely apologies for this.
>
> What does this mean?
>
> Are you saying that for all 10 versions of this patch submission, it
> has never been tested?  And despite being authored by you and
> submitted by you, you have never actually boot tested the driver
> yourself?  Relying instead on your co-worker to conduct the testing,
> who failed to do so.  Is that really correct?
>

On carefully reading to the document how to upstream, I find that I
had full duty for verify patch i sent.
The fault is entirely mine and I deeply regret that it should have occurred=
.
I will always verify patch by meself before sending it.
I have already verfied sub-device adc/led/regulator done in Mediatek
phone and Hikey960 development board

> > > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > > ---
> > > >  drivers/mfd/mt6360-core.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > > > index db8cdf5..e9cacc2 100644
> > > > --- a/drivers/mfd/mt6360-core.c
> > > > +++ b/drivers/mfd/mt6360-core.c
> > > > @@ -412,6 +412,7 @@ MODULE_DEVICE_TABLE(of, mt6360_pmu_of_id);
> > > >
> > > >  static struct i2c_driver mt6360_pmu_driver =3D {
> > > >       .driver =3D {
> > > > +             .name =3D "mt6360_pmu",
> > > >               .pm =3D &mt6360_pmu_pm_ops,
> > > >               .of_match_table =3D of_match_ptr(mt6360_pmu_of_id),
> > > >       },
> > >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
