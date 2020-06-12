Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DD8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA92C2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="g3KYVEGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgFLT0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:26:30 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6630 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgFLT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:26:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ee3d6870000>; Fri, 12 Jun 2020 12:24:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Jun 2020 12:26:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Jun 2020 12:26:29 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Jun
 2020 19:26:21 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 12 Jun 2020 19:26:21 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ee3d6dd0001>; Fri, 12 Jun 2020 12:26:21 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] mm/hmm: remove redundant check non_swap_entry()
Date:   Fri, 12 Jun 2020 12:26:18 -0700
Message-ID: <20200612192618.32579-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591989895; bh=icsVOdgmAkRserHRvC2Osttgk9x3GM+LGacD67WObIc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=g3KYVEGlWLmJzmMnSj6C5n05opBwBpp+vfJZwrSgLFHWsR7KWI6rT8AU5cWxhvuzm
         JPS1/JkvO9NCmbtYXaMe2RgJeWutLsLWGRskZevRYZVV49jdnd4b7pN8ocAvVJaf8r
         d3qvbj4rDOK2tLwPUChEILsEdEwuErcSQV5EvZpDKoXUcwCyz+qYDuGQLGpsLOFSZB
         IdLwRkSkKqAGF6DHgp9zjmSpyxiSWYWZbcCottT+ymYGg+ttuxA6O0tkQNFUXjWSjV
         gu12wA48zxIzms9WaZKThPPnRFmt8JKj20gxqbv9RxDXKoTkbmqGUp9sefjDvIUM2y
         A7jN80UJypEzg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In zap_pte_range(), the check for non_swap_entry() and
is_device_private_entry() is redundant since the latter is a subset of the
former. Remove the redundant check to simplify the code and for clarity.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

This is based on the current linux tree and is intended for Andrew's mm
tree. There is no rush so it could go into 5.9 but I think it is safe
enough to go into an rc after the patch is reviewed.

 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index dc7f3543b1fd..bdbb4f97e7d0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1098,7 +1098,7 @@ static unsigned long zap_pte_range(struct mmu_gather =
*tlb,
 		}
=20
 		entry =3D pte_to_swp_entry(ptent);
-		if (non_swap_entry(entry) && is_device_private_entry(entry)) {
+		if (is_device_private_entry(entry)) {
 			struct page *page =3D device_private_entry_to_page(entry);
=20
 			if (unlikely(details && details->check_mapping)) {
--=20
2.20.1

