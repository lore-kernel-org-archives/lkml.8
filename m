Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC0BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBA4214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nA0aENMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgE2GWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:22:38 -0400
Received: from ozlabs.org ([203.11.71.1]:48679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2GWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:22:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49YDy34ggxz9sSn;
        Fri, 29 May 2020 16:22:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590733356;
        bh=0hkPBU4OayEnCpn2LY0u1EX3laQKxXpw07shDgw7UU4=;
        h=Date:From:To:Cc:Subject:From;
        b=nA0aENMawOrA2JFXQNgururFV4ZlRFTnRk0k3uKNlyuQiPfhVEOeu/DOw/n/+yB5W
         i6aKt/rB8x8MqJJONJXWUKVSvMalM/gyTmsuUKBQi8r2WGTmo+z2kEx6Q0c0UJ2eYW
         QZXNFKU04Ua1+htEjzE28iwaxRZ3OjfaU0adTtVcygfeeRkn8oV4SqrneQRK2NnNsd
         +7mY6i+VL1imsLRmfJ/jTDj/BsbKbOIUBEyh4kddDvdLjfHpF+KiSpcdx8WF2jqKJJ
         EYOPebytvO0UGFL6PO7ZxIoExEvCldz0+aPE3/ca8uiOGPj3uGzPtMEb7rrAqsXV28
         5a/VzJHEaGsOw==
Date:   Fri, 29 May 2020 16:22:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: linux-next: manual merge of the rcu tree with the tip tree
Message-ID: <20200529162234.4f1c3d58@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NgeGF7mWgIPijkLkXuHoiXE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NgeGF7mWgIPijkLkXuHoiXE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  kernel/rcu/tree.c

between commits:

  806f04e9fd2c ("rcu: Allow for smp_call_function() running callbacks from =
idle")
  aaf2bc50df1f ("rcu: Abstract out rcu_irq_enter_check_tick() from rcu_nmi_=
enter()")

from the tip tree and commit:

  3f3baaf3ac07 ("rcu/tree: Remove dynticks_nmi_nesting counter")
  c0601bb42994 ("rcu/tree: Clean up dynticks counter usage")
  3f3baaf3ac07 ("rcu/tree: Remove dynticks_nmi_nesting counter")

from the rcu tree.

I fixed it up (I punted and took some from the former and some from the
latter) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/NgeGF7mWgIPijkLkXuHoiXE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7QqioACgkQAVBC80lX
0GzZOAf9EzY9W7R3G8BZaVrbCxQ2jWygkRvmBcxfV/PCx2pCEAIcvp/z98CNxmnw
IB5KU0hg3mNW9qc2Pt6Vabo5Up20JMoJzGh8Ki03thbqsNOxNgG7NBFeGG8qpfvK
ryRtBcVLd49ggr/VYa2ItAIMlXkluD8gT19U4UX68Wvd9Grmzji6FZp7GcYYmWRd
Wt8CM6fLKGYP+RY3BNVGlRNstY90UHdUA36YVLXV06BqgkuBZeruUUqWs6F75L3r
9DAHsgg6uxDxQWpV6zktL5aSsvuB4BoBGihzt3YnkqAPPYEViHVpC9MO1diV3YRr
EzmEJRZbdLg4LsxZtlYkhrpVTc5L/g==
=zMiK
-----END PGP SIGNATURE-----

--Sig_/NgeGF7mWgIPijkLkXuHoiXE--
