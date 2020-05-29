Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A70C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A31720776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EXGnSgfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgE2PiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgE2PiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:38:14 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93548C08C5C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:38:14 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g34so945836uah.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GHRa10u7oS+985JdG3r13wXGy+KoMCxBZOBtMkLgO5w=;
        b=EXGnSgfAZgMSOPLDsgH6z5alUcJbMuuWJR2nK38GGilVPHRIhMh3ruWLUzVdrkw9Tk
         UuNffrIsHiJLTgYvAW67yY/cGM8h38MsBMM4PfxkNNhuYkliLnML+JUPnO1U4G7wMuMu
         XckNK2FkI/9EjnWpAg3Pg7aVM5UydpT66ZxwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GHRa10u7oS+985JdG3r13wXGy+KoMCxBZOBtMkLgO5w=;
        b=uHyp8FhqSvNbLxwdouw93jltwELEl4PPftVNuy2hsmECuxJe24vPBV7oOXVeWuxB/A
         V0r36VIYUXRZZDwDO646Ja+bk6tdmLBpOxfflKvsfSdlhGA2QMO5uYMWOmN0rRxpPJS6
         lLa7OUjLhCHOU5AuQptIkcOtceUMABc37D8tMCEGq7XxHpEFP59pBu9om2X0r506+AlD
         1m3NhfceOl3sNklvj3c/7CHS/8CuVmA0skTfNp9RCO3M/xoffyyQfVT772b8sMmCnye1
         tHP8JfBqOt0L1gKoq9v7zdk9iIKf6Y2xAildRiqoCa9kEvt5jjtl7RQ50huf34ja4xTk
         LceQ==
X-Gm-Message-State: AOAM533aOYODbsbH0OOh66+AogRYcWOUMcHpLT4uRBhSg7PwM7fTrqmw
        vqERxU+3tzBhqacM7Ch4CxHe4n4EsPY=
X-Google-Smtp-Source: ABdhPJyGfpYeN4siAoAQLlRJO7SmCthXnJo+X4QYhMtwqBh6z7t0QdFxO7I4bZ0if0KjyBy79RXjxw==
X-Received: by 2002:ab0:3356:: with SMTP id h22mr6519842uap.51.1590766693012;
        Fri, 29 May 2020 08:38:13 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id k16sm978100vsp.12.2020.05.29.08.38.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 08:38:12 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id c1so1716182vsc.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:38:11 -0700 (PDT)
X-Received: by 2002:a67:e884:: with SMTP id x4mr6330934vsn.106.1590766691432;
 Fri, 29 May 2020 08:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200528151912.1.Id689a39ce8d1ec6f29f4287277ad977ff4f57d7d@changeid>
 <c628b545-f883-3c2e-cabf-944f6a313bf2@molgen.mpg.de>
In-Reply-To: <c628b545-f883-3c2e-cabf-944f6a313bf2@molgen.mpg.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 29 May 2020 08:37:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XwQ9jo4kCFeunvBed2r1m0u-0-sKozhpmU6sbpYEotDA@mail.gmail.com>
Message-ID: <CAD=FV=XwQ9jo4kCFeunvBed2r1m0u-0-sKozhpmU6sbpYEotDA@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis_spi: Don't send anything during flow control
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 29, 2020 at 1:33 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Douglas,
>
>
> Thank you for the patch.
>
> Am 29.05.20 um 00:19 schrieb Douglas Anderson:
> > During flow control we are just reading from the TPM, yet our spi_xfer
> > has the tx_buf and rx_buf both non-NULL which means we're requesting a
> > full duplex transfer.
> >
> > SPI is always somewhat of a full duplex protocol anyway and in theory
> > the other side shouldn't really be looking at what we're sending it
> > during flow control, but it's still a bit ugly to be sending some
> > "random" data when we shouldn't.
> >
> > The default tpm_tis_spi_flow_control() tries to address this by
> > setting 'phy->iobuf[0] =3D 0'.  This partially avoids the problem of
> > sending "random" data, but since our tx_buf and rx_buf both point to
> > the same place I believe there is the potential of us sending the
> > TPM's previous byte back to it if we hit the retry loop.
> >
> > Another flow control implementation, cr50_spi_flow_control(), doesn't
> > address this at all.
> >
> > Let's clean this up and just make the tx_buf NULL before we call
> > flow_control().  Not only does this ensure that we're not sending any
> > "random" bytes but it also possibly could make the SPI controller
> > behave in a slightly more optimal way.
> >
> > NOTE: no actual observed problems are fixed by this patch--it's was
> > just made based on code inspection.
>
> s/it's was/it was/

I'll assume this is easier to get fixed up when applying the patch,
but happy to send a v2 if requested.


> Were you able to test this? Maybe in the =E2=80=9CChromebook QA arsenal=
=E2=80=9D? Are
> you already running it in production on Google Chrome OS devices?

I've tested it locally but not much more than that.  As far as I can
tell it doesn't break anything or fix anything but still seems like a
good change to make.  ;-)

Generally Chrome OS tries to work with an "upstream first" philosophy.
That has lots of benefits, but one downside is it means that patches
get sent upstream before they've actually landed anywhere.  That being
said, even if we landed this today we'd get limited testing because of
the Chrome OS kernel trees only the Chrome OS 5.4 tree uses the
upstream driver for Cr50 (the one SPI-connected security chip that
Chromebooks use).  Cr50 originally did not get developed as "upstream
first", so all the old codebases have the old downstream driver.  This
problem doesn't affect the old downstream driver which had its own
"struct spi_transfer".  If anything it makes the upstream code behave
more like the old downstream driver.  If you want to see the old
downstream driver:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-=
4.19/drivers/char/tpm/cr50_spi.c#172


Another note is that I don't have access to any SPI-connected chips
that are _not_ Cr50.  That means that half of this change is totally
untested but looks sane.  If anyone can test it that'd be great.  :-)


> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >   drivers/char/tpm/tpm_tis_spi_main.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm=
_tis_spi_main.c
> > index d96755935529..8d2c581a93c6 100644
> > --- a/drivers/char/tpm/tpm_tis_spi_main.c
> > +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> > @@ -53,8 +53,6 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_sp=
i_phy *phy,
> >
> >       if ((phy->iobuf[3] & 0x01) =3D=3D 0) {
> >               // handle SPI wait states
> > -             phy->iobuf[0] =3D 0;
> > -
> >               for (i =3D 0; i < TPM_RETRY; i++) {
> >                       spi_xfer->len =3D 1;
> >                       spi_message_init(&m);
> > @@ -104,6 +102,8 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data,=
 u32 addr, u16 len,
> >               if (ret < 0)
> >                       goto exit;
> >
> > +             /* Flow control transfers are receive only */
> > +             spi_xfer.tx_buf =3D NULL;
> >               ret =3D phy->flow_control(phy, &spi_xfer);
> >               if (ret < 0)
> >                       goto exit;
> > @@ -113,9 +113,8 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data,=
 u32 addr, u16 len,
> >               spi_xfer.delay.value =3D 5;
> >               spi_xfer.delay.unit =3D SPI_DELAY_UNIT_USECS;
> >
> > -             if (in) {
> > -                     spi_xfer.tx_buf =3D NULL;
> > -             } else if (out) {
> > +             if (out) {
> > +                     spi_xfer.tx_buf =3D phy->iobuf;
> >                       spi_xfer.rx_buf =3D NULL;
> >                       memcpy(phy->iobuf, out, transfer_len);
> >                       out +=3D transfer_len;
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks for reviewing!  :-)

-Doug
