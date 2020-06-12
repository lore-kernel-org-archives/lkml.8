Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2C7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492C020835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT60cBBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgFLQee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLQee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:34:34 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD11C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:34:34 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r2so10918752ioo.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zGtrkPwQHWrCekYK5dUaegAtQMN8QZalOj8VmvHgaA4=;
        b=AT60cBBv3QR8xJsxBMrR/A4GpRqeznHdckKOSk0xmw1K1neMHnj2m16VPCQp/VANcC
         O/gHP6I3TPgj+ejrK0ySfOEOvziyF0zMlNrAmi84zx4I6buJRHr48yykQS3V9gVRa3B3
         xmk1y9RTZT97Or5/bNoLD6KB2aEYx5QKKUKVFAlkcyqD1bhjqUUTkpOm0hDf5NyUmFei
         gpH4ONWuxKPxxS/iu5MktOe3dOKWH2/VuD2JqwWr/Vh+JJBW/jxpZNOfM/n+IiKr2emV
         3t459QX0VGshbHNoFlV/dGz8fiwJLVa8a6GTC1fZLadFJtUtDccmvtJ5GzgTpU8YLp+4
         F25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zGtrkPwQHWrCekYK5dUaegAtQMN8QZalOj8VmvHgaA4=;
        b=sSR5wPfKO+PBjJILrbFfFr01vY/JXvwwHPw7A2fnd+IQJNNyXA1CR+kPtwbiMrcWzf
         42O5U/wroID7uXor5irXwc7srxAHiQyU1+oBinaSlbNYSuDj0qpaamo4mCS5xRA9AS8T
         ut21LiUKRWdcB62DIWz1FUd5MIzO1PmJ/K8AooJjW1Qn/55ehPYECbSQel37mP7vdncX
         tz/VTsqIdpv7xagxeFqXNl7J1NQergqoaFYIkkSuGneyIVUSEBwCwpRuX2lH4ekGwyXD
         Hc7HjFNppWGvgA6yppGyEEUkLtjvdzIf5aiLgenWFeUuXtkfSyFBL5UH/SDMatbzplYb
         JQxg==
X-Gm-Message-State: AOAM532i1kEXxTdACz9YIS0TkMNNpkj/4I51M1KRX3FnfRQju7QPF6WV
        SupFCK53ez8hxVoifE9jJwA4P/IwNpXpQcPtVnI=
X-Google-Smtp-Source: ABdhPJyxpKZoQ9j7S5fMNo0YLbXNEkvp8Z6oUPQNqDRsiML6KXD8ePD8vcex091bLfNnSXVS5/cUq0kqmWt5t5828xI=
X-Received: by 2002:a05:6602:2e87:: with SMTP id m7mr14643455iow.203.1591979673042;
 Fri, 12 Jun 2020 09:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200611054454.2547-1-kdasu.kdev@gmail.com> <20200611054454.2547-2-kdasu.kdev@gmail.com>
 <20200611092707.75da8c6a@xps13> <CAC=U0a3RXScu12LkU+hCv_5Lp_he92ExRFSgqLkwx40D6Xtrag@mail.gmail.com>
 <20200612090728.043b6baf@xps13>
In-Reply-To: <20200612090728.043b6baf@xps13>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Fri, 12 Jun 2020 12:34:22 -0400
Message-ID: <CAC=U0a1oLPs_=SgUTxYPxiW8JpQXOpz-RbL2KrgzDjutt1v0mQ@mail.gmail.com>
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

On Fri, Jun 12, 2020 at 3:07 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Kamal,
>
> Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 12:04:29
> -0400:
>
> > On Thu, Jun 11, 2020 at 3:27 AM Miquel Raynal <miquel.raynal@bootlin.co=
m> wrote:
> > >
> > > Hi Kamal,
> > >
> > > Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 01:44:54
> > > -0400:
> > >
> > > > Implemented ECC correctable and uncorrectable error handling for ED=
U
> > >
> > > Implement?
> > >
> > > > reads. If ECC correctable bitflips are encountered  on EDU transfer=
,
> > >
> > > extra space                                         ^
> > >
> > > > read page again using pio, This is needed due to a controller lmita=
tion
> > >
> > > s/pio/PIO/
> > >
> > > > where read and corrected data is not transferred to the DMA buffer =
on ECC
> > > > errors. This holds true for ECC correctable errors beyond set thres=
hold.
> > >
> > > error.
> > >
> > > Not sure what the last sentence means?
> > >
> >
> > NAND controller allows for setting a correctable  ECC threshold number
> > of bits beyond which it will actually report the error to the driver.
> > e.g. for BCH-4 the threshold is 3, so 3-bit and 4-bit errors will
> > generate correctable ECC interrupt however 1-bit and 2-bit errors will
> > be corrected silently.
> > From the above example EDU hardware will not transfer corrected data
> > to the DMA buffer for 3-bit and 4-bit errors that get reported. So
> > once we detect
> > the error duing EDU we read the page again using pio.
>
> Ok I see what you mean, can't you fake the threshold instead? The NAND
> controller in Linux is not supposed to handle this threshold, the NAND
> core is in charge. So what the controller driver should do is just:
> increase the number of bitflips + return the maximum number or bitflip
> or increase the failure counter. Is this already the case?
>
/* threshold =3D ceil(BCH-level * 0.75) */
brcmnand_wr_corr_thresh(host, DIV_ROUND_UP(chip->ecc.strength * 3, 4));
This how the threshold is set, all it means is that for high BCH
levels don't interrupt on low number (less than threshold) of
bit_flips. Yes the controller driver only increments correctable ECC
count. But due the EDU design an EDU operation is disrupted when the
controller interrupts on correctable ECC errors during subpage ECC
calculations. Hence the driver needs to read the page again with PIO
to transfer corrected data.

> >
> > > >
> > > > Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash=
-edu for dma transfers")
> > > > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > > > ---
> > >
> > > Minor nits below :)
> > >
> > > >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 26 ++++++++++++++++++++=
++++
> > > >  1 file changed, 26 insertions(+)
> > > >
> > > > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd=
/nand/raw/brcmnand/brcmnand.c
> > > > index 0c1d6e543586..d7daa83c8a58 100644
> > > > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > > @@ -1855,6 +1855,22 @@ static int brcmnand_edu_trans(struct brcmnan=
d_host *host, u64 addr, u32 *buf,
> > > >       edu_writel(ctrl, EDU_STOP, 0); /* force stop */
> > > >       edu_readl(ctrl, EDU_STOP);
> > > >
> > > > +     if (ret =3D=3D 0 && edu_cmd =3D=3D EDU_CMD_READ) {
> > >
> > > !ret
> > >
> > > > +             u64 err_addr =3D 0;
> > > > +
> > > > +             /*
> > > > +              * check for ecc errors here, subpage ecc erros are
> > > > +              * retained in ecc error addr register
> > >
> > > s/ecc/ECC/
> > > s/erros/errors/
> > > s/addr/address/
> > >
> > > > +              */
> > > > +             err_addr =3D brcmnand_get_uncorrecc_addr(ctrl);
> > > > +             if (!err_addr) {
> > > > +                     err_addr =3D brcmnand_get_correcc_addr(ctrl);
> > > > +                     if (err_addr)
> > > > +                             ret =3D -EUCLEAN;
> > > > +             } else
> > > > +                     ret =3D -EBADMSG;
> > >
> > > I don't like very much to see these values being used within NAND
> > > controller drivers but I see it's already the cause, so I guess I can
>
> s/cause/case/
>
> > > live with that.
> > >
> > > > +     }
> > > > +
> > > >       return ret;
> > > >  }
> > > >
> > > > @@ -2058,6 +2074,7 @@ static int brcmnand_read(struct mtd_info *mtd=
, struct nand_chip *chip,
> > > >       u64 err_addr =3D 0;
> > > >       int err;
> > > >       bool retry =3D true;
> > > > +     bool edu_read =3D false;
> > > >
> > > >       dev_dbg(ctrl->dev, "read %llx -> %p\n", (unsigned long long)a=
ddr, buf);
> > > >
> > > > @@ -2075,6 +2092,10 @@ static int brcmnand_read(struct mtd_info *mt=
d, struct nand_chip *chip,
> > > >                       else
> > > >                               return -EIO;
> > > >               }
> > > > +
> > > > +             if (has_edu(ctrl))
> > > > +                     edu_read =3D true;
> > >
> > > You don't need this extra value, you already have the cmd parameter
> > > which tells you if it is a read or a write. You might even want to
> > > create a if block so set dir and edu_cmd and eventually a local
> > > edu_read if you think it still makes sense.
> > >
> >
> > I needed the value since dma and edu read has multiple conditions like
> > oob is not included, buffer is aligned, virtual address is good. This
> > indicates to
> > the if (mtd_is_bitflip(err))  block that the error was from an edu
> > transaction that happened.This way all ecc error handling for dma,
> > edu, pio is in one place.
> > Also there is more controller version specific logic for read error
> > handling in there and this allows us to maintain the hierarchy how we
> > handle both correctable
> > and uncorrectable error.
>
> Fair enough.
>
> >
> > > > +
> > > >       } else {
> > > >               if (oob)
> > > >                       memset(oob, 0x99, mtd->oobsize);
> > > > @@ -2122,6 +2143,11 @@ static int brcmnand_read(struct mtd_info *mt=
d, struct nand_chip *chip,
> > > >       if (mtd_is_bitflip(err)) {
> > > >               unsigned int corrected =3D brcmnand_count_corrected(c=
trl);
> > > >
> > > > +             /* in case of edu correctable error we read again usi=
ng pio */
> > >
> > > s/edu/EDU/ ?
> > > s/pio/PIO/
> > >
> > > > +             if (edu_read)
> > > > +                     err =3D brcmnand_read_by_pio(mtd, chip, addr,=
 trans, buf,
> > > > +                                                oob, &err_addr);
> > > > +
> > > >               dev_dbg(ctrl->dev, "corrected error at 0x%llx\n",
> > > >                       (unsigned long long)err_addr);
> > > >               mtd->ecc_stats.corrected +=3D corrected;
> > >
> >
> > Will fix all the other typos.
> >
> > > Thanks,
> > > Miqu=C3=A8l
> >
> > Thanks
> > Kamal
>
>
> Thanks,
> Miqu=C3=A8l
