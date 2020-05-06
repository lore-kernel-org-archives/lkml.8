Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF680C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D783820714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgEFIb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:31:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:39174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbgEFIbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:31:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 56620AC4A;
        Wed,  6 May 2020 08:31:56 +0000 (UTC)
Message-ID: <f162c378380dc4b1bd2af24b44b30082b6e1e310.camel@suse.de>
Subject: Re: [PATCH v3 1/2] arm: rpi: Add function to trigger VL805's
 firmware load
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     mbrugger@suse.com, U-Boot Mailing List <u-boot@lists.denx.de>,
        Marek Vasut <marex@denx.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Simon Glass <sjg@chromium.org>, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        mark.kettenis@xs4all.nl
Date:   Wed, 06 May 2020 10:31:51 +0200
In-Reply-To: <CAEUhbmWOQNDeStd3oDFTveiugzDG0zf0X1ybSWeCSP4QStNcPA@mail.gmail.com>
References: <20200505162607.334-1-nsaenzjulienne@suse.de>
         <20200505162607.334-2-nsaenzjulienne@suse.de>
         <CAEUhbmWOQNDeStd3oDFTveiugzDG0zf0X1ybSWeCSP4QStNcPA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-EaTpgXN83yDr3EDiIRK3"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EaTpgXN83yDr3EDiIRK3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bin,

On Wed, 2020-05-06 at 13:33 +0800, Bin Meng wrote:
> Hi Nicolas,
>=20
> On Wed, May 6, 2020 at 12:26 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > On the Raspberry Pi 4, after a PCI reset, VL805's (a xHCI chip) firmwar=
e
> > may either be loaded directly from an EEPROM or, if not present, by the
> > SoC's VideCore (the SoC's co-processor). Introduce the function that
> > informs VideCore that VL805 may need its firmware loaded.
> >=20
>=20
> I still did not get it. Without the firmware being loaded, does xHCI
> on RPi 4 still work?

On newer revisions of RPi4, no, it will not work.

> What exact functionality does the firmware provide?

It provides xHCI functionality.

The old RPi4 design loaded this vl805 firmware trough a dedicated EEPROM
memory. But they removed it, probably in order to save costs. They then cre=
ated
this new interface to trigger a firmware load from RPi4's co-processor.

Regards,
Nicolas


--=-EaTpgXN83yDr3EDiIRK3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6ydfcACgkQlfZmHno8
x/7ivggAt4hC6IOQmOjKnnlEb1k415vNhq/1A8H12ikDPTgDwb1KfxPkaGuWdIEm
nnRIa4TmNiRnLV5V90EeEZGllgFuHLEcOrleX5iyLbxuZu9AuAPxxkR4qSBFYjM3
5JVrsMS+6yVulS8MV3WGEOEOH91etho4nOFKCeDIuKDaFo3YYGujpKJguvY6WVpo
2HwmqwJmYyotzuRcLF19ECfjVbk8hMEkj9y9SHwJUPYkbw+Pf6jrQ/6cTnIDnqfz
gBi59lnx0epm86zB5eYHK1ecRjy1gWkab13ixQ1+UYhY4w6HyjPibmg6kz/nBheD
X1dAFcnYj3rIkWQlM4QZ3uCeqD4NKA==
=kORr
-----END PGP SIGNATURE-----

--=-EaTpgXN83yDr3EDiIRK3--

