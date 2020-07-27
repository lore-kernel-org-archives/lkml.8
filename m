Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D465BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8EA20775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MT2SdTaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgG0NqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:46:15 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42069 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgG0NqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:46:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BFh0j1Gygz9sPB;
        Mon, 27 Jul 2020 23:46:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595857573;
        bh=B1vYykWWB1vRTRXzc6qPktG/npyuWbJ8rcf/oj8D32E=;
        h=Date:From:To:Cc:Subject:From;
        b=MT2SdTajAUxbjtyZ7GYqErCSlB35KKGQMQQMxoGEw1MScnB5xDE52MZidM4q8pJhX
         0AjNx9rDbYiCjtV1iVOSMJ0UOwWHuIBZyssVCYS37fGK2dUQqPKIFzLCp9nkbEmGWJ
         Un+vPj3aYUypmdjaRhZiInBmyp8gEpNZ6Q2QpECjQIKiF7B+/48IjM4GABjr8eXF6I
         V+IRNitQTFtPKHvVFB380xmPtYd+0UuOXUe+EUQcjM9dU1tHbXU6FWkFXqv5XZ6yPe
         Lo7ZMLw+zKmJUNu4GnNiosz2J9Y4xDJIPCHkn6fyHwkBBUWto8E40nRiSAb3YwSP9b
         QuM2pf3stDkHw==
Date:   Mon, 27 Jul 2020 23:46:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: linux-next: Fixes tag needs some work in the printk tree
Message-ID: <20200727234612.3037c4a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OoKAPBgphrrI0yd9CSkMldM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OoKAPBgphrrI0yd9CSkMldM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  96b917f8e9ec ("printk: ringbuffer: support dataless records")

Fixes tag

  Fixes: ("printk: use the lockless ringbuffer")

has these problem(s):

  - No SHA1 recognised

Maybe you meant

Fixes: 896fbe20b4e2 ("printk: use the lockless ringbuffer")

--=20
Cheers,
Stephen Rothwell

--Sig_/OoKAPBgphrrI0yd9CSkMldM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8e2qQACgkQAVBC80lX
0Gyv6ggAhAASWG145yAQpOhUd+3bYdxAeJcOxeKVJTqrWuCfNDqf1NwyG9yUaiAh
QU1ePPL6ubgVSFe5j+9fTqzumQjLZRKIRPPzU8h6qabO0vtfvzmrF5+EwfXuv1Yl
5Uilaa0C3Zpn6s8xdYaeiaElx9OvC740oyvFxmwTiY3nr5+RUWeveWDTbzZ/PHRo
VxqvM539L2wbwDHPu09dwByRgd2N7y0/Rykkfp1NFHCqvZZDjZXJq3/kAwobPDYy
zRqDHhSJT1QNxRJYRVz2an33/cZPbXfvZRS9cW3UKtmEUOyroKWVRbBoE9EUU1sk
9dw2Bs21WFZYRnSY2g0BE/e7eHIS7w==
=RmbZ
-----END PGP SIGNATURE-----

--Sig_/OoKAPBgphrrI0yd9CSkMldM--
