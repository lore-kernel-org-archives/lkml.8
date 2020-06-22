Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863A1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6470820720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XwRBjtLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgFVXjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:39:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18836 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbgFVXjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:39:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef140ca0000>; Mon, 22 Jun 2020 16:37:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 16:39:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 16:39:17 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 23:39:09 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 22 Jun 2020 23:39:09 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef1411d0000>; Mon, 22 Jun 2020 16:39:09 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [RESEND PATCH 1/3] nouveau: fix migrate page regression
Date:   Mon, 22 Jun 2020 16:38:52 -0700
Message-ID: <20200622233854.10889-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622233854.10889-1-rcampbell@nvidia.com>
References: <20200622233854.10889-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592869066; bh=aaU6roovY2dxLmV2cNcmX9CI+ssI/Uf3SDOsfiZQ3j8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=XwRBjtLVQcC1BQRXmuzfODaRHh8z2BxdWfUzWsQSEXIZs8mKBoikZmycdmR2+cpaX
         tbFNwyH4Q0mJcY8T6YasB97SPCXIoHssi/KXz2DsD1LZ9A0M90tUUgfNXVL9DnBKfD
         u1zV0BU7458Cgv08vMZiAfQUH+zOHtGvFF3oijKoj0k2mI6fhdFJ9BP7u/dUR21A2J
         V/8X2eUvRK2ImvmQ9RpPl6MJId+ftbM0Z9Bdn7v6eslH2m4UjvQScaJEFv3rgwm56u
         sjmr4ojlC+vuKA75ks7mF4PE+pIlZbX7mkOj6GXVIwFexzatUQBLiNvL3EiYG4LpEJ
         GYBz5KwyeEUUw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch to add zero page migration to GPU memory inadvertantly included
part of a future change which broke normal page migration to GPU memory
by copying too much data and corrupting GPU memory.
Fix this by only copying one page instead of a byte count.

Fixes: 9d4296a7d4b3 ("drm/nouveau/nouveau/hmm: fix migrate zero page to GPU=
")
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouve=
au/nouveau_dmem.c
index e5c230d9ae24..cc9993837508 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -550,7 +550,7 @@ static unsigned long nouveau_dmem_migrate_copy_one(stru=
ct nouveau_drm *drm,
 					 DMA_BIDIRECTIONAL);
 		if (dma_mapping_error(dev, *dma_addr))
 			goto out_free_page;
-		if (drm->dmem->migrate.copy_func(drm, page_size(spage),
+		if (drm->dmem->migrate.copy_func(drm, 1,
 			NOUVEAU_APER_VRAM, paddr, NOUVEAU_APER_HOST, *dma_addr))
 			goto out_dma_unmap;
 	} else {
--=20
2.20.1

