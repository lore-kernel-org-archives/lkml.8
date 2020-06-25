Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B529AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 02:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F32620789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 02:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ag48Ej54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389568AbgFYC57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 22:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388930AbgFYC56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 22:57:58 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C991C061573;
        Wed, 24 Jun 2020 19:57:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49sl7Q29dtz9sRf;
        Thu, 25 Jun 2020 12:57:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1593053876;
        bh=psPe9FzujwmVzuE9PFq9+5QBvHHW8QOUloymleHrmB0=;
        h=Date:From:To:Cc:Subject:From;
        b=Ag48Ej54AJGxJsdBdpiEhqFZENi3qz0QyS2Oz5N/MKZcYhCrKjwBFQhLq4fvRCXZ/
         gJyRNiAC1QSaHQTazLRNHjKM9c4oTZY9pb6h9Xdr3bPNHg673GvvRl16m0UYBPMXTV
         EqoEbQCBfmL8tmUL865HR7jn/MyQCcs4OmnxQnUZPFOsUch5PcfUKVoJLXf+1OjteM
         3hJoiaBPR311aFtxdk/9oyYueTvEHL25wcPYSJ/bFBIhfAJpX5Z7ZpD0R/HSr/vnel
         nLcWrWcHQN/94vOibwgiEdlty4MOiQ+x79GURsSFmmRQGuhbJcNO2jQ5m1KEjMMm3x
         ZJOrV+Fts3ETA==
Date:   Thu, 25 Jun 2020 12:57:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: linux-next: build failure after merge of the rcu tree
Message-ID: <20200625125753.6ec44d50@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bJTHBuQJEM8peeNQsjWP.RA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bJTHBuQJEM8peeNQsjWP.RA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

kernel/rcu/tree.c: In function 'rcu_dynticks_eqs_enter':
kernel/rcu/tree.c:251:8: error: implicit declaration of function 'arch_atom=
ic_add_return'; did you mean 'atomic_add_return'? [-Werror=3Dimplicit-funct=
ion-declaration]
  251 |  seq =3D arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dyntick=
s);
      |        ^~~~~~~~~~~~~~~~~~~~~~
      |        atomic_add_return
kernel/rcu/tree.c: In function 'rcu_dynticks_eqs_exit':
kernel/rcu/tree.c:281:3: error: implicit declaration of function 'arch_atom=
ic_andnot'; did you mean 'atomic_andnot'? [-Werror=3Dimplicit-function-decl=
aration]
  281 |   arch_atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
      |   ^~~~~~~~~~~~~~~~~~
      |   atomic_andnot
kernel/rcu/tree.c: In function 'rcu_dynticks_curr_cpu_in_eqs':
kernel/rcu/tree.c:314:11: error: implicit declaration of function 'arch_ato=
mic_read'; did you mean 'atomic_read'? [-Werror=3Dimplicit-function-declara=
tion]
  314 |  return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
      |           ^~~~~~~~~~~~~~~~
      |           atomic_read

Caused by commit

  d2f8491368e5 ("rcu: Fixup noinstr warnings")

I reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/bJTHBuQJEM8peeNQsjWP.RA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl70ErEACgkQAVBC80lX
0GzaYgf9EeSnACAXZv6/pEn2jlqn/dAiRC6IBF+fsXdlu++mqbGuc05PRXyH1zK2
1z7zAHlbU9cEM9R4723WGeyTwRBN+LV1jjO1YAe0OXisJI5HWoXcLNToEnMd4+8b
rB9a6g3YaK9FF1SAJGgQupzgKY5jReo7dT5ueRUPGpdLILBH4BqJ+LvXXeIa+ZQW
m/SLbON0cgHgYR1v5FEgqQqS+a/fNGe+bNGHQGenTaaUXluzdrOi1q+yYV8BNn8D
Ux5yUhZyAAa9edwiTnhUd+FpejIKv/ojBHkudhuSRNDTpwbirf/XzXH3zTysRfQZ
NctqjW1sM8LmQAo1WZtmJC9K3TqGoA==
=Y+S6
-----END PGP SIGNATURE-----

--Sig_/bJTHBuQJEM8peeNQsjWP.RA--
