Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAF9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB3420722
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G6sMfBcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgGFObl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgGFObk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:31:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4C5C08C5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 07:31:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so33138777wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 07:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhw/BUTROVOYN40TpUh0RgTpP5MGKfF0bQwNQn8IkII=;
        b=G6sMfBcyiYZnXJjewARbxvkBt3nPIhVdokEGhTOdGLVzWM49cWwLxahf6Rk2CZ1TFB
         s/0S87lpRaLeyIqVJQEXwzGp3bW5n5qiDoJasdHuh95CUnRkVR+HzZeQgjKbYbhlqt3b
         WD9MqtcyVkJe4aVoz5MvW6z5eWkzVtxC+SoaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhw/BUTROVOYN40TpUh0RgTpP5MGKfF0bQwNQn8IkII=;
        b=ja1BrcSeAM48SJaANWdw6s4pIdEIaYpZKabIY9FeJn+1vUB4b0UBY6q5cXXONERQRH
         3qNzkQWRMAnH+d3Bp+iWBK97dYNS76TPxx8JSCLwHGcwANXUavq2eq5+4JsCyu2K+zPy
         i9Etms+XGnRH7S1aj3blMVfc/vWNASpLU2jIbZssqrPi2C3FgjS7KJwpRCfPqxt1is4k
         57FJ/Vjifj3IUu/bbl8/SSKOrwWDUSCXKXhiKT9MllxiPkK/mRXVwNdoiT4rbQCysz2W
         5793s0yVJTr742HuZmg0NgJsVxjE+Ylm6On9f743aCn/hFfHmCtBrxI+p7YhPvptB1hA
         20pw==
X-Gm-Message-State: AOAM533WGyqm6A6hTC8Ej/dL9CkvS9TxnvCPnojgK9Dmc1JTfzODL6Rt
        PhhvhJ/HSPbTWtrBRGg2fx2Efcuvakh1ByfOjxyQNw==
X-Google-Smtp-Source: ABdhPJyHqRH6FGwmZgD3+KEklIah/GrAEhS53xleM7Xl7Ibxb6V9FYXfGur/MTogqCYMmnM+3ePQijdxNsAEQ6ymJm4=
X-Received: by 2002:adf:edc6:: with SMTP id v6mr49556859wro.413.1594045898580;
 Mon, 06 Jul 2020 07:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200701212155.37830-1-james.quinlan@broadcom.com>
 <20200701212155.37830-3-james.quinlan@broadcom.com> <968d6802-b30e-b618-1dd5-1b1a5ba6548a@cogentembedded.com>
In-Reply-To: <968d6802-b30e-b618-1dd5-1b1a5ba6548a@cogentembedded.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 6 Jul 2020 10:31:27 -0400
Message-ID: <CA+-6iNyoMiy6gybczF6_fqazHAjps-gbJt9pyJ65wTxSp1Lmpw@mail.gmail.com>
Subject: Re: [PATCH v6 02/12] ata: ahci_brcm: Fix use of BCM7216 reset controller
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 5:32 AM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>
> Hello!
>
> On 02.07.2020 0:21, Jim Quinlan wrote:
>
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > A reset controller "rescal" is shared between the AHCI driver and the PCIe
> > driver for the BrcmSTB 7216 chip.  Use
> > devm_reset_control_get_optional_shared control() to handle this sharing.
>
>     Not "devm_reset_control_get_optional_shared() control"?


Hi Sergei, sorry for the delay in my response.  I will fix the above.

Thanks again,
Jim

>
>
> >
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> >
> > Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
> > Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
> > ---
> >   drivers/ata/ahci_brcm.c | 11 +++--------
> >   1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> > index 6853dbb4131d..d6115bc04b09 100644
> > --- a/drivers/ata/ahci_brcm.c
> > +++ b/drivers/ata/ahci_brcm.c
> [...]
> > @@ -452,11 +451,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
> >
> >       /* Reset is optional depending on platform and named differently */
> >       if (priv->version == BRCM_SATA_BCM7216)
> > -             reset_name = "rescal";
> > +             priv->rcdev = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
> >       else
> > -             reset_name = "ahci";
> > +             priv->rcdev = devm_reset_control_get_optional(&pdev->dev, "ahci");
> >
> > -     priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
> >       if (IS_ERR(priv->rcdev))
> >               return PTR_ERR(priv->rcdev);
> >
> [...]
>
> MBR, Sergei
