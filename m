Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5FDCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35624206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbgEMM4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:56:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:33650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733110AbgEMM4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:56:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EB7FAAD08;
        Wed, 13 May 2020 12:56:31 +0000 (UTC)
Message-ID: <87d71fa371739486a19f17a6b3ca72d2315220d2.camel@suse.de>
Subject: Re: [PATCH v3 0/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     mbrugger@suse.com, u-boot@lists.denx.de, bmeng.cn@gmail.com,
        marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl
Date:   Wed, 13 May 2020 14:56:27 +0200
In-Reply-To: <20200505162607.334-1-nsaenzjulienne@suse.de>
References: <20200505162607.334-1-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zJ6m1nQczXy6DejoCnBn"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zJ6m1nQczXy6DejoCnBn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-05-05 at 18:26 +0200, Nicolas Saenz Julienne wrote:
> Newer revisions of the RPi4 need their xHCI chip, VL805, firmware to be
> loaded explicitly. Earlier versions didn't need that as they where using
> an EEPROM for that purpose. This series takes care of setting up the
> relevant infrastructure and run the firmware loading routine at the
> right moment.
>=20
> Note that this builds on top of Sylwester Nawrocki's "USB host support
> for Raspberry Pi 4 board" series.
>=20
> ---

Just for the record, here's the version of this in the Linux Kernel:
https://patchwork.kernel.org/cover/11529585/

Regards,
Nicolas


--=-zJ6m1nQczXy6DejoCnBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl677nsACgkQlfZmHno8
x/4lwgf/az8ddaA++TvpX2NQkZGoTV4ECgURLlQzVVNgRpdiDSad2Dq0OMhJoUIS
DSUgQOnYDBQGMkOPlhEMV/vsNtno+RvAenDdkBrFr5Y5rUtd5cFkcOkaUagw4+jP
gFQluOKw3MyAhFlgQRZhlSTS9fihdmxlLZEosnS33gcyuS1SJnmyL2YL0NiP9aHG
9VdyqXirGnrwPJXnBkEoAyHKchhriGj7hvfUZI2Yxp3Z1xEwSttz+KZy5VCFx+nr
TaFhC35xIxEpkTY8mIxb+UcQfESD+Q1lDDcEiztuOH+PZJLuOO8jFymrTS7BsW6+
fzTkDmCMuoKPZf1m9rddp1pO+VcMww==
=1fCZ
-----END PGP SIGNATURE-----

--=-zJ6m1nQczXy6DejoCnBn--

