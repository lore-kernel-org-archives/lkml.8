Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B411C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 03:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71CB2076A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 03:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c+TabvGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgC3Dfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 23:35:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729239AbgC3Dfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 23:35:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48rJ526rbjz9sPR;
        Mon, 30 Mar 2020 14:35:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585539336;
        bh=0N1vyu0JrrPWsv0e3uRcCWRzBXBCY3mf6GeXnYgep5M=;
        h=Date:From:To:Cc:Subject:From;
        b=c+TabvGu5Ux4Bt1sJJs/BnP9B/9ysQcG8SiUYVDaNnNGMdnvQkZI0JILCxd6H+u9O
         RsoQb2MjSVtkVWMR3aajq7aIh2wxQWYuSsQ+iGGAiLtlGPp0oNGPE41M9nLVCVCNnv
         Z0BxJATDCYZNpiK7yyXuWJ8M3RWmejAhO4DUylojIvuo6JDFiNTDSvaEDWOMgooK8A
         2U276AnJKpv77HdwsA9J7LD0uEkrLOMfMKcJ60CV+5D6V31n0MeA2qBMbfRnSR5Ke8
         4O640q0E3WgaogX14O/x997va5N8C8WhlVMbc+N4iP0ORDoUB7YazrglyzCW4944cb
         ps5bozuOFBmtA==
Date:   Mon, 30 Mar 2020 14:35:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20200330143529.4dafeb34@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UpT7KfG+Q+LkgpTns95Jv8E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UpT7KfG+Q+LkgpTns95Jv8E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ld: warning: discarding dynamic section .rela.data.rel.ro

lots of similar warnings, followed by

`.exit.text' referenced in section `__bug_table' of crypto/algboss.o: defin=
ed in discarded section `.exit.text' of crypto/algboss.o
`.exit.text' referenced in section `__bug_table' of drivers/macintosh/windf=
arm_core.o: defined in discarded section `.exit.text' of drivers/macintosh/=
windfarm_core.o
`.exit.text' referenced in section `__bug_table' of drivers/i2c/i2c-core-ba=
se.o: defined in discarded section `.exit.text' of drivers/i2c/i2c-core-bas=
e.o

Caused by commit

  72cb2113c1bb ("vmlinux.lds: Discard .note.gnu.property sections in generi=
c NOTES")

I don't see why, but reverting that commit fixes the build warnings
and failure.

I have reverted that commit for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/UpT7KfG+Q+LkgpTns95Jv8E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6BaQEACgkQAVBC80lX
0Gzc2Af+PdnxYxwuqyeJG6ScjYkNHlAxY2a+tJulxJBfTw0FYiNdrCZeh0fWzHI/
R43hptTY9apWeQIsgOqsu6ruhOlV6KuZ7/vgvqT0ySK2ecPWlv8Enc9k3i7t7YMU
E78Ywo4UzFpg8eGKI2o5F3QmTi4X4t9+eXMwk4x1cCY94BMPXBvVn3MhhALY/oPc
TlIbps2a7jRkA+RLHjXXoQ/yGodsdGB5qDIkUNCIsXKZ5uJ3pn73aqFXxjLpI8xw
T+lUltD5Vw55EikNU0bP2G3mu8pyLrO1DO6uCIHyhDIIYufYqD5G4fRJCaTK5VTm
c+zcuch0gkwgFQniOIy12YdGb0YD4w==
=uN79
-----END PGP SIGNATURE-----

--Sig_/UpT7KfG+Q+LkgpTns95Jv8E--
