Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0452CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C718F206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tmsp.io header.i=dorian.stoll@tmsp.io header.b="RHOZqAXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgFARZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:25:54 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21440 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgFARZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:25:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591032343; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=HiLwFlw4OqVyekTVq3ZhHe3KuTL0uZYjx9ef26M0GCrGVP81FaAEpGrpcQ4p73mZFuCJZo3TeR5kWCs5OOpBPkhhmwsrkFbcZNTdYhEGkQcRysDm7gcFGBQ7adxN5r/ALH1sfVaFwMzJy/nt6/c3J3MPER2exfwktaPriMKbpw4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1591032343; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vlBnbImMvoxRoGhW9EeU6cOKLTdoxD1IEu+LeomI8b4=; 
        b=KmDyYDz4OG6SzpwAv/M8JfwfeneR1bkFJMbgTSuPTSK8vmMExcmj+vMEGX1hWAwYGuo/PQSppeDxLUjbcxcooL7Bj+5wwxQQDpUQG1vYYKdxvb5z8i2l5u4T3f3sPG6T63U4wVlq9J+PLUiokYb3hO5GSyKlMoi0ogAj+Iy4eqk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=tmsp.io;
        spf=pass  smtp.mailfrom=dorian.stoll@tmsp.io;
        dmarc=pass header.from=<dorian.stoll@tmsp.io> header.from=<dorian.stoll@tmsp.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591032343;
        s=zoho; d=tmsp.io; i=dorian.stoll@tmsp.io;
        h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type;
        bh=vlBnbImMvoxRoGhW9EeU6cOKLTdoxD1IEu+LeomI8b4=;
        b=RHOZqAXqghC3Y/I8dUS+TcKfjI0L5vrJynpzDOHdGNTxtnLxflM7sHjC2M9Pf6OO
        EAlsP4IBmeqfLcdIZxikN8TYqx9d94Op8AE5x88BYPaCVih6eWHh1XyetFsYvYRzzI0
        VWTNgpMR1ypg7uzpt6t98aP9Xj9c5aKo08o4hxAs=
Received: from desktop.localnet (79.140.114.1 [79.140.114.1]) by mx.zohomail.com
        with SMTPS id 1591032340881666.4112610781169; Mon, 1 Jun 2020 10:25:40 -0700 (PDT)
From:   Dorian Stoll <dorian.stoll@tmsp.io>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mei: me: Add itouch device IDs for SPT / ICP
Date:   Mon, 01 Jun 2020 19:24:13 +0200
Message-ID: <4082996.zthe6f22So@desktop>
In-Reply-To: <b22a353f4d4f47df9676c9572b6ac773@intel.com>
References: <20200601155954.764558-1-dorian.stoll@tmsp.io> <b22a353f4d4f47df9676c9572b6ac773@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2678332.PafoQRUqbn"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2678332.PafoQRUqbn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> 
> > These device IDs can be found on Microsoft Surface devices.
> > 
> > Signed-off-by: Dorian Stoll <dorian.stoll@tmsp.io>
> 
> This need to be done differently because of the server platforms conflict.
> I have patches for that I will post short, though we are not officially supporting those devices under Linux, 
> It will be hard to maintain,  as currently on the MS surface enables it as far as I know.
> 

Thank you for your response!

If you don't mind, could you elaborate on these devices not being supported
under Linux? Is it just that the functionality they provide
(Intel Precise Touch & Stylus / iTouch / IPTS) won't be supported? Because
that I already know, and it is not the intent of this patch. Or do you mean
that the entire MEI interface won't be supported for these devices?

Some context on this patch: I am part of a small team of volunteers who try
to make the MS Surface devices usable under linux, including the touchscreen
(which uses IPTS as of the Surface Pro 4).

The IPTS driver connects to the device over the MEI bus, but the MEI device
is provided by the iTouch devices. Currently we build our own kernels with
this patch applied to allow the driver to work. All of this is loosely based
on a driver that Intel published a few years ago.

Since the driver is otherwise pretty much standalone, my hope was that adding
these IDs would make it easier to develop / install our driver without having
to recompile the entire kernel (i.e. using DKMS). At least until the driver
has matured enough and is ready for upstream submission itself. Especially
since other iTouch devices have their device IDs added already.

That this would cause conflicts is unfortunate. Judging purely by your words
- without having any deeper knowledge about the MEI bus - it seems that it
might be possible to fix these conflicts? If thats true, I hope it would also
be possible to add these IDs, so that just the MEI interface to IPTS becomes
supported - I don't expect you to support the entire IPTS technology.

> > ---
> >  drivers/misc/mei/hw-me-regs.h | 2 ++
> >  drivers/misc/mei/pci-me.c     | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-
> > regs.h index 9392934e3a06..90e7d3020fa5 100644
> > --- a/drivers/misc/mei/hw-me-regs.h
> > +++ b/drivers/misc/mei/hw-me-regs.h
> > @@ -59,6 +59,7 @@
> > 
> >  #define MEI_DEV_ID_SPT        0x9D3A  /* Sunrise Point */
> >  #define MEI_DEV_ID_SPT_2      0x9D3B  /* Sunrise Point 2 */
> > +#define MEI_DEV_ID_SPT_4      0x9D3E  /* Sunrise Point 4 (iTouch) */
> >  #define MEI_DEV_ID_SPT_H      0xA13A  /* Sunrise Point H */
> >  #define MEI_DEV_ID_SPT_H_2    0xA13B  /* Sunrise Point H 2 */
> > 
> > @@ -90,6 +91,7 @@
> >  #define MEI_DEV_ID_CDF        0x18D3  /* Cedar Fork */
> > 
> >  #define MEI_DEV_ID_ICP_LP     0x34E0  /* Ice Lake Point LP */
> > +#define MEI_DEV_ID_ICP_LP_4   0x34E4  /* Ice Lake Point LP 4 (iTouch) */
> > 
> >  #define MEI_DEV_ID_JSP_N      0x4DE0  /* Jasper Lake Point N */
> > 
> > diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c index
> > a1ed375fed37..5e621e90d8d4 100644
> > --- a/drivers/misc/mei/pci-me.c
> > +++ b/drivers/misc/mei/pci-me.c
> > @@ -68,6 +68,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
> > 
> >  	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT, MEI_ME_PCH8_CFG)},
> >  	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_2, MEI_ME_PCH8_CFG)},
> > +	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_4, MEI_ME_PCH8_CFG)},
> >  	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H, MEI_ME_PCH8_SPS_CFG)},
> >  	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H_2, MEI_ME_PCH8_SPS_CFG)},
> >  	{MEI_PCI_DEVICE(MEI_DEV_ID_LBG, MEI_ME_PCH12_SPS_CFG)},
> > @@ -94,6 +95,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
> >  	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_H_3, MEI_ME_PCH8_CFG)},
> > 
> >  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_LP, MEI_ME_PCH12_CFG)},
> > +	{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_LP_4, MEI_ME_PCH12_CFG)},
> > 
> >  	{MEI_PCI_DEVICE(MEI_DEV_ID_TGP_LP, MEI_ME_PCH15_CFG)},
> > 
> > --
> > 2.26.2
> > 
> 
> 


--nextPart2678332.PafoQRUqbn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE5GxxbvBMm/p0R1H88drNAsYZRCoFAl7VOb0ACgkQ8drNAsYZ
RCq72g/9HElOfF6SHD6dXOiDFq+HoYp8aLof0EAs57PeTCzhUNIceyL7k6+1GGH2
zgsEgR/Apx3EFTLSDgQ+v1W1pgm8fD4cQAzL+ejn0r6P9br/rwlFWzOMc8TFRhVV
zgKovWK3eSPh4rQNMKwyH8nd6WPehj01GV7jhZxZ+97DhRUA9YOvnTbm9BBxqezs
lccKVH13erBNpqIljaXf+TrhOyoj2EYISc8kPK+IX76URTaWzIzj37BF37COyNB9
hhrVk4ULkMj0shIbu1iKDM7vU8ZbUyabzwZ1TjlLyL+4r29QE4C6ZMn8JJJAPvkU
weI0HPAegXhU55d1FHDCwdcskT71TJ2R8SrRLLV4KeDHe2klVRke1SEZ6tix5YyF
oRYH6wsfPGcux6fEDKR2m/MCIgq8VVgs2X74mHN3NTGOVOx7Rtq1axo/swJpGQ3x
szfiaZRAArbLQYtS10NqfwMbTC5rTLKOe53D0HwOjeY4uBIsX1oMdx1wB4SHxJHs
SowEJ7MiV0iR7bzhscUZhwLtgmsg40u8vIqzhWzmDMbGk35pdke1Elhh9MOgJrEF
5NrBpv0oDWj4XyNvRoVkzRVoDtWx7VyfWgt3n4LrJI/j2md1hAeUGLKTNeGQm4UD
M/ii+ISoXfg8ePbdMJHn2L9j8eSe4hBzz76g4bQ3W7PzGBYdNlA=
=yCYS
-----END PGP SIGNATURE-----

--nextPart2678332.PafoQRUqbn--



