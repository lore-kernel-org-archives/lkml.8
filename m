Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B53C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71D92071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e/O8NquH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgGOBuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 21:50:51 -0400
Received: from ozlabs.org ([203.11.71.1]:36569 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgGOBuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:50:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B60hm1Rxmz9s1x;
        Wed, 15 Jul 2020 11:50:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594777849;
        bh=4QgHxfCAQBboonG2XX1+XZjhqDoWr3MhkyKnkmbrqvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e/O8NquH9L2YcbTBxTk5J/DJuooPWI11QHJ7eDSoHTvcXByO5KA5gTz6dJLOf+2Vz
         AWTwtQNSu7FDZwj6HoxS1BK6d/lyNjiidpngIHU58n5bxTYrbx0hSpVoKr0BckbVqS
         pSoIKW9zyAHn1gI1xclLE3+gEbbRQQnPGWIS+Ba1Gg/XyWf4Le7aWO5NSg2T23/PM0
         UWZQclpDPHvYreF7ox5Xr+iDnZbxkC5ct+Npj7Zv7ta8MDFqmpGyjV6z6Dtw60MU8K
         dAEBthn5jvMajMxi1jFtQFTuxVOqO4sKlVEx8fvAAREyyfZ5/fSo17f5fIqOK6okJH
         kxUI0YSkJ++1Q==
Date:   Wed, 15 Jul 2020 11:50:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>,
        <john.wanghui@huawei.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3] mm/percpu: fix 'defined but not used' warning
Message-ID: <20200715115043.45a505ca@canb.auug.org.au>
In-Reply-To: <6d41b939-a741-b521-a7a2-e7296ec16219@huawei.com>
References: <20200714134101.80534-1-cuibixuan@huawei.com>
        <20200714225311.7aeffffd@canb.auug.org.au>
        <6f1a8c76-d6d7-1a2c-8b0b-26a4a31f1a19@huawei.com>
        <20200715062229.78591ff9@canb.auug.org.au>
        <6d41b939-a741-b521-a7a2-e7296ec16219@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qGFqx0dYRdKvwv3VGvg/U.H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qGFqx0dYRdKvwv3VGvg/U.H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 15 Jul 2020 08:25:19 +0800 Bixuan Cui <cuibixuan@huawei.com> wrote:
>
> Gcc report the following warning without CONFIG_MEMCG_KMEM:
>=20
> mm/percpu-internal.h:145:29: warning: 'pcpu_chunk_type' defined
> but not used [-Wunused-function]
>  static enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *chunk)
>                              ^~~~~~~~~~~~~~~
>=20
> Add 'inline' to pcpu_chunk_type(),pcpu_is_memcg_chunk() and
> pcpu_chunk_list() to clear warning.
>=20
> Acked-by: Roman Gushchin <guro@fb.com>
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  mm/percpu-internal.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

I have added this patch to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/qGFqx0dYRdKvwv3VGvg/U.H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8OYPMACgkQAVBC80lX
0Gz2pQf/RlRCbFlqoCB/Vwd97ITx6U2YwfBhztTNFDbws8aJ3nRMj4REvOrhGtHG
PTjMJXbTdMb7bHWgPs0gIP9R8ohGb9XI1srw3ModYUCD3Hvyja3Y5Ov7nqsEtu4Z
S9Pl4ziV0UIWCZGDGYdeY2zTbMxwRD345TEqlYoZxmQT4Szpttlvbe84+Z4FLMxj
p39hOvyzu66fBWoIGfWZRIsCVDWskY2iSrp6webdeir4Ueoyn0sN0oLwS4NOryHH
a8glYhfm/tlNkONOQIDa63KX8YT8PFnb1xxUvJg5+6pNaYloS9b6XOKd+ZQ6u6vl
IvKzf7F4w4/6fmctufaQY+kX4y6YgA==
=HC4M
-----END PGP SIGNATURE-----

--Sig_/qGFqx0dYRdKvwv3VGvg/U.H--
