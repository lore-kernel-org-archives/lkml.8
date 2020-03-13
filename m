Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F33C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0139E206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jkBwnhJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgCMJ5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:57:52 -0400
Received: from ozlabs.org ([203.11.71.1]:42371 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgCMJ5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:57:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48f1Mw69v5z9sPF;
        Fri, 13 Mar 2020 20:57:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584093469;
        bh=pe1kF012lJcfDdaduHbyryL8XG5t/pVUetl6nXOwlLA=;
        h=Date:From:To:Cc:Subject:From;
        b=jkBwnhJqXYBYY2DFtN2siMvaX9KSJEH40JeC1M7R4MW+FXmQrc025WT0OgxDGMduc
         M6Omwyh78A+9NimmLk9GPIC2aUq79GycKA5QwyO/YRARqmKfVBs0JbvxkwG+2QlCR3
         IxYZxUQ4AAMHlIoRygglrjF2MZ9ViiwO5Vas0VHyzkY6MO/JB1grd7ojmegJlEpwXM
         GBPgzYBr/KVivdFQ0cGggAzH947c+jYj2r/q+EH5PSSpYVMdMb0cSy1XHMiICUnAiq
         7s7X91B55uirRvm5SwOFBu9qGShYGrZFwf+k6N6VUCIjVFJZbcO483UgLFs4de7OkV
         Pbjt8LP9HQVTw==
Date:   Fri, 13 Mar 2020 20:57:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20200313205748.03d30145@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O8Uy58JlLveRERi9.xdDOtx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O8Uy58JlLveRERi9.xdDOtx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (powerpc
allyesconfig) produced this warning:

In file included from include/linux/compiler_types.h:59,
                 from <command-line>:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_hwmgr.c: In function 'sm=
u7_request_link_speed_change_before_state_change':
include/linux/compiler_attributes.h:200:41: warning: statement will never b=
e executed [-Wswitch-unreachable]
  200 | # define fallthrough                    __attribute__((__fallthroug=
h__))
      |                                         ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_hwmgr.c:3706:4: note: in=
 expansion of macro 'fallthrough'
 3706 |    fallthrough;
      |    ^~~~~~~~~~~

Introduced by commit

  e86efa063cd1 ("AMD POWERPLAY: Use fallthrough;")

--=20
Cheers,
Stephen Rothwell

--Sig_/O8Uy58JlLveRERi9.xdDOtx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5rWRwACgkQAVBC80lX
0GwJiAf+KQoFAS6xFVfJ5xJwdEkRbrjdmhSC0DeBjcu5qXpIsaVty8HfoG9tDV2U
CIZtHbBvFr7K7B9YC4pVmRPs8JsVPHBPqy2cwdctG1CZaLbsp+RSw8ieldi1MRHB
RsrES8Zk1R+oaGr8Roj8jDd8GLrLnwx2G8A4a8LlGBJjaN72fbc8cAsqKRPvidft
qn3+MJ+2fmmGOglw6mcUY1ySh1nYLHk/g9G9hkwonhu4HeWYfpN8ZZ0CJEyR1r41
46Kd5G73aYI8mBDWiQjVUUV+KZx3OfkxmkkVtzF69lJea2hn8uh7NMJ163iRkapv
AWQzihrby85HtqpXvMSNmSSBI1wp4w==
=WkAW
-----END PGP SIGNATURE-----

--Sig_/O8Uy58JlLveRERi9.xdDOtx--
