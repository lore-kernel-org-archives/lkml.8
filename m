Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD98CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3FB20740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Ybjla2kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbgEMIhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:37:48 -0400
Received: from www.zeus03.de ([194.117.254.33]:42026 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgEMIhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=OG4/TUlRa/Km5Fzod2UGV4khLRkH
        9Ea1loCjzOxACaA=; b=Ybjla2kUPcqEAp0pxUCr6IL5u/aq6dAZg1d9JcBa0ira
        vGTTFyBwShqkGu15SXirDoOyvYF/IhOy0F18G2j2H1q9/kT3CWj/gdRFq3D1v8D8
        B6X6TuY0C0OCxgu/Qc42ZdkWh/Jq2kJzD9t38pQTzVleHFyNkhbmgxJ/2th9K+s=
Received: (qmail 3269378 invoked from network); 13 May 2020 10:37:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 May 2020 10:37:46 +0200
X-UD-Smtp-Session: l3s3148p1@xmGRfoOlRtkgAwDPXwcWAIZZjypw6UMc
Date:   Wed, 13 May 2020 10:37:46 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     minyard@acm.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] char: ipmi: convert to use i2c_new_client_device()
Message-ID: <20200513083745.GC1043@ninjato>
References: <20200326210958.13051-2-wsa+renesas@sang-engineering.com>
 <20200512214532.14117-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <20200512214532.14117-1-minyard@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2020 at 04:45:32PM -0500, minyard@acm.org wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Move away from the deprecated API.
>=20
> Based on a patch by Wolfram Sang <wsa+renesas@sang-engineering.com>.
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
> I think this works.

Yes, we can do it like this (despite the question from earlier if it is
really needed). I fixed other drivers using this pattern, too.

As Stephen Rothwell pointed out, you either need to remove my "From:" or
add my SoB. I am fine with both.

Thanks,

   Wolfram


--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl67sdkACgkQFA3kzBSg
KbZc6Q//Qy9PcisKiZItyJKAXN51ct0m3wgrDYvLsUd0H91ROrFV01xRfcqyUyh3
xyvwAejOPaQvtfwoN/iyaXaU7k2Yf6RHv6UIcDUp+/kDV7ZE0KWCcRdEbw5uIR0h
7pkcyMlzlO5Jb1WY5mKQd3BWhgMjv0b0FJvKa+t2j/xZpmpZHBrUJDZRs+0WDbJc
mgMdg3UrJzuiIlKQ6jsLvalRIkTs2K0vEYmaJlg29J5l97NbTNOb7nXRO6YqKNmB
7aqWbxZHsU1frGokluyACOd+Z9bx0H6R7GuiE6MsnNovlVapfYB/HXvuLAUt9OJO
jWgYnvajJ0S71JDO/dbVGGNZe13dTeU8JfOHntnDLOiaoaaUSQ3YdHm2NWqGMKNY
4PquR4B2a2SIRK3Or4W3eABDg+m4oMZ5E4ijmUJB6WwkrhTbKhO/af83Uot+35hr
zFEjFbqe9yCGGvQteD13r7Vefs0HsTP9J0eZM/r5yD63Q4Z8bwVrujNWl7/jcMYM
OyGsYKj+umEcqKyXH9PXaLu5zLyPQtuum+ZzYc/nsGyatpLVB5X+20M5CqzgPqH7
7Eo9CpMlYO3+KDd3SBstZ/TjNo2tRC9zzg3vy3r7/ZpCBSa8YoXJfcfaHMsE76NL
nJxEHVVs+udEStW/Td0MujBTVYa7NGrX44UZ84Lq97cMa0+glPU=
=ZqST
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
