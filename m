Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0810EC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0862078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="A97fOK+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgDTLfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:35:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43379 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgDTLfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:35:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 495Pkx71S6z9s71;
        Mon, 20 Apr 2020 21:35:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587382523;
        bh=9HNZXDQ2jku75LULznlIt2gVSDkDGtRUfetclacD8Fs=;
        h=Date:From:To:Cc:Subject:From;
        b=A97fOK+EgV9lhMdHp1E6XXc6whR8BDqO9uYniP1LubHFfGS4coHuqBBXJEzZLtiH5
         y97RMaFReGX8gxplIjHnXe6Uci5eefhKc1qv8fePbubZFotJc1x4LygV6K/+hxQlnj
         wlj74+EYMEJB0TUE/m6jVcZHIU/k3pZCfcdfVUHQTg+54StDLxWWLPs4VnikGfcAMZ
         L1IOq38Y76qxX7uOOit3KWSxrs8FQD/+HcipwlsAt6KhvL5zB0NvvshzxTvjv7I5lb
         mnNv2j0On/AcWWP/MdRtkbChX7Mou82ZS2TPR7Z183PEzBz82Mpw9PXtXcnpeUrbu9
         cckd72tO4QfOA==
Date:   Mon, 20 Apr 2020 21:35:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Dmitry Safonov <dima@arista.com>
Subject: linux-next: build failure after merge of Linus' tree
Message-ID: <20200420213519.3c5ee143@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Moytko7.w5QiWdvPaewmWzF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Moytko7.w5QiWdvPaewmWzF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[reported by the kernelci.org bot]

For some time, building Linus' tree, the linux-next build (mips
mtx1_defconfig) fails like this:

ERROR: modpost: "sysrq_toggle_support" [drivers/tty/serial/serial_core.ko] =
undefined!
ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!

Caused by commit

  68af43173d3f ("serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE")

--=20
Cheers,
Stephen Rothwell

--Sig_/Moytko7.w5QiWdvPaewmWzF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6diPcACgkQAVBC80lX
0Gy9rAf+JuLx+iAw0rACbUfNtGc/eS2bqCVMDbl45AYlVyQCUemSRXZaSfdguncs
sn+YgJx3SeOoBwbhQp23tZa8k/EUxcgE5ycxnKf4MCtdAubzUwRAtIC18IyVvSS1
cIdZ2h0kZKOqcqILBUMvjf36YBBROGYWghDzbD/EefQlnfS4/4ASIjJv+t6NSod2
Byw5Kp5DQ8RbNf83f3XP2GbgfcUHTygVOg4TiH3mQFij0yzOMX6CXE1KmugQfydN
cd7jf13jpskEpo/t7+Nq+3ELu2Cy0nGg6048koKjzAHE7w9MkKiL47F4E+9TlNMO
KNIWDXlhVO1rmHkej4SB09i4gE2zMQ==
=O73D
-----END PGP SIGNATURE-----

--Sig_/Moytko7.w5QiWdvPaewmWzF--
