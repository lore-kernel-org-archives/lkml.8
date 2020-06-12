Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267AFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC8F206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgFLPWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFLPWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:22:15 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A207C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:22:15 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0F1EC3A2; Fri, 12 Jun 2020 17:22:11 +0200 (CEST)
Date:   Fri, 12 Jun 2020 17:22:10 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] iommu: Move Intel and AMD drivers to a subdirectory
Message-ID: <20200612152205.GA18833@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I am not sure it is the right time to send this. The patches below have
not been part of the IOMMU updates for v5.8, in the AMD case because it
made the merge conflicts even worse, and in the Intel case because it
was not done yet.

It would be good to have both drivers moved in v5.8-rc1, mostly because
it avoids conflicts between fixes and v5.9 updates later in the cycle.
But it is also no problem to defer these changes, I can put them again
into the IOMMU tree and the end of the v5.8 cycle when you feel this
should have been ready earlier. With that said:

The following changes since commit 431275afdc7155415254aef4bd3816a1b8a2ead0:

  iommu: Check for deferred attach in iommu_group_do_dma_attach() (2020-06-04 11:38:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-drivers-move-v5.8

for you to fetch changes up to 672cf6df9b8a3a6d70a6a5c30397f76fa40d3178:

  iommu/vt-d: Move Intel IOMMU driver into subdirectory (2020-06-10 17:46:43 +0200)

----------------------------------------------------------------
IOMMU drivers directory structure cleanup:

	- Move the Intel and AMD IOMMU drivers into their own
	  subdirectory. Both drivers consist of several files by now and
	  giving them their own directory unclutters the IOMMU top-level
	  directory a bit.

----------------------------------------------------------------
Joerg Roedel (2):
      iommu/amd: Move AMD IOMMU driver into subdirectory
      iommu/vt-d: Move Intel IOMMU driver into subdirectory

 MAINTAINERS                                            |  5 ++---
 drivers/iommu/Makefile                                 | 18 +++++++++---------
 drivers/iommu/{ => amd}/amd_iommu.h                    |  0
 drivers/iommu/{ => amd}/amd_iommu_types.h              |  0
 drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c}   |  0
 drivers/iommu/{amd_iommu_init.c => amd/init.c}         |  2 +-
 drivers/iommu/{amd_iommu.c => amd/iommu.c}             |  2 +-
 drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c}       |  0
 drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c}     |  0
 .../iommu/{intel-iommu-debugfs.c => intel/debugfs.c}   |  0
 drivers/iommu/{ => intel}/dmar.c                       |  2 +-
 drivers/iommu/{ => intel}/intel-pasid.h                |  0
 drivers/iommu/{intel-iommu.c => intel/iommu.c}         |  2 +-
 .../{intel_irq_remapping.c => intel/irq_remapping.c}   |  2 +-
 drivers/iommu/{intel-pasid.c => intel/pasid.c}         |  0
 drivers/iommu/{intel-svm.c => intel/svm.c}             |  0
 drivers/iommu/{intel-trace.c => intel/trace.c}         |  0
 17 files changed, 16 insertions(+), 17 deletions(-)
 rename drivers/iommu/{ => amd}/amd_iommu.h (100%)
 rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
 rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (100%)
 rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
 rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (99%)
 rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (100%)
 rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)
 rename drivers/iommu/{intel-iommu-debugfs.c => intel/debugfs.c} (100%)
 rename drivers/iommu/{ => intel}/dmar.c (99%)
 rename drivers/iommu/{ => intel}/intel-pasid.h (100%)
 rename drivers/iommu/{intel-iommu.c => intel/iommu.c} (99%)
 rename drivers/iommu/{intel_irq_remapping.c => intel/irq_remapping.c} (99%)
 rename drivers/iommu/{intel-pasid.c => intel/pasid.c} (100%)
 rename drivers/iommu/{intel-svm.c => intel/svm.c} (100%)
 rename drivers/iommu/{intel-trace.c => intel/trace.c} (100%)

Please pull.

Thanks,

	Joerg

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl7jnZkACgkQK/BELZcB
GuMCwRAAnfsSfW4OvKQ8lSOp2CfpXDKojX9nZ+pUuKjngIb/VKATSWuoEK6bSYJy
yAvu6itq2ftA4oQe5htoX4x5NpFJc8Yu7NOlMLCPkDa0s+ylqac7R+YZONgBnTCJ
LM9Am/UAxFvY9AJCFyKOqlOfHy6sYhzWSUTXlZk+WvXWznaNhec5rUFIOCgdbPAt
shPcTA39ilxOhyz/APN3DyP3SHah5odG+MO9Q5u40BzFl4M5pR80q0lCb0I29ejk
+llm/jbhnkE0E6W+SqvZkJoHdsnmnnoG2pQDhY1APmGXlhuJhsQGCHR+K3e6r+Hz
rYdyhiNVu7nXZ+yj/5tW+IemHMVayyGrsybe1L8RgoAMF12FyLcpTECQWgp6ceI4
hDtF1zmT5yQMTCZUI3W5V/ByfizTvhs4Y5H3gvc9ISvwzVD4vSZ9Eb6xnqypegi+
PRh1kOFUdEJTgAGOkIC4jVJwvs6NbO05eGOL4xpKd4jACrWUUNv0MYOry/+Q9Ot4
n4DMKuT4ML3mF/YZ3zilp2MrSzvXSoTMVfdrIEpXeSgHDBbp8ribOWQKYh8wsqLn
/Lox1b1AuqZGd1fGCjaKEoGDAx6djTcAVzVyMhpp98qEQDLO5X0CQnISf7v/C6+1
0oheyGvH2I89ui7VseYf8CMiJyAUWWNQ4ieKg8mDmLJpW9rvYPM=
=rI59
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
