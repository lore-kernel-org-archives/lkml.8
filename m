Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E1EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B160F206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSz6Td8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgFKPXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgFKPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:23:08 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BD8C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:23:08 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d5so6697142ios.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=05dAwFr23x6Wppd3aNSMMdwYxKpiRDbAuqlCwKPeXLs=;
        b=bSz6Td8dFaOqGljMe+1eneoUKrmQkEKpijse6qYgWOnOjpf+lKXD+jhBG6dS39PsP0
         OXni1wRiqAMdPUA7iHtVRQpprUmR9VRMyxsOxay3NgLezGIG6NbYfraE1bN8Ri7UjNuw
         ZNrcfhRmEzqonmX9Q9RpTjgMcEEeqvxX/VfXyZspPNDSdRacTc7G1KawNqfrnAfruXTS
         wNUoFIida5sohhd8IALsGjfKN4Ilq1EdQA1ALjP6dvEUXoR3kgB94mS8CnA4TpmlgImb
         F6aanALco9UeNpBpWgUpCyuROUV4kMcKDHEnkm5aGCkM8qIDGd9mIsSK7Sbf8T+oBIsr
         268g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=05dAwFr23x6Wppd3aNSMMdwYxKpiRDbAuqlCwKPeXLs=;
        b=RbBLzT1293UhcGoa9z0CoKK6V5yM8muUoseBr6U714cCdE+rSXrefiINej/TCvHMow
         7QQP178D4EvuPGys4zamtJNynrtuFvbsh9AhSz5RHWQtIJfW0gvPiiSpyUTt/bYZC/um
         IUSalrFaCgJvlXcKrOxpW+72jnyuz2uyM/yPcHJR/QRLInAWS7wcVpheSsu0L5Z3x8Of
         xuI2UsZeUABw5rluHISSt9cdcDcxPAXQGRs7m3cZ2ScV8HRHrygUgkXNDacJX9ON6EwH
         Bfiaqv8iUEJ8X7u16pgNKPg+VNNoYheiZNWyv6nV/s/ZZQlELXMWf4FU87CfXj5YuMtI
         +g8Q==
X-Gm-Message-State: AOAM530MW1IxEO4bxCpD0gSPEyCJ/dvuqoTkvRJC73ISiI5bq9Riv+9z
        T/uETJCEu9W66Ln6Mw/18hqIMCMqQwp7dtZFfRc=
X-Google-Smtp-Source: ABdhPJycJe56RMdmTSlh49JWS/4xOF/jY8JcxrWNnB+gxvwV3TotTs2lDnPAQjHS4uzji26kHExgWy0GfGqPDMtFPHQ=
X-Received: by 2002:a6b:f40a:: with SMTP id i10mr8810173iog.155.1591888986914;
 Thu, 11 Jun 2020 08:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200611054454.2547-1-kdasu.kdev@gmail.com> <20200611091604.1bec2418@xps13>
In-Reply-To: <20200611091604.1bec2418@xps13>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Thu, 11 Jun 2020 11:22:56 -0400
Message-ID: <CAC=U0a0ReuPpxZjB2vV_YNynrMx4OjzPmPPyJeVbhueFgFeNbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: rawnand: brcmnand: Don't default to edu transfer
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 3:16 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Kamal,
>
> Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 01:44:53
> -0400:
>
> > When flash-dma is absent do not default to using flash-edu.
> > Make sure flash-edu is enabled before setting EDU transfer
> > function.
> >
> > Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu=
 for dma transfers")
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nan=
d/raw/brcmnand/brcmnand.c
> > index 8f9ffb46a09f..0c1d6e543586 100644
> > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > @@ -2953,8 +2953,9 @@ int brcmnand_probe(struct platform_device *pdev, =
struct brcmnand_soc *soc)
> >               if (ret < 0)
> >                       goto err;
> >
> > -             /* set edu transfer function to call */
> > -             ctrl->dma_trans =3D brcmnand_edu_trans;
> > +             if (has_edu(ctrl))
> > +                     /* set edu transfer function to call */
> > +                     ctrl->dma_trans =3D brcmnand_edu_trans;
>
> Does this fallback to returning an error in case !has_edu() ? Othewise,
> how is it handled?
>

 The driver will default to pio if both flash-dma and falsh-edu are
not present.

> Thanks,
> Miqu=C3=A8l

Kamal
