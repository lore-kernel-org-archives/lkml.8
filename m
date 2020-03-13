Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F08C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD82920637
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OXZtnXfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCMCTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 22:19:11 -0400
Received: from ozlabs.org ([203.11.71.1]:43833 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgCMCTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 22:19:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48dqBd3LZWz9sSW;
        Fri, 13 Mar 2020 13:19:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584065946;
        bh=NVMEuaQx4TxOWTt4RbY0DGYKQCDGpPDgE1FjtwKP62g=;
        h=Date:From:To:Cc:Subject:From;
        b=OXZtnXflXSgETNQG9tzLywnQqzVk0BwXxjOA0ddMxYjFqGMvNhdUBmre2f14XQUms
         ENMNmBs/lIQPsEjDLv/rAKVy6qpb+JE6opcuZiWNtQDDJFAvr6GnvZX1qa5pPuJ1eN
         SdjphArhLeBoP2hDi3jgc7HjzosZYwWwh2JZZ1g/10wL6Wo3pgbp+XIPKsj6naDWxk
         /iRt6/vlOwXksbjBBXnmtu4UCKbdnHtMU19AkycLOfi2G6jQ4tMbThv0KUvJuEEx2f
         +L5TXNNJNcD3ipHWIBfEvnrgzAAlxvnmhStGW680vKhjBKZ1WNvt3QLiNvCtkq/3Jd
         uMbPBlJSNe+4g==
Date:   Fri, 13 Mar 2020 13:19:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: linux-next: build failure after merge of the v4l-dvb tree
Message-ID: <20200313131903.3975cdd2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aaVrJ9xWlerAddN4drz9MQ1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aaVrJ9xWlerAddN4drz9MQ1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

ERROR: modpost: "fwnode_get_name" [drivers/media/v4l2-core/v4l2-fwnode.ko] =
undefined!

Caused by commit

  dfc22c073b78 ("media: v4l2-fwnode: add initial connector parsing support")

I have used the v4l-dvb tree from next-20200312 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/aaVrJ9xWlerAddN4drz9MQ1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5q7ZcACgkQAVBC80lX
0GyThggAokPa7fqKCMQneit5QBLLZcBkldmDSeJ029oNeEefcFSqSeafcDr1uynQ
7K4phlybJFhpkEJ7U2o1Wc8fACBv6/Fq7QST1INm+vp+VKPeDM5Aq9CSYIP3qjhI
jqWne8+4OrO99AgNm3maphfoPTweri2b9VDR7mcoKsEZGnCabsauS7T2mERsis6O
eR/J039gfqBu7XFtaMP+2FmMBcF4qyX+vW6VFjN6IIX5KXbk6myo+M5eKUaR7TzP
C6n93me0Zptg3gjnXIbgXK+Fbyq79S3f0IeOXlHHkR3MKIjrN5JkJPeW3g2mYDA5
Lb943M/XV1FOlLALi8SsvE7Ezfhu4Q==
=02CG
-----END PGP SIGNATURE-----

--Sig_/aaVrJ9xWlerAddN4drz9MQ1--
