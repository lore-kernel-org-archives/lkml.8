Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE044C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A9C20772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DrfY3qkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgFBEmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFBEmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:42:39 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8392EC061A0E;
        Mon,  1 Jun 2020 21:42:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49bfXq52Ldz9sSf;
        Tue,  2 Jun 2020 14:42:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591072956;
        bh=fKtvbAaS+Iil51RJnv0uiF7U53xY3VQx/jibttG+xiE=;
        h=Date:From:To:Cc:Subject:From;
        b=DrfY3qkpRL7ZcxRWrybul3SbgCW3aXgKF4d7nZ5EEqOxF9P8nZe6JJguOB6KS7UsP
         QZgyPYp2x3qK4YCtlxzNT5xmQvqd1tZLuMuVAPZArEPS2Pf2vPFWWsPQu6vVZRhaZT
         kDIl8HhZJFZPrFXWS/UT7Dz34vazxGCfDqaSrLzPMboJqUQKjnUVDNULccXY8MP3Y/
         V8rlq/FtbXaAeszhhUPLzyEFwIX6SUuSeEoj7RyXjgYkZa6iI4urYBCE84VdWITuo5
         jiZvH9oRi2R1o1e2ZHAqrCc0xLeDq/qf/vCqniEBjVRK+DSWM7B7hq5IOllVrYcxO5
         FaYdJ607s1Fpg==
Date:   Tue, 2 Jun 2020 14:42:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the irqchip tree with the tip tree
Message-ID: <20200602144234.70ffb673@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/StZ/XqOp4++UmMl0345z/yL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/StZ/XqOp4++UmMl0345z/yL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the irqchip tree got a conflict in:

  drivers/irqchip/Kconfig

between commit:

  d77aeb5d403d ("irqchip: Fix "Loongson HyperTransport Vector support" driv=
er build on all non-MIPS platforms")

from the tip tree and commit:

  4a786cc36028 ("irqchip/loongson-htvec: Don't compile when COMPILE_TEST is=
 selected")

from the irqchip tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/StZ/XqOp4++UmMl0345z/yL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7V2LoACgkQAVBC80lX
0Gw2+ggAiZf7uKyfH8F1E/K5adbXhqSMaqTtpP0B6qRVd5HaFLxyDE5AfPOSEMit
R9SYV8pIgSTAEU+Jt1+ZaZkGp2Ho788ibDHlD+P77l/JQNPVc3eqk0fha/b1+oJV
DeA6Qd4E1acQPVjVy3YHpit7DMGeCXLVWPTGn5nxtN/C8XDCSHVgZ2CqifQ1sUFl
ZvTcrD6mNQheAxQNeZVXZ34mvMcAneXepzaLZTTmKi3U+ZfKVBwJJrofrHqKlf4v
dfgFOIPSVYAv0qAI/uXrWRQdMeC+N/ZYDhMAo3qrJHCKB6rtKsxN2dWhkNLYEcu5
RBO1QFzLMAGaH8B6VXCclNrH8kvvtg==
=WNWp
-----END PGP SIGNATURE-----

--Sig_/StZ/XqOp4++UmMl0345z/yL--
