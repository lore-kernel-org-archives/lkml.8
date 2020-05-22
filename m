Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EC4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA622078B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KMBRLvBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgEVBEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 21:04:49 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2925 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgEVBEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 21:04:48 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec724e00000>; Thu, 21 May 2020 18:03:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 21 May 2020 18:04:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 21 May 2020 18:04:48 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 May
 2020 01:04:48 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 22 May 2020 01:04:47 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.48.182]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec7252e0002>; Thu, 21 May 2020 18:04:47 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <jgg@ziepe.ca>
CC:     <Liam.Howlett@oracle.com>, <daniel.m.jordan@oracle.com>,
        <dave@stgolabs.net>, <hughd@google.com>, <jglisse@redhat.com>,
        <jhubbard@nvidia.com>, <ldufour@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <peterz@infradead.org>, <rientjes@google.com>, <vbabka@suse.cz>,
        <walken@google.com>, <willy@infradead.org>, <yinghan@google.com>
Subject: [PATCH] mm/gup: might_lock_read(mmap_sem) in get_user_pages_fast()
Date:   Thu, 21 May 2020 18:04:43 -0700
Message-ID: <20200522010443.1290485-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590109408; bh=orFrUSfsuRLARmy9U5y3S0SO6hDyarPkvJhx+oK/0Hs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=KMBRLvBLyYyTvaxnVcV1qu9rFMZ92Jbco7/6QV/Z/phN5ZTLDHOGl9Ki3m6a2DcSD
         BpKmHS6l2KQY8LakU8ItjBIyfIaInKVAaqH5FwPdk7TKjpu7o8L1SANr+YDWBmwOyS
         lcxd4dM7iMfyPp77XEwOOh4/I9EA4SJ2eAo5nuReCE/PYstFfoaoIMdZK060pjQsty
         Rkljf7hCsLVq9Cky/GdawmLzJt/3w9D5ImKkECpevqNFbylyEP6TWumchnsHZ+DLc9
         Z0c+kwjayDs8wrvy1wtXGy4VRQspw27xGF89S5+NRdeGxPFAt67RVu3XGlLH9J/eE0
         wL6Nt0UeiR8Zw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of scattering these assertions across the drivers,
do this assertion inside the core of get_user_pages_fast*()
functions. That also includes pin_user_pages_fast*()
routines.

Add a might_lock_read(mmap_sem) call to internal_get_user_pages_fast().

Suggested-by: Matthew Wilcox <willy@infradead.org>
Cc: Michel Lespinasse <walken@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi Andrew,

This applies on top of [1], which in turn applies to
today's (20200521) linux-next.

As noted in the discussion [2], this will need changing from
mmap_sem to mmap_lock, after Michel Lespinasse's patchset
arrives.

[1]
https://lore.kernel.org/r/20200521233841.1279742-1-jhubbard@nvidia.com

[2] https://lore.kernel.org/linux-mm/20200520124817.GG31189@ziepe.ca/

thanks,
John Hubbard
NVIDIA

 mm/gup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index ada6aa79576dc..3462c076e8ecf 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2728,6 +2728,9 @@ static int internal_get_user_pages_fast(unsigned long=
 start, int nr_pages,
 				       FOLL_FAST_ONLY)))
 		return -EINVAL;
=20
+	if (!(gup_flags & FOLL_FAST_ONLY))
+		might_lock_read(&current->mm->mmap_sem);
+
 	start =3D untagged_addr(start) & PAGE_MASK;
 	addr =3D start;
 	len =3D (unsigned long) nr_pages << PAGE_SHIFT;
--=20
2.26.2

