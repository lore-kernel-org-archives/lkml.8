Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC451C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B73320736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="U2hf0Q5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgELQ0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:26:05 -0400
Received: from www.zeus03.de ([194.117.254.33]:40920 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgELQ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=mqm9c+k7F1lRus2EbYhv//Yz2OQa
        7fELNgY8PfT2FaM=; b=U2hf0Q5fbrD1bkRHJ7ZWzbo/DkhVTrNgAjvAiZmxoXBe
        qbTrl3bOqjgjE+jx9Glf40SozR+ChkRwM2dOyvGG9vzsW/RgmO8x4xGWxxE4N4Hj
        1aKFWSIJAyBuLhohQ63SV+z6PKwuLN/jsAMor5SK2uT1SjsgOBIcE6TJi1cm6z4=
Received: (qmail 3009274 invoked from network); 12 May 2020 18:26:02 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 May 2020 18:26:02 +0200
X-UD-Smtp-Session: l3s3148p1@i/lm63WlZMggAwDPXw2aAE67cgFBY+HL
Date:   Tue, 12 May 2020 18:26:02 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mfd: htc-i2cpld: convert to use
 i2c_new_client_device()
Message-ID: <20200512162602.GH13516@ninjato>
References: <20200326211009.13411-1-wsa+renesas@sang-engineering.com>
 <20200326211009.13411-2-wsa+renesas@sang-engineering.com>
 <20200415110442.GK2167633@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bygAmIonOAIqBxQB"
Content-Disposition: inline
In-Reply-To: <20200415110442.GK2167633@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bygAmIonOAIqBxQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 12:04:42PM +0100, Lee Jones wrote:
> On Thu, 26 Mar 2020, Wolfram Sang wrote:
>=20
> > Move away from the deprecated API and return the shiny new ERRPTR where
> > useful.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/mfd/htc-i2cpld.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> Applied, thanks.

Thanks! I don't see it in -next, though?


--bygAmIonOAIqBxQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl66zhoACgkQFA3kzBSg
KbYWAQ//X7ol9geQZ53WyM6joMgWJsBZrXVjey0w62TUhNvQmZrGKbFlYwa+8466
2aUrK8D2vhnGuP4sfniFDGS+c30hDjz4tXjx/lBFregiFl+GEVsNRGKw+KOhS10w
0iU0src8eppVPFTJmgNDWhgLXvf2OU4cPzF8tnCU+/Xssef7UQ5Kbtlj4W9z5Imn
2B7LWv+nxkjRVTJA2E/HN5MSg+/QERXHFu2Uz9YgzF6UGRBU8BQOYMhAx1KD3toC
fhqh5OpNiSSpsMyibwCb0v6ixC0HUhzbvVitQPxOwCCwYNODct5N5YpNZ5N5nLgH
fhMevRljRb9Wlljt0xeszYpb9JZpGXv9n3NUHfv+tap/cfTNBEgZTKh4VPbWwBug
QFItU7mX1lwPk5D0Y4k/S7jBH3RPRpu8ERdL6vg0k/npPjbOpEUC2ftClK3WUOuF
ESpngyiNUtxfO+wyyGUQyjg0j8PoycY3Q3Ppj7dcqk4jYToMojXeAC45CHRGhrVR
unv4AfYNBO6/A8esUOOPAyCPFO6rFa72z4G7saOrTN7dclWE+fJB1WqUX2RTlHBK
jESODwZhQYN/4+/LuV1dgMYRmlbttieswC1Bzmxff9ypnavwkXHsmVAxKJR0C14Y
eKDdW+98y8o98tK0otR6b/RJogVkKRZzbt7hxcDOILFgUNtVjSg=
=Lr/T
-----END PGP SIGNATURE-----

--bygAmIonOAIqBxQB--
