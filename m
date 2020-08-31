Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C463AC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 21:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB022137B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 21:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RCXCvDYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgHaVWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 17:22:32 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18494 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgHaVWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 17:22:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d69e80000>; Mon, 31 Aug 2020 14:21:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 14:22:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 31 Aug 2020 14:22:30 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 21:22:30 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 21:22:29 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4d6a150001>; Mon, 31 Aug 2020 14:22:29 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 1/2] mm/migrate: remove unnecessary is_zone_device_page() check
Date:   Mon, 31 Aug 2020 14:22:21 -0700
Message-ID: <20200831212222.22409-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200831212222.22409-1-rcampbell@nvidia.com>
References: <20200831212222.22409-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598908904; bh=lW7r6oHxQx8fXPiNLSVPMYvMf7jRKDuGDFS9fvpd+DY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=RCXCvDYm0RJCr4PbsQ4jczkmiYom2pXKkeuFLr7jI2ZGyYfnrBqoUKKFa31P6/Xqx
         xSGgf91mH84s5YEq4LZ7nJgco6/NQmUy8pSOXEGvWhw3rMI1iyYmZXKruVg4r5NyIh
         WvavOoGvUcEiznRjju0C9EV6DbO5Hdu6MKCMjQgvK/eoEzb/TmLOnWVuQsCdP6+BI3
         LQvtrOPuy3Fy/ddwCOMNbnha0bZAciuV1aMXLQrTGmdHy9+Bt+g1FioFzMMQZvSqbG
         BJdR40k7XOhMgtiFbWQDFLhsnDgvjgUKv4DgvbgsvRKFU2ZRgYB16mfNK1oh3mCsz2
         er1+iG7ebGZ/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for is_zone_device_page() and is_device_private_page() is
unnecessary since the latter is sufficient to determine if the page
is a device private page. Simplify the code for easier reading.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/migrate.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 659d3d8a3e1f..fe339a847328 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -246,13 +246,11 @@ static bool remove_migration_pte(struct page *page, s=
truct vm_area_struct *vma,
 		else if (pte_swp_uffd_wp(*pvmw.pte))
 			pte =3D pte_mkuffd_wp(pte);
=20
-		if (unlikely(is_zone_device_page(new))) {
-			if (is_device_private_page(new)) {
-				entry =3D make_device_private_entry(new, pte_write(pte));
-				pte =3D swp_entry_to_pte(entry);
-				if (pte_swp_uffd_wp(*pvmw.pte))
-					pte =3D pte_swp_mkuffd_wp(pte);
-			}
+		if (unlikely(is_device_private_page(new))) {
+			entry =3D make_device_private_entry(new, pte_write(pte));
+			pte =3D swp_entry_to_pte(entry);
+			if (pte_swp_uffd_wp(*pvmw.pte))
+				pte =3D pte_swp_mkuffd_wp(pte);
 		}
=20
 #ifdef CONFIG_HUGETLB_PAGE
--=20
2.20.1

