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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0546BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C714F2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z92vUS4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgFKQEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgFKQEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:04:42 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA97C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 09:04:40 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id h3so5899228ilh.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6QgP2oZvpsF1JRXIhUxXLqPHdCzhLmzL7DYVCPQ3hw0=;
        b=Z92vUS4vJqNYB/xIUI4RTxkMavBjZ5p2banNf0tuWBsTQ2RVALs4G3AeMn2PRXYmxM
         byejBgZpMCIXuxlFac4UzWl/c03+RrLQqwDAoXdWMH+R32Mwm0N9Ulom8sMZVkVlgMIc
         N5+Ve6oMRWntAz2BOoc0sNz5if6nSuHBRk2opw79sUKNJuEQxEvYZ67zJGGXS92Zx+lA
         CU5F4LSfqFbr/yvXkQ0HdNG/imXtdrVasABo1CYCUWpkJQjCZejOt3DM/QTFgG1fE+2W
         9KwRyBB7MwMsp/ykJUmTDyoK3SDf7o6mpwZHNOmXnDVOeavS6cb4O1wp8BO4jC0bxm66
         dL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6QgP2oZvpsF1JRXIhUxXLqPHdCzhLmzL7DYVCPQ3hw0=;
        b=tNfb/tEUr10tZJHXoa5zIGptnmu5CxGx8vf4fVOsm1jNQ+fD4YXNOeAtwUg4pCoMsc
         AFFUQlgFP6bH6Doy3+VP8ovDFF8jAwc1XdOl90EWfs8y+gxd6vFKyscFihrfMrxxXWKj
         RGE2dL3olvliLU5AeiebP53JwWj8xncSbT2/HRT6mABgpkwEAZp1X+0rEZUxLZVAvTQt
         Wn3htBqinjh9VW6HvDTWxURCj5/LYF5I8FCQ1vtPamGd57p77qJ4cS6Fw4tbyogc4xLX
         TJ1u+0JCMbZCoYqKHMes6jLvJqX/d47W00Ef8rqqAQhZ8c3k9G2DoC393sSWMHXu8uO6
         zAEQ==
X-Gm-Message-State: AOAM530WOC6Cdeql1LHLram3d9dbyRM7CXrANy+nFbNgyzhMe1MZkphu
        UFfxOLeHeElVusvfNv+K6pq8c9mcSGNLQiaZeqk=
X-Google-Smtp-Source: ABdhPJwteAWxdqw7GZDJTzA0giSI51iE1i/CVhjwKS3MqtkEaZp5HCakg/gy0hay4aj96XJDCTiGE/Zvzy9KNn1zyMI=
X-Received: by 2002:a92:c94b:: with SMTP id i11mr9053840ilq.177.1591891480001;
 Thu, 11 Jun 2020 09:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200611054454.2547-1-kdasu.kdev@gmail.com> <20200611054454.2547-2-kdasu.kdev@gmail.com>
 <20200611092707.75da8c6a@xps13>
In-Reply-To: <20200611092707.75da8c6a@xps13>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Thu, 11 Jun 2020 12:04:29 -0400
Message-ID: <CAC=U0a3RXScu12LkU+hCv_5Lp_he92ExRFSgqLkwx40D6Xtrag@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: brcmnand: Ecc error handling on EDU transfers
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

On Thu, Jun 11, 2020 at 3:27 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Kamal,
>
> Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 01:44:54
> -0400:
>
> > Implemented ECC correctable and uncorrectable error handling for EDU
>
> Implement?
>
> > reads. If ECC correctable bitflips are encountered  on EDU transfer,
>
> extra space                                         ^
>
> > read page again using pio, This is needed due to a controller lmitation
>
> s/pio/PIO/
>
> > where read and corrected data is not transferred to the DMA buffer on E=
CC
> > errors. This holds true for ECC correctable errors beyond set threshold=
.
>
> error.
>
> Not sure what the last sentence means?
>

NAND controller allows for setting a correctable  ECC threshold number
of bits beyond which it will actually report the error to the driver.
e.g. for BCH-4 the threshold is 3, so 3-bit and 4-bit errors will
generate correctable ECC interrupt however 1-bit and 2-bit errors will
be corrected silently.
From the above example EDU hardware will not transfer corrected data
to the DMA buffer for 3-bit and 4-bit errors that get reported. So
once we detect
the error duing EDU we read the page again using pio.

> >
> > Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu=
 for dma transfers")
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > ---
>
> Minor nits below :)
>
> >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 26 ++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nan=
d/raw/brcmnand/brcmnand.c
> > index 0c1d6e543586..d7daa83c8a58 100644
> > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > @@ -1855,6 +1855,22 @@ static int brcmnand_edu_trans(struct brcmnand_ho=
st *host, u64 addr, u32 *buf,
> >       edu_writel(ctrl, EDU_STOP, 0); /* force stop */
> >       edu_readl(ctrl, EDU_STOP);
> >
> > +     if (ret =3D=3D 0 && edu_cmd =3D=3D EDU_CMD_READ) {
>
> !ret
>
> > +             u64 err_addr =3D 0;
> > +
> > +             /*
> > +              * check for ecc errors here, subpage ecc erros are
> > +              * retained in ecc error addr register
>
> s/ecc/ECC/
> s/erros/errors/
> s/addr/address/
>
> > +              */
> > +             err_addr =3D brcmnand_get_uncorrecc_addr(ctrl);
> > +             if (!err_addr) {
> > +                     err_addr =3D brcmnand_get_correcc_addr(ctrl);
> > +                     if (err_addr)
> > +                             ret =3D -EUCLEAN;
> > +             } else
> > +                     ret =3D -EBADMSG;
>
> I don't like very much to see these values being used within NAND
> controller drivers but I see it's already the cause, so I guess I can
> live with that.
>
> > +     }
> > +
> >       return ret;
> >  }
> >
> > @@ -2058,6 +2074,7 @@ static int brcmnand_read(struct mtd_info *mtd, st=
ruct nand_chip *chip,
> >       u64 err_addr =3D 0;
> >       int err;
> >       bool retry =3D true;
> > +     bool edu_read =3D false;
> >
> >       dev_dbg(ctrl->dev, "read %llx -> %p\n", (unsigned long long)addr,=
 buf);
> >
> > @@ -2075,6 +2092,10 @@ static int brcmnand_read(struct mtd_info *mtd, s=
truct nand_chip *chip,
> >                       else
> >                               return -EIO;
> >               }
> > +
> > +             if (has_edu(ctrl))
> > +                     edu_read =3D true;
>
> You don't need this extra value, you already have the cmd parameter
> which tells you if it is a read or a write. You might even want to
> create a if block so set dir and edu_cmd and eventually a local
> edu_read if you think it still makes sense.
>

I needed the value since dma and edu read has multiple conditions like
oob is not included, buffer is aligned, virtual address is good. This
indicates to
the if (mtd_is_bitflip(err))  block that the error was from an edu
transaction that happened.This way all ecc error handling for dma,
edu, pio is in one place.
Also there is more controller version specific logic for read error
handling in there and this allows us to maintain the hierarchy how we
handle both correctable
and uncorrectable error.

> > +
> >       } else {
> >               if (oob)
> >                       memset(oob, 0x99, mtd->oobsize);
> > @@ -2122,6 +2143,11 @@ static int brcmnand_read(struct mtd_info *mtd, s=
truct nand_chip *chip,
> >       if (mtd_is_bitflip(err)) {
> >               unsigned int corrected =3D brcmnand_count_corrected(ctrl)=
;
> >
> > +             /* in case of edu correctable error we read again using p=
io */
>
> s/edu/EDU/ ?
> s/pio/PIO/
>
> > +             if (edu_read)
> > +                     err =3D brcmnand_read_by_pio(mtd, chip, addr, tra=
ns, buf,
> > +                                                oob, &err_addr);
> > +
> >               dev_dbg(ctrl->dev, "corrected error at 0x%llx\n",
> >                       (unsigned long long)err_addr);
> >               mtd->ecc_stats.corrected +=3D corrected;
>

Will fix all the other typos.

> Thanks,
> Miqu=C3=A8l

Thanks
Kamal
