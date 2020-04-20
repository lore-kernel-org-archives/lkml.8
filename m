Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B66C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182AB2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgDTNdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:33:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:56528 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbgDTNdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:33:37 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jQWYJ-0008G0-Dt; Mon, 20 Apr 2020 14:33:35 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jQWYI-008In4-Vl; Mon, 20 Apr 2020 14:33:34 +0100
Message-ID: <7fb8e9ac69a1c03a673875dc39fcd8f94407abca.camel@decadent.org.uk>
Subject: Re: [PATCH] x86/microcode/intel: replace sync_core() with
 native_cpuid_reg(eax)
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Borislav Petkov <bp@alien8.de>,
        Evalds Iodzevics <evalds.iodzevics@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de
Date:   Mon, 20 Apr 2020 14:33:30 +0100
In-Reply-To: <20200420093129.GA21839@zn.tnic>
References: <20200420120037.1537-1-evalds.iodzevics@gmail.com>
         <20200420093129.GA21839@zn.tnic>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-rO2E3TbHWeD2oFIYU2q8"
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rO2E3TbHWeD2oFIYU2q8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-04-20 at 11:31 +0200, Borislav Petkov wrote:
> On Mon, Apr 20, 2020 at 03:00:37PM +0300, Evalds Iodzevics wrote:
> > sync_core() always jums past cpuid instruction on 32 bit machines
> > because data structure boot_cpu_data are not populated so early in boot=
.
>=20
> I'm guessing because boot_cpu_data.cpuid_level is not properly set and
> very early code in head_32.S sets it to -1 temporarily until the highest
> CPUID level has been detected (or not).
>=20
> But the microcode loading happens *before* that.
[...]
> Hrm, the original patch of mine did use native_cpuid_eax():
>=20
> 4167709bbf82 ("x86/microcode/intel: Add a helper which gives the microcod=
e revision")
>=20
> but the backport:
>=20
> commit 98cc1464cfd6edf9dc7fa96aaaf596aae952029b
> Author: Borislav Petkov <bp@suse.de>
> Date:   Mon Jan 9 12:41:45 2017 +0100
>=20
>     x86/microcode/intel: Add a helper which gives the microcode revision
>    =20
>     commit 4167709bbf826512a52ebd6aafda2be104adaec9 upstream.
>    =20
>     Since on Intel we're required to do CPUID(1) first, before reading
>     the microcode revision MSR, let's add a special helper which does the
>     required steps so that we don't forget to do them next time, when we
>     want to read the microcode revision.
>    =20
>     Signed-off-by: Borislav Petkov <bp@suse.de>
>     Link: http://lkml.kernel.org/r/20170109114147.5082-4-bp@alien8.de
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     [bwh: Backported to 4.4:
>      - Don't touch prev_rev variable in apply_microcode()
>      - Keep using sync_core(), which will alway includes the necessary CP=
UID
>      	^^^^^^^^^^^^^^^^^^^
>=20
> decided to use sync_core() for whatever reason. Perhaps because the
> native_cpuid* things weren't there. Adding Ben to Cc.

This commit didn't introduce the call to native_cpuid_eax(), but only
moved it.  So I didn't think it made sense for the backport to change
from sync_core().

If it's important to use native_cpuid_eax() then these older branches
should presumably get backports of:

484d0e5c7943 x86/microcode/intel: Replace sync_core() with native_cpuid()
f3e2a51f568d x86/microcode: Use native CPUID to tickle out microcode revisi=
on

Ben.

> I believe this is the background info Greg needed to figure out *why*
> you're doing this.
>=20
--=20
Ben Hutchings
Klipstein's 4th Law of Prototyping and Production:
                               A fail-safe circuit will destroy others.


--=-rO2E3TbHWeD2oFIYU2q8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl6dpKoACgkQ57/I7JWG
EQniqw//T43dRiR0wAcQlfqixG+5yD5o7m7mIZZtMGTN5OZKoNE8a0yIlexSEFVp
KRd2nIHHFcFlU8TJPj0JcgSmAUJS0OprvFRVwh24/SmFblAPYZwgRv2gE7Hftt8j
pkAQxrBwXJXdIkMNpLTXnrDoIJwx+H4sw86hoVr+jx3qofR1Li75EgBzsgZ6/hlQ
Hx/5MvS5Qb5WvuWsqkIP2o1pUryiHFJBluZOD6R6V+JlS4CTnoXoCFyWqkrVrZ6L
hBFfBGbOsnLT+KrYuGPW0+eMLsj9D+t/Tbpabr8prpHpz+ZQD4SEjBpC5ENE5LLI
azrENtuATD5SpiCLzxvtIdeVikidgh3RjOFW2iWF39697tlFnrPoOOs4P9Lttl1j
35NEEU1Iwj9uEBM7a1cL7HtagRFvBAkktOWvQ8/CNHAhodmHXUCb9K29TqD6/8Gs
62PLlYeOK09yRX3MMtGNbQNXnluBiMp8PhaXcUO6uYeS3EAfMC7KmSqB8Yk1YFEt
JA95Cm7jDGcRN3Kh5fnhFlCkeStrW2YQ2kyQ68QCFQo5UK4CMYpmAxBlzVfLXBUk
WMiaUjpUEID78xDM+4qw7A6Hhe3BJIlfQYSQ78hEUpxfw4GDKgJoPr/A51MTuA9A
dBFVZYTmmbmyAyPKlk+jsst/iJDA5LFDoheK3mNErqB469kvBhQ=
=lBHM
-----END PGP SIGNATURE-----

--=-rO2E3TbHWeD2oFIYU2q8--
