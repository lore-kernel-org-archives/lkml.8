Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FD3C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC5F206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD1Eou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:44:50 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55723 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgD1Eot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:44:49 -0400
Received: from methusalix.internal.home.lespocky.de ([109.250.101.169]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MfYDO-1j0XvY2as4-00fwEP; Tue, 28 Apr 2020 06:44:44 +0200
Received: from falbala.internal.home.lespocky.de ([192.168.243.94])
        by methusalix.internal.home.lespocky.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <post@lespocky.de>)
        id 1jTI6r-000482-VZ; Tue, 28 Apr 2020 06:44:43 +0200
Date:   Tue, 28 Apr 2020 06:44:40 +0200
From:   Alexander Dahl <post@lespocky.de>
To:     webmaster@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: New Wiki URLs?
Message-ID: <20200428044440.kd2rf3cxa5rffewm@falbala.internal.home.lespocky.de>
Mail-Followup-To: webmaster@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6rmhozldre3ci2et"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Scan-Signature: 43227bb1a0d9095ae2bb1ca1fd71373a
X-Provags-ID: V03:K1:zZsd+o4iLKjEyP5P+XBhwrWENVcApqAdfolg81YTjc/dzkddyIH
 Mfd/MDEOxT3XgiKLP8hUnx5xQr9nL40UcJE9HF1ccN6kkahv07stAfJ0Ssyj1o6wwxtCH5i
 caKKjRzdHyf64/yLlTq/sIAvxu70JHWlqz0vNLttoZrzfEQan2hgIJ8l8iWtsaCjnzOklAK
 uC79reoTriX+4tTyDGV2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7UorH9nhJFM=:0Tj2F8RM368aOSQNNuX8Rg
 WRZFE8yXcxIj1q94UxiQvxcCMQ3iiQNpqm4VXnfw0PPJGmXnlpz8yUw/+K9zSO0uQ/c03Ll3d
 /y80alGFtnQEra6vTAY8Pkc6jQll7shOAtOmSUK+a3DiYVpOxaiJgijOOkczJh0+6ZAL0nWrX
 83eb3D8qI6d+tCiMeOTd6DGxxZuk4KRK6ATeaWK6woG8krsa4vCJzXcQqzw7mFMyScAarYWzb
 bWOitRi4tGFV7ve+bLWTtkQyHVxK0Aiqh4S1BPbaIaKSJAEAJIzlMCyGHcwtyMmF6drWy6hbs
 vA6rvvdmgH/U+VvhjRKYad4kmhEN/OZ9mkRLqLhxaasWkAh2ebXxsIFcBUomSHdRIG23nUirV
 c2M3IhFFafx4JmqfuFbwqqSTxIZF7dnWixRw+zzx5rTXp/KPz7UfxSVjbwOGqxE5fEROvsX4L
 M1uTdppEgCvIYKAcfst4BsKRxyrBxXz4XYEtj269WfGYaT2k6pNTqOXqz5i+0vLRu6T/M/vdh
 FsvJyhdNxKf1oilagmUADdhx9/SkCoIUnYXB0IKVLF8r2MYmAqmhv+1ZdvnKVbvPfRZ5DBzYF
 pnfuylhWE3DDDuBvw3hx9O+hraj+nlnw1fVIHdT2ZkILiZ22qMumRX6TH7vZPKx6EbhzKx3SN
 39P8g4+REgzbqJgDxho+BbTS3ALNuSwHi29AtyE9XoMXoVPUHftt65IR28jUqVCj8A5sKptGf
 SYORdw61qCg3IkB9eFOZYxhirG0d/3Kaszzj1XH1i7cxuFCxhOCfGXgNM7lyVOfyveffTEh7Y
 S/1eL6+phwQHmt2/3rnmUNAXHw/9yvbNWsw/kv8Mnw9HGnK6V78XTbxXPwwT5y7K/jdm+Ci
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6rmhozldre3ci2et
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I noticed the kernel wiki URLs might have changed. The URLs now are
like this:

https://wireless.wiki.kernel.org/en/users/drivers/b43

However in the kernel source code and in the kernel log output you
find something like this:

    b43-phy1 ERROR: You must go to http://wireless.kernel.org/en/users/Driv=
ers/b43#devicefirmware and do
    wnload the correct firmware for this driver version. Please carefully r=
ead all instructions on this=20
    website.

(Notice the additional subdomain and the case change in the resource
path.)

Some websites seem to link on those old URLs, see
https://packages.debian.org/source/buster/b43-fwcutter for example.

Could the webmasters of kernel.org please configure some kind of
redirects so people don't get 404 errors when looking for docs?

Bonus question: would it make sense to change all those URLs in the
source (as in: send patches for that)? Then what URLs are supposed to
be the right ones now?

Kind regards
Alex

--=20
/"\ ASCII RIBBON | =BBWith the first link, the chain is forged. The first
\ / CAMPAIGN     | speech censured, the first thought forbidden, the
 X  AGAINST      | first freedom denied, chains us all irrevocably.=AB
/ \ HTML MAIL    | (Jean-Luc Picard, quoting Judge Aaron Satie)

--6rmhozldre3ci2et
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEwo7muQJjlc+Prwj6NK3NAHIhXMYFAl6ntLQACgkQNK3NAHIh
XMbeAhAAyRPtVq5b/B1fRdh/FkSS2r/auAWSB+DoukfvUZADasr5JWDaEDISPJb3
vWnVFt493cuGo05LV569Qj37aNKu6g9EUguFmWMShunSU6Vguojlag6J7+rinOMR
8feiEnec4bQWAmSONzxyXxwC66vsKMTD+smOPhS8MEIAX+iHKxYLFLVBPqIcAEzr
AqVHNWOaOODk7IOsCo7wKr8exjRXrWQe4erzZNWb+/4feHsygBuzfVgvEiDKQDVq
pDQDgOodqCWsOZC0y2mWrUamry97g3vGNM1nKZPSkMe1wi5tNKe5aFJgeABf8FY6
sqnFrw1kEL0fOuht0Bsx4ry9XLnt3rXRMw7ArY2Epgyjj7yb8pWo+4oe7Gx+PXUY
PBUMU1016XOLOeoxkwFQtLGJ1a0iRnfkcEJznx8zQ2gA9ebZ1LfTzaQ4Xhr1qtQC
QDTINb6ToeMozwYTZrPqc5g8HJwKRGrAGZlBRRRTzK03trBQ/aydpTKqJltQQBgv
1GNUFQfauysdDaL/n/mIg1d4bjHSNs/ETi6AovgCAmTTrnueKtGTdhXUS4BezjlE
Z8eA7UUuktkuzX7th8T71u+RVptjnFGZeQ7T1nQIDvrNH3ii30qqqzqq+nGC7EW9
l40I+hK8dg61biL2dRnLd3upz81IuelnqQXIwoFCAVVWkV6ECP0=
=+NxB
-----END PGP SIGNATURE-----

--6rmhozldre3ci2et--
