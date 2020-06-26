Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3209DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5AC20707
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dSKhZ+J1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgFZR0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:26:41 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9996 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFZR0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:26:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef62fc40000>; Fri, 26 Jun 2020 10:26:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 10:26:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 10:26:41 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 17:26:31 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jun 2020 17:26:31 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef62fc60001>; Fri, 26 Jun 2020 10:26:30 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] nouveau: fix page fault on device private memory
Date:   Fri, 26 Jun 2020 10:26:26 -0700
Message-ID: <20200626172626.19207-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593192388; bh=+jL8198tCi4VPutVCs4yXHE2/yX1fXK0+ZzD5egdp4w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=dSKhZ+J1Nn3Eb0LX95a8mp/H26NjdofgeBJOetygGbQkKjHzbZyrwmqEC8ErmvCS1
         eUA99lTXoBFGkmL6xDJtRRF94rW9DzYwnDhvi4TFwLxXXyAzWwALy8yhk4EGhbY3Bb
         dM9eAML6m8QPXetN/JpnNXJ3EIjbnTy2qTQJLk6Ka8GKBkmNtDgc4SYKdvITcbD4X4
         27HWfqCOadM0ADG566k+W7W+V9Cn9hKHfOc1FjWdWzTJhJHZ6EnyT9phhQSJ/zhc8c
         UgmzTQaANl52Mx1odNDsQazX9USnqk2tgx9XzVzMHFfoy9dyAoo6ZojlUjoPAGFykl
         zbNqgCRLeM0Yw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If system memory is migrated to device private memory and no GPU MMU
page table entry exists, the GPU will fault and call hmm_range_fault()
to get the PFN for the page. Since the .dev_private_owner pointer in
struct hmm_range is not set, hmm_range_fault returns an error which
results in the GPU program stopping with a fatal fault.
Fix this by setting .dev_private_owner appropriately.

Fixes: 08ddddda667b ("mm/hmm: check the device private page owner in hmm_ra=
nge_fault()")
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

This is based on Linux-5.8.0-rc2 and is for Ben Skeggs nouveau tree.
It doesn't depend on any of the other nouveau/HMM changes I have
recently posted.

 drivers/gpu/drm/nouveau/nouveau_svm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index ba9f9359c30e..6586d9d39874 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -562,6 +562,7 @@ static int nouveau_range_fault(struct nouveau_svmm *svm=
m,
 		.end =3D notifier->notifier.interval_tree.last + 1,
 		.pfn_flags_mask =3D HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
 		.hmm_pfns =3D hmm_pfns,
+		.dev_private_owner =3D drm->dev,
 	};
 	struct mm_struct *mm =3D notifier->notifier.mm;
 	int ret;
--=20
2.20.1

