Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459FCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187E02063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686937;
	bh=/cuD2ZRHke61dcElaO4+21/PDcRJpbABFxPbMOpsJZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZUeDWgScH/+XqVcLrjV5O0hSl+/Cy3pSW34SYGILXffMlQpepR9P7KEaLeo+rxIp2
	 KwsiZ9cWo+WUhVorVsoysS2+rndX+seWtOdaDEo75NZO4wq8eH6QF+hALVxChET8ek
	 HFCf+PpWB8S35liFrH6g0ZHpr3Qbhnobe6YUclSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbgHQRze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388374AbgHQQKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:10:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B39E20748;
        Mon, 17 Aug 2020 16:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680642;
        bh=/cuD2ZRHke61dcElaO4+21/PDcRJpbABFxPbMOpsJZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2oUXpx63GSEwVIjdCdo/AnsDJtD6EloYj0zcYrJ7JMKg1r/jzhmDYqDoTOWoxDt0
         +wtRSpELXUKkK/k6qiY3uoURgZNL4Rb3/WP8vkMvmb8IKeUPMO5EogRrKA3OtaYNRm
         CqljBQtpYDGxVhEl3XZ3lCe5auAzuqAj0yRxUVII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 5.4 269/270] s390/gmap: improve THP splitting
Date:   Mon, 17 Aug 2020 17:17:50 +0200
Message-Id: <20200817143809.204796062@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

commit ba925fa35057a062ac98c3e8138b013ce4ce351c upstream.

During s390_enable_sie(), we need to take care of splitting all qemu user
process THP mappings. This is currently done with follow_page(FOLL_SPLIT),
by simply iterating over all vma ranges, with PAGE_SIZE increment.

This logic is sub-optimal and can result in a lot of unnecessary overhead,
especially when using qemu and ASAN with large shadow map. Ilya reported
significant system slow-down with one CPU busy for a long time and overall
unresponsiveness.

Fix this by using walk_page_vma() and directly calling split_huge_pmd()
only for present pmds, which greatly reduces overhead.

Cc: <stable@vger.kernel.org> # v5.4+
Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/mm/gmap.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2485,23 +2485,36 @@ void gmap_sync_dirty_log_pmd(struct gmap
 }
 EXPORT_SYMBOL_GPL(gmap_sync_dirty_log_pmd);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int thp_split_walk_pmd_entry(pmd_t *pmd, unsigned long addr,
+				    unsigned long end, struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+
+	split_huge_pmd(vma, pmd, addr);
+	return 0;
+}
+
+static const struct mm_walk_ops thp_split_walk_ops = {
+	.pmd_entry	= thp_split_walk_pmd_entry,
+};
+
 static inline void thp_split_mm(struct mm_struct *mm)
 {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	struct vm_area_struct *vma;
-	unsigned long addr;
 
 	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
-		for (addr = vma->vm_start;
-		     addr < vma->vm_end;
-		     addr += PAGE_SIZE)
-			follow_page(vma, addr, FOLL_SPLIT);
 		vma->vm_flags &= ~VM_HUGEPAGE;
 		vma->vm_flags |= VM_NOHUGEPAGE;
+		walk_page_vma(vma, &thp_split_walk_ops, NULL);
 	}
 	mm->def_flags |= VM_NOHUGEPAGE;
-#endif
 }
+#else
+static inline void thp_split_mm(struct mm_struct *mm)
+{
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /*
  * Remove all empty zero pages from the mapping for lazy refaulting


