Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEDFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 01:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0C0207D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 01:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuJvNTbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgFEBxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 21:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEBxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 21:53:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9925BC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 18:53:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u13so6973823wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 18:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U4CZosCgrOco+0qX9JfsnJUkrPPDI6uu5MxkB4nkR6o=;
        b=HuJvNTbC7yu3dhhouWqHe74UiZWFmMLxhe4kcFamGNSRP7J+7L14dKfv5b4AZD7dCw
         SywGJg61ciHTa4/uU6OtMBNcLClDeRdZzfFLtS3mMeXAL9EdqUeh4AObQwxzcg5BT7Nm
         bKgowOoFtVUfKiC0M30n/UIz2Akrebr6RppfpOeaKlcs0MhT2H+ZlVdpgqLpMZEZ7GzK
         rcKBDLh/mmBLtk6AcjRS2QvWYyhNi1+KvpNucB0134E7o7XwYx5kB4zZE1xHXzvXC7ut
         808GhiM99zuIxTidP/vCzH90R9jY5eQhcx26qlN4R6JweaZQfcXfrnPKVs2gNVAD/X+T
         CDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U4CZosCgrOco+0qX9JfsnJUkrPPDI6uu5MxkB4nkR6o=;
        b=nuWni1rdF3zeUlZuQ5HpsuE78wFjQccQwkxMmdzPZhvBkj80SYgecZsbUqrenEhSRO
         365gGy30wV+LG3gre+2y7EBns9jz9ZqFWmhtC3CIzQK/LvwfFWi04ZLBEZL2lgT98OFH
         ERouZqpUzR00OTrg+Ipqj2cdbbbq1K51xnbi1tVB3pgtMI4iowP+tvDmWlVrr3ohxCus
         Nhso05vYAeGzw5DlXVr4W8nJbgfVC7UyN8UT+NpvVJMdsHjEAX6i/NyeU8ndaxVzQKER
         g3fd/WAfJvjZHdy8LlcMLlYXDg233ucG50oGGYbqaOF8dufuudS6iN76PV0t2v+N1X14
         YvxA==
X-Gm-Message-State: AOAM5334895R502xcKWM5BSBCWhaWQKXaUe4ELZ2325PdNnHMzNQqdIo
        NAJvhwqflFkp2w7us0fqOCOvtGANEZSNGjFyRDQ=
X-Google-Smtp-Source: ABdhPJw8if8OhVcmzWAvMi+CdfmYoq0LWuDN09khwUdOEfAMuIZ2h0feechMs60u6jZX25A+N99hK7LpkqfgJ+XWXic=
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr202787wmj.3.1591322031098;
 Thu, 04 Jun 2020 18:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200527062147.680-1-zhang.lyra@gmail.com> <CAAfSe-voe6as4VveyMt2pyJR1jytdzfRCp1z3s9AnS+QzTvPKA@mail.gmail.com>
 <20200604111639.GZ3714@dell>
In-Reply-To: <20200604111639.GZ3714@dell>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 5 Jun 2020 09:53:14 +0800
Message-ID: <CAAfSe-uuzWp+NS9dMj5=f-UFRyYR0XvuX0D_sJ0JpSRVJxnyiA@mail.gmail.com>
Subject: Re: [PATCH V2] mfd: sprd: Add wakeup capability for PMIC irq
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 19:16, Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 04 Jun 2020, Chunyan Zhang wrote:
>
> > Hi Lee,
> >
> > On Wed, 27 May 2020 at 14:21, Chunyan Zhang <zhang.lyra@gmail.com> wrot=
e:
> > >
> > > From: Baolin Wang <baolin.wang7@gmail.com>
> > >
> > > When changing to use suspend-to-idle to save power, the PMIC irq can =
not
> > > wakeup the system due to lack of wakeup capability, which will cause
> > > the sub-irqs (such as power key) of the PMIC can not wake up the syst=
em.
> > > Thus we can add the wakeup capability for PMIC irq to solve this issu=
e,
> > > as well as removing the IRQF_NO_SUSPEND flag to allow PMIC irq to be
> > > a wakeup source.
> > >
> > > Reported-by: Chunyan Zhang <zhang.lyra@gmail.com>
> > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > Tested-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> > > Changes from v1:
> > > * addressed comments from Lee;
> > > * added tested-by from Chunyan.
> > > (This patch is rebased on branch for-mfd-next)
> >
> > Could you please pick up this patch if there's no more comments :)
>
> Please don't send contentless nags.  Your patch is in my queue.
>
> The merge-window is currently open, which is a) a busy time for

I understand that very much, and also appreciate all maintainer's
works for the great opensource project.
And just because of that I know you're busy during merge-window, I was
worried that this patch was left out, since I didn't see it at
mfd-next.
I apologize if the last email made you unhappay. I will not send
reminder email to you anymore.

Best regards,
Chunyan

> Maintainers and b) a time where some of us take a little breather
> before the next release.  Please wait until -rc1 has been released
> before sending out your [RESENDS].
>
> > > ---
> > >  drivers/mfd/sprd-sc27xx-spi.c | 28 +++++++++++++++++++++++++++-
> > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-=
spi.c
> > > index 33336cde4724..adb4a1b13332 100644
> > > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > > @@ -256,7 +256,7 @@ static int sprd_pmic_probe(struct spi_device *spi=
)
> > >         }
> > >
> > >         ret =3D devm_regmap_add_irq_chip(&spi->dev, ddata->regmap, dd=
ata->irq,
> > > -                                      IRQF_ONESHOT | IRQF_NO_SUSPEND=
, 0,
> > > +                                      IRQF_ONESHOT, 0,
> > >                                        &ddata->irq_chip, &ddata->irq_=
data);
> > >         if (ret) {
> > >                 dev_err(&spi->dev, "Failed to add PMIC irq chip %d\n"=
, ret);
> > > @@ -272,9 +272,34 @@ static int sprd_pmic_probe(struct spi_device *sp=
i)
> > >                 return ret;
> > >         }
> > >
> > > +       device_init_wakeup(&spi->dev, true);
> > >         return 0;
> > >  }
> > >
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static int sprd_pmic_suspend(struct device *dev)
> > > +{
> > > +       struct sprd_pmic *ddata =3D dev_get_drvdata(dev);
> > > +
> > > +       if (device_may_wakeup(dev))
> > > +               enable_irq_wake(ddata->irq);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int sprd_pmic_resume(struct device *dev)
> > > +{
> > > +       struct sprd_pmic *ddata =3D dev_get_drvdata(dev);
> > > +
> > > +       if (device_may_wakeup(dev))
> > > +               disable_irq_wake(ddata->irq);
> > > +
> > > +       return 0;
> > > +}
> > > +#endif
> > > +
> > > +static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_p=
mic_resume);
> > > +
> > >  static const struct of_device_id sprd_pmic_match[] =3D {
> > >         { .compatible =3D "sprd,sc2731", .data =3D &sc2731_data },
> > >         {},
> > > @@ -285,6 +310,7 @@ static struct spi_driver sprd_pmic_driver =3D {
> > >         .driver =3D {
> > >                 .name =3D "sc27xx-pmic",
> > >                 .of_match_table =3D sprd_pmic_match,
> > > +               .pm =3D &sprd_pmic_pm_ops,
> > >         },
> > >         .probe =3D sprd_pmic_probe,
> > >  };
> > >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
