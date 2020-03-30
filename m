Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0F2C2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B934E2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="kR36fS77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgC3R5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:57:55 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:38903
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbgC3R5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:57:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0N2tCImxz8xPLtAw92sN+BVAR1FMyCDKUJxak0yo4xlPj3uMhLKiy1AEvCXAp2tGw7YjP9Xg+ZscH9mQHjlFYq/SOR1p6MPIRjI/HGoHtTxgY23pbr3RNYyobw4qBKVI71JlpI0z5MqtQif+vKxsRRTyE/UmiSJTipSgrS0kOLMz8GFXXIKtNCCn6Bkmq1o8+olL5v0O8ihkgSRD9/ro+RHnFdCjiXuG19QksLqzu59aGWbizG3WMfcvkLcuWq86aC9brwd+WYqt65jsyn587XhOvzEcu06e9916xYHCHOpPN5mMRRj8lPuqEozJ+FFQZIGqMR+Txp5ZavamvP1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2fNT6WPbvGT4O2cVXJBTUxrPfCnKkoN4KIgzkkCOuU=;
 b=nY3LgtVYOGJeg36hvvW5pKJY9JWmzuKFZ36I0r+40zHmaOdaS2C0baiHAb5e8LeTjFDh62WVs/Z1WvCs5hlmK/WzEWZFyPaK0o2NycdKyNphA25KlU13Gvwz1/PmaefjUTqq4kffT2R6ceA9FNUqciQq007t8VwUVksjP1TYb2kTMedPEfHXRsNnldCBA/Lp7Ds7IQe3ArJC8tt9uigAm3JKAhvyY/0lS+xC5LOkNr78GpDarvORGMWEvt/vFXcf/jcX7J67V7zrk3iRB/er0Y+eS5eBsA8pTT2kOJyoErbjGEtckcyge9g6sbNfIwRVwBvnytBn/Pl8dFSRrECSFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2fNT6WPbvGT4O2cVXJBTUxrPfCnKkoN4KIgzkkCOuU=;
 b=kR36fS77RW8XIriFGqKLRptaDjF6fibUU4SOImJ+74eyHIvXqBTJzcLnMY4E4nO57yW7A7b+JhwmeotmWIIEMb6SkhsENSPd+NBgvknSi5cXDuHMZn1JESN+qrWnQNE3VZfK63oJn+edWHIWZ0j9n4CsX980U4eqg4g2QJgG3Xo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4942.eurprd05.prod.outlook.com (20.177.51.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 17:57:51 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 17:57:51 +0000
Date:   Mon, 30 Mar 2020 14:57:48 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [GIT PULL] Please pull HMM changes
Message-ID: <20200330175748.GA32709@ziepe.ca>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR19CA0025.namprd19.prod.outlook.com
 (2603:10b6:208:178::38) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR19CA0025.namprd19.prod.outlook.com (2603:10b6:208:178::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 17:57:51 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jIyfU-00005x-1N; Mon, 30 Mar 2020 14:57:48 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63b8f37a-5b20-4300-9a01-08d7d4d3dd34
X-MS-TrafficTypeDiagnostic: VI1PR05MB4942:
X-Microsoft-Antispam-PRVS: <VI1PR05MB49424CD3CFEA76060B9C701ECFCB0@VI1PR05MB4942.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(9746002)(9786002)(21480400003)(186003)(1076003)(8676002)(9686003)(36756003)(81166006)(52116002)(5660300002)(86362001)(44144004)(66946007)(66476007)(66556008)(2906002)(316002)(478600001)(6916009)(4326008)(33656002)(26005)(81156014)(8936002)(24400500001)(2700100001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eI3m7ro8CN9blgAryv2/kMnqFhMR+1xfpwzwGu259EF9nYJSYGWadknaZ3WxcoWAbQxKoQpGWttATXoaZe3bQeejnJPHXcWfOhtqwCOtKcaK+su55S1z5Iloc4UGja5McQIRE1uESq1pX5DcIeM8bxCor0Y0dRzhHFT/BkDtZkGfCavAxwtTnRbnc3A2Nf9bDNSD5mvlfdDcJ4Cl4MFWectoz8pQXUodwUeRrThLtlrVePEFjo0UyLC5pzBHpPxZNZPZqhMJgR2PMibIIyB1sF9MU/Uyq1UU0CkJ6kyzGJwddj/qVsEr8zSbsqJzXskrNYZHSXhX2ItLNIlNGYlSXclxjP5apR4lAojlbY9wz9C+YzoovZIGFTjV03MrL06FgEb5nvQ8nak74/MljrdVWisrxLBRD82Oc/772V3/w33Hkeg5v2yraUWfwnnJZ1rTFtR7n7adwgJyEj1YRsZgydrk/0N6jwWuSTJfeG8A9UFIEKarWpvAVYFkL8Mwygnlo+g8NvDEViFa3h4uAO425w==
X-MS-Exchange-AntiSpam-MessageData: 7kYFlGD8ljrOKMImAA3TE7+0e538HauXCT4DptZn29kNUvQRAsc0jbqg2aYCoxuUDLkTtnEm3X8BQwTNb5GB3prbS51PLi/twiUKUq6EPHl+HbXF1tU4aP+Gk4Zh/sYbhc+IDZ5Ebg8AmBAJoAD9BQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b8f37a-5b20-4300-9a01-08d7d4d3dd34
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 17:57:51.2013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsnPmrjBtypGYHeb729fbMCEGhLDFtKK5OiMEVk7dUR/JwCsJOfcGGSAkIaEyhHXKt5qlasKb7n/urW/1ZZKNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This series arose from a review of hmm_range_fault() by Christoph, Ralph and
myself. Several bug fixes and some general clarity.

hmm_range_fault() is being used by these 'SVM' style drivers to
non-destructively read the page tables. It is very similar to get_user_pages()
except that the output is an array of PFNs and per-pfn flags, and it has
various modes of reading.

This is necessary before RDMA ODP can be converted, as we don't want to have
weird corner case regressions, which is still a looking forward item. Ralph
has a nice tester for this routine, but it is waiting for feedback from the
selftests maintainers.

Regards,
Jason

The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-hmm

for you to fetch changes up to 9cee0e8c6f1eb4b5e56d3eb7f5d47b05637bab4f:

  mm/hmm: return error for non-vma snapshots (2020-03-27 20:19:25 -0300)

----------------------------------------------------------------
hmm related patches for 5.7

This series focuses on corner case bug fixes and general clarity
improvements to hmm_range_fault().

- 9 bug fixes

- Allow pgmap to track the 'owner' of a DEVICE_PRIVATE - in this case the
  owner tells the driver if it can understand the DEVICE_PRIVATE page or
  not. Use this to resolve a bug in nouveau where it could touch
  DEVICE_PRIVATE pages from other drivers.

- Remove a bunch of dead, redundant or unused code and flags

- Clarity improvements to hmm_range_fault()

----------------------------------------------------------------
Christoph Hellwig (9):
      mm/hmm: don't provide a stub for hmm_range_fault()
      mm/hmm: remove the unused HMM_FAULT_ALLOW_RETRY flag
      mm/hmm: simplify hmm_vma_walk_hugetlb_entry()
      mm/hmm: don't handle the non-fault case in hmm_vma_walk_hole_()
      mm: merge hmm_vma_do_fault into into hmm_vma_walk_hole_
      memremap: add an owner field to struct dev_pagemap
      mm: handle multiple owners of device private pages in migrate_vma
      mm: simplify device private page handling in hmm_range_fault
      mm/hmm: check the device private page owner in hmm_range_fault()

Jason Gunthorpe (17):
      mm/hmm: add missing unmaps of the ptep during hmm_vma_handle_pte()
      mm/hmm: do not call hmm_vma_walk_hole() while holding a spinlock
      mm/hmm: add missing pfns set to hmm_vma_walk_pmd()
      mm/hmm: add missing call to hmm_range_need_fault() before returning EFAULT
      mm/hmm: reorganize how !pte_present is handled in hmm_vma_handle_pte()
      mm/hmm: return -EFAULT when setting HMM_PFN_ERROR on requested valid pages
      mm/hmm: add missing call to hmm_pte_need_fault in HMM_PFN_SPECIAL handling
      mm/hmm: do not check pmd_protnone twice in hmm_vma_handle_pmd()
      mm/hmm: remove pgmap checking for devmap pages
      mm/hmm: return the fault type from hmm_pte_need_fault()
      mm/hmm: remove unused code and tidy comments
      mm/hmm: remove HMM_FAULT_SNAPSHOT
      mm/hmm: remove the CONFIG_TRANSPARENT_HUGEPAGE #ifdef
      mm/hmm: use device_private_entry_to_pfn()
      mm/hmm: do not unconditionally set pfns when returning EBUSY
      mm/hmm: do not set pfns when returning an error code
      mm/hmm: return error for non-vma snapshots

 Documentation/vm/hmm.rst                |  12 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c      |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |   3 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c  |  19 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c   |   3 +-
 include/linux/hmm.h                     | 125 +--------
 include/linux/memremap.h                |   4 +
 include/linux/migrate.h                 |   8 +
 mm/hmm.c                                | 476 +++++++++++++-------------------
 mm/memremap.c                           |   4 +
 mm/migrate.c                            |   9 +-
 11 files changed, 227 insertions(+), 439 deletions(-)

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl6CMxQACgkQOG33FX4g
mxrdbQ/9EgzX4/pos+iDt5YS6mX7bzfBiCuHiY9+quUvtaXjKFA5YPVv9oNAR98m
qlFje7F61M07IlwoIYvTv15cta+J72ezL6unXUvaBXVL/aeeuTUTrsOPmoMRoAU/
H/S4M1luYncKndMnOBN+Qnem67s5838tduRPACuF8T1TC75Izf36CaC64CBlhHgK
L0lWQzSX2JI7u4DLyVVn2Ow8PkSuHzE6fEwNMldOt5ylxNvwX2PtaS3I0wMBqxSB
AOPksg/KIg2xHNh9YC99FSETZW1iLs9UMGHE6hKYqjxPvIlimAmzwiB1Ak+gvINj
tHS1r/7jSU/0Fmp09G8o/Ik8IHqziUQvpHW1ga1JaIJ6Q813bk9s8fzhPb8pHi9/
bbYFhs3vKRkjC0OHQ7IdjqFVgLEqru0+oH1S0XODoZ0FvG4P5HT7YpcWGIqO9zQN
yuHTEp8G8bGhWmTshayjpWGX+/fqmZkJJ8tr9395QD6J3eDuA28CCT9qw86IRB+i
1EFCAqwxpuY+kbKBqblMKB8KIx02IsA9vg0XVTOm59kMkOW853jw/riq8bDljVs4
NDFOpEQ3i/qldu2ylOPYFHfEhWWDLQjx+Vj0uNV3kORlgcKVXVA82FMQF+th86jd
zGg178GSyLZdanKV2GycM0sZQjusLWm0hwKZrpn+rERHjqcRkFA=
=WwN7
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
