Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896C5C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 09:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CAB21744
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 09:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbgALJ7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 04:59:44 -0500
Received: from 8bytes.org ([81.169.241.247]:59692 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732395AbgALJ7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 04:59:44 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0116D3AA; Sun, 12 Jan 2020 10:59:42 +0100 (CET)
Date:   Sun, 12 Jan 2020 10:59:41 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.5-rc5
Message-ID: <20200112095936.GA17108@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

  Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-fixes-v5.5-rc5

for you to fetch changes up to 55817b340a31951d23d1692db45522560b1d20f9:

  iommu/dma: fix variable 'cookie' set but not used (2020-01-07 17:08:58 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.5-rc5

Including:

	- Two fixes for VT-d and generic IOMMU code to fix teardown on
	  error handling code paths.

	- Patch for the Intel VT-d driver to fix handling of non-PCI
	  devices

	- Fix W=1 compile warning in dma-iommu code

----------------------------------------------------------------
Jon Derrick (2):
      iommu: Remove device link to group on failure
      iommu/vt-d: Unlink device if failed to add to group

Patrick Steinhardt (1):
      iommu/vt-d: Fix adding non-PCI devices to Intel IOMMU

Qian Cai (1):
      iommu/dma: fix variable 'cookie' set but not used

 drivers/iommu/dma-iommu.c   |  3 ---
 drivers/iommu/intel-iommu.c | 22 ++++++++++++++++++----
 drivers/iommu/iommu.c       |  1 +
 3 files changed, 19 insertions(+), 7 deletions(-)

Please pull.

Thanks,

	Joerg

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl4a7ggACgkQK/BELZcB
GuO5JA/+Je/0TqClzmUhSe6RXC4s+fHx9kvT+ZDcQH6LPbh8zgUfSwIs2WnrqpJZ
gIsdrLNehRv8PYin8AJg14ZxzQ/SOuJC7vf0NybVRGq5fsDPbEPh9T6k6bf7czzF
Z0lMrby3qt1NHHsjRJHKmnPStgYuchwFvJy8JK/dZ0gmQsU79m5kVKdqtAVntIDg
DDdaXBQCUa+jlZi9ndgkQklm2zaxdBVCkSEEfFjBHOOSMJJAce3wjDTEfQBSurZs
NU7Nw0dR7Nq2YZJGTIAMj5RKWH6N3Cn9NUnL6stsKXOo5ivJPLaUEVBncXQLLjuL
Yp4USo1hPhKCPCJzemGljcU7PN1ALlvNW6KFzy6eFEAlZ7k9vHWKejbGDj3hkBu8
eM4Ia9h4rAyLellqI06+KOWZK9liikCo7n9bzI8+jvzsWUo/GuIJ9cWm4IEtlDpW
DS+dyqldqW9K3ykK2q9w3CY6u3dQTLb0cIhNlePBQ+Y6u/cHpmfn2DMccPRXnLy2
+uiUsk+et9IXbGRhqc9n0XLoBO7KXWdkDlNXBwmYFwHx9+vASwgmyUI7TjUHS5M3
5+SEra0BmsE9M3DoZgXWGyr1qZypb+LveXooDF5aeE4DJ00XS7dkELe9p1hNL/fk
S7dcK7IJJDlX5kmoq/iXYdxBYhK7ncvsiQvUvNV4QM07l2FN2Oc=
=2L+s
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
