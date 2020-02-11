Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26843C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CA6206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="cTscvQdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgBKWVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:21:40 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:40828 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgBKWVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o/px/Cwkq5jYDnhxW4czK4w1OaP63S+evUJw3Wy8PH0=; b=cTscvQdc5myFTYFkGInrp+o/j
        1XaQFlnXbzhZ1GxD42SpREBuON3he14RsyXo1ZNvkLUME2fWVdYeBcydemFQh2/NvsfVdycvZys/K
        X7f5dxtIZ33X1k4GqbFgAVTMRyitC0bkfl3p9hh9jJaqexzRbNuPhlnQTqqUuoPDE9pUU=;
Received: from p200300ccff0bd500e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff0b:d500:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j1duU-0004jk-4P; Tue, 11 Feb 2020 23:21:38 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j1duT-00049m-JE; Tue, 11 Feb 2020 23:21:37 +0100
Date:   Tue, 11 Feb 2020 23:21:29 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: rn5t618: cleanup i2c_device_id
Message-ID: <20200211232129.0594d397@kemnade.info>
In-Reply-To: <20200130152428.GD3548@dell>
References: <20191211215731.19350-1-andreas@kemnade.info>
        <20200128194555.324cff21@kemnade.info>
        <20200130152428.GD3548@dell>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nxiL9CKKHkacqD+I6uRLg.G"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nxiL9CKKHkacqD+I6uRLg.G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jan 2020 15:24:28 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Tue, 28 Jan 2020, Andreas Kemnade wrote:
>=20
> > Hi,
> >=20
> > just re-checking the patch again. Seems that I have added it on top of =
my RTC
> > series. It breaks because of...
> >=20
> > On Wed, 11 Dec 2019 22:57:31 +0100
> > Andreas Kemnade <andreas@kemnade.info> wrote:
> >  =20
> > > That list was just empty, so it can be removed if .probe_new
> > > instead of .probe is used
> > >=20
> > > Suggested-by: Lee Jones <lee.jones@linaro.org>
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > >  drivers/mfd/rn5t618.c | 11 ++---------
> > >  1 file changed, 2 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> > > index 18d56a732b20..70d52b46ee8a 100644
> > > --- a/drivers/mfd/rn5t618.c
> > > +++ b/drivers/mfd/rn5t618.c
> > > @@ -150,8 +150,7 @@ static const struct of_device_id rn5t618_of_match=
[] =3D {
> > >  };
> > >  MODULE_DEVICE_TABLE(of, rn5t618_of_match);
> > > =20
> > > -static int rn5t618_i2c_probe(struct i2c_client *i2c,
> > > -			     const struct i2c_device_id *id)
> > > +static int rn5t618_i2c_probe(struct i2c_client *i2c)
> > >  {
> > >  	const struct of_device_id *of_id;
> > >  	struct rn5t618 *priv;
> > > @@ -251,11 +250,6 @@ static int __maybe_unused rn5t618_i2c_resume(str=
uct device *dev)
> > >  	return 0;
> > >  }
> > >   =20
> > I added the pm stuff above ...
> >=20
> >  =20
> > > -static const struct i2c_device_id rn5t618_i2c_id[] =3D {
> > > -	{ }
> > > -};
> > > -MODULE_DEVICE_TABLE(i2c, rn5t618_i2c_id);
> > > - =20
> >=20
> > and below it in my RTC series.
> >  =20
> > >  static SIMPLE_DEV_PM_OPS(rn5t618_i2c_dev_pm_ops,
> > >  			rn5t618_i2c_suspend,
> > >  			rn5t618_i2c_resume); =20
> >=20
> > Do you want to have it rebased so it can be applied first?
> > Sorry for the confusion here. =20
>=20
> You may as well wait until -rc1 is out and rebase on top of that.
>=20
hmm, then the RTC/IRQ series does not apply on top of it:
https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/

and needs to be rebased. I have no idea if that is more favorable for you.
The RTC/IRQ series happily applies on top of v5.6-rc1, but not on top of
this patch.

Yes, I should have documented that apply-conflict, but was
not aware of it while submitting this patch.

Regards,
Andreas

--Sig_/nxiL9CKKHkacqD+I6uRLg.G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl5DKOkACgkQl4jFM1s/
ye8T9g/+OCOYZG7WNDbF0krSdNmZ/vyPBoqmgkHFoWZ4iNnnSiLVW3XABkPWjbvG
cglCqYeBIrxYR6c/Am5GpAUkqRZiWizK77QHtrlb9dJIDb/GWoQ/IGYDJjr/MT3U
OUmoW9VEo03Ph/Yero3eTn7tkYusKQeBb8fc877VMVwTx/MsTC6/4iwqog0effZh
ot3g1J1RSzlshtqh26RNJADnPTEyqlEXsIer+aOn0SL/bAbukYvT2MZ8Ph4k4cEq
TRnJvQgJ3tYODhXroJhUiXUDjio2st7Nuf32BVZ2EXN9SPBS9ywpKpxpOBy+FrEC
TVGBg5LE2+HIL9kdZSB8GkAAlVKB9k/UAkzo7k6CM4UbYFcPD/oDdlJ0l3YFKIPD
zfZnV6LojCPopDyuoTZKfiqgX0NRF/RWTM2jyH/dB2rI5XikkHVyVu30QrgTlIj3
CkGLcL8v1z+rwPBnVwtWXynVaNi3EDSIhNHyMGKNQ5BMTXLcm0B6/iaVe3GcHj98
gQ0CBdVQH3f+0GsSo0N2W7YgiyHR0Bg/V2ZaT25rA9xb9Pn/13Tlow8dKSZ4AZhW
5/T7jmHXoOE4H3yKqmhuTMp1qH/5QXH5KU/xueoqXcerVs0NR6VCYPHhR0Zt1scP
X/Ygr6xBRmwxofCCoju2mOVI0gGk6txGiZfLoadhy5rAn4QOkkQ=
=4uhQ
-----END PGP SIGNATURE-----

--Sig_/nxiL9CKKHkacqD+I6uRLg.G--
