Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D1C3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81D7221F7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgDQSGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:06:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:33830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730236AbgDQSGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:06:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 89AABABD6;
        Fri, 17 Apr 2020 18:06:10 +0000 (UTC)
Message-ID: <500e8c46a9b411aed03965b6f9130ccde457193d.camel@suse.de>
Subject: Re: [PATCH v2 0/2] of: property: fw_devlink misc fixes
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     saravanak@google.com
Cc:     frowand.list@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Apr 2020 20:06:04 +0200
In-Reply-To: <20200417165442.1856-1-nsaenzjulienne@suse.de>
References: <20200417165442.1856-1-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-NXq2S/HrSFRiloiSwbjW"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NXq2S/HrSFRiloiSwbjW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Fri, 2020-04-17 at 18:54 +0200, Nicolas Saenz Julienne wrote:
> As I'm interested in using this feature to fine-tune Raspberry Pi 4's
> device probe dependencies, I tried to get the board to boot with
> fw_devlink=3Don. As of today's linux-next the board won't boot with that
> option. I tried to address the underlying issues.
>=20

On a semi-related topic, have you looked at vendor specific properties? mos=
t of
them create a consumer/supplier relationship, it'd be nice to be able to ta=
ke
those ones into account as well.

Regards,
Nicolas


--=-NXq2S/HrSFRiloiSwbjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6Z8AwACgkQlfZmHno8
x/7W4Af+L7+hPKqqXUkYFXjbuqmUF+sKSHVVRIXIsxSYit8z826zssjJ7Mg+nYKA
wWHS17cWFa9hM+ncxWwq5sRFPPjVP/+u0nTPWOANTWzUxCz8rFkej89KC+W4V6sm
A5ccmxsUz/6uXTaMwCca0h5Z9tklUdNFSCAMTGvOCmaIRt/kW/7bbV0ISVRNVkMl
1iz6zSZI99s0mLyzEJRGB67bq0uRZxAF49/CUeybCUupRh172CX90MydlAo97Qrf
a2WODZVjRyb4y4W6LLwZZaqnMgosP4CgMzoBi1K68ZopU9aNigjY7e2vyrWQ+RHc
VEmwjwpWi00cCNzqlIdIOZi6S+8Rig==
=DXai
-----END PGP SIGNATURE-----

--=-NXq2S/HrSFRiloiSwbjW--

