Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E5BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F0420706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Nh8irsot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbgFWA1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:27:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35755 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731260AbgFWA1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:27:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49rRt92hbCz9sRW;
        Tue, 23 Jun 2020 10:26:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592872018;
        bh=0sW7p/PkHLD+Tq1rXycj2cNzH1JjCQUzen32bfXLSfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nh8irsotGUlmrfdjUXXLGA5ZdCT10gGCxnSQpYkv3HLVqPbDwbYsPfAsfEOaG0T7j
         DWttd5z4pMAEb5HXtIv0vw7gb+O8w1eYofbEqd/51QMKO3ibRVhNptVhFfgNEdvKcY
         t6ERU6UKa03May6dSjljwO0lv9mT2/GXPwvbYkZR2X2+ENbKp1jyaeXLueTYth2L9b
         prof9aFzJu9/YPxiaELu5qo35ABhGmdYiL25LRXFf/duuAjMzIUDgeuhuB3s3dPiDI
         crMmW+Ne7GKy/HweKR1Lqy+H0I6DAccet2VhymDkp6tYAcUe5A0gbtt+aqjLXkSWTI
         W92L8d6gUKDzw==
Date:   Tue, 23 Jun 2020 10:26:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: linux-next: build failure after merge of the printk tree
Message-ID: <20200623102655.6d16e610@canb.auug.org.au>
In-Reply-To: <20200621131554.5a662afe@canb.auug.org.au>
References: <20200621131554.5a662afe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WGn5_jueQ4BieacC0LW1yUM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WGn5_jueQ4BieacC0LW1yUM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Sun, 21 Jun 2020 13:15:54 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> After merging the printk tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> In file included from include/linux/printk.h:10,
>                  from include/linux/kernel.h:15,
>                  from include/linux/list.h:9,
>                  from include/linux/lockdep.h:43,
>                  from include/linux/spinlock_types.h:18,
>                  from include/linux/genalloc.h:32,
>                  from drivers/soc/fsl/qe/qe_common.c:16:
> include/linux/ratelimit_types.h:16:2: error: unknown type name 'raw_spinl=
ock_t'
>    16 |  raw_spinlock_t lock;  /* protect the state */
>       |  ^~~~~~~~~~~~~~
> In file included from include/linux/wait.h:9,
>                  from include/linux/pid.h:6,
>                  from include/linux/sched.h:14,
>                  from include/linux/ratelimit.h:6,
>                  from include/linux/dev_printk.h:16,
>                  from include/linux/device.h:15,
>                  from include/linux/node.h:18,
>                  from include/linux/cpu.h:17,
>                  from include/linux/of_device.h:5,
>                  from drivers/soc/fsl/qe/qe_common.c:19:
> include/linux/ratelimit.h: In function 'ratelimit_state_init':
> include/linux/ratelimit.h:14:21: error: passing argument 1 of '__raw_spin=
_lock_init' from incompatible pointer type [-Werror=3Dincompatible-pointer-=
types]
>    14 |  raw_spin_lock_init(&rs->lock);
> include/linux/spinlock.h:102:24: note: in definition of macro 'raw_spin_l=
ock_init'
>   102 |  __raw_spin_lock_init((lock), #lock, &__key, LD_WAIT_SPIN); \
>       |                        ^~~~
> include/linux/spinlock.h:95:52: note: expected 'raw_spinlock_t *' {aka 's=
truct raw_spinlock *'} but argument is of type 'int *'
>    95 |   extern void __raw_spin_lock_init(raw_spinlock_t *lock, const ch=
ar *name,
>       |                                    ~~~~~~~~~~~~~~~~^~~~
>=20
> Caused by commit
>=20
>   494c8512c90e ("printk: Make linux/printk.h self-contained")
>=20
> changing include files is hadrer than it loooks :-(
>=20
> I have used the printk tree from next-20200618 for today.

I am still getting this failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/WGn5_jueQ4BieacC0LW1yUM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7xTE8ACgkQAVBC80lX
0GzsBwgAhX0sN9CnTf7I0SIhFxhRB+0gjymfs/nFJYXY716WvN5LT9ThOHTqAXas
g2fs5a4EjpG/mPWiSp77kVNLjfBMoTJR1ie1/IMNyE2xKM3qmb14eHwj9jiF5Nsl
AaMjpmCJVOlB1Afnps+JNQH+D3dMGmiGucOZE2FWcQzouf5TRaCqN0qOJ4qjQtdj
YCKViErDN6Ek9VCxjjSCVjGc24aWmNUMpsdYaxbvPnJYRLMXAhp/eqkN9Zvf9QjW
JTGZ/ogZyGyK9ELSQU9wKMPye9H53MyLRYJo5533nWZp7Jm3PPUmHpTrwIMQCK4S
UmG8ZlPacOXxVtcSkztvAGCnF1xU/A==
=UgPw
-----END PGP SIGNATURE-----

--Sig_/WGn5_jueQ4BieacC0LW1yUM--
