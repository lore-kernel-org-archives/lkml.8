Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72403C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE452072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="epnH81UO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgE2IpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:45:17 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9464 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2IpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:45:16 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed0cb900000>; Fri, 29 May 2020 01:45:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 29 May 2020 01:45:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 29 May 2020 01:45:16 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 May
 2020 08:45:16 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 29 May 2020 08:45:16 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.62.53]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ed0cb9c0002>; Fri, 29 May 2020 01:45:16 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Kara <jack@suse.cz>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm/gup: documentation fix for pin_user_pages*() APIs
Date:   Fri, 29 May 2020 01:45:15 -0700
Message-ID: <20200529084515.46259-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590741904; bh=YJZ6AZpFhdMTjSg3xt2syrJQG9Kn4gqR1ugcbx4KgGM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=epnH81UON5VVHMciiZrqvpQ2bMB4L++EGy4Shh6SqZ77UhDzeAgjGlBgP1nR7N2se
         /FZV3hWdEDGdb+OG7S27dN+YJnE2DC8zMzKE5IylPGrSS+DrFhHuErTFvRD3S3+mOu
         hjgMT/lkDWJvFZPrN9gdEriE/o8/zSJpxdyFZKbJPJtzEQduNDubhFZa0Ylol3pHOJ
         mDUX6+nT+odFDhF4n0tt2AEqv4ApLKnyVH9P+sLw1MA3+QfCnFb8vOiAZEUEJ91JPM
         L9DPxbLFZoc3+Jg6AJ2o29m4p95HPdcuXds79QLaEMcnATya+OBrTkADyp9Ns2mTdi
         P7yu4KUsp3KxQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the pin_user_pages*() API calls will cause pages to be
dma-pinned. As such, they are all suitable for either DMA, RDMA,
and/or Direct IO. The documentation should say so, but it was
instead saying that three of the API calls were only suitable for
Direct IO. This was discovered when a reviewer wondered why an
API call that specifically recommended against Case 2 (DMA/RDMA)
was being used in a DMA situation [1].

Fix this by simply deleting those claims. The gup.c comments already
refer to the more extensive Documentation/core-api/pin_user_pages.rst,
which does have the correct guidance. So let's just write it once,
there.

[1] https://lore.kernel.org/r/20200529074658.GM30374@kadam

Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

This applies on top of linux-next, in order to avoid a conflict with
Mauro Carvalho Chehab's fix to the lines right above these.

thanks,
John Hubbard
NVIDIA


 mm/gup.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ee039d421746d..311d0f11b35e6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2875,9 +2875,6 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). P=
lease
  * see Documentation/core-api/pin_user_pages.rst for further details.
- *
- * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pa=
ges.rst. It
- * is NOT intended for Case 2 (RDMA: long-term pins).
  */
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages)
@@ -2951,9 +2948,6 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast_only);
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). P=
lease
  * see Documentation/core-api/pin_user_pages.rst for details.
- *
- * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pa=
ges.rst. It
- * is NOT intended for Case 2 (RDMA: long-term pins).
  */
 long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
@@ -2987,9 +2981,6 @@ EXPORT_SYMBOL(pin_user_pages_remote);
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). P=
lease
  * see Documentation/core-api/pin_user_pages.rst for details.
- *
- * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pa=
ges.rst. It
- * is NOT intended for Case 2 (RDMA: long-term pins).
  */
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages,
--=20
2.26.2

