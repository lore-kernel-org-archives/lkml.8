Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BF2C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51122464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBSQvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:51:25 -0500
Received: from 8bytes.org ([81.169.241.247]:55022 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgBSQvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:51:25 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2BA8833E; Wed, 19 Feb 2020 17:51:24 +0100 (CET)
Date:   Wed, 19 Feb 2020 17:51:22 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.6-rc1
Message-ID: <20200219165116.GA7503@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.6-rc2

for you to fetch changes up to ab362fffa0feb0da23191111e60b641d39130053:

  iommu/arm-smmu: Restore naming of driver parameter prefix (2020-02-19 12:03:21 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.6-rc2

Including:

	- Compile warning fix for the Intel IOMMU driver

	- Fix kdump boot with Intel IOMMU enabled and in passthrough
	  mode

	- Disable AMD IOMMU on a Laptop/Embedded platform because the
	  delay in introduces in DMA transactions causes screen
	  flickering there with 4k monitors

	- Make domain_free function in QCOM IOMMU driver robust and not
	  leak memory/dereference NULL pointers

	- Fix ARM-SMMU module parameter prefix names

----------------------------------------------------------------
Joerg Roedel (6):
      iommu/vt-d: Fix compile warning from intel-svm.h
      iommu/vt-d: Add attach_deferred() helper
      iommu/vt-d: Move deferred device attachment into helper function
      iommu/vt-d: Do deferred attachment in iommu_need_mapping()
      iommu/vt-d: Remove deferred_attach_domain()
      iommu/vt-d: Simplify check in identity_mapping()

Kai-Heng Feng (1):
      iommu/amd: Disable IOMMU on Stoney Ridge systems

Robin Murphy (1):
      iommu/qcom: Fix bogus detach logic

Will Deacon (1):
      iommu/arm-smmu: Restore naming of driver parameter prefix

 drivers/iommu/Makefile         |  4 ++--
 drivers/iommu/amd_iommu_init.c | 13 ++++++++++++-
 drivers/iommu/intel-iommu.c    | 41 ++++++++++++++++++++++++-----------------
 drivers/iommu/qcom_iommu.c     | 28 ++++++++++++----------------
 include/linux/intel-svm.h      |  2 +-
 5 files changed, 51 insertions(+), 37 deletions(-)

Please pull.

Thanks,

	Joerg

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl5NZ4QACgkQK/BELZcB
GuOe4w//a/2D9GfQeOZAfFZwlvWvvI7z7OrwlpOQK07cY1eCygcT8C/aFh+cBpzH
cXikuzdNUZm7O78MqRy9AJ92diPBde/wn2ldZrFqI0EGP37BOXMeOdxKhv4Tw4Qz
6fukIrs2UivLRHvCQteSdOhvjvmBO29HiykDTx0zXfzJSlgmS1Ae6FxipGr21fp5
RwSjT+JfAcCajLop/MaM9T/CKJxcedgzrf+smr97DX5Ux92tTD1ym+vQ6AwTfA3Y
jzA09JZGBPmcypS8+XI0kEFEhEJNmK2+vTub1JOza/NH9RBQ5b3GB95KyxqraBgj
gH7Ff1Mkef07IbI8PH1U9QWeoI+9j8U9cgL19TBRkhnJFDOraOeeLA2hK1aDYtJw
wuB9G5jA3G9a/ETUj1r/p8CljIxtE1oMuhdFFNwInxC5xHLFLGuolIE+wEhMZdYt
/7xGvzMD82yi2cDUqFjLbCAt+OyDBqXx2UgDs/88NSBGXiyiG3gigt7gGTySGS6E
mX+xMcfBbn0+fmtF+1P8oLb9UqVD51XfgXg+VQALBMrHvJj+bLuhv9Syp4tLN3sC
ZZ5sQhtKPkweqspjR0Av4nkvItkoD0ilAVNgI0LBjAJ5/VHazujvbighh1tFFCd5
nNzC1ldL66Kd9AwhVutY7quMq3FMxmRoUwW02/lXvrcFhHYlD3I=
=+M+m
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
