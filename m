Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830ECC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64479206D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qJ72SvLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEHBnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 21:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEHBnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:43:43 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A290C05BD43;
        Thu,  7 May 2020 18:43:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49JClw4J0pz9sRY;
        Fri,  8 May 2020 11:43:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588902221;
        bh=1wLoxkkY9YL7HHfDN3xPSDGcQoGfNr7wJukvvyf1oa4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qJ72SvLFl47rBhtq2X7x6/EFJScJP9TYDPssBU0kNDfkDo4gPKG0uoCPcdnH9aqdo
         tG0XHLX/R5WfymPB8DOnaH72919jMUlRElJqK8gNBfdy3VBMH18XQ059AuN0+5ovnp
         em+dC5DoIhB0fHJoUotMPkwU8zK1SlWWz9cxRpx/NDHygrUcfn01BjG2RAfZS+ztQc
         mUKn8BI5hwmk3PwiACQSszKhChn/jX6cmYYdBx5wef/4avUsZmEvjLAkrnz2i69Ab7
         29if27k0DE5R0I/gqKinvuYaoL47d4P6L7XnRRsKnws7/Kfm0xSxGYzRnYKPP09d0P
         z5IE3iPvyVnsA==
Date:   Fri, 8 May 2020 11:43:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20200508114338.02d2b843@canb.auug.org.au>
In-Reply-To: <20200507221721.0330271c@canb.auug.org.au>
References: <20200507221721.0330271c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gWV6hIMcFCsa=dV2OB6P/I.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gWV6hIMcFCsa=dV2OB6P/I.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 7 May 2020 22:17:21 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the akpm-current tree, today's linux-next build (arm
> collie_defconfig and many others) failed like this:
>=20
> arch/arm/mm/dma-mapping.c: In function 'dma_cache_maint_page':
> arch/arm/mm/dma-mapping.c:892:6: error: implicit declaration of function =
'kunmap_high' [-Werror=3Dimplicit-function-declaration]
>       kunmap_high(page);
>       ^
> arch/arm/mm/flush.c: In function '__flush_dcache_page':
> arch/arm/mm/flush.c:221:6: error: implicit declaration of function 'kunma=
p_high' [-Werror=3Dimplicit-function-declaration]
>       kunmap_high(page + i);
>       ^
>=20
> Caused by commit
>=20
>   6b66ab470b4d ("arch/kunmap: remove duplicate kunmap implementations")
>=20
> kunmap_high() is now only declared when CONFIG_HIGHMEM is defined.

Is there anything that can be done quickly about this as it broke a
large number of builds ...

--=20
Cheers,
Stephen Rothwell

--Sig_/gWV6hIMcFCsa=dV2OB6P/I.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl60uUoACgkQAVBC80lX
0GyOuAgAkfoqA2UzIk5jra5cPLhHMe8/Ug0E3/DxEX/uFHLBQ9wRytAT8SM1Ty0O
ssm13c5YtZOHfOeWFvyh746gw9QcXB8ORUdeeW1/bbtoFRwq/kptP0RRP9mHz+RA
rAHaT/DDYsHB+JRKkjyJYk4Y4uy4L+9B0wBA6wRlIqs+c6PPPom9gbayk+kD0nLd
I3bVjDPCYbov5w1y1K0pzXCalg2XNsaKEHT8Zqtf7QA4eoNTGQX/2unOdTMAFWrJ
bfjnnIoNzzReNB+w0dYD5XOE0Tf1CiwUsjZ8kVR0Jla9cwmBst/liRylTkV1QtV+
dDMn35nM00Tz09aVVCWKnTNxbiPEvA==
=P9ww
-----END PGP SIGNATURE-----

--Sig_/gWV6hIMcFCsa=dV2OB6P/I.--
