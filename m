Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D7FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBD420771
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgGMPg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:36:57 -0400
Received: from 8bytes.org ([81.169.241.247]:52602 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbgGMPg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:36:57 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 33070379; Mon, 13 Jul 2020 17:36:56 +0200 (CEST)
Date:   Mon, 13 Jul 2020 17:36:54 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.8-rc5
Message-ID: <20200713153649.GA2615@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.8-rc5

for you to fetch changes up to a082121b55bac125f7d09d78de00607ea75a6903:

  iommu/arm-smmu: Mark qcom_smmu_client_of_match as possibly unused (2020-07-09 17:20:22 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.8-rc5:

Including:

	- Fix for a use-after-free of the device iommu-group. Found in the
	  arm-smmu driver, but the fix is in generic code.

	- Fix for the new Allwinner IOMMU driver to use the atomic
	  readl_timeout() variant in IO/TLB flushing code.

	- A couple of cleanups to fix various compile warnings.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      iommu: SUN50I_IOMMU should depend on HAS_DMA

Joerg Roedel (1):
      iommu/amd: Make amd_iommu_apply_ivrs_quirks() static inline

Jordan Crouse (1):
      iommu/arm-smmu: Mark qcom_smmu_client_of_match as possibly unused

Maxime Ripard (2):
      iommu/sun50i: Change the readl timeout to the atomic variant
      iommu/sun50i: Remove unused variable

Qian Cai (1):
      iommu: Fix use-after-free in iommu_release_device

 drivers/iommu/Kconfig         | 1 +
 drivers/iommu/amd/amd_iommu.h | 2 +-
 drivers/iommu/arm-smmu-qcom.c | 2 +-
 drivers/iommu/iommu.c         | 2 +-
 drivers/iommu/sun50i-iommu.c  | 8 +++-----
 5 files changed, 7 insertions(+), 8 deletions(-)

Please pull.

Thanks,

	Joerg

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl8Mf44ACgkQK/BELZcB
GuOffw//fCaeb/TOZG6EmMVwNzc2L+qj0Ja5u4ng5pemQxsQpjXjog/zB2ayDbLx
tIRWThvlEtbnMHlZGsqPyVIqqWb1qAJk6Kn1IUmTG0JxWN/+SX8fewyCQRMiLYDS
ifGCVUTM84O5I8QpDtDsdTrBgUUph/Pf8P3zeiBEA2mbmsm+CrSj2yYI44xGUhiD
NhCTc7eCf1HZOdBAF15nPRqacPLyS2ZpviLodmujquh80kauRkBDu1GHCoFhcIJ7
LJl/olALhhmV2mCiptXBHvd0/m90PxH9V38JKElptXsAIL74hmNMG5thbEtRTv5C
xNrSkAniPnKRU96L49X5qT3hHixxEWK2Mb4ZEV+droefG5I1DOeo/DOaikPEhgTS
jXfRysXe4CKEbMoWRcibJOaUjkyvr3vjd5n92sgYxMjTYuTnQvSg8OJKNTBR7zLz
SUhwNyHVQ3jCnqOjLgAG3I1hsAAkYF5GN002GrZpACGp85ksRuICRQSGSs3nUMki
DQGD89tw4WOAUR4gDLP0i70Jo7p5VQcUQuzSdz/mcwrH3ix/3PHDQq/3D88Ekfp4
gVFnhzjZauvTPCE5CWfmGo1rhGap4gsTG38b8NE7gh4FkHD0SPA7N9YlObqnveAC
vLKftVjIOYomkXK+mdSYmDs7rv8scb1XsVXskrsn4T7G8SjhTyE=
=WYBG
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
