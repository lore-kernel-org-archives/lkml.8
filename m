Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A457C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 040BD2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ur7hzzNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgH0Sdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:33:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:44463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH0Sdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598553209;
        bh=JC6EGGYuRkpIvNDG4Yb9STTAcipoDvrJsIR/5CHpPtE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ur7hzzNqkd3wZqDEAKCLXKjhQJudexvjhYIuZQzx3D/0+qLUCLaTKhBi78x7qulFY
         oKM2CrY7+c87+j6yCVkoxUUHerk9u8gC2WKj1PP6h2Zq1R7FPkjIIiAgqmhO12vBd9
         FiItzyCki3x4l2MrwSGJjd7h2d7xnU6/As/o3XI4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([146.60.75.230]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1kNxt43UWI-00Dq3f; Thu, 27
 Aug 2020 20:33:28 +0200
Date:   Thu, 27 Aug 2020 20:33:23 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, michael@walle.cc,
        rjones@gateworks.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v2 2/2] ARM: dts: imx: add devicetree for Tolino Shine 2
 HD
Message-ID: <20200827183323.GE103070@latitude>
References: <20200826204251.5082-1-andreas@kemnade.info>
 <20200826204251.5082-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <20200826204251.5082-3-andreas@kemnade.info>
X-Provags-ID: V03:K1:EE1U1fSZI7ODiI4pwlRNdpOKIK4hXA6uKhqX2I1mpsyHq1DAK6j
 kI+HNnP6ymythIOTNjlxd3o6P7wYOBt2OSXFchfSySwTFDNJpSim2WufDwo1U3rzoT+3pJY
 BqjOtosdAPaOeS9nh8hdEqiQGTSyv5Va6Zpx8kPfBtTh6ep383kgW5DK5Uf2vb342zMdamu
 sO3dhG0OA7WznQuAsiqSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NUh/Jk1F6v0=:cp2M50eZswsTElOniRZcw4
 YKyNrFI0/SZBfnzvvc3s6rEqZIvIl/LAmswvmcaH4e48j0aeLNMDNHZL50FmJor4UHyIcVDsO
 HyV3UDW3lVE5KyIxOL9xQyaUucG4vzYRy5kM5zf8htlotP+j0cVwsS2YOjySxkTo3Lsf4dY8p
 wc962zuJ0eq8ho91dylQ+PtAFNaMuMIS2dhX5s4YY0uNP26yiSmNl53oJfLy06F0vToQR062h
 f5NmUtjVSCO7nufKeNSTUW+vq9st7/zXfHqTjCd1LCDtoz+s4/Q6XsNqUI2nrkpkfbQmRrGI8
 GwlFmkT+R2EYFVt0ToY0PNxqB83/8yp1Ch47Fe5SLUsIK96ZV2fkWmJFSRUKI/E0IydFpaJC2
 gYlokTiITC/IVvmuNl7bLL5bYU9LN6u/1BYiRxGv35n0r2qOphuIUvAvbJo3Id5fFIzJowyxd
 ckVcKwbv+3Jmooa8EL+GWodBYQy5ZE+Z5tl4mv7YLgFaMUdjGkA7xuL5uGSLumctrJdFnLczK
 WBbG/dMAikpeSHXIA3KH40Q1qu6cpDXC24DUj+5WoT8x3mRkifiNeKWJXeFM7UqgobNRBYWGR
 O8s64zwUoC15Qn8KjfCmrOqw0vTnJbrXeNYo51Ke16F/U9OjQ4mmzFlNnFGLdG8WB+CVNzFlR
 PbjHqmiVhPKBBXYmJiO6fNeuMy8+cCagfSW4XqoxSKN/mOG1RBbboQfHDxJrNXfocTOcVCgSh
 LiJhCNWrsQU9ohUuwnheYhE95gbaPZrXwtOs68YtO6elgzgITNL/g0bgNjStsEkV2O4pPQsvA
 TCXSXENwiuMakufT46hTmDYdwDKWOV/hWUG5ZYxKIeJKAZ6n7lv9yDkNV310XVE2YWItNbyhx
 RgLe65fhAeXYyrEUYQxwvR95h6MjpaUoyr7xWUhn3L1ygC3nudTLWd1LgTdv5VQp59i2HIZwW
 gvHA/l1ek33X7lXFuJb7FeCk8tU8kw0awhmOGDAFJJEhFzrqv67KyOWqOPShGtotdRpc8HWSJ
 xaL2LVaEvfYnBWWNSBLTM6SEYUI3tX00f79sdJTLOAD98Qx5MWUK5ri8esFJ4sc4qxsxlEuym
 ght7hAoD63x/FoP8PDnXOWfMiOY0uVIlP2qkeZ2NZpJIjoQ1qu86aUse7uqgwwbTAU5OxceBO
 tOWCwpH20UEInzImbCXEMJ33QjoXjgINYgyyrPiKdeAGhoJEFfCbVNqqDMbZ26oxhCc8hCleo
 6UQYR1hb9KhXzHN+9AEaIlOd7EAWVXuicL2Xxcw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 10:42:51PM +0200, Andreas Kemnade wrote:
> This adds a devicetree for the Tolino Shine 2 HD Ebook reader. It is based
> on boards marked with "37NB-E60QF0+4A2". It is equipped with an i.MX6SL
> SoC.
>=20
> Expected to work:
> - Buttons
> - Wifi
> - Touchscreen
> - LED
> - uSD
> - USB
> - RTC
>=20
> Not working due to missing drivers:
> - Backlight (requires NTXEC driver)
> - EPD
>=20
> Not working due to unknown reasons:
> - deep sleep (echo standby >/sys/power/state works),
>   wakeup fails when imx_gpc_pre_suspend(true) was called.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
[...]
> +		fl {
> +			label =3D "Frontlight";
> +			gpios =3D <&gpio3 26 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_BRIGHTNESS_CYCLE>;
> +		};

Another option might be KEY_BRIGHTNESS_TOGGLE/KEY_DISPLAYTOGGLE, but
it's not a perfect match, either. (And perhaps a worse match due to the
connotation of turning the display off.)


Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Thanks

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl9H/GIACgkQCDBEmo7z
X9tufxAAvtp6+WXWxqDO+2LqEf6DmXG80cKCHTfpPshB+iWKBRfxjlqNrOjcD3Fn
iZH0NTxUZ3dKzAEIrY8CBi8Ygjo41Rk+9AgOkYIECJ6YBS5fUnjOJe2tUPXar9m+
wI0mI8nAoTFtSSoMX2+XvGDEOhZ7PYIc6G1mM5h9m6phtSulSYVr6M8ALJTh+wxM
VqdsWkKbHcmwOQbe0xYcro6p4WQ5xX9Y7zdsGxD8mmxwLxYD+9mB2X4EAGF0Di0W
lxdoC4DDJ6wBX/8c+8vRaQQCKX6HDgjfeVoSRGrHQi3fQOFfmieyjZZhU+j4rHjP
zKjmzXwiZjiVorDXYbhcWY84epp6hFw4wYSZwHKXzz69lOIiBjUjQM57mY2YI8yt
s5jXNlIP8crJzA8lRPtXMr6wFKLfcOOSwkgSStG2CXHrnnQvwEHgjB3J2yr5XqMu
tAgWQ9lh5Af02xcAHUttR/d1wePLo0nNEoJJUUslpDAwPfM9/juHynIYSHEXadPh
+q3qJdqTH1iC4SZAoLJXqfe9ptQo8qXArTEOD6DaGF3MEZMFOJPupU/zHEyGyND7
DDZX4OBMEF4QaY0vgT/WFghZTaEHdlZCSopMRNOb04gEHT7hPqgX5ITYEm8bjJma
AhBDQXdsY5ejCJMhtJEM+2FI4Bkdx/ArF8lZQWJ1KxFmlgbWnAI=
=ylRR
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
