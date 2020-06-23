Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D379C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46C552072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LKidMHUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgFWGq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:46:27 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3579 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730489AbgFWGq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:46:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef1a4e70000>; Mon, 22 Jun 2020 23:44:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 23:46:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 23:46:26 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 06:46:26 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Jun 2020 06:46:26 +0000
Received: from ng-desktop.nvidia.com (Not Verified[10.110.48.88]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef1a5410001>; Mon, 22 Jun 2020 23:46:25 -0700
From:   Nitin Gupta <nigupta@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Nitin Gupta <ngupta@nitingupta.dev>,
        Nitin Gupta <nigupta@nvidia.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: Fix compile error due to COMPACTION_HPAGE_ORDER
Date:   Mon, 22 Jun 2020 23:45:44 -0700
Message-ID: <20200623064544.25766-1-nigupta@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592894695; bh=sQDcI940fD/qM5n2u+V5GJ+0quSFLSiPSXJWwk8BXlA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=LKidMHUezYnfC231U1hU2as/V8fJLmd8X9WdJ2nJ+Fm/HHijTx4gI0OR37xNu5oTD
         NMWEXy8MoQH94wTf2C2EeREO4WL8Y9ZQ1tk4K883++yGn3+YhWlhlW9eOJaKKxpJW4
         pQ24MGkBasnUt8vxZYI5jXnSm1jpgYPRyUkDlP+hY6m9wyKUcrfupaD9jNcQAV+OOO
         lgbQY9KPeS50K1cxF5z6gCbHbC2hdwYpkRE5T5L7hMoMODorjWwwsXETRgng91OfU7
         QSFeqrdHbMREAVccZzPbsD5lIfi3xJnQTuyRl0Lh/ZCbEI3k8x4ZN6ZxeIdDYBbGJO
         PIhM1YDJxW/oA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compile error when COMPACTION_HPAGE_ORDER is assigned
to HUGETLB_PAGE_ORDER. The correct way to check if this
constant is defined is to check for CONFIG_HUGETLBFS.

Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
---
 mm/compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 45fd24a0ea0b..02963ffb9e70 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -62,7 +62,7 @@ static const unsigned int HPAGE_FRAG_CHECK_INTERVAL_MSEC =
=3D 500;
  */
 #if defined CONFIG_TRANSPARENT_HUGEPAGE
 #define COMPACTION_HPAGE_ORDER	HPAGE_PMD_ORDER
-#elif defined HUGETLB_PAGE_ORDER
+#elif defined CONFIG_HUGETLBFS
 #define COMPACTION_HPAGE_ORDER	HUGETLB_PAGE_ORDER
 #else
 #define COMPACTION_HPAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
--=20
2.27.0

