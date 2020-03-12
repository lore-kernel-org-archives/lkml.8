Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B33BC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE8F2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgCLT02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:26:28 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:37883 "EHLO
        10.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgCLT02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:26:28 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 15:26:27 EDT
Received: from player687.ha.ovh.net (unknown [10.110.171.96])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id DF667127C62
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 20:10:17 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player687.ha.ovh.net (Postfix) with ESMTPSA id D21501053114D;
        Thu, 12 Mar 2020 19:10:04 +0000 (UTC)
Date:   Thu, 12 Mar 2020 20:10:01 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <t-kristo@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: driver-api/dma.../provider.rst: fix indents
Message-ID: <20200312201001.17756b09@heffalump.sk2.org>
In-Reply-To: <20200312181318.1368421-1-steve@sk2.org>
References: <20200312181318.1368421-1-steve@sk2.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/D1hSsBmuZS=0yQzzXmBo_nm"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 9878927258995543368
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D1hSsBmuZS=0yQzzXmBo_nm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Mar 2020 19:13:18 +0100, Stephen Kitt <steve@sk2.org> wrote:
> This fixes some block indentations, formatting them as definitions
> (which seems appropriate given the content), and addressing these
> warnings:
>=20
> 	Documentation/driver-api/dmaengine/provider.rst:270: WARNING:
> Unexpected indentation.
> 	Documentation/driver-api/dmaengine/provider.rst:273: WARNING: Block
> quote ends without a blank line; unexpected unindent.
> 	Documentation/driver-api/dmaengine/provider.rst:288: WARNING:
> Unexpected indentation.
> 	Documentation/driver-api/dmaengine/provider.rst:290: WARNING: Block
> quote ends without a blank line; unexpected unindent.

... which are already fixed in linux-next, so please ignore this.

Regards,

Stephen

--Sig_/D1hSsBmuZS=0yQzzXmBo_nm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl5qiQkACgkQgNMC9Yht
g5yjPQ/+IIi6Nyd2DgTkmWshlC+0gijXtvuEY2mvIpUm4MUnJ0QNTmC4ICVJBjHo
+JlNfadJLaxXBqomZ1tEyBh8/9C5sFGkfyar8ofz88lX4ee1A6h8PQL1z39HtXvY
YlSf1xSdWcjFO6BmLDAMpMBnl40dsGLFYtnSYrCerzj1It4JQUPDTSv5vSdm/Rnq
IIE4ccNoy1LnkqqqgpsyOtih20U5MJvtZVSl3Pcnbb5SkxpQlE0kHaqZGj6EpDF2
OIM7sIZj+ADJ+fnMEp1M/IkSCxVu/YBox7m1sOsuTAgMfjbEC6v5FDYHTMtkT/Hh
Rdpo6HWWTIFPaWFOQC/tKQQfYR63YVHZ8npMrmYwPAzqGFJ4Ql/lWKfFvDOz6XAB
SbrDt/FgpjN0E7p52ePT7HkPI04xojnzvPMzt+mD3hPOVFIAFQDzwPngI47WFGnK
ZuUVylhfMVIPmzxzHNuuwjUPDwqiqhPPhfHpHF3mvb8v+urpv20Id5V9YJP1BI2Q
InwPGeoj27I6jcIJcHijq9GSWRmzpzxyU3janNAAFsQaLZamMwAEOsOt8AaUVA7J
zT4jSw6gD79MXP5BGMKuN772PIg+7dlf8yY/kW3+jIuuBLVTXX8WRKpazuklS3UZ
byPY5jWhPt4dnKSzwhXVAL/aGN9wPPgSea5PE6SxSbfVF3xZjAQ=
=WVyT
-----END PGP SIGNATURE-----

--Sig_/D1hSsBmuZS=0yQzzXmBo_nm--
