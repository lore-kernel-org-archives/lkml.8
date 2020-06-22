Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D8CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E39720720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="omMEPhG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbgFVXjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:39:20 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18838 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730789AbgFVXjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:39:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef140ca0001>; Mon, 22 Jun 2020 16:37:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 16:39:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 16:39:18 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 23:39:10 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 22 Jun 2020 23:39:09 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef1411d0001>; Mon, 22 Jun 2020 16:39:09 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [RESEND PATCH 2/3] nouveau: fix mixed normal and device private page migration
Date:   Mon, 22 Jun 2020 16:38:53 -0700
Message-ID: <20200622233854.10889-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622233854.10889-1-rcampbell@nvidia.com>
References: <20200622233854.10889-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592869067; bh=ZfcMxwlEjaJ9jud4ZrslX8wzG6hxoVtsjt+UlX695yk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=omMEPhG6aQgofgh8JB/wY8i6c4L08LQas11cdktO9N4pAN3nh2AyCizenczXX1JHo
         YBqQqeR+XhYqCtpKORfjRlll6+l7sLVNeD9gksfNzuAnQz4gpnvv88XowoCVc1wNRo
         UJMmkFVVbFku+vr7rA0ISYrJw5u1xd/xKjyUvJtZ+G29yM3QZcswpg9FaoXXo1gY00
         PLwlL0/PQF4BzZ+uT8TYOhoffGycHclg3iHdTgsO2PHv+sng7wA3q+i8tK2vbb89S/
         nA8OQCmw4fnC05SWnlKh6EGzzH7NyCgHpgwOps/w5Jo9AfjRIXqnXkdGUhGfBFJkcJ
         yX8j3BpOJV5NA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OpenCL function clEnqueueSVMMigrateMem(), without any flags, will
migrate memory in the given address range to device private memory. The
source pages might already have been migrated to device private memory.
In that case, the source struct page is not checked to see if it is
a device private page and incorrectly computes the GPU's physical
address of local memory leading to data corruption.
Fix this by checking the source struct page and computing the correct
physical address.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouve=
au/nouveau_dmem.c
index cc9993837508..f6a806ba3caa 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -540,6 +540,12 @@ static unsigned long nouveau_dmem_migrate_copy_one(str=
uct nouveau_drm *drm,
 	if (!(src & MIGRATE_PFN_MIGRATE))
 		goto out;
=20
+	if (spage && is_device_private_page(spage)) {
+		paddr =3D nouveau_dmem_page_addr(spage);
+		*dma_addr =3D DMA_MAPPING_ERROR;
+		goto done;
+	}
+
 	dpage =3D nouveau_dmem_page_alloc_locked(drm);
 	if (!dpage)
 		goto out;
@@ -560,6 +566,7 @@ static unsigned long nouveau_dmem_migrate_copy_one(stru=
ct nouveau_drm *drm,
 			goto out_free_page;
 	}
=20
+done:
 	*pfn =3D NVIF_VMM_PFNMAP_V0_V | NVIF_VMM_PFNMAP_V0_VRAM |
 		((paddr >> PAGE_SHIFT) << NVIF_VMM_PFNMAP_V0_ADDR_SHIFT);
 	if (src & MIGRATE_PFN_WRITE)
@@ -615,6 +622,7 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 	struct migrate_vma args =3D {
 		.vma		=3D vma,
 		.start		=3D start,
+		.src_owner	=3D drm->dev,
 	};
 	unsigned long i;
 	u64 *pfns;
--=20
2.20.1

