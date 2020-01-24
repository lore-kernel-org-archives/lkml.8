Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF49C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEEB2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389270AbgAXR3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:29:47 -0500
Received: from 8bytes.org ([81.169.241.247]:60826 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387661AbgAXR3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:29:46 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 79A5AA52; Fri, 24 Jan 2020 18:29:45 +0100 (CET)
Date:   Fri, 24 Jan 2020 18:29:44 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.5-rc7
Message-ID: <20200124172938.GA30565@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.5-rc7

for you to fetch changes up to 8c17bbf6c8f70058a66305f2e1982552e6ea7f47:

  iommu/amd: Fix IOMMU perf counter clobbering during init (2020-01-24 15:28:40 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.5-rc7

Two Fixes:

	- Fix NULL-ptr dereference bug in Intel IOMMU driver

	- Properly safe and restore AMD IOMMU performance counter
	  registers when testing if they are writable.

----------------------------------------------------------------
Jerry Snitselaar (1):
      iommu/vt-d: Call __dmar_remove_one_dev_info with valid pointer

Shuah Khan (1):
      iommu/amd: Fix IOMMU perf counter clobbering during init

 drivers/iommu/amd_iommu_init.c | 24 ++++++++++++++++++------
 drivers/iommu/intel-iommu.c    |  3 ++-
 2 files changed, 20 insertions(+), 7 deletions(-)

Please pull.

Thanks,

	Joerg

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl4rKYEACgkQK/BELZcB
GuNdkhAAlRLkHjoXT38iYdfMCBUggHmc7U5H/GiIADORG9kD/CoKDwmvtmpqRfk/
Kta1udCotWFtBGyWm77mglk2cdxlHAyfsN+Prmy+4acFCBu/7dgu/KvgaYWcZiz+
UGNuHP8D9LvXIupkEI3w4xszR63TBPU8ptwQti0yyXb11zpyUFu8WdJgOjE/ejDM
CqABUbgYy5ZGnWmU3mmNF7uU895199jRCy74PWJ8fyulhwlIeXVRGviseF7Lhumr
SULq7PGXVWrLQ4BxWXHQZ+bTA7ZtOntj80DH5pLXkQYEWYbF46Tk4o+7swsdcRvj
+EFdDxrLkgVtuRWXGQ9e1LcK/hpWTuoWcZZiAEskmGuQfCASuK9v0a0Z7tOa3VYO
ewVzn7fQFP4jM/6Vj4ulqw34+xTWnZ77W7LCgCYxAc/mVSSaWu5ieR7uqtTBFRpv
IC6w95gQaUwMYnh42UN+5TLRWVrGxZVQ2daCsoqu0m4H0N1B2sXyJOK9AuAMDteN
FxDQJc+YBPfVCB5mnHopU604uzVTXJ8goXudo4kAz3B45JvCngCa5pPUYfWMsf1j
0XdVy9uDw17mRTX85gv5AjwbyIM2exowxbaGI6+3Y3m853WZN1tHIkV5dF/ulT+M
M3GgWktVnd5J8BfJgvaKvncxVRWL/mCymNYi2YUQD/yCBp01r1o=
=DFl+
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
