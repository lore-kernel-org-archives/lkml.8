Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FABC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 00:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4095206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 00:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qau+JTU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgA3AbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 19:31:16 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:45529 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgA3AbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 19:31:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 487Lr15Sc6z9sRK;
        Thu, 30 Jan 2020 11:31:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580344273;
        bh=UasNzZsdmoKqNzUfwBDjvPcSgD+GAGln/F/xYXps81o=;
        h=Date:From:To:Cc:Subject:From;
        b=qau+JTU08cJFdWkUIptCsK37f/CFd4NAlRjttvCBkXbtu0xA/fru9yoWjMwHgj6a7
         beYh76PnWpZ89kn2m+RFG0LfjbViYk8WUgYDd5CrfBzqcQaPGM8Ud0meRYonJm9/Vy
         Yp8AVNoICa8dpFcoeocRW6y5mQllA7Bc2LviyAM5F9jXErCSCn7qFRyeufNtCUJv+X
         PbjAcDIxuuyxVsV/aY9qIhQ35M1nkN+JflTI9gVkP7DCd2mluVWHXesWuOVnGM42Ce
         7kS7wvF7RWRJ394T7uWge08cT+cXxRoMs9HeboOUSN2sn2ISQzQfitsPRYkfyyNEPK
         XMCD5NV2v+wAg==
Date:   Thu, 30 Jan 2020 11:31:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bharata B Rao <bharata@linux.ibm.com>
Subject: linux-next: Fixes tag needs some work in the kvm-ppc tree
Message-ID: <20200130113113.590049a8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Xu5GMCSQAi5uoDfLLOScfP3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xu5GMCSQAi5uoDfLLOScfP3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e032e3b55b6f ("KVM: PPC: Book3S HV: Release lock on page-out failure path=
")

Fixes tag

  Fixes: ca9f4942670 ("KVM: PPC: Book3S HV: Support for running secure gues=
ts")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/Xu5GMCSQAi5uoDfLLOScfP3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4yI9EACgkQAVBC80lX
0GyJcQf+MISFUiMhzEks+ikpdj72fIkC97dYHjTN+yZaaAvl9zcS3vhILNLVJcM+
JdEM0EbECnsz/WzT6NHx7YMRUSUmry8R5hw/DXQFTIBnlWtHdr/9LkANs+Lpusua
JcLnDjHPHDFhYE4NLNATSCoQUjrdROUcSdb318O5wdBvDm94JZEKwg6apBhjPtLD
WbmJOlNfR/Akje6EwT7Y/HiY4afYLnS2cgoAhLt2eP+/5t7MapJMoiR3yxZzEPYX
wML+Rjr6dfLVqqLnb7Htlx6XcYOBSYRPmyDwfgNMvP2kDj3N3VaxYqsrWmTN4/Y5
DFW03GM/LIbL8QfSmYoHXlSOH+vM+A==
=3sm1
-----END PGP SIGNATURE-----

--Sig_/Xu5GMCSQAi5uoDfLLOScfP3--
