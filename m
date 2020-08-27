Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B303C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50939207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WlEJMPn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgH0THy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:07:54 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15737 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0THx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:07:53 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f48040e0001>; Thu, 27 Aug 2020 12:05:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 12:07:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 27 Aug 2020 12:07:52 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 19:07:52 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 27 Aug 2020 19:07:52 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4804870001>; Thu, 27 Aug 2020 12:07:51 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] mm/migrate: remove obsolete comment about device public
Date:   Thu, 27 Aug 2020 12:07:35 -0700
Message-ID: <20200827190735.12752-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827190735.12752-1-rcampbell@nvidia.com>
References: <20200827190735.12752-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598555150; bh=BfJm+RGbGFk68/SdYnbTc0lCDPuZwtCIZZNn8TT1MVQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=WlEJMPn2H4T2sLGFlK0P8GAlqPSxGWLhY8Tb3wL+kNObc7FQT3itTF21dSAwgDufG
         Sdh6u2ULItn05ZXXAJ0Jph6vlAKMSEn/7LgyckmtFAoPb5UzY4MpQUD9x7Ghw2aE2H
         HjyT5IYCEzp18iKdjMz3eCTxprFOo9AGIrhOay5MPt81jzzzpHuUX3fBIKrf5Qh0iR
         Fj4ljlrQY23gH+5LYSFurwVua6AneXgVNNzdVKERjFjgHYfBEKQIjqcKaSfcXbyRhR
         WyWh245sYbKxnXH9Y2NXGPQzuOdsP54/neD248fZFEYz4uxpMsTAJs0e+O7C42PjBZ
         Uxdeze5ddEcnQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device public memory never had an in tree consumer and was removed in
commit 25b2995a35b6 ("mm: remove MEMORY_DEVICE_PUBLIC support").
Delete the obsolete comment.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

This applies to linux-mm and is for Andrew Morton's tree.

 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index eb859f7a9811..34fdd25a26db 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -381,7 +381,7 @@ static int expected_page_refs(struct address_space *map=
ping, struct page *page)
 	int expected_count =3D 1;
=20
 	/*
-	 * Device public or private pages have an extra refcount as they are
+	 * Device private pages have an extra refcount as they are
 	 * ZONE_DEVICE pages.
 	 */
 	expected_count +=3D is_device_private_page(page);
--=20
2.20.1

