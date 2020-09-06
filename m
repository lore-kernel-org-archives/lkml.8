Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F331C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EF420714
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgIFPBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 11:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgIFPBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:01:31 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A80C061574
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 08:01:30 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6E14839B; Sun,  6 Sep 2020 17:01:21 +0200 (CEST)
Date:   Sun, 6 Sep 2020 17:01:20 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.9-rc3
Message-ID: <20200906150115.GA29365@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.9-rc3

for you to fetch changes up to 29aaebbca4abc4cceb38738483051abefafb6950:

  iommu/vt-d: Handle 36bit addressing for x86-32 (2020-09-04 12:14:28 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.9-rc3

Including:

	- Three Intel VT-d fixes to fix address handling on 32bit, fix a
	  NULL pointer dereference bug and serialize a hardware register
	  access as required by the VT-d spec.

	- Two patches for AMD IOMMU to force AMD GPUs into translation mode
	  when memory encryption is active and disallow using IOMMUv2
	  functionality. This makes the AMDGPU driver working when
	  memory encryption is active.

	- Two more fixes for AMD IOMMU to fix updating the Interrupt
	  Remapping Table Entries.

	- MAINTAINERS file update for the Qualcom IOMMU driver.

----------------------------------------------------------------
Chris Wilson (1):
      iommu/vt-d: Handle 36bit addressing for x86-32

Joerg Roedel (2):
      iommu/amd: Do not force direct mapping when SME is active
      iommu/amd: Do not use IOMMUv2 functionality when SME is active

Lu Baolu (2):
      iommu/vt-d: Serialize IOMMU GCMD register modifications
      iommu/vt-d: Fix NULL pointer dereference in dev_iommu_priv_set()

Lukas Bulwahn (1):
      MAINTAINERS: Update QUALCOMM IOMMU after Arm SMMU drivers move

Suravee Suthikulpanit (2):
      iommu/amd: Restore IRTE.RemapEn bit after programming IRTE
      iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE

 MAINTAINERS                         |   2 +-
 drivers/iommu/amd/Kconfig           |   2 +-
 drivers/iommu/amd/init.c            |  21 ++++++-
 drivers/iommu/amd/iommu.c           |  26 ++++++--
 drivers/iommu/amd/iommu_v2.c        |   7 +++
 drivers/iommu/intel/iommu.c         | 114 ++++++++++++++++++++----------------
 drivers/iommu/intel/irq_remapping.c |  10 +++-
 7 files changed, 119 insertions(+), 63 deletions(-)

Please pull.

Thanks,

	Joerg

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl9U+bsACgkQK/BELZcB
GuOQFA/9FEF/OAEBiLBSlFtyFVNEoVadWTs2RrTmOnXUfufE8dnHCKA3/7qKKDD4
WwwDZbdPueRQbo/G7REbDkKNrUr+UkRieMWnlpEhXD7w8dV94oVpwKSBHQhR/RZ6
uzfKHUPth8ttozSxA5PaHdLsxcOB9MMO+wF1JKTURIa1P/5dXmmc3H2Uqmpf6uuG
GOjlWqTx5lvrnhqGkCIj4TYJiILk2dwbIKcMPCz3FSbvstU9nIXXlJtKAFfDv2m3
xW+r4M5NXgISI/8Tu8ihAJrP94in2qxauCcbUw+6IMaEtsLhct60PRDf/rPjtQbO
f8a/EIZPttsfAgkWOxxDT0GtBAzzYtNpcEOEOSDhEBQL68WpTr+nUM3VJp+ZahVa
fkLM461BonEY4Pqb6PBe2lSWCuMuP2KmpUiZf8Z6hbUOhOB6Z2k4IdDy+Th55Ag3
AcDbVAVmQ+nG1H0GhRVbKmIvD4wSvYqIqj2nDqpR8gTugz0XfzS2eHoGKm3EJFOJ
TkjZunRUcHk+H3MMexjZfMSnFVheGB1KAXcbhPfXg8qmcKgnk8QdxHtwkqB3yXs0
KaqQdzoAIT4Ti7kj6LHlMEw1xbU64NmE9JWqWaMQ3yG98oLAQVD9sO6QZBAzyv83
e4A782NG0EZ2jNXkPivcfRgfvDetY3tlBfOMuW+rqMQYljRM/ZQ=
=8Q1t
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
