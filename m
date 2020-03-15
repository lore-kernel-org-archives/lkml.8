Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A93C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 10:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC9220575
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 10:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGiYoRT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgCOKM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 06:12:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33702 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgCOKM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 06:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584267144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fYeknRcTWmnQg8ZYRz0ZJkyEQG95MNGzU7Kd6SLL+M=;
        b=KGiYoRT5/pHTLCbsXHXyfUGwxRTA05LKHRjQn8elcem/8l8E1ZlqCjCul7ZyD6/ILYJZiM
        IHak6IkjZZppYKHNj6MvnphMorjHoiv5bXn0qxGl/f5h/qs8c5F3RC2eNpLoYWC69JBSqx
        snyxBOBc7a1BvUr1Prkk34/EqGw6dzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-ojHza0DOPKSAkDn91LjYXg-1; Sun, 15 Mar 2020 06:12:21 -0400
X-MC-Unique: ojHza0DOPKSAkDn91LjYXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A3A91005512;
        Sun, 15 Mar 2020 10:12:18 +0000 (UTC)
Received: from localhost (ovpn-116-26.ams2.redhat.com [10.36.116.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1792A5C1B2;
        Sun, 15 Mar 2020 10:12:16 +0000 (UTC)
Date:   Sun, 15 Mar 2020 10:12:15 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH 0/2] doc: zh_CN: facilitate translation for filesystems
Message-ID: <20200315101215.GA325031@stefanha-x1.localdomain>
References: <20200315092810.87008-1-wenhu.wang@vivo.com>
MIME-Version: 1.0
In-Reply-To: <20200315092810.87008-1-wenhu.wang@vivo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2020 at 02:27:58AM -0700, Wang Wenhu wrote:
> This patch series set up the basic facility for the translation work
> of the docs residing on filesystems into Chinese, indexing the filesystem=
s
> directory and adding one indexed translation into it. The virtiofs.rst
> added is not only a translation itself but also an simple example that
> future developers would take.
>=20
> The detailed diff info also shows the basic essential markups of
> the toctree and reStructuredText, at least for the most simple occasions.
> More translations of filesystems are on their way, and futher,
> of more subsystems.
>=20
> ---
> Wang Wenhu (2):
>   doc: zh_CN: index files in filesystems subdirectory
>   doc: zh_CN: add translation for virtiofs
>=20
>  Documentation/filesystems/index.rst           |  2 +
>  Documentation/filesystems/virtiofs.rst        |  2 +
>  .../translations/zh_CN/filesystems/index.rst  | 29 +++++++++
>  .../zh_CN/filesystems/virtiofs.rst            | 62 +++++++++++++++++++
>  Documentation/translations/zh_CN/index.rst    |  1 +
>  5 files changed, 96 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/filesystems/index.rs=
t
>  create mode 100644 Documentation/translations/zh_CN/filesystems/virtiofs=
.rst
>=20
> --=20
> 2.17.1
>=20

I am not a Chinese speaker but thank you for translation the
documentation!

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5t/38ACgkQnKSrs4Gr
c8i7pggAxFGK9yalFhtI40r+K7LMZVxPGH3zc20Ho6hCuGGbk0pnrVxuDOyAsgTo
w809N9Ypju11BY4lh8vzpA8wmi+mrjCI1I+/Md87gv+vIuur17n6v895rHas9rkh
VN6uRiHTxQR/zaDSaUM3yrR/KDCqHqe26T77B8//ope+JTqpWRNrhNccDtz5x/Kt
BVWkyKGmHwKK2LZm3OkHHYXhZx519RS6gBrxbzSySnBbwPbBWcY75et0o8c3FSJP
qh/pJ8keEtMEKVj/EGTZ2B9MN5d4nSi1yhxVizGHWkeDJ/yg6/l2kMKQ7MzAxPIP
iM5LDusm9auID4W1sU3363No0ZF+4Q==
=Sx9O
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

