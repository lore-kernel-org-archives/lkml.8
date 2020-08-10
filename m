Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9CBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DDC820729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597052221;
	bh=dvkUWEpX11q9NnNs+5HsTRFZXhhHmCDnX3kk5ka9XSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=krCS8rFYY5jysIikbp82L0DiCYxUlg65Agp4/GHLlN+MLYost7iRdz1HI+7ftAd3C
	 VjDRHB9n2ZqvQGwrRa66IGNB6wf6ezyCukxBVWO3iqDhZupGLr5iyw0tkZR3jqYYJe
	 0Ljwk2EAVmzWusHs3lUUvV5fZlxpRQTDFE56YySs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHJJhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgHJJg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:36:58 -0400
Received: from localhost (p54b3345b.dip0.t-ipconnect.de [84.179.52.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9126206C3;
        Mon, 10 Aug 2020 09:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597052218;
        bh=dvkUWEpX11q9NnNs+5HsTRFZXhhHmCDnX3kk5ka9XSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wq9MsZ8yyEzUmBKzWzWaZEVgaxEG7UmUj6PsRBmvAWd5SSuqzeWWpK58MZWPLz1fn
         +YQoooGtM9Rs2mwkIAa4zhq9vliIcBRPgcIHRaPt2qVdfVdpuewh4O5kKlYZ+Jse1+
         NahxdTFdekalVb0crHAKao/DCK7CJlyKraPjz5rE=
Date:   Mon, 10 Aug 2020 11:36:56 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: s3c64xx: use simple i2c probe function
Message-ID: <20200810093656.GC1290@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200809172243.15192-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <20200809172243.15192-1-steve@sk2.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 09, 2020 at 07:22:43PM +0200, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

This is useful, helps deprecating the old probe method:

Acked-by: Wolfram Sang <wsa@kernel.org>


--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl8xFTcACgkQFA3kzBSg
KbY/yQ/9ECsCNMtOHAhn4jj7UTPyaXTpKMovFeOo2SLZqo73Z6/ygK2yUrPj7To2
ChLU/yEXgtx06igcZfxmnMe/cpve6vxL1f+A9xA64AYvCPEvOMfcStfoypiJaWZz
NGwZvl4uMHhRnr91318kIrJBolFkKwUFskOUA0oDTWqlwoZpQcglUbFlHgPehJTC
S1EqYCedlQem2ezoTsZwqdYE/YTNy+CMwAEz0pmZGxHNhKLQkNnbqE7MYt8XPXnx
viLLoKK/dV+mb/1JZGqpfURVzFOb53LBGUPZldu/f2OyqyoBD3ykQm4hh8G5GNQU
fNznO56AdlBjyHIRiYrN3iaelHMhIONh46SUdpiBSafvP0wkgJ/Cn2IKqBYyrJSs
4s9j8YgBqC+pVO2ypYTy/4+hxikcgsmJSSDQkIdBmnggjYcf3TZB94KTFgtIQc1P
zb+1Af3u9nBbTyZ2TMpJcyMi2cq3Hlt5du++2wcrNeY8HiwB8EOk1uDocBnqY5Gt
mc2lAgpVdnvNn/9KJEQ7k4/CGmxeJplqJj059goeumBFou6ZBl59yVTNZphsaErA
8Ed9pwksRP0pOY7GfEadYcD+6uo6iaIApQRrlQS7wQ5g+0FZWRNnjezZ2KUsOfRy
d4H56AItKVUxj9gzocdvvWAWaQw+3YdocYv9ee71Ujx/HvRx76Q=
=YOJP
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
