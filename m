Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBC0C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F39DD2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633926AbgDNVdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:33:05 -0400
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:59558 "EHLO
        15.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633860AbgDNVbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:31:48 -0400
Received: from player714.ha.ovh.net (unknown [10.108.35.215])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id DF0B12049DD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:21:56 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player714.ha.ovh.net (Postfix) with ESMTPSA id 8EA5A11551A57;
        Tue, 14 Apr 2020 21:21:47 +0000 (UTC)
Date:   Tue, 14 Apr 2020 23:21:37 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.de>, Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] docs: admin-guide: merge sections for the
 kernel.modprobe sysctl
Message-ID: <20200414232137.37301572@heffalump.sk2.org>
In-Reply-To: <20200414172430.230293-1-ebiggers@kernel.org>
References: <20200414172430.230293-1-ebiggers@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/+MMOYGDEQHeD1zd57H4NBI/"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 2987012454176869791
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrfedugdduiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtdefreertddvnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedugedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+MMOYGDEQHeD1zd57H4NBI/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Apr 2020 10:24:30 -0700, Eric Biggers <ebiggers@kernel.org> wrot=
e:
> From: Eric Biggers <ebiggers@google.com>
>=20
> Documentation for the kernel.modprobe sysctl was added both by
> commit 0317c5371e6a ("docs: merge debugging-modules.txt into
> sysctl/kernel.rst") and by commit 6e7158250625 ("docs: admin-guide:
> document the kernel.modprobe sysctl"), resulting in the same sysctl
> being documented in two places.  Merge these into one place.
>=20
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Stephen Kitt <steve@sk2.org>

Thanks for taking care of this!

> ---
>=20
> Jon, could you take this through the docs tree as a fix for 5.7?
>=20
>  Documentation/admin-guide/sysctl/kernel.rst | 47 +++++++++------------
>  1 file changed, 19 insertions(+), 28 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst
> b/Documentation/admin-guide/sysctl/kernel.rst index
> 39c95c0e13d30..0d427fd109419 100644 ---
> a/Documentation/admin-guide/sysctl/kernel.rst +++
> b/Documentation/admin-guide/sysctl/kernel.rst @@ -390,9 +390,17 @@ When
> ``kptr_restrict`` is set to 2, kernel pointers printed using modprobe
>  =3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -This gives the full path of the modprobe command which the kernel will
> -use to load modules. This can be used to debug module loading
> -requests::
> +The full path to the usermode helper for autoloading kernel modules,
> +by default "/sbin/modprobe".  This binary is executed when the kernel
> +requests a module.  For example, if userspace passes an unknown
> +filesystem type to mount(), then the kernel will automatically request
> +the corresponding filesystem module by executing this usermode helper.
> +This usermode helper should insert the needed module into the kernel.
> +
> +This sysctl only affects module autoloading.  It has no effect on the
> +ability to explicitly insert modules.
> +
> +This sysctl can be used to debug module loading requests::
> =20
>      echo '#! /bin/sh' > /tmp/modprobe
>      echo 'echo "$@" >> /tmp/modprobe.log' >> /tmp/modprobe
> @@ -400,10 +408,15 @@ requests::
>      chmod a+x /tmp/modprobe
>      echo /tmp/modprobe > /proc/sys/kernel/modprobe
> =20
> -This only applies when the *kernel* is requesting that the module be
> -loaded; it won't have any effect if the module is being loaded
> -explicitly using ``modprobe`` from userspace.
> +Alternatively, if this sysctl is set to the empty string, then module
> +autoloading is completely disabled.  The kernel will not try to
> +execute a usermode helper at all, nor will it call the
> +kernel_module_request LSM hook.
> =20
> +If CONFIG_STATIC_USERMODEHELPER=3Dy is set in the kernel configuration,
> +then the configured static usermode helper overrides this sysctl,
> +except that the empty string is still accepted to completely disable
> +module autoloading as described above.
> =20
>  modules_disabled
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -446,28 +459,6 @@ Notes:
>       successful IPC object allocation. If an IPC object allocation sysca=
ll
>       fails, it is undefined if the value remains unmodified or is reset =
to
> -1.=20
> -modprobe:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -The path to the usermode helper for autoloading kernel modules, by
> -default "/sbin/modprobe".  This binary is executed when the kernel
> -requests a module.  For example, if userspace passes an unknown
> -filesystem type to mount(), then the kernel will automatically request
> -the corresponding filesystem module by executing this usermode helper.
> -This usermode helper should insert the needed module into the kernel.
> -
> -This sysctl only affects module autoloading.  It has no effect on the
> -ability to explicitly insert modules.
> -
> -If this sysctl is set to the empty string, then module autoloading is
> -completely disabled.  The kernel will not try to execute a usermode
> -helper at all, nor will it call the kernel_module_request LSM hook.
> -
> -If CONFIG_STATIC_USERMODEHELPER=3Dy is set in the kernel configuration,
> -then the configured static usermode helper overrides this sysctl,
> -except that the empty string is still accepted to completely disable
> -module autoloading as described above.
> -
>  nmi_watchdog
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> --=20
> 2.26.0.110.g2183baf09c-goog
>=20

Regards,

Stephen

--Sig_/+MMOYGDEQHeD1zd57H4NBI/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl6WKWEACgkQgNMC9Yht
g5xHkQ/+PfaiRj8GZ0xTZ/vjJGIJK7CbRdxmF4Aq2UUtjdbUT4c2kHzjIrLDJnOr
ukca2RlGdSB6k/dLeJ/kYUdYBKc82Nzg6q0ealt515lw5lDiYJ5q/yoMaMbRAIeB
rbyKiBIFzUNmE1lTMVJfAFwn0ZlM5BKdJsjUiQb2QxaRQ8rKKe3CRASlmqR3Y+9/
Lpu9geuKtyg7p+kLkra9HK3ay/bjn4ciupxyBvU38rfKsVjAOP0VmeSd2uf8Dfb8
WX0OcptNzWayalS8MkbwkEJMq4n761Ye39qRhJTCtJZkpDRUZnTGIl/+DVjj9w9K
kwvVRueNHu4ww7NE349+u4eVqElArsk1/Rua0HxBBZ7dAJ0U2km67liMmYs4rfmg
KRUktx+vjiNobdfXqmBEl3yZve0Q3XQDFhnoK7UWsv7xIgFG937qr7r7/9wHRRmK
C9txSRQfKJCRMfj8KOXs8ocZTMTlM3MU3SUwviHc5YxENtG66Kg4tVqF3ZQJ49C4
EuLQpcuSMSTa7uFSKTzEbX6gFW8DQsHRVEXcEl/0zuNpu/ECmLavbk0ZK7EX1VsP
hgxhH0MgZmQYdA7yV4d5vuVthTDTEEAG9XWa0UDo62KR1RgaSs+iyO1LXebDZiMc
LL4A+whZYHCgN6DriItBA/GInvR2U8gyhDtcFhUNhoJY0BJwbfc=
=1aqM
-----END PGP SIGNATURE-----

--Sig_/+MMOYGDEQHeD1zd57H4NBI/--
