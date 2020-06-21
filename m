Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D143C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 03:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D764214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 03:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XQdJmFLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgFUDQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 23:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgFUDQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 23:16:00 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6BBC061794;
        Sat, 20 Jun 2020 20:16:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49qHk35v69z9sRW;
        Sun, 21 Jun 2020 13:15:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592709357;
        bh=TCjP38Yjt6IyEg+R3oHmUvpaJ3vzLP0ZKXa0OWjZPyg=;
        h=Date:From:To:Cc:Subject:From;
        b=XQdJmFLUTTMYRuajF7eCxZz8/v9tDQNwP8BXBAO7VOiDciQkXWoH5YVlRDjnoaZ+9
         ZBYjHzFqbAYUQxMe53rAOioHzpd3G6Rxw/d7EQOKhcOmuj0LwItHRVfjqgTzXakwPX
         PgB4QxaZ5ZqxFM46TxMc6xV4Hu1bbvbjbvo/pLKdM99b7SsvbVSCrJ0o0p502xLkka
         441DhTYIEdWMd9zuJsRoU3W0feWP2OF9H3sHh6s1tYJlHsaDZW+jiU9+233au7oN4T
         6OOoCNppIrMrho8Nv/K4C1WayA+dWDGjWNQiSVKNDjjM6LUTD5XXyP/WBeCth/1JXG
         7dx4Jdz4YuNPA==
Date:   Sun, 21 Jun 2020 13:15:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: linux-next: build failure after merge of the printk tree
Message-ID: <20200621131554.5a662afe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PRKw8==YXVF31BiyaBR5zFr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PRKw8==YXVF31BiyaBR5zFr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the printk tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/printk.h:10,
                 from include/linux/kernel.h:15,
                 from include/linux/list.h:9,
                 from include/linux/lockdep.h:43,
                 from include/linux/spinlock_types.h:18,
                 from include/linux/genalloc.h:32,
                 from drivers/soc/fsl/qe/qe_common.c:16:
include/linux/ratelimit_types.h:16:2: error: unknown type name 'raw_spinloc=
k_t'
   16 |  raw_spinlock_t lock;  /* protect the state */
      |  ^~~~~~~~~~~~~~
In file included from include/linux/wait.h:9,
                 from include/linux/pid.h:6,
                 from include/linux/sched.h:14,
                 from include/linux/ratelimit.h:6,
                 from include/linux/dev_printk.h:16,
                 from include/linux/device.h:15,
                 from include/linux/node.h:18,
                 from include/linux/cpu.h:17,
                 from include/linux/of_device.h:5,
                 from drivers/soc/fsl/qe/qe_common.c:19:
include/linux/ratelimit.h: In function 'ratelimit_state_init':
include/linux/ratelimit.h:14:21: error: passing argument 1 of '__raw_spin_l=
ock_init' from incompatible pointer type [-Werror=3Dincompatible-pointer-ty=
pes]
   14 |  raw_spin_lock_init(&rs->lock);
include/linux/spinlock.h:102:24: note: in definition of macro 'raw_spin_loc=
k_init'
  102 |  __raw_spin_lock_init((lock), #lock, &__key, LD_WAIT_SPIN); \
      |                        ^~~~
include/linux/spinlock.h:95:52: note: expected 'raw_spinlock_t *' {aka 'str=
uct raw_spinlock *'} but argument is of type 'int *'
   95 |   extern void __raw_spin_lock_init(raw_spinlock_t *lock, const char=
 *name,
      |                                    ~~~~~~~~~~~~~~~~^~~~

Caused by commit

  494c8512c90e ("printk: Make linux/printk.h self-contained")

changing include files is hadrer than it loooks :-(

I have used the printk tree from next-20200618 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/PRKw8==YXVF31BiyaBR5zFr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7u0OoACgkQAVBC80lX
0GxufAf/TXpcV8uY3vUUj9WLPqRGzyoyExxMtD6HUMWYhbVROanjRKhyoQw7VJ7e
ZXuRTb2axJ9tbY1qrL6Ty9CmDhCptwOj7EmJC6jjMpfGDx28HNcyfE866LHk+pZi
wyhuVaDj5fWFM2AIDczH0oav3KmGC79QG+xH4CaaeVQaBRPNeg6h+Z0ILE3flghs
oLBhdyKgCCmeAeqTKSTTl7eHZPdaAjGhEPfYP4CV1FgR4IgSvSMMgqqzEGCRJuK9
xNQeQpcLy4J6UyAOtUN9ACG8ERkcLmK/AvLmyWX8QVyRNMQr6mq5DQZKtAfB1rFm
4OT/QTC3lNfJAYMN46fbmXj/2nhwbQ==
=9nQw
-----END PGP SIGNATURE-----

--Sig_/PRKw8==YXVF31BiyaBR5zFr--
