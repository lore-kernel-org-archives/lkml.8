Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD12BC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 07:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6D720CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 07:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgAaHsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 02:48:07 -0500
Received: from sauhun.de ([88.99.104.3]:57240 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgAaHsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 02:48:07 -0500
Received: from localhost (p54B333AF.dip0.t-ipconnect.de [84.179.51.175])
        by pokefinder.org (Postfix) with ESMTPSA id 3A5192C0830;
        Fri, 31 Jan 2020 08:48:05 +0100 (CET)
Date:   Fri, 31 Jan 2020 08:48:04 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     enric.balletbo@collabora.com, Akshu.Agrawal@amd.com,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-i2c@vger.kernel.org, dlaurie@chromium.org
Subject: Re: [PATCH 2/4] i2c: i2c-cros-ec-tunnel: Fix ACPI identifier
Message-ID: <20200131074804.GE1028@ninjato>
References: <20191121211053.48861-1-rrangel@chromium.org>
 <20191121140830.2.I68b9a92ed4def031c3f247d3b49996a2512d762d@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline
In-Reply-To: <20191121140830.2.I68b9a92ed4def031c3f247d3b49996a2512d762d@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2019 at 02:10:51PM -0700, Raul E Rangel wrote:
> The initial patch was using the incorrect identifier.
>=20
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Applied to for-next, thanks!


--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4z27QACgkQFA3kzBSg
Kbb5cg/9H0LUPULqEiQRxGpcaJN3LbVlrAu+cTdTuWalgb2YG4wmZe+NMJptm1Oh
LDQA1Pb06KUK7apsZ6m6gkjilCYxdbqUuLUJ+sjmUGTonKS3EyLREd1nKYGaNrOO
d0tYOodUJ3+XtmdgS3gaZiNn8JKAVAicVKUcHhyGgFcRtlsXdWU4D8l1PohMzHeW
GxWLJ9ieIoEuFcI3fS5uwBeRiXc3puDJpPmzWahRy+l0859MoHcKxwCxY8KNd0Nq
e8oWyQZ/H1bpHDDQUfuaJhVsj/f6X7rdUdRjxtRi+3zfz6U42HRAvijoc2u+9PU4
EdvjdNoxLOvce2otSe/rWCpfQ6DlvMq64P5JI4jTygtj7kNh8+KFSoJ8NMDSJ7YL
d5LP0aptiSVwnvw9FCx6+mRgqhQ3u6/o2G9qOBVmsCaR4h9OlCPf/o0bUUJIbyb6
0SRpDU3B4lG60V5PvH974GqWTqUyV94138iSVn5hxI0OTgaW7T4/g7Q2CuvXick+
6y+P7z9xuzs+jWhvnh7bwJVM/wK9Uoep+P3zd0NNl2zzsH/R9nae8ugfMc5v4AtX
MprSee2weCMHgJC48uBoEYTZOTpP7qsR8KqYByOXz3jwqiypEMBw3T7iicCyLryO
nCw71PDB9ImgpmBq27pJxh7xX0rdyUcRIfq5YMcCT/ytlsp+FiQ=
=XrQx
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
