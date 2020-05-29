Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4011C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1BD2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgE2S6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:58:44 -0400
Received: from 8bytes.org ([81.169.241.247]:45446 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgE2S6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:58:43 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B97E450C; Fri, 29 May 2020 20:58:42 +0200 (CEST)
Date:   Fri, 29 May 2020 20:58:41 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.7-rc7
Message-ID: <20200529185836.GA31964@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.7-rc7

for you to fetch changes up to 7cc31613734c4870ae32f5265d576ef296621343:

  iommu: Fix reference count leak in iommu_group_alloc. (2020-05-29 15:27:50 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.7-rc7

Including:

	- Two compile test fixes for issues introduced during the
	  5.7-rc1 merge window.

	- A fix for a reference count leak in an error path of
	  iommu_group_alloc().

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      ia64: Hide the archdata.iommu field behind generic IOMMU_API
      x86: Hide the archdata.iommu field behind generic IOMMU_API

Qiushi Wu (1):
      iommu: Fix reference count leak in iommu_group_alloc.

 arch/ia64/include/asm/device.h | 2 +-
 arch/x86/include/asm/device.h  | 2 +-
 drivers/iommu/iommu.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Please pull.

Thanks,

	Joerg

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl7RW1wACgkQK/BELZcB
GuPY8A//aBv4G6EhNbtdu/IoPcOeUHJZBmngcH/CA26kfJOfUOTkDqz0NBZrvrb0
VLbvXPc8SBiJkTYSQge5oMNQpEf+mtIEsjN2Um4y9lupF4p8+P6/cFmkaB4R57rN
23M2uJu7012BV4qR21vzeM46rGy377XD2QlSIrc8E2V8ndJ5hOwgmgTcAjuAmTZ6
dRb7/Q6pmsMvmmldYQQasVVNKcYmCkA6gA28wN2FZIDC1bLawc1kBw4wYrlSKHEi
et5ichhOlG/ApkE0/r8/ZUXwiLkDGnYcHpaiwvQwG4WjaKB/fXth131tKwMb+miU
O44aydqUzpUXQZ/SGKt4FPGljcKXfBqYS57GdInoaOoVRB71cGQvMHfVhKL1ER/O
m4MswSNkNGz4ChGw0uk+sE200mFJkowRs1OTb9gX/4j2XgYKlfho59WHEtbvS1T2
UfLsGJ37hTx3qYwMiG+8csIH9NhwYSDI8CmAx1qE3AjoGTfXmamjfyHr2ipM62ek
yPIVYIsWVnBAFRaSh7Caqcm9UiUfQ/ugwRFoAeNZzQvMZLfeWPdXabnD8ncJyBAf
42GBK3yjb0KYAJJ1rPy5MZsBwK2ISZpeWbDWJqpCLG7qbW0Ie1ceCB912MBAsCnY
cFZa1T21FllnZaWpbgsqA1nEeZdf0qZqf22Br91jzojLdaCTxY4=
=XJWf
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
