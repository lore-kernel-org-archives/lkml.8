Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF220C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE060207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IxdRdVnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgESUOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:14:52 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2923 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESUOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:14:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec43dac0000>; Tue, 19 May 2020 13:12:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 May 2020 13:14:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 May 2020 13:14:51 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 May
 2020 20:14:51 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 19 May 2020 20:14:50 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.90.179]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec43e3a0000>; Tue, 19 May 2020 13:14:50 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     John Hubbard <jhubbard@nvidia.com>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>
Subject: [PATCH v2] fpga: dfl: afu: convert get_user_pages() --> pin_user_pages()
Date:   Tue, 19 May 2020 13:14:49 -0700
Message-ID: <20200519201449.3136033-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589919148; bh=pJ6llEOWavFwdUD9sGVI9Hsd6427RYrbByo8iB19GBI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=IxdRdVnS7o9ITUl3yhAZz8epzgBO7EMfVjjSbeDenYiUzsrUtdWHttFa1OPGyXhda
         Io72M052YsrgywmA6Dnx9YdG/SL7y4iV4Sov9dRPvIyByheMmGqP/mP0UA9+gged0l
         RWEKM3oz3qfYOEBhE97EYYqr6hn8sZ6anCgw7eRTotZakp5DHGwAEk2k3ZdegrwOL4
         2CEphAVvnb6zi3tz1KBHSsmGCKz9JDF4IbJKO0tfdPRGoEcYsnmLYXZrBmJt0bbpIs
         KldyrhLnkn81oB3ij/SigpYyK0V80bzsKxvLN1N/9cApcX+EQhvSU4RnD/OAkItVp7
         MVWfJPhPBzX0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was using get_user_pages_fast(), in a "Case 2" scenario
(DMA/RDMA), using the categorization from [1]. That means that it's
time to convert the get_user_pages_fast() + put_page() calls to
pin_user_pages_fast() + unpin_user_pages() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Cc: Xu Yilun <yilun.xu@intel.com>
Cc: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

Changes since v1:

Changed the label from "put_pages", to "unpin_pages".

thanks,
John Hubbard
NVIDIA
=20
 drivers/fpga/dfl-afu-dma-region.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-r=
egion.c
index 62f924489db5..a31dd3a7e581 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -16,15 +16,6 @@
=20
 #include "dfl-afu.h"
=20
-static void put_all_pages(struct page **pages, int npages)
-{
-	int i;
-
-	for (i =3D 0; i < npages; i++)
-		if (pages[i])
-			put_page(pages[i]);
-}
-
 void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
 {
 	struct dfl_afu *afu =3D dfl_fpga_pdata_get_private(pdata);
@@ -57,11 +48,11 @@ static int afu_dma_pin_pages(struct dfl_feature_platfor=
m_data *pdata,
 		goto unlock_vm;
 	}
=20
-	pinned =3D get_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
+	pinned =3D pin_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
 				     region->pages);
 	if (pinned < 0) {
 		ret =3D pinned;
-		goto put_pages;
+		goto unpin_pages;
 	} else if (pinned !=3D npages) {
 		ret =3D -EFAULT;
 		goto free_pages;
@@ -71,8 +62,8 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_=
data *pdata,
=20
 	return 0;
=20
-put_pages:
-	put_all_pages(region->pages, pinned);
+unpin_pages:
+	unpin_user_pages(region->pages, pinned);
 free_pages:
 	kfree(region->pages);
 unlock_vm:
@@ -94,7 +85,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platfo=
rm_data *pdata,
 	long npages =3D region->length >> PAGE_SHIFT;
 	struct device *dev =3D &pdata->dev->dev;
=20
-	put_all_pages(region->pages, npages);
+	unpin_user_pages(region->pages, npages);
 	kfree(region->pages);
 	account_locked_vm(current->mm, npages, false);
=20
--=20
2.26.2

