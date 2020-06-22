Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F6AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D6820716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2pyWuv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgFVQCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:02:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50099 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729804AbgFVQCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592841749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCUVrs1HEs3cDPWkLQt5NRK2RuPmGi2jCX5YSWGwgt0=;
        b=Y2pyWuv8y4y7DeesnEqg7rKrbZKyH9m272EQxEqiPQfROE4uMNamvvzdiNs/Zeo9JeK3Qh
        3gQ69RaReqRd+/Vueo4xbLXOj7nBXvIvcFGdO7QxZHcoKQ1PgIm7GJ5hTGEq/bZjHu0Nlk
        dX7FNygXPLIY7kqts+82e48dJOlvaKo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-UU-l60LuMMe5-s72qaE3Bw-1; Mon, 22 Jun 2020 12:02:23 -0400
X-MC-Unique: UU-l60LuMMe5-s72qaE3Bw-1
Received: by mail-wr1-f69.google.com with SMTP id d6so11097826wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XCUVrs1HEs3cDPWkLQt5NRK2RuPmGi2jCX5YSWGwgt0=;
        b=cqjKNxNPhD3MQw7Ab1AlI0ihjVE++WMH6akWzAsB8c2W1em3zxFuWoK53TVvUWNINU
         r2Fil3YBFhZWEjPRJaDs7hlf9w3D81wPr0OXx3vLwhSJ/9HxNHoGZe3MuDVgNbT0xzJE
         wgkdpfTy1vJGlqpiCWyFUJ3HmadkIJlaVg5BUqXIFB+V0A8RSZxLKTKqToNErhjCW3XH
         qS3+uWn8+e6yWWxwDryGFPAjSM3KDjkrGFBqxa+9pHD/1SwxNsKqv1Z7wkwMfcoRZt3F
         TiGfhnqjd1tzn2BIlCIbO+JKXK54Heb0a0V19etpsgp08b+tCWdi+tDbToLxtnLV3niV
         3hvQ==
X-Gm-Message-State: AOAM531zA1Wl+Tj+uzahnhlk2OSdIpOWkIH0YDAuKkZnWPmzSG6PmrO5
        0NBPhp6hS9cgGXi6d1qkPF3uQ0ZvLIFiV1Uu9lBidzocuztCvx2csJPVhX2Xv1Itay9ohFSsque
        QDq/ePMAUxoyuKRRGaRy4h/J0
X-Received: by 2002:a5d:698e:: with SMTP id g14mr21196192wru.301.1592841741813;
        Mon, 22 Jun 2020 09:02:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7AC2zXM9wMhdUYjep6D0hT7FOv+53GJXD/KBgo/7Gd1G2Y6F8d5neAkpIP+MhZ51pJS/Z0w==
X-Received: by 2002:a5d:698e:: with SMTP id g14mr21196154wru.301.1592841741539;
        Mon, 22 Jun 2020 09:02:21 -0700 (PDT)
Received: from localhost ([151.48.138.186])
        by smtp.gmail.com with ESMTPSA id q128sm17358370wma.38.2020.06.22.09.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 09:02:20 -0700 (PDT)
Date:   Mon, 22 Jun 2020 18:02:17 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: mt7612 suspend/resume issue
Message-ID: <20200622160217.GD27892@localhost.localdomain>
References: <20200618090556.pepjdbnba2gqzcbe@butterfly.localdomain>
 <20200618111859.GC698688@lore-desk.lan>
 <20200619150132.2zrc3ojqhtbn432u@butterfly.localdomain>
 <20200621205412.GB271428@localhost.localdomain>
 <CAHcwAbR4govGK3RPyfKWRgFRhFanWtpJLrB_PEjcoiBDJ3_Adg@mail.gmail.com>
 <20200622145338.GB27892@localhost.localdomain>
 <CAHcwAbR1W_aOaozr=m48UCWKPr1m71bk-c+kwkGd6A2GTLGF6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <CAHcwAbR1W_aOaozr=m48UCWKPr1m71bk-c+kwkGd6A2GTLGF6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Jun 22, 2020 at 4:53 PM Lorenzo Bianconi
> <lorenzo.bianconi@redhat.com> wrote:
> > > On Sun, Jun 21, 2020 at 10:54 PM Lorenzo Bianconi <lorenzo@kernel.org=
> wrote:
> > > > > > +static int __maybe_unused
> > > > > > +mt76x2e_suspend(struct pci_dev *pdev, pm_message_t state)
> > > > > > +{
> > > > > > +   struct mt76_dev *mdev =3D pci_get_drvdata(pdev);
> > > > > > +   struct mt76x02_dev *dev =3D container_of(mdev, struct mt76x=
02_dev, mt76);
> > > > > > +   int i, err;
> > > >
> > > > can you please double-check what is the PCI state requested during =
suspend?
> > >
> > > Do you mean ACPI S3 (this is the state the system enters)?  If not,
> > > what should I check and where?
> >
> > yes, right. Just for debugging, can you please force the card in PCI_D0=
 during the
> > suspend?
>=20
> Do you want me to do this:
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
> b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
> index 5543e242fb9b..e558342cce03 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
> @@ -119,9 +119,8 @@ mt76x2e_suspend(struct pci_dev *pdev, pm_message_t st=
ate)
>=20
>      mt76x02_dma_reset(dev);
>=20
> -    pci_enable_wake(pdev, pci_choose_state(pdev, state), true);
>      pci_save_state(pdev);
> -    err =3D pci_set_power_state(pdev, pci_choose_state(pdev, state));
> +    err =3D pci_set_power_state(pdev, PCI_D0);
>      if (err)
>          goto restore;

I think you can just substitute pci_choose_state(pdev, state) with PCI_D0, =
not
removing pci_enable_wake()

Regards,
Lorenzo

>=20
> ?
>=20
> --=20
>   Best regards,
>     Oleksandr Natalenko (post-factum)
>     Principal Software Maintenance Engineer
>=20

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXvDWBwAKCRA6cBh0uS2t
rNHqAP9TnaCtdI/P+S0pzYktL3HWcUDwojePvhLOFUPT9cUTIQEAz0LLtfRL8dJ+
nzlc0/5SI1eF0RoUKiJLONdzkKKyiA8=
=rs8D
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--

