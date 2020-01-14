Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58037C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399BA24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgANSDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:03:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:37782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANSDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:03:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6D55DADF1;
        Tue, 14 Jan 2020 18:03:37 +0000 (UTC)
Message-ID: <df7b8b1e2f411660cf2012bd86513491c9b5bf53.camel@suse.de>
Subject: Re: [PATCH] arm64: defconfig: Enable Boradcom's GENET Ethernet
 controller
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 14 Jan 2020 19:03:36 +0100
In-Reply-To: <a10b3e49-9c4f-5124-9e25-ef1482681287@gmail.com>
References: <20200114164900.27483-1-nsaenzjulienne@suse.de>
         <a10b3e49-9c4f-5124-9e25-ef1482681287@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-NnY7PP2kYYNNjACY7ulI"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NnY7PP2kYYNNjACY7ulI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-14 at 09:20 -0800, Florian Fainelli wrote:
> On 1/14/20 8:48 AM, Nicolas Saenz Julienne wrote:
> > Currently used on the Raspberry Pi 4.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> Typo in the subject: s/Boradcom/Broadcom/ other than that

Ouch, my bad.

> do you want me to pick that up now for 5.6?

Yes please. BTW sorry for the late submission, but I just realized we were
missing the config option. All the genet related code is already in place s=
o
it's a shame it doesn't work out of the box.

Regards,
Nicolas

>=20
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index 38b4f998e24a..245d52a4d009 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -256,6 +256,7 @@ CONFIG_VIRTIO_NET=3Dy
> >  CONFIG_AMD_XGBE=3Dy
> >  CONFIG_NET_XGENE=3Dy
> >  CONFIG_ATL1C=3Dm
> > +CONFIG_BCMGENET=3Dm
> >  CONFIG_BNX2X=3Dm
> >  CONFIG_MACB=3Dy
> >  CONFIG_THUNDER_NIC_PF=3Dy
> >=20
>=20
>=20


--=-NnY7PP2kYYNNjACY7ulI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4eAngACgkQlfZmHno8
x/6niwf+IPx+6hb5KZBUiJdysfp4ZFwwt6Xf8WdwLblNLxh4s4fFNinSMScIGe/7
dfM3l6wUpLrt+LT3elyfA0hK6qHlvinhXg939aGND4tTulzB5sPd+QgrWn+gO8c1
mxktOwhk0srMcuuDoBpEdfJ4Gro38J7LIznkRtGCiP4seFrOsPIieqvagoq/9blI
Zv9MMZvZiesdxY227Chgc3wjv2zhYD0KQ7c1mt/QwZzWpvXXmK3vh5XuGCMSdH/M
91VoVtpdr3mkWqe2/5lNmf1WdyTpaNKGxbx0g7TI38SGARUZwzF5IMkXiSTysCqt
tVMp2y8t64U6ONH8pvMx5+NXHWeOaw==
=aFRM
-----END PGP SIGNATURE-----

--=-NnY7PP2kYYNNjACY7ulI--

