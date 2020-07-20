Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79112C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5592065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgGTNPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:15:16 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:44242 "EHLO
        6.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTNPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:15:16 -0400
X-Greylist: delayed 1198 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jul 2020 09:15:15 EDT
Received: from player796.ha.ovh.net (unknown [10.108.42.170])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id 79C4298DDB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 14:39:58 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id 6D8E41471EEFB;
        Mon, 20 Jul 2020 12:39:39 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R006a3aeb924-0296-417f-a3b8-f6f0c1881744,0F02D7EA884A4F67B656D4016842B815EED48EBE) smtp.auth=steve@sk2.org
Date:   Mon, 20 Jul 2020 14:39:37 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, gregkh@linuxfoundation.org,
        tyhicks@canonical.com, jpoimboe@redhat.com, jkosina@suse.cz,
        tglx@linutronix.de, keescook@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] docs: process/index.rst: Fix reference to nonexistent
 document
Message-ID: <20200720143937.00b47310@heffalump.sk2.org>
In-Reply-To: <20200718165107.625847-5-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
        <20200718165107.625847-5-dwlsalmeida@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/G1ltjrPvjS1uwgqPa15+ffG"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 10420766588460813694
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrgeeggddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepjeekffdvhfejkeffudekhedvtddvhfeiheehvdehkeetkedufeejffeuueevvddvnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G1ltjrPvjS1uwgqPa15+ffG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Jul 2020 13:50:59 -0300, "Daniel W. S. Almeida"
<dwlsalmeida@gmail.com> wrote:

> From: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
>=20
> Fix the following warning:
>=20
> WARNING: toctree contains reference to nonexistent document
> 'process/unaligned-memory-access'
>=20
> The path to the document was wrong.
>=20
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Fixes: c9b54d6f362c ("docs: move other kAPI documents to core-api")
Reviewed-by: Stephen Kitt <steve@sk2.org>

--Sig_/G1ltjrPvjS1uwgqPa15+ffG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl8VkIkACgkQgNMC9Yht
g5zYyQ/+PriM4pJoTPsHS3SErNTVbeZisEts37yOOuhYiDxzm4YKbmwB7gUcMgWr
H+0eOanfto2X6wh/vSnnkwfZD/ifJLP/eDYryF1BgUL+xi18IDoFobNgq8db4OiT
5VXohSNk6O5Sc4dZcb96RKJ5J2lDjrqJO9Psqa6C30ZYLVcGxh6Mu6D2zriOMWST
Lk7Kp2PJoFljnkU46ZZjODF6EjrBouYmTyX4UkYYIl7OfaQ7VF4JGcBLMiTtYdK3
NbmPvMJry5V7SHSX/RdxnrPq1XeD8mjHK8sdMn+IPpYoz0CHxkKj5OguGUK3MXnT
0/9iJIsYb7SG4Y996Ym3hDrowxEnoexuYk06wSOOomnF6YtM/Rhzx5SRoqG1lssj
25/hxzUdw+3nb4ROyAuAgkYCGy5qXo6JF8lL321tO0/wi0Dk+OHzW1KbtEyFkFkx
xUPCfEmKiHJq71hCWcenE/I04m8oRSTAqoxM7JyS+XIGA8LbxhY9glPqOdaX71dV
GMWKUKF1t9j0UOVwN9JfpTGxRkgBhOI909Zp1guBPAADlCmZYaVLYDFUesYCpCWC
i7KyWshGumH4HrJh+csNiqD/0mvLRdcr7rBmIudm+CdkobzUTIvruo28Vhc+OeP+
4JI1mgedlRAm0HqDj71Kw8nJu2F8iPhbXJy7Ulu/uwIipOQLRP0=
=vV5J
-----END PGP SIGNATURE-----

--Sig_/G1ltjrPvjS1uwgqPa15+ffG--
