Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDE1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3571208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fIgHF8zL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgHDPGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:06:21 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7502 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgHDPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:06:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2979540000>; Tue, 04 Aug 2020 08:05:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Aug 2020 08:06:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Aug 2020 08:06:09 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Aug
 2020 15:06:08 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 4 Aug 2020 15:06:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm4T/D+uVDqgQwal0/tAuXHdX6Mj8NaqDc5o/oO/l3JWEXZqOJgkun/MveezmfxbUzoMcyDy7DLKC9jrcIEWsvQTl7z56c/ta0hojdpnbDqyRcFqj7jSFVXNrlroVO1P+SUE1AQAn78eF1bjhlMObQZ7cMTaFVQJ/gQJzk4bHNiAwa3jlL6WLt18X5w7UpWLRnWT/juzc/nRdJTORpP5P27ikkW0p8rn9fuQdT9+AsNxV4xt7jIN/AVFUJ2473K9C1ZlPnt8m7LbGBaucQVm39CG0qRIRECzYldOxhpc48INkt3J4WbtOlEpCG3ELRVbCAZjVIPk1OqwwQXP9o8s2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VAm5Bzk2ICpz79N/XUKwvUpzsA2QT75/eIm8MfxiWc=;
 b=HwChv0hB/pvCSzHPgXVbG3azrbhTXxaszL81mTyUJG28+qoOVso6TWaUtks3Yb54Sfg9zOD/qHAnvCls58of3IQacMWJw1Vz9urNQ/lQmRLbT8VUzqh8n8mXPQ81KW24YOOp3i+lqcSAorD6gF2RT/rL7j0pqy9rqMgc++1007nRheLNfFhR2mCHhdZiBCyw6DE6ytwdCbE80dTh6irqzhwEQ/joHDMop1kruh2GNSbcpYOGui0oT4t89YdSP4mO91bkNrI2nLjxodIYmckgZlQjcacsjtqpwbh2mBdX024NWN0CtxNlm+U+SUbMOg0u6cvSiLLPmekEFPr1u4veFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3113.namprd12.prod.outlook.com (2603:10b6:5:11b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Tue, 4 Aug
 2020 15:06:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 15:06:07 +0000
Date:   Tue, 4 Aug 2020 12:06:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [GIT PULL] Please pull hmm changes
Message-ID: <20200804150606.GA809710@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR01CA0028.prod.exchangelabs.com (2603:10b6:208:10c::41)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0028.prod.exchangelabs.com (2603:10b6:208:10c::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 15:06:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k2yVy-003Oil-Bs; Tue, 04 Aug 2020 12:06:06 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e15020c7-fde8-4cd3-11c7-08d83887ea33
X-MS-TrafficTypeDiagnostic: DM6PR12MB3113:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3113DCE90A24A3CDDC247E5DC24A0@DM6PR12MB3113.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXwO2bS4Z+SLrtFs3HxRuKAP3MH8WIN+CIBGZ2hdkoymsTbydCYa3GZYRKEHUpzcKG/t8DqomRhr0c4VDy4kqMNMBc9wZJlfk+ymHf+Kd0+WEm8CVOc0FJsfY+Be/K+bOh2vG1bgOHjfGOVcSF1nY5w8a+BVLr+mh2rkEJjMqDu8+xIiUHchqX9l+XguFw8vY5P2vZwJ/qUqDmJj+besZUvP+TfyLpKE2K20jt6yQfKwS8JBJaWx9VUylFLgrHeUUksMMf9tMIW7skIc+00erCWM/R9dT9Ro2QJFIxgn4F1T2Qw3wGAv5Rov/jcbsHh9DBaA4swwDo8tGOoDjm6JXZEwT/lN6ggoNc4XmPififNaknC8WVIZZRQfgWIyydDN5thB387dMpgYWIvrnei/5PCUtQRU1xdDcwMjzemHYJTYwGrydTypeFzRbL7j7C4kXJB/06jRGaClkpzVFmqdqJPs6/HD6Z1RHvyKYV+qecE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(5660300002)(2616005)(1076003)(21480400003)(66556008)(66946007)(86362001)(66476007)(83380400001)(36756003)(8676002)(6916009)(2906002)(9786002)(9746002)(316002)(4326008)(426003)(33656002)(966005)(186003)(44144004)(478600001)(8936002)(26005)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Lmh4G85brAhmLaaC9m43PiIjS4Ict/mIBovypxzIcLdIbwMuh/E3rJr0Yd9U/E3kGECrJEm/HOVotvoI+TO5UhsT0/a4YuA3RCifTWJG+9AD16qh5hJHxREhvYXXuBCm7nxn0Uk4mVOKbY8fPZErLODPe0dntLLS2pY6IYOXhKZB1oFIQEt+QRoiUBDQmUap6/WVVWydOooaHCIhsRelwkYRWUJJIwzuBirSwyNrlnOnM7yBZqVq3RCAiR7qxibnKPqy2KfCaCH1qqvLsbMD3DrzIBRGn0WbevbxAnBPjGitopC9FaGJxz+UPXC+vVNw9E3jgIESaTnR/dQ3d0B4KllMMa/rkCR0zsKqQUXzd4iLbtqWJgkaDGBB4thx6HFt6567oD4JKdPc9uX74KgBrFg8QS7gxXcmJQ45n0F77AsyY2o7dfYhPnrdxNFwViXkNtk0yJJrjbUCtAHo0GyBgkteS2teyJAg/eT/wcqxzxSFP88QV9PHo+a6PMyKV3kIzWu0VDdRK08txRxggOyFmaSg31xkkhUt496yHXUlNtSk8q7w6GYKZnPUSVL2fUNNWXRojz6UNk+mrHx4ExV/EkYg99EeGYcXnpcMpZGcGbIuY+X1sEX4tWG0ZYctgpsmpqlDjpIjXjwD0IlaLedetg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e15020c7-fde8-4cd3-11c7-08d83887ea33
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 15:06:07.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bny+t49grlOr2OkJh73wD1jhoFDFdxk4qjJ29BKkdVRu4PbppXZsxWMg/GwrlZCo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3113
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596553556; bh=8VAm5Bzk2ICpz79N/XUKwvUpzsA2QT75/eIm8MfxiWc=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=fIgHF8zL1C04AoxkGotxoLvBclfrAHl1/kDFPEYkr5nH3o9N+zS0r9sxmiLoFgdVP
         39vKp05+mF4VVHp+I/An+re7rFh9MsT0bFN/H2oqEvqkg5LS3vrOoh1J3UvyT8dzCu
         NUEx3TayHmgwluwNvdwUvDj08PiCEe+qzKqJO8Tt20snBjxChIc3bI+hlQetGo715v
         bKrMKoSCPMSMzUXpdbBXwNTyF63kAvayqRH2+EnbxBYP0gaVegUNo29FzPQ/l940ZF
         0zCBvX8Y88CRpMrhCBHrj5Wip00z85qUhAAdyVSmu36dJ+7KNJyIHyoJG0s+nQmTzH
         Frja7Z0Ey1mvw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Ralph has been working on nouveau's use of hmm_range_fault() and migrate_vma()
which resulted in this small series of improvements.

There are two expected conflicts. Conflict with the kvm-ppc tree:

https://lore.kernel.org/linux-next/20200730191610.204ed02c@canb.auug.org.au/

This is because the kvm-ppc tree moved __kvmppc_svm_page_out() within the
file. To resolve the diff from 5143192cd410 ("mm/migrate: add a flags
parameter to migrate_vma") needs to be applied to the new location:

-       mig.src_owner = &kvmppc_uvmem_pgmap;
++      mig.pgmap_owner = &kvmppc_uvmem_pgmap;
++      mig.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;

There is an accidental conflict with the DRM tree, due to a confusion the same
patch got applied to both trees and we couldn't undo it in time. Please take
the hmm version of the resolution.

Since neither DRM or kvm-ppc have been merged by you, I've made a very hacky
for-linus-hmm-merged tag with my resolutions for your reference.

Thanks,
Jason

The following changes since commit dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258:

  Linux 5.8-rc4 (2020-07-05 16:20:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-hmm

for you to fetch changes up to 7d17e83abec1be3355260b3e4812044c65c32907:

  mm/hmm/test: use the new migration invalidation (2020-07-28 16:20:33 -0300)

----------------------------------------------------------------
hmm related patches for 5.9

This series adds reporting of the page table order from hmm_range_fault()
and some optimization of migrate_vma():

- Report the size of the page table mapping out of hmm_range_fault(). This
  makes it easier to establish a large/huge/etc mapping in the device's
  page table.

- Allow devices to ignore the invalidations during migration in cases
  where the migration is not going to change pages. For instance migrating
  pages to a device does not require the device to invalidate pages
  already in the device.

- Update nouveau and hmm_tests to use the above

----------------------------------------------------------------
Ralph Campbell (10):
      mm/hmm: provide the page mapping order in hmm_range_fault()
      mm/hmm: add tests for hmm_pfn_to_map_order()
      nouveau/hmm: fault one page at a time
      nouveau: fix mapping 2MB sysmem pages
      nouveau/hmm: support mapping large sysmem pages
      nouveau: fix storing invalid ptes
      mm/migrate: add a flags parameter to migrate_vma
      mm/notifier: add migration invalidation type
      nouveau/svm: use the new migration invalidation
      mm/hmm/test: use the new migration invalidation

 arch/powerpc/kvm/book3s_hv_uvmem.c                 |   4 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |  19 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c              | 257 +++++++++------------
 drivers/gpu/drm/nouveau/nouveau_svm.h              |  13 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c      |   5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c |  91 +++++++-
 include/linux/hmm.h                                |  24 +-
 include/linux/migrate.h                            |  16 +-
 include/linux/mmu_notifier.h                       |   6 +
 lib/test_hmm.c                                     |  47 ++--
 lib/test_hmm_uapi.h                                |   4 +
 mm/hmm.c                                           |  16 +-
 mm/migrate.c                                       |  14 +-
 tools/testing/selftests/vm/hmm-tests.c             |  94 +++++++-
 14 files changed, 410 insertions(+), 200 deletions(-)

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl8peVwACgkQOG33FX4g
mxr/YQ//UuGwMs0XikkVUCMgve0Gt/1Ig5uyk2JTmK+KzagZ1IeCI/dJacKrsghx
Rg5tniYYY5XY+2xrmW0tnBQXwUZQmJiOT0HBcddyJn7HyASi+Skh/Hndpbxxudo6
aZOBFQZ6MCG0e+lKTu6UW7yR592ZmikrNQdG5oK4R8tfFzsQvvtJMczM69n57bjd
qV5HWghxnVswgapVP2ccWh5Xexw3FS/vzH+1fZZJjTOzxcxHshYhy6YMJx/wDGA4
gvRB0bBw35PDq/rQbv9WNuO8qEG0Aq35yWThP4Qrip8hA5i3k4h7d1DOPEAcGbOL
pFmDIUhbfu3IbSSCGW3f4HfUGNQ3gk4Skx/QcdU82A+2Fd5sa25FIqZNdk5lW/ib
dI8QBpNAIN3RAJyillzUkIGurhCaiBd05/G8zTlriEmaxTpNZ25hnaXkC6chp5Me
+mG2KMx/sVqG/HVTFx7nRw/7vGvc/BesJ9gMGnK5an3MiaFzwrHniRbWQqgIpUqA
J7oOqXWVtYmO3QeEaDsEoUhIKVxPzwnODu3BZSp3MK7lNFtCt5E3D5COU/KoSh5J
RGtq8bwsbJOJnpl/seur3hbTXlQLshndG241Cd6iGamFYNL6SZxtD4vfh4GTlZ9W
G0NPKrev7gmms7SL/r8WUXX9U3IVXlnOR8JnqYq6TWzXOevHKek=
=Fn9D
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
