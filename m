Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3584C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B2D2075B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgECMTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 08:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727807AbgECMTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 08:19:40 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B13C061A0C
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 05:19:40 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E13FF3A2; Sun,  3 May 2020 14:19:35 +0200 (CEST)
Date:   Sun, 3 May 2020 14:19:34 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.7-rc3
Message-ID: <20200503121929.GA10425@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.7-rc3

for you to fetch changes up to b52649aee6243ea661905bdc5fbe28cc5f6dec76:

  iommu/qcom: Fix local_base status check (2020-05-01 13:37:23 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.7-rc3

Including:

	- Fix for a memory leak when dev_iommu gets freed and a
	  sub-pointer does not.

	- Build dependency fixes for Mediatek, spapr_tce, and
	  Intel IOMMU driver.

	- Export iommu_group_get_for_dev() only for GPLed modules

	- Fix for AMD IOMMU interrupt remapping when x2apic is
	  enabled

	- Fix for error path in the QCOM IOMMU driver probe function

----------------------------------------------------------------
Geert Uytterhoeven (1):
      iommu/mediatek: Fix MTK_IOMMU dependencies

Greg Kroah-Hartman (1):
      iommu: Properly export iommu_group_get_for_dev()

Kevin Hao (1):
      iommu: Fix the memory leak in dev_iommu_free()

Krzysztof Kozlowski (1):
      iommu: spapr_tce: Disable compile testing to fix build on book3s_32 config

Lu Baolu (1):
      iommu/vt-d: Use right Kconfig option name

Suravee Suthikulpanit (1):
      iommu/amd: Fix legacy interrupt remapping for x2APIC-enabled system

Tang Bin (1):
      iommu/qcom: Fix local_base status check

 drivers/iommu/Kconfig          | 4 ++--
 drivers/iommu/amd_iommu_init.c | 2 +-
 drivers/iommu/intel-iommu.c    | 4 ++--
 drivers/iommu/iommu.c          | 3 ++-
 drivers/iommu/qcom_iommu.c     | 5 ++++-
 5 files changed, 11 insertions(+), 7 deletions(-)

Please pull.

There are also some race condition fixes for the AMD IOMMU driver
pending, but I wait for more testing feedback from Qian before sending
them your way, so they are not included here.

Thanks,

	Joerg

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl6uttAACgkQK/BELZcB
GuNcNg/9EEptDzjNdWIh4GD+okAC+zWIMeWezt2Te8ytNx/r7zOS1Ye3VqgYq8GS
TavgT+a5hIeaxo2qTLRj7ZNrxVGcB7vshQBwXqBpFg2rYOeo3O+7lhmBeWpGUgBy
6IjyF0WctoUYCkxZPVYjAjoUrSI2ZMzYBpjNKto2EpLFj1f8FAR+Wujcx9l3qWFb
J8G49VIqPhjtHLOGHT1ijmfWaF2MvQmZVpYRsGkRqlaWc//iOrHKc+ONLTApmatP
ZqnqDTqeQNBSEbP0K4G2WZ4N8D3vdBjVrDRb4jQaPpmunK2WHXnSgv/VJy1IyqUT
P4jicSh0vr5YKbkrAeGEj11RLKyji8jrHV2yWBIH8TtHNLagJeyIK5KkNqk+Qz02
g+fUjjiS0Whvxc4zT2r+I+j3MvARZbY2sXRG/3WOUOna6D9HGKLVdQs/7ezDQKES
2LrYSx3G9omTIdwCugJ2jvItokXuryN6wLL87EpnK5iipKWtYnXKoG8Quq/VgJ3+
VI2mvqx4nspJ/ENj22DU++bbNO9KhTKgzrOeOgO8eE8QyUK382MGn5/ehBddK0yD
xnBbTtjEvQPFbAA2rEUrTyZszBE0BhHxQxwNEhmFBVE5CR10BHUseeWdW8HVUI7r
ZdTpE2CMZxR6tM3+hswWH6d5Vg5IeQbz8Amc4CN8DLYU8xQb8wo=
=cYaI
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
