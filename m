Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D051C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E3422B40
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678504;
	bh=Oopa2Q4J01ZunaBcR25lClVjGsRiJotF3lTYnimf010=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iBtb6X5THo74gL9FkdnbKyb3LcSivnlpu2YjgYBI2Wwrz/cEJf5N8ZWbXdOAYQbhW
	 hDi0fwZ67ioQAZs9s81pe2OXvUyBS0B9T8x0m0yH+VItPGUVG+A/FledreNnZXlNEK
	 23bgRlYcrncHJiL900/M+eQ8QRxIJFYmeTg32vRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgHQPfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730174AbgHQPaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:30:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35BC23B21;
        Mon, 17 Aug 2020 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678219;
        bh=Oopa2Q4J01ZunaBcR25lClVjGsRiJotF3lTYnimf010=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1cTwM4OWI8Iqyh28LWeyf8IieC7qLJ7DkH7sEJXyhsAYSE2qQ/U55+WTnblhUCumL
         hr51qDsotWmuQa0tK2y/dG9g46rdrz5bhUQ0PN4HjmZxL/q1sl8mppNny1wDJk2iLP
         t5VG5HRYQ8HAopoxOB4WliEofgTjdHsvTkz6duNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 251/464] powerpc/mm/radix: Free PUD table when freeing pagetable
Date:   Mon, 17 Aug 2020 17:13:24 +0200
Message-Id: <20200817143845.819219557@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharata B Rao <bharata@linux.ibm.com>

[ Upstream commit 9ce8853b4a735c8115f55ac0e9c2b27a4c8f80b5 ]

remove_pagetable() isn't freeing PUD table. This causes memory
leak during memory unplug. Fix this.

Fixes: 4b5d62ca17a1 ("powerpc/mm: add radix__remove_section_mapping()")
Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200709131925.922266-3-aneesh.kumar@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index bb00e0cba1195..c2989c1718839 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -700,6 +700,21 @@ static void free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 	pud_clear(pud);
 }
 
+static void free_pud_table(pud_t *pud_start, p4d_t *p4d)
+{
+	pud_t *pud;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		pud = pud_start + i;
+		if (!pud_none(*pud))
+			return;
+	}
+
+	pud_free(&init_mm, pud_start);
+	p4d_clear(p4d);
+}
+
 struct change_mapping_params {
 	pte_t *pte;
 	unsigned long start;
@@ -874,6 +889,7 @@ static void __meminit remove_pagetable(unsigned long start, unsigned long end)
 
 		pud_base = (pud_t *)p4d_page_vaddr(*p4d);
 		remove_pud_table(pud_base, addr, next);
+		free_pud_table(pud_base, p4d);
 	}
 
 	spin_unlock(&init_mm.page_table_lock);
-- 
2.25.1



