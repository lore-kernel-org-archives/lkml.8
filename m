Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4CCC38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854D4205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonedaddy.net header.i=@bonedaddy.net header.b="kQKORLJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDTKNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:13:07 -0400
Received: from smtp.bonedaddy.net ([45.33.94.42]:49310 "EHLO
        smtp.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgDTKNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:13:07 -0400
Received: from chianamo (n58-108-4-64.per1.wa.optusnet.com.au [58.108.4.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pabs3@bonedaddy.net)
        by smtp.bonedaddy.net (Postfix) with ESMTPSA id DBE60180043;
        Mon, 20 Apr 2020 06:13:03 -0400 (EDT)
Authentication-Results: smtp.bonedaddy.net; dmarc=fail (p=none dis=none) header.from=bonedaddy.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonedaddy.net;
        s=mail; t=1587377585;
        bh=jod12xCYdZoqLDqiEfNqvtxkjlDlQfPOlPJo+0zFZj4=;
        h=Subject:From:To:Cc:In-Reply-To:References:Date;
        b=kQKORLJllYva2I4fnjPn8rv4ux1Hg1BqcOaFMVMHHC0xUvXMiUqvo/wD2TghCCN+T
         05QlnHjg6C7Pgbmn5NkC4fr/MZJRHMgsb59rfTIdoK/SIJjccG8OcHq0I8nQEV1KSA
         /zlbyoL6cUujLcPhGke0jOq9rFpt5k2WPEC4JjzYzNByPEnr6Yj8gnDTlaWCJi68Gi
         NZbpKD9flv1Q1J9S41ab0pMKvkpEcIEoLisLoFmtPedtuu/naWm3hRLgxK7uTuCLa4
         et9LcCrOC7TkKGMbFDm8YrERe+TBhcVxCPXS/Njn9fyMvY9Phu3KlrIqKcA26Cbhy0
         lcjoaKwhvGezQ==
Message-ID: <a0034feda1f6f598c8376a418949b48109307e67.camel@bonedaddy.net>
Subject: Re: [dm-devel] [PATCH 0/3] dm raid/raid1: enable discard support
 when any devices support discard
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Ondrej Kozina <okozina@redhat.com>, dm-devel@redhat.com
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-kernel@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>
In-Reply-To: <6bbf9d94-2fbb-f96f-ea85-a480ba109c55@redhat.com>
References: <20200419073026.197967-1-pabs3@bonedaddy.net>
         <20200419131908.GA22398@redhat.com>
         <9cb6a39a43178be29af2f47a92c2e84754b62b69.camel@bonedaddy.net>
         <6bbf9d94-2fbb-f96f-ea85-a480ba109c55@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-7gYIJ8Sm/tiyMSzyv4MA"
Date:   Mon, 20 Apr 2020 18:13:01 +0800
MIME-Version: 1.0
User-Agent: Evolution 3.36.1-1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7gYIJ8Sm/tiyMSzyv4MA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-04-20 at 09:35 +0200, Ondrej Kozina wrote:

> Did you have discard allowed on both dm-crypt devices? dm-crypt
> (kernel) does not allow discards by default.

I did not, I guess that explains why I got no errors.

--=20
bye,
pabs

https://bonedaddy.net/pabs3/

--=-7gYIJ8Sm/tiyMSzyv4MA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAl6ddakACgkQMRa6Xp/6
aaMDqg/8Cj1meyJPg+ICUeg+WsYjGw/jaRrqC/UZzGwBCq/fguJ8BOwu+HtorOmM
Kqr370rlTrjwdn4THs3So6PDSr3es270GKN0Cg1sO7z97lXUYQJA1RklOHRDw/5M
EIw3uHHRNtutjWgyLScDBoy4kS+jzlNElwkj2M/amxTS2nlL99W5CI9sCdWwMjvm
+ftXtELcNC8znWUBQlPJ/JnTu4/6kfKPytrzBWGvPxODgFosI8fA1K7kMoXNSvq7
OSMCVZkq4AlhlHq+MIkXlPPE8pQoTbMTLflqD+wrusgEFGJMRYEGnndbg1vBrk5Y
ieZ/z96mxOQ4VrFEeIC9IeY560Z/lb1MJJBYJRF7HF9ez02YAqevzmM85jzo6CMv
7Bp8m+VcT/RcceAChWR14LOE+q3vJfhX1nu5wHatR3vTRYz5tFha+xqAypQMg504
sVo+YzxIp/z45EDbinz7niePh8v4V04K1ne75G2R1iX++RcIurieGBS7+4OueAEl
7anc/Evu+FPD/LDMlhGxVtiH1PqPk4ZJpD/Z6uVfKOQiOPhvF0RfPGJRE/8mW+uY
VdECV0zqsWlTYaOmSH0FiCgq3zxW5Zw8rxYs+ioHUR/431c7zo3JLBJPEF8+3H4t
x3hiW6iJ21Nw0ibptbIVJCg7jzqfMfe0cWHHqrynzZtfMIOzTAY=
=GclY
-----END PGP SIGNATURE-----

--=-7gYIJ8Sm/tiyMSzyv4MA--

