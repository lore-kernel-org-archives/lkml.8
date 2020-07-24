Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD4DC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159DB206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgGXS0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:26:47 -0400
Received: from 8bytes.org ([81.169.241.247]:33414 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgGXS0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:26:47 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CD9F06FA; Fri, 24 Jul 2020 20:26:45 +0200 (CEST)
Date:   Fri, 24 Jul 2020 20:26:44 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fix for Linux v5.8-rc6
Message-ID: <20200724182640.GA12653@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit ba47d845d715a010f7b51f6f89bae32845e6acb7:

  Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.8-rc6

for you to fetch changes up to 1014a2f8d76b05e0f228dd097ac1a249c5934232:

  iommu/qcom: Use domain rather than dev as tlb cookie (2020-07-22 17:29:28 +0200)

----------------------------------------------------------------
IOMMU Fix for Linux v5.8-rc6

One fix:

	- Fix a NULL-ptr dereference in the QCOM IOMMU driver

----------------------------------------------------------------
Rob Clark (1):
      iommu/qcom: Use domain rather than dev as tlb cookie

 drivers/iommu/qcom_iommu.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

Please pull.

Thanks,

	Joerg

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl8bJ+AACgkQK/BELZcB
GuN4Ag/+LYRNBjDTSFdYRBeAApKWrAu7yMICB26qTPb1nsSxRVMmu0vZxNUlaJBF
nsHFnPSRRtZj6b5psvn5tQYFZsG4fjUHAvH9b7eRgtmmRhR09ghi07nEbO3jUCDB
lpm2hhDtbeixcxOrKqD6bdkquPtMvzIqMaG0qXuWgEvBcHmxtFLnZ2SKeNxudMlO
IMXetLjKtxLIhnQ1od3mCtkgLBWf5GgaD5CO6+jJ5rgiYYG2DkeTcKTWU0gM/bhS
5ylCJHk7rOqF7Q7a2PFGOz67hLfD539JoeiZTBLo3KVqx2F30imRKDyaLkh5q3gD
ckgSpGvMETOySacW/Cm3bYr9f7688eGAw+i7fp/GwkaBAf+46dZATk2wNC3i4sth
3ZaNmBygfL+Xz3cnsnk81xx3uMjl+qsvlVJMxG3XQron1ypt741vwb7V69hBtT1T
1Je0ykxlpu5HTJFudN3P1qjLM/8WSdjDxjfpLHeoICnLujoRNQmSKS30l1X5uhAx
7rYllOoWJnGK7J3CQzDIGNnHrqb7qPwyX6vVhij2thPxJnmPy0h13Dqr/hGquC7j
w1AjI54LIPHCPeW3U13pccratpuccf3hZW3oJyA5GSzCJGp2k6zWeGVclElxCt3j
eLSIw5rOgRxqWNdxWQZFwmbY26+IOJdvAddgeKhdjb+ykLTkRwE=
=/4zN
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
