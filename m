Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC916C2D0EE
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 17:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857D1206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 17:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="csp0eGgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgC1RU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:20:27 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:46236 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1RUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 13:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wWK4xAp/5vJR/o4OLYfi1bsqvSaU3tpDalVSsy0Q3Jg=; b=csp0eGgrU3+Kiq/IcnyZ2vJu9
        r4CzQcr7f7t1lWdj7jM8hlyMWCtrbc978u/TPrPrXtRIXcxymoa4sVY4me2ncy9F8nCKSoZLghv9p
        GnBnISvGhXsbGaA32nBnOw6h4lB07d4yQOBFMiIZI5IjWiE9lxu47MimiPwIkG69zIfRg=;
Received: from p200300ccff341200e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff34:1200:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jIF84-0007EU-V8; Sat, 28 Mar 2020 18:20:17 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1jIF84-0000rq-3g; Sat, 28 Mar 2020 18:20:16 +0100
Date:   Sat, 28 Mar 2020 18:20:08 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CHKDT error by f95cad74acdb ("dt-bindings: clocks: Convert
 Allwinner legacy clocks to schemas")
Message-ID: <20200328182008.5ac2f99e@kemnade.info>
In-Reply-To: <A65A26D8-9F66-4D46-B1E1-84ECECF079E3@goldelico.com>
References: <A65A26D8-9F66-4D46-B1E1-84ECECF079E3@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/aeW6NK3=3jaZ_gJz9XTWR1O"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aeW6NK3=3jaZ_gJz9XTWR1O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nikolaus,

On Sat, 28 Mar 2020 13:26:24 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi Rob,
> I am trying to check my new bindings with v5.6-rc7 but get this before
> the process tries mine:
>=20
> make dt_binding_check dtbs_check
> ...
>=20
>   CHKDT   Documentation/devicetree/bindings/bus/renesas,bsc.yaml - due to=
 target missing
>   CHKDT   Documentation/devicetree/bindings/bus/simple-pm-bus.yaml - due =
to target missing
>   CHKDT   Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb=
-clk.yaml - due to target missing
> /Volumes/CaseSensitive/master/Documentation/devicetree/bindings/clock/all=
winner,sun4i-a10-ahb-clk.yaml: Additional properties are not allowed ('depr=
ecated' was unexpected)
> make[2]: *** [Documentation/devicetree/bindings/clock/allwinner,sun4i-a10=
-ahb-clk.example.dts] Error 1
> make[1]: *** [dt_binding_check] Error 2
> make: *** [sub-make] Error 2
>=20
> What am I doing wrong?
> Is there an option to skip such errors and continue?
> Is there an option to just test my bindings and yaml file?
>=20
maybe your tools are outdated, so rerun

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master


Regards,
Andreas

--Sig_/aeW6NK3=3jaZ_gJz9XTWR1O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl5/h0kACgkQl4jFM1s/
ye8VlBAAvjUhK0aZjt10hczyjZ7dVWP6/WRsiCMr8PbuL/lo4DHpsTN3Dv+FybqL
5AJCWbeFe5HNWxU1cxd65NWOYrhtMO8EALLKX9Rzx1EBlGktXMOChHewMF/yn9WO
zIWJHa7kniuyK2a7rLCz7cKrAlJwELY/Vosee5z5SuQ/J8bY4LdNpHcBDSGXwRiW
Hx3s+2z0Znm+abcX/Eu6QIutoNo859TmSjyBQ+RMJlNQhOejqY3hWpX0QghMted3
QEgqbclUpsLgD0Ip2IWZn6vmDoChEGT1LEaOvexKQ2SY8rNmEL/GVvFEapmcY4OL
PW0IGcVB118YZjpZMlHyXymV/KReYQq/ZAsmFjb3wWxnmRoxgAn2CHt6S9l2Ijy8
9h3KTfoUjKgXOOQQJLQZOUSQhdWEqxhSHHaJcOu+bLSpKnqs/9e0yMiEMiPXuRuI
v/nXydCQm23uhE0hmjd/gJATjezGOCnel3zYnMIRsDx1zq+SyzM/ey8ORE47zm+F
Yfp/iPruJsUblZ1N1SgXcnTqaV/aa+1j1ChYNSftvSnuTcuDZ8onp91yp3Gykee6
tj/y4UdR+GEBqDx6O6133Z4ORiZg1wtz5FV6Yj612BZovgnwLU5plx/LJI4M+9zc
+5xOxNcgusMxuQy5Mev+NdNvkV28PpqsOUi9xfo2Mts0CNIlxqg=
=yBKe
-----END PGP SIGNATURE-----

--Sig_/aeW6NK3=3jaZ_gJz9XTWR1O--
