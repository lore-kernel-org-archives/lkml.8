Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DD5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 21:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7FC206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 21:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZzXUvi0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgHaVWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 17:22:36 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11379 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgHaVWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 17:22:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d69980001>; Mon, 31 Aug 2020 14:20:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 14:22:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 31 Aug 2020 14:22:30 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 21:22:30 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 21:22:30 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4d6a150003>; Mon, 31 Aug 2020 14:22:29 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 2/2] mm/migrate: preserve soft dirty in remove_migration_pte()
Date:   Mon, 31 Aug 2020 14:22:22 -0700
Message-ID: <20200831212222.22409-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200831212222.22409-1-rcampbell@nvidia.com>
References: <20200831212222.22409-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598908824; bh=/ipjpHkkeivZ87Vlc2yYb0Vba/A4X8d8GxlfEZWUxR0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=ZzXUvi0px/bTG0EVGP2xyCKwESunCzWASuxsvDpudVMigdzLlKaTlJZs5JHmzz0aB
         jyXi1u44c9KoM2W7SmcyDofzVrhN3jkFmxVc6gvXHkT+malP6swX/k9haqrisgdcwh
         HMfmBvCqWbWl/QYLPbKbJcc6gotJX2fRbO31yUE43PXRc8rjID84khaMLCtZG9f20a
         Sbj8gKC1sArfB/DBZkB8k0lXkeqBGRjjKMrTPbJMPaxZfBvO3MmVsOisWNk+YUcdr1
         1W4xmUS1P05smOPgsPhQT0VkxxrglfA7NCcMXAjZvLdEYCV9ZGg3DHgaW7Qx/zEI2t
         x9BNk7o+QUfhQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to remove a migration PTE and replace it with a device private
PTE was not copying the soft dirty bit from the migration entry.
This could lead to page contents not being marked dirty when faulting
the page back from device private memory.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/migrate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index fe339a847328..4f89360d9e77 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -249,6 +249,8 @@ static bool remove_migration_pte(struct page *page, str=
uct vm_area_struct *vma,
 		if (unlikely(is_device_private_page(new))) {
 			entry =3D make_device_private_entry(new, pte_write(pte));
 			pte =3D swp_entry_to_pte(entry);
+			if (pte_swp_soft_dirty(*pvmw.pte))
+				pte =3D pte_swp_mksoft_dirty(pte);
 			if (pte_swp_uffd_wp(*pvmw.pte))
 				pte =3D pte_swp_mkuffd_wp(pte);
 		}
--=20
2.20.1

