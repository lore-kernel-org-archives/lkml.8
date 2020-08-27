Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B58AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A0222B4D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ljY2+3je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgH0THp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:07:45 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9007 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0THo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:07:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4804720000>; Thu, 27 Aug 2020 12:07:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 12:07:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Aug 2020 12:07:44 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 19:07:44 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 27 Aug 2020 19:07:44 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4804800000>; Thu, 27 Aug 2020 12:07:44 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] mm/migrate: remove cpages-- in migrate_vma_finalize()
Date:   Thu, 27 Aug 2020 12:07:34 -0700
Message-ID: <20200827190735.12752-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598555250; bh=awbwyASLbtxTy+p22pc3l4aK1xu021e4G6SblCHI+0g=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=ljY2+3je4EroVqmCgZoKwHcalhm5yEcj7rQPPx1nCADDR52KoUWZg3TLrd+qJoYwT
         9l/WHI0bRC21ZOv8ymmoUwz4EwXWnz1GMoBwgAXV0d1eprBJEOtNyfLs8SO0mdhHZH
         zbzkGKauJqekAxEImu5+y+Wps7gnyxZdNDoJ+bZ0JjCm7w1uB4k/zWUJGpuwwRXwk6
         5XhtGInICZfCBvfc1vlnrDXuOoKqUN0dBkpq4fDPjihvr7DcSug5/dHlD6IRaXMUII
         b77Pig/yFYU4fNeAWt4z2SuzHw4abqPGMWoSvekPnikVPwoUqyvQxODTj8yOrRNw6O
         uQIdkomlt7+EA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable struct migrate_vma->cpages is only used in
migrate_vma_setup(). There is no need to decrement it in
migrate_vma_finalize() since it is never checked.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

This applies to linux-mm and is for Andrew Morton's tree.

 mm/migrate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 0b945c8031be..eb859f7a9811 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -3087,7 +3087,6 @@ void migrate_vma_finalize(struct migrate_vma *migrate=
)
=20
 		remove_migration_ptes(page, newpage, false);
 		unlock_page(page);
-		migrate->cpages--;
=20
 		if (is_zone_device_page(page))
 			put_page(page);
--=20
2.20.1

