Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0266C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73211206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qubes-os.org header.i=frederic.pierret@qubes-os.org header.b="dgaa/8qE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgDGRXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:23:24 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21355 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDGRXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586280184; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IllL1jgUVzeR1OCq6kQj7nczjkCfQX0tOdBYU9oYkfqEef4r9UCmB4tJW+6yYb1JqCtiFNoz1K5ocVl87rBczAVeLHVBDKYnvU0MTzsZXm5qzxx6kySqfp7o4q/kWMvhQ3piJ3Aj2w+kvqnB5jf+teWyvMH+4V56sL9EFqDlzdI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1586280184; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=+FPrBfNaFtutiMNtfPMulp7dBZ8DmyA2KzNoqu6ZqOo=; 
        b=YSDZAKjLDKnlDsNcc6X66R9XjkfLPLV7OZuzs2hrZvepV7r3poScqA7QPVBOJ8jp9hSSbs4PvjAeNa+FSW6KmQvwvPAEcYJuUsEdm4Hb2TFY4oLG4GCPjqMLqr0MMvcCim4Yt8q7dVzo2ClVtVMlC3eJgyxDLVJy7kxK3k6I4Ls=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=qubes-os.org;
        spf=pass  smtp.mailfrom=frederic.pierret@qubes-os.org;
        dmarc=pass header.from=<frederic.pierret@qubes-os.org> header.from=<frederic.pierret@qubes-os.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1586280184;
        s=s; d=qubes-os.org; i=frederic.pierret@qubes-os.org;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type;
        bh=+FPrBfNaFtutiMNtfPMulp7dBZ8DmyA2KzNoqu6ZqOo=;
        b=dgaa/8qEkvrS7aPSQ52qAV7V/smaqILjzE066hVw9uudvMh0a5vXXED2Oa1iPdb6
        SysMi+nWfoEpKrwOVLHRNh0nogJ4myCl+/xItTfaG3CDqgsyb7MspUt7zScKUZLlRyj
        U8zmZeJg/7Js2CLW4YYSZqpcO63XKgYL4q1mTDWI=
Received: from [10.137.0.45] (82.102.18.6 [82.102.18.6]) by mx.zohomail.com
        with SMTPS id 1586280180057216.17014763214718; Tue, 7 Apr 2020 10:23:00 -0700 (PDT)
Subject: Re: [PATCH] gcc-common.h: 'params.h' has been dropped in GCC10
To:     Kees Cook <keescook@chromium.org>
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
References: <20200407113259.270172-1-frederic.pierret@qubes-os.org>
 <202004070945.D6E095F7@keescook>
From:   =?UTF-8?B?RnLDqWTDqXJpYyBQaWVycmV0?= 
        <frederic.pierret@qubes-os.org>
Message-ID: <3119553b-49dc-9d88-158f-2665f56f7b5c@qubes-os.org>
Date:   Tue, 7 Apr 2020 19:22:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <202004070945.D6E095F7@keescook>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4XWCrZTtaZ42dw52ols0VomB3Ercd5okc"
X-Zoho-Virus-Status: 2
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4XWCrZTtaZ42dw52ols0VomB3Ercd5okc
Content-Type: multipart/mixed; boundary="uK8FzINuxQUk8r0phr911MVYPlWxSULBl"

--uK8FzINuxQUk8r0phr911MVYPlWxSULBl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020-04-07 18:45, Kees Cook wrote:
>=20
> Hi! Thanks for the patch. I don't think this is a hack: it's the right
> thing to do here, yes? GCC 10 includes this helper in gimple.h, so we
> can ifdef it out in gcc-common.h.
>=20
> -Kees
Hi Kees,
Thank you very much for your comment. Would you like me to rephrase the c=
ommit including your comment too? "Hacky" mostly meaning humble modificat=
ion from my point of view :)

Best regards,
Fr=C3=A9d=C3=A9ric


--uK8FzINuxQUk8r0phr911MVYPlWxSULBl--

--4XWCrZTtaZ42dw52ols0VomB3Ercd5okc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn6ZLkvlecGvyjiymSEAQtc3FduIFAl6Mtu4ACgkQSEAQtc3F
duLWfxAAt5A2O4A+itcGNrTdpAEUvqtfL4GTDGTq66jH7en/pqESFgN1ZW3Q/Kx7
dH9Oah/kiqnfDIKbNmPrY2b8tVREJPY42/AttYTcvggL4jb10VhIAXfgxn+rqEs1
JmRD314Hhwb5hQLDQpUsyh33me9OY73MxV0DGzJU7EuBZmSDCUq9PzCw6TnQXVsx
G5ydyRGb7YySpwUFb4J5+BTnHRB/Ddq3k9GPOR6TVxpMWH48qwfvXuvCSf6NLIqC
logQ417Q5PsC7nzMB+eWIQgdieN8QqaficV1Jdoh3fWzdACAS5SkFrqasJ06B1ul
lwbKa5NjRklJ+8WS9UOyqABGveOLwQyK5RVcBeIKieX7Jkbm2mkTezSn/UzXZHfm
Ta9Hg2wzxhpSW0ccLnvO/gO3FUcdopDePvkPKDAc1//pBFkoej22ByQAy7/MTSmF
xPK2ryuRoThRJBEdDPcJp0XLIq5yaXhJ8zWlJ0NnL6rc5gh0MpTFR1+le+B5ihMP
gaZYJ4w9hLdJ3N2y/lukq0P/t05HUUH94qwq3RGcl43ZC0rIrTyDtAoWEu0KcXgU
0UBD1Qm4DSIjIpVbfltKfbdf1T4GG3L8pv3+bdCnjgcClZX/iRRgK5QG4xp1pUM9
GCERodJnBvzXqfi78pZ4u9lV+i2bczqbUhimlWkmxSCocckpLqM=
=GnQ3
-----END PGP SIGNATURE-----

--4XWCrZTtaZ42dw52ols0VomB3Ercd5okc--
