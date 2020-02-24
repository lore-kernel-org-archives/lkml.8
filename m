Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989BDC38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685BB20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fxfy7DYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBXSrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:47:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:57305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgBXSrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582570042;
        bh=BfAI1FVsT11yqsC+vZjYwySllMzL3rHhAbjku17Hgus=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fxfy7DYvXO8IsjrNbbMHvvk5J9Z/qY87+CKFM0E/4DtW2+awSPG9zMaWI7HO98kMO
         dJormyG+uhzpo6BLv4et42X4Q4tzo9EU6B8P685NKcx0nosFv7X/DE0fUR/W9sCVm9
         0fXYXuFeqoKQKD875H2bSOpvsKX1T62LJ+n2vdGk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.92]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1jfuh9089p-00Zfy1; Mon, 24
 Feb 2020 19:47:22 +0100
Date:   Mon, 24 Feb 2020 19:47:19 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: process: changes.rst: Escape --version to fix
 Sphinx output
Message-ID: <20200224184719.GA2363@latitude>
References: <20200223222228.27089-1-j.neuschaefer@gmx.net>
 <20200224110815.6f7561d1@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20200224110815.6f7561d1@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:fsAeT8jc4NbrdnLB6PZ//t50f8Ob7WbKWPM7H3sxqDhEMEd6jEv
 6NF9JL0EqqKK1ZSNNEYDrngv9nITxQ6RsAg3dJGHSu+W6T4z5MZfczNMFBusJoziBo5Gv1o
 SCqiA0v11dkuoE+oiz9emBZ0tUBPgrtbnYN/KF6Of8lEHxP8rIafD3qEvFmOfjJvMHspUaO
 +XOeOmf9u9zC3mFhtdc4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Q8yMOasXeg=:j/soneMYUhPui8J0ZqIcnc
 Nqp2zeMUKvgCrXqM9vYHL95WUwGFFy5atTPTBiS3M2fyUx5QX0whadv6flE4skqJtwKMpapHS
 9EIb/z2bBGKAe9qQoX3J2c+wr4lQJntSWhj0Zt0GyyMgF4DN9tszrpvm7zQ6rNmMJ5DqE7XCM
 NvWIQlOCjaF++V4vlAcUCvAf7IFruZS232/h+Kq77BFfhINyuOB+YClGs/UItZvhNBR/LJjqa
 KuGuoICf34611UrPn+iwZ4SYB1QcgTAynt5vOaCG5Kw/Tmae19LinX8fNOC3ytCPCCkAf+2j2
 lc4Jq/NY+mxi096PsD5ikRD5YNL1WtlLcQ2Dln4WK6eJFXzVNH6UdU2u24eAZL+A9ASBe+E+D
 QdbiVAMf+2aV4jrBq9gi9FVRFa8n/F/ttymk4ZA+RSmZ4Bt5DnCJ5EAiNxX+hNTrxOWMva5jL
 5oecgz97ia4aJe793NWxGe+dZqyG0g1aFPSf0p7T/BEOJncMm+r4Kwf8S3P3Bvr95Kc1R5QR2
 zRXUkFywQ3vO8qath1Nu4jxA3xEvDg3brhkvkIS0l67ORv2wezw4tVHPPaCVsebTX94qsodLl
 r8u84gu8b101BSQ1msNePKLxrqUXuv7aBZ+2FRCjgTjCofZ9rkcbi0SX6mtqUtQODS/umEkgm
 b/A4vSL+WEtU7VGcxtlekoajQfj0UzlhE2pe1i0Y8V6Im7dAsoRElLaQKkhfVJ5gMO6Vaa2QB
 xMsn9fme55u0UtvVi0Y72izRNfan7KqbO/GkMuRKGV3pjvNPhhBIQ12m5blpnmjQzCr1spEu4
 00ea86bQDL70dOPxE5y0aFgi815Awh+Ru09Th6ApRmpvPjJd/J6aVIokk0JIV8rr58j9EmDG1
 oFgHuSoiEolSlPjnfATQTWAk9vu69Qjj0WxUmvo5WvGgeVKz7naBdRwXwL8LdkUro/vapr5OF
 tgTG1E5xxa2eCOtsJGCzUyprAUeUz6V9WiODisEJDY4bY5k6Yehok+ZAU7gHZzBNtbqPNF6dJ
 /7jfLEmOSU8vrRQaolLyq+kXDXUgXd2ZmTbNswrofGTmr7r0qef+ZplcBZQrEaXwpTGUprjBA
 nuGyaDwmwKxnwsJYNM5okL5M2IKee/rdQzpMtxcsBh2xC/nUhEyvY823xYuCapG3ejYlsN4CN
 arYR5BShNbUgztfyUz8jo+D5OgdofF6O0/85Pa2G9YKLhi9xDXEi4SB/eG9PJ7tehZ9EBIoaN
 Qt+1kN/2Yx4F2YAib
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 11:08:15AM -0700, Jonathan Corbet wrote:
> On Sun, 23 Feb 2020 23:22:27 +0100
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
>=20
> > Without double-backticks, Sphinx wrongly turns "--version" into
> > "=E2=80=93version" with a Unicode EN DASH (U+2013), that is visually ea=
sy to
> > confuse with a single ASCII dash.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>=20
> This certainly seems worth addressing.  But I would *really* rather find
> a way to tell Sphinx not to do that rather than making all of these
> tweaks - which we will certainly find ourselves having to do over and
> over again.  I can try to look into that in a bit, but if somebody were
> to beat me to it ... :)

This seems to do the trick:


diff --git a/Documentation/conf.py b/Documentation/conf.py
index 3c7bdf4cd31f..8f2a7ae95184 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -587,6 +587,9 @@ pdf_documents =3D [
 kerneldoc_bin =3D '../scripts/kernel-doc'
 kerneldoc_srctree =3D '..'

+# Render -- as two dashes
+smartquotes =3D False
+
 # ------------------------------------------------------------------------=
------
 # Since loadConfig overwrites settings from the global namespace, it has t=
o be
 # the last statement in the conf.py file

(Documentation at https://www.sphinx-doc.org/en/master/usage/configuration.=
html#confval-smartquotes)


Jonathan Neusch=C3=A4fer

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl5UGjAACgkQCDBEmo7z
X9suPw//SJEUBOwuKVasHsBaBFpALZvFpkVKtlYVbYVEFOaadikgUyNnnYqbaLVS
4yHQtGpwPe7putz3cdDsiFdJ1TmZGwy3NbpSS9clLxo/BL8IQJZFnnbGqkWdFYWu
HWiv/pROGlnzPOiZRWn7jndmRWcj8xvFpx87YimwP13duu4rSEUKQ40EqdJdXUkw
jb+jSZ7jopFr2zXkWMAAtvKU0yVRQ2ZCIdIRUBS17y+PaOMFRDXu6ALmDINOKChv
fiXQ8S7K7LBKk3/w/WDgMHY/PiYcOfGM7MDeHos7pkYRR3JfacZZufS4tEZAn7VG
N+8l5WxJlIZmr7e27yx4X9vYabsb0jngmZd2pVMlkiTnfddUlro18A0DYwcWlLYR
YwqTR56zh1Ire1emuxiJsUu0DU9ppO7O0I1zHgZ6ESBob18GeJzoHRXiruCa1RGq
Hc62JAtMipfgLhJ1Tr8zV1Uxqsp2zTZfqiMPtNux72SDnLyDofvPJ/3aQG5Kr+Iz
ueFjGRUdtuEvACOG0fTmtfbmqOxSB6ms9bgzpYd0GymzeZuRf7qBkPiyOiVRNtew
o4UbEVYRgYJcA6H+p2wSGbieOnvoGV4qrn0vGE2gAoLxoaxNBU4D1xHVMRYmLCQZ
S1VvafKS/SwOtvEDwjpUo8d0FC5oz7+tv+EIm5XFipPqpY8kMOU=
=6TUA
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
