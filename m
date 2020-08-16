Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B65DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53FC20838
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597587856;
	bh=xkBC+H3ZNkqHkgahGnGRODOgp8Bra4n6v42RR5Q2N+c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YPLxYnPjWaMrC44QxeaxMHmoEEFZ9BRVZMmFhKi7Ims7ayK8aKOV+ego81vyrMqAZ
	 Ub8GE3YHqoSCHoIvnADFOCt0cWoMfBAKxoK5lb69EHyTvrVPaIKfa2W6sHx/LH4lH+
	 X8acJAL7EtvUm3cUHxCqyIpxVEYlzhqB9RRndvJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgHPOYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 10:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729394AbgHPOYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 10:24:13 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FB8E204EC;
        Sun, 16 Aug 2020 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597587852;
        bh=xkBC+H3ZNkqHkgahGnGRODOgp8Bra4n6v42RR5Q2N+c=;
        h=From:To:Cc:Subject:Date:From;
        b=EfsYUCodboa3hGL+f80lzxiKuB1LjMHShEYEi25qGbkMLB6IqngOQfMsszvYNMhG4
         gz6VJds3oxi4tBp5s6LVpm0YqavFo9ygT5xoQzB+x0npfhflNvIwUxRyk9Q6yZFmK3
         IgslH9XPDMyGVxVv9LxATEErdZO+9Ni0UN41P1vg=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Meelis Roos <mroos@linux.ee>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] parisc: fix PMD pages allocation by restoring pmd_alloc_one()
Date:   Sun, 16 Aug 2020 17:24:03 +0300
Message-Id: <20200816142403.15449-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Commit 1355c31eeb7e ("asm-generic: pgalloc: provide generic pmd_alloc_one()
and pmd_free_one()") converted parisc to use generic version of
pmd_alloc_one() but it missed the fact that parisc uses order-1 pages for
PMD.

Restore the original version of pmd_alloc_one() for parisc, just use
GFP_PGTABLE_KERNEL that implies __GFP_ZERO instead of GFP_KERNEL and
memset.

Fixes: 1355c31eeb7e ("asm-generic: pgalloc: provide generic pmd_alloc_one() and pmd_free_one()")
Repoerted-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Tested-by: Meelis Roos <mroos@linux.ee>
Link: https://lkml.kernel.org/r/9f2b5ebd-e4a4-0fa1-6cd3-4b9f6892d1ad@linux.ee 
---

Hi,

I've trimmed the 'cc list relatively to the bug report and added parisc
maintainers.

 arch/parisc/include/asm/pgalloc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index cc7ecc2ef55d..a6482b2ce0ea 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -10,6 +10,7 @@
 
 #include <asm/cache.h>
 
+#define __HAVE_ARCH_PMD_ALLOC_ONE
 #define __HAVE_ARCH_PMD_FREE
 #define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
@@ -67,6 +68,11 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 			(__u32)(__pa((unsigned long)pmd) >> PxD_VALUE_SHIFT)));
 }
 
+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	return (pmd_t *)__get_free_pages(GFP_PGTABLE_KERNEL, PMD_ORDER);
+}
+
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 	if (pmd_flag(*pmd) & PxD_FLAG_ATTACHED) {
-- 
2.26.2

