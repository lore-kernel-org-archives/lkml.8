Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93263C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC322063A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667815;
	bh=ZmwBUR7+DZZ6gNJAh78+DU1YLOyaYWC2FmNmChYEAxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VWwL+LTCue7uqEnQnZ+qdrI7xCOh+0Q1nGlcgmAsoJi1h2aP4T4ytf1bkehKdT/Bd
	 XXLy4yt58e6yLKZxXdgHQVc5zRQ1JLReTDDhlyzr0Nkckc4sfXBfuiQgs3/x/S+A+9
	 ZNVD/XdqygaAP6nsXtwvDFznQzsadibeHW3tbdeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389097AbgE1MKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388707AbgE1L4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:56:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1E9212CC;
        Thu, 28 May 2020 11:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590666982;
        bh=ZmwBUR7+DZZ6gNJAh78+DU1YLOyaYWC2FmNmChYEAxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/ouTlHhib2/+3jEHUxq4MqvXq5cFvfBwv1zw6OEcO0DzAW6Gm3qm9OacI/2HuYEZ
         S8UKtAI9utZgoPw9bRqY4lRC1tEl9/O28bzkm+T4aHCXNKkBC2LQEoCPVtQiv2iUHm
         KT62Q7Jurxi8esTDQ9hf6cFuzsDaA0cmgtv0/roQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 19/47] s390/mm: fix set_huge_pte_at() for empty ptes
Date:   Thu, 28 May 2020 07:55:32 -0400
Message-Id: <20200528115600.1405808-19-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115600.1405808-1-sashal@kernel.org>
References: <20200528115600.1405808-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

