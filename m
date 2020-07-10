Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BA0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D0720748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="E84Y2WCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgGJTsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:48:53 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11366 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJTsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:48:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f08c6170000>; Fri, 10 Jul 2020 12:48:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Jul 2020 12:48:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Jul 2020 12:48:51 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 19:48:44 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 10 Jul 2020 19:48:43 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f08c61b0000>; Fri, 10 Jul 2020 12:48:43 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Bharata B Rao" <bharata@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2 0/2] mm/migrate: optimize migrate_vma_setup() for holes
Date:   Fri, 10 Jul 2020 12:48:38 -0700
Message-ID: <20200710194840.7602-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594410519; bh=mfPaUs6+x4bmBVrgZ3KdArEOMvZq2FRlHrjkkL09nCI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=E84Y2WCBAtmNmgyyncAosp+p3PipEUI8ngP0g0RKi6QzPKJnPnUnZh7yj8lClrVXZ
         6N/b9s8B9Ma5U+12zTvMapXSmKTkhd9m4UJ7g9GXyx7NTrlrxSP8poz0VchDozLdVW
         hWiY0pwHicL4G2SpGQQ1Nya8TwiH5CzC5d92Mx+gPVrsykgm0soh3yjE9m1PBMM39u
         6D9PYs1PvRUR7qgzpfQwi9z8LYTcoHDIacXULcRtsx/yzpVAQGy42YVa4jUEu+X7Zt
         Ibyyki+0kDkjmygV0NPPCbL0l4lsW1JwBvz/r/8TPwTklDDCeNJlGnTnJea3rNGEV6
         ex0Vtst4cWI/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A simple optimization for migrate_vma_*() when the source vma is not an
anonymous vma and a new test case to exercise it.
This is based on linux-mm and is for Andrew Morton's tree.

Changes in v2:
Do the same check for vma_is_anonymous() for pte_none().
Don't increment cpages if the page isn't migrating.

Ralph Campbell (2):
  mm/migrate: optimize migrate_vma_setup() for holes
  mm/migrate: add migrate-shared test for migrate_vma_*()

 mm/migrate.c                           | 16 ++++++++++--
 tools/testing/selftests/vm/hmm-tests.c | 35 ++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

--=20
2.20.1

