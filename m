Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20D0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EA02086A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366759;
	bh=ZmwBUR7+DZZ6gNJAh78+DU1YLOyaYWC2FmNmChYEAxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=emJtYRNpWkAcyLGBLXQYxTjsaBo+rtdlw3fvF65D0pCVai/E2ShGC2/o0w2SPS3gp
	 inHk2otoUtjzuEc5Hx1xzr0/5FyabU89Xe6SSccDFb8/Tx8c3quJIrdvwA3QbLCdr/
	 twpW69Oz1CsNmkqKh4YBvv+vUEEnORhBMq/Fu0bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgFEOTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbgFEOTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:19:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE828208B8;
        Fri,  5 Jun 2020 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366751;
        bh=ZmwBUR7+DZZ6gNJAh78+DU1YLOyaYWC2FmNmChYEAxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdkDmpwhJ1dkLFqvAgoXmFLnE0OvRqGWG1xV2GUXsOSz2BdxQfzMTjmCOjcgoBcUN
         Ihos2ZwBmdCZzHmuSCIPp2H+ozXmey3fockagSVxIO9mQ8yw9l+e08qfENYIpLotNL
         SHDlDNUb5wB3QHoknkWnEnVm/qrIsTfzoQWjWkJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 33/38] s390/mm: fix set_huge_pte_at() for empty ptes
Date:   Fri,  5 Jun 2020 16:15:16 +0200
Message-Id: <20200605140254.825987686@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140252.542768750@linuxfoundation.org>
References: <20200605140252.542768750@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

[ Upstream commit ac8372f3b4e41015549b331a4f350224661e7fc6 ]

On s390, the layout of normal and large ptes (i.e. pmds/puds) differs.
Therefore, set_huge_pte_at() does a conversion from a normal pte to
the corresponding large pmd/pud. So, when converting an empty pte, this
should result in an empty pmd/pud, which would return true for
pmd/pud_none().

However, after conversion we also mark the pmd/pud as large, and
therefore present. For empty ptes, this will result in an empty pmd/pud
that is also marked as large, and pmd/pud_none() would not return true.

There is currently no issue with this behaviour, as set_huge_pte_at()
does not seem to be called for empty ptes. It would be valid though, so
let's fix this by not marking empty ptes as large in set_huge_pte_at().

This was found by testing a patch from from Anshuman Khandual, which is
currently discussed on LKML ("mm/debug: Add more arch page table helper
tests").

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/mm/hugetlbpage.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 5674710a4841..7dfae86afa47 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -159,10 +159,13 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		rste &= ~_SEGMENT_ENTRY_NOEXEC;
 
 	/* Set correct table type for 2G hugepages */
-	if ((pte_val(*ptep) & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3)
-		rste |= _REGION_ENTRY_TYPE_R3 | _REGION3_ENTRY_LARGE;
-	else
+	if ((pte_val(*ptep) & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3) {
+		if (likely(pte_present(pte)))
+			rste |= _REGION3_ENTRY_LARGE;
+		rste |= _REGION_ENTRY_TYPE_R3;
+	} else if (likely(pte_present(pte)))
 		rste |= _SEGMENT_ENTRY_LARGE;
+
 	clear_huge_pte_skeys(mm, rste);
 	pte_val(*ptep) = rste;
 }
-- 
2.25.1



