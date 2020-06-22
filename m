Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D3DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D280020732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bp3xnSlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgFVOxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:53:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53314 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729180AbgFVOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592837627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P7taa7KigpgUZeLwSBQmyXWitMWaWACRV2B/k/C5al0=;
        b=bp3xnSlh++41yORb8vzP1kvVb6Ul1HP3QnFrvtRdbcRc4hFu/1SCZ0CGEs1I7YVbGTzDjR
        Qwf6ILILnlK1oZszTC+yeb0eTW6HGdjQvHVTpi7X5xc8fswcxGBBYG6fwzsrQNekIKB+HF
        xEFP8MGsyPf9zJaDIzZTWIo47gej+30=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-pDEtJsRNOqmrFHw1EfO52A-1; Mon, 22 Jun 2020 10:53:43 -0400
X-MC-Unique: pDEtJsRNOqmrFHw1EfO52A-1
Received: by mail-wr1-f70.google.com with SMTP id i10so7006778wrn.21
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P7taa7KigpgUZeLwSBQmyXWitMWaWACRV2B/k/C5al0=;
        b=UjtBXrM4BMLTAG7cyj7MXlXYMq8Fhe4+LKEqD9uiK0JYQQz3fzd5MkYvIp/+ow9Y/X
         kjNHDXPS0jIQVcRzQz2bilMvKIz5dmAPFze0RoMcWIW0Juto2m/lfXnFO/5/gjQK2GrS
         n0I6tXJDmJkK9FGO5+w2TP1nSdNdvsurmZTPqpwZyRPdihrfsXUa45maX4qXGbo3eMSr
         YCVJx3+X4RJKcPtcjLZedtkPpVOd08DrtsRaltmNQ54CpPjf+aJsq67CfOFDSbbKvI9i
         HmRhA9eO94GOjQJ4EbMTUo7IYxcNYjRogLERIMxdf0A6Y/KvRH4sK+cIWjMQ7xhLbGkw
         WAhw==
X-Gm-Message-State: AOAM533pGuZUqKWaXJ84WoF1ddUvS6kFaYdyYNBrtPeEueSsSs6QMMxn
        MO95ZbTgGqK1kMrXaEJWn5XBnthN8kgpL3/R7vfUQQ/hKx+VirJSiUSBZqYZoTJ3csfp/Uns/75
        a7vMQb8YJRHUIYfMuOnYOqxfW
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr5512123wru.22.1592837622435;
        Mon, 22 Jun 2020 07:53:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUuKsQy1lYYQH5S5wcZD53SekQyD8JGsIHp4PC0g4E/zNEVCx/JYFP61TwuMuJ4vKGweBlJw==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr5512094wru.22.1592837622169;
        Mon, 22 Jun 2020 07:53:42 -0700 (PDT)
Received: from localhost ([151.48.138.186])
        by smtp.gmail.com with ESMTPSA id e25sm19318997wrc.69.2020.06.22.07.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 07:53:41 -0700 (PDT)
Date:   Mon, 22 Jun 2020 16:53:38 +0200
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
Message-ID: <20200622145338.GB27892@localhost.localdomain>
References: <20200618090556.pepjdbnba2gqzcbe@butterfly.localdomain>
 <20200618111859.GC698688@lore-desk.lan>
 <20200619150132.2zrc3ojqhtbn432u@butterfly.localdomain>
 <20200621205412.GB271428@localhost.localdomain>
 <CAHcwAbR4govGK3RPyfKWRgFRhFanWtpJLrB_PEjcoiBDJ3_Adg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <CAHcwAbR4govGK3RPyfKWRgFRhFanWtpJLrB_PEjcoiBDJ3_Adg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello, Lorenzo.
>=20
> On Sun, Jun 21, 2020 at 10:54 PM Lorenzo Bianconi <lorenzo@kernel.org> wr=
ote:
> > > > +static int __maybe_unused
> > > > +mt76x2e_suspend(struct pci_dev *pdev, pm_message_t state)
> > > > +{
> > > > +   struct mt76_dev *mdev =3D pci_get_drvdata(pdev);
> > > > +   struct mt76x02_dev *dev =3D container_of(mdev, struct mt76x02_d=
ev, mt76);
> > > > +   int i, err;
> >
> > can you please double-check what is the PCI state requested during susp=
end?
>=20
> Do you mean ACPI S3 (this is the state the system enters)?  If not,
> what should I check and where?

yes, right. Just for debugging, can you please force the card in PCI_D0 dur=
ing the
suspend?

Regards,
Lorenzo

>=20
> Thanks.
>=20
> --=20
>   Best regards,
>     Oleksandr Natalenko (post-factum)
>     Principal Software Maintenance Engineer
>=20

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXvDF7wAKCRA6cBh0uS2t
rJ4uAP9lKuUy0QTisY2SFP33vemkDckUeiQV2JsSGBnBdJ4FIQD/Yo4wkX1kg1Dr
YM/2gw/OmT+M00BF1XWr3MJF0Tx7sQo=
=rEPw
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--

