Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268BBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F118B208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgCENuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:50:00 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:49398 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgCENt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:49:59 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D09F01C032D; Thu,  5 Mar 2020 14:49:57 +0100 (CET)
Date:   Thu, 5 Mar 2020 14:49:57 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 12/87] arm/ftrace: Fix BE text poking
Message-ID: <20200305134956.GD2367@duo.ucw.cz>
References: <20200303174349.075101355@linuxfoundation.org>
 <20200303174350.172336594@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <20200303174350.172336594@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Peter Zijlstra <peterz@infradead.org>
>=20
> [ Upstream commit be993e44badc448add6a18d6f12b20615692c4c3 ]
>=20
> The __patch_text() function already applies __opcode_to_mem_*(), so
> when __opcode_to_mem_*() is not the identity (BE*), it is applied
> twice, wrecking the instruction.
>=20
> Fixes: 42e51f187f86 ("arm/ftrace: Use __patch_text()")

I don't see 42e51f187f86 anywhere. Mainline contains

commit 5a735583b764750726621b0396d03e4782911b77
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Oct 15 21:07:35 2019 +0200

    arm/ftrace: Use __patch_text()

But that one is not present in 4.19, so perhaps we should not need
this?

Best regards,
								Pavel

> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm/kernel/ftrace.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index ee673c09aa6c0..dd0215fb6fe23 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -106,13 +106,10 @@ static int ftrace_modify_code(unsigned long pc, uns=
igned long old,
>  {
>  	unsigned long replaced;
> =20
> -	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
>  		old =3D __opcode_to_mem_thumb32(old);
> -		new =3D __opcode_to_mem_thumb32(new);
> -	} else {
> +	else
>  		old =3D __opcode_to_mem_arm(old);
> -		new =3D __opcode_to_mem_arm(new);
> -	}
> =20
>  	if (validate) {
>  		if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
> --=20
> 2.20.1
>=20
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXmEDgwAKCRAw5/Bqldv6
8nSOAKCSRVNfm8M9KqXZY/UIoN+oE8kDagCbBOglnH+Ev4iU4/iQOq7jO+O3TOQ=
=QGDc
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
