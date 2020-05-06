Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DADC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508C020714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETIAmoHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgEFGqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:46:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36970 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727859AbgEFGqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588747609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dylOKlOOkcmqnOmlxPIhLIeCImPfi8HZqhDsGTLntD8=;
        b=ETIAmoHALpHKjgOlTTYfInA6Yl+qcNVlKeOAg7FH5bm6ZTEWCOkHNM6dhnxqFOuXi49MV+
        +opD8RPrlGBj52uhhIgLzhgpGXE813v9w2erRo+1B9OsKvnb2D7CFa6WAgO6UyYUgv1j+h
        s8vRQhNfPk0PLl4kHYoQ5AZKQUJLRF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-E0L-RSu4McSJCbfgZLbRDA-1; Wed, 06 May 2020 02:46:45 -0400
X-MC-Unique: E0L-RSu4McSJCbfgZLbRDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE27245F;
        Wed,  6 May 2020 06:46:43 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F112A605DF;
        Wed,  6 May 2020 06:46:41 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com, shan.gavin@gmail.com
Subject: [PATCH] arm64/mm: Remove add_huge_page_size()
Date:   Wed,  6 May 2020 16:46:35 +1000
Message-Id: <20200506064635.20114-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function add_huge_page_size(), wrapper of hugetlb_add_hstate(),
avoids to register duplicated huge page states for same size. However,
the same logic has been included in hugetlb_add_hstate(). So it seems
unnecessary to keep add_huge_page_size() and this just removes it.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/mm/hugetlbpage.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index bbeb6a5a6ba6..ed7530413941 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -441,22 +441,14 @@ void huge_ptep_clear_flush(struct vm_area_struct *v=
ma,
 	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
 }
=20
-static void __init add_huge_page_size(unsigned long size)
-{
-	if (size_to_hstate(size))
-		return;
-
-	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
-}
-
 static int __init hugetlbpage_init(void)
 {
 #ifdef CONFIG_ARM64_4K_PAGES
-	add_huge_page_size(PUD_SIZE);
+	hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
 #endif
-	add_huge_page_size(CONT_PMD_SIZE);
-	add_huge_page_size(PMD_SIZE);
-	add_huge_page_size(CONT_PTE_SIZE);
+	hugetlb_add_hstate(CONT_PMD_SHIFT + PMD_SHIFT - PAGE_SHIFT);
+	hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
+	hugetlb_add_hstate(CONT_PTE_SHIFT);
=20
 	return 0;
 }
@@ -473,7 +465,7 @@ static __init int setup_hugepagesz(char *opt)
 	case CONT_PMD_SIZE:
 	case PMD_SIZE:
 	case CONT_PTE_SIZE:
-		add_huge_page_size(ps);
+		hugetlb_add_hstate(ilog2(ps) - PAGE_SHIFT);
 		return 1;
 	}
=20
--=20
2.23.0

