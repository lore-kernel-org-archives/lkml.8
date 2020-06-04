Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C20C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A3120663
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0mnEIdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgFDLQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgFDLQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 07:16:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82047C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 04:16:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v19so4843995wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=boJyGP+gPrammziGfBa0Rtpgvb7ZM8NCT5rtIiHrchY=;
        b=B0mnEIdGvO/8pNPYWfxGpx9Fzt94z97xsG2Jy1Xp/LJCeaLS5KYgVDM2lJ+kNOnZqP
         6a1jdogX8HleRkSrqHQfbaMfaw+YqL7yueS0qKAIj92JcUPAk46ShsuhTkvy2GSPuXH5
         4eM76bmfxHNXV1FomJBfohipL7/rTTscXBtHCl+c4MPLGuqyo3RUxG4bPlbZydhwOOWX
         5xrSp8aMRWaxxhtLvbxTLj67wESI0eHy4GOIwW4xYTro+BASCNy3hquFm6LRfbKAmcUE
         HqiidTxf4xKT6lhHcUOMjpLI6Q0QLYnRnyP4UDisg19Rm7r9/4QCy/UqPsi9l2hDB3Kn
         /BhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=boJyGP+gPrammziGfBa0Rtpgvb7ZM8NCT5rtIiHrchY=;
        b=kOYEdhTI+AH4tQn98Hdqj9m6HVsmzf0Lys0wQrRHteplNyIg15kYPaUXAeIM0MSCFP
         DlfGffsyiVVORvxUB57i/y15tIGZsddRch5V2j1zg5UwHmHOONlJtVkEUFf5tFvh8UFV
         fauGIa+oBwBqSpJMt75H+2ntFZlXDH5q0VkgyCr58vmmaoJSKQDmc0aacgSdepccVLvS
         WUuzxKoGKUYm38NUej1pZlL+IZ+1NiQQKCYWknPhAKFOmuC7NLNlBB1QmeXMUwMdfxAJ
         kV8XlFFiJHNOfPwDsL3IVyZ4srCGCnKxG9HmK8nBT2BIY+9Fo13osEk1XTOI1Q9MrVrj
         w4fQ==
X-Gm-Message-State: AOAM533RihLpqAUT/MTjFG51oXzp4PYVZ6cqAG9jSfW2cSNfil2nVpFu
        G/U1Iov1N8mrbKqSu4GjE82HJQ==
X-Google-Smtp-Source: ABdhPJxryzqz4ew9/g4Ibkz6WjYMEviCTsNzCQva4r53NLnbdtuaO9mWGbqNGP6OUY7rYgYlXx75OQ==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr3518122wmi.22.1591269403185;
        Thu, 04 Jun 2020 04:16:43 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id l1sm8856507wrb.31.2020.06.04.04.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 04:16:42 -0700 (PDT)
Date:   Thu, 4 Jun 2020 12:16:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH V2] mfd: sprd: Add wakeup capability for PMIC irq
Message-ID: <20200604111639.GZ3714@dell>
References: <20200527062147.680-1-zhang.lyra@gmail.com>
 <CAAfSe-voe6as4VveyMt2pyJR1jytdzfRCp1z3s9AnS+QzTvPKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAfSe-voe6as4VveyMt2pyJR1jytdzfRCp1z3s9AnS+QzTvPKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jun 2020, Chunyan Zhang wrote:

> Hi Lee,
> 
> On Wed, 27 May 2020 at 14:21, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > From: Baolin Wang <baolin.wang7@gmail.com>
> >
> > When changing to use suspend-to-idle to save power, the PMIC irq can not
> > wakeup the system due to lack of wakeup capability, which will cause
> > the sub-irqs (such as power key) of the PMIC can not wake up the system.
> > Thus we can add the wakeup capability for PMIC irq to solve this issue,
> > as well as removing the IRQF_NO_SUSPEND flag to allow PMIC irq to be
> > a wakeup source.
> >
> > Reported-by: Chunyan Zhang <zhang.lyra@gmail.com>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > Tested-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> > Changes from v1:
> > * addressed comments from Lee;
> > * added tested-by from Chunyan.
> > (This patch is rebased on branch for-mfd-next)
> 
> Could you please pick up this patch if there's no more comments :)

Please don't send contentless nags.  Your patch is in my queue.

The merge-window is currently open, which is a) a busy time for
Maintainers and b) a time where some of us take a little breather
before the next release.  Please wait until -rc1 has been released
before sending out your [RESENDS].

> > ---
> >  drivers/mfd/sprd-sc27xx-spi.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> > index 33336cde4724..adb4a1b13332 100644
> > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > @@ -256,7 +256,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
> >         }
> >
> >         ret = devm_regmap_add_irq_chip(&spi->dev, ddata->regmap, ddata->irq,
> > -                                      IRQF_ONESHOT | IRQF_NO_SUSPEND, 0,
> > +                                      IRQF_ONESHOT, 0,
> >                                        &ddata->irq_chip, &ddata->irq_data);
> >         if (ret) {
> >                 dev_err(&spi->dev, "Failed to add PMIC irq chip %d\n", ret);
> > @@ -272,9 +272,34 @@ static int sprd_pmic_probe(struct spi_device *spi)
> >                 return ret;
> >         }
> >
> > +       device_init_wakeup(&spi->dev, true);
> >         return 0;
> >  }
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +static int sprd_pmic_suspend(struct device *dev)
> > +{
> > +       struct sprd_pmic *ddata = dev_get_drvdata(dev);
> > +
> > +       if (device_may_wakeup(dev))
> > +               enable_irq_wake(ddata->irq);
> > +
> > +       return 0;
> > +}
> > +
> > +static int sprd_pmic_resume(struct device *dev)
> > +{
> > +       struct sprd_pmic *ddata = dev_get_drvdata(dev);
> > +
> > +       if (device_may_wakeup(dev))
> > +               disable_irq_wake(ddata->irq);
> > +
> > +       return 0;
> > +}
> > +#endif
> > +
> > +static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume);
> > +
> >  static const struct of_device_id sprd_pmic_match[] = {
> >         { .compatible = "sprd,sc2731", .data = &sc2731_data },
> >         {},
> > @@ -285,6 +310,7 @@ static struct spi_driver sprd_pmic_driver = {
> >         .driver = {
> >                 .name = "sc27xx-pmic",
> >                 .of_match_table = sprd_pmic_match,
> > +               .pm = &sprd_pmic_pm_ops,
> >         },
> >         .probe = sprd_pmic_probe,
> >  };
> >

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
