Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AA7C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B422467D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EZ9SJk6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgBSC3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:29:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42937 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgBSC3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:29:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so11683112pfz.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Lwgaqpl0HZQ1P9McupBrS5OPeUo6B2/L0nmFQFzJpZ0=;
        b=EZ9SJk6GGVAI+GAOUJ/e5T3k0xmSQAgenxkgUj3FNHcdryseTmuv3u6iNykko5/4Sx
         940TJ11ToPsGThl+bY/R7CTI2jt0YDJEyKjeITxDxmCEacKKwplsxrSGcNzBB+BMaFpS
         maWI9j6+FOBv2LtRAzave9vRkSfJ1nr6V/UI/xvPeOrY7TASlCzQ+i8ijO2XkXX5+TQu
         A8zI/anJz8BbQS17k0ruVajAiyPORd3NqtF+k+C5U7kr3yc4nsnhHEkWkKqU8D9YSI6e
         WtEKKcrWQTGXayvTLGiTFyVob2adLXHr5ocmXKchx/ZsOfAqNRdsbKyaAexrLziwqcJU
         ScQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Lwgaqpl0HZQ1P9McupBrS5OPeUo6B2/L0nmFQFzJpZ0=;
        b=dTqUs1ISeEERn4ctPAFhGw9NfWpjHauetJowyo6bCRj/MxujMnHqgzONa0CYB/Dhtz
         +YHHEAj5fQzE4T8/jDDEkziNoz9nQi/eR2uqoPRwsU522TNLrl4hSJIRvO6mIUeRXPAU
         dqf28aAhwW/CTGL3DlRqGfq4iRBmK0nBgNCRaMslrk8kMUEGzoyisfcinTVe+hXR4NqC
         DrHyHCSeNPfYWgZ2mMsORUPjHAqKOmTx2qSKtrCDWIO6K9r5aXb+2dlJMh3RCzhfBgUl
         EsdIvsPtm5FPaitemLMHhj0sMaGMipzaRbm5f2l2eZXZGbznYliLuVxHFce9fVw7N1rK
         hpUQ==
X-Gm-Message-State: APjAAAUUw6F8RZDZsPiLZaGhSqnfBZtHT7qTepsQM6bC+QexqJrZIJIZ
        hDNyxPJ1C3RungrUND3oRdOMwQ==
X-Google-Smtp-Source: APXvYqy7aU7raQfgCHEI7AbrGHGmPKQaKeC5I1nufKOMorOVg8CvFXs8yw3rsK3JutEaK2w5uM/4KQ==
X-Received: by 2002:a65:5242:: with SMTP id q2mr25082514pgp.74.1582079360199;
        Tue, 18 Feb 2020 18:29:20 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l13sm257529pjq.23.2020.02.18.18.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 18:29:19 -0800 (PST)
Date:   Tue, 18 Feb 2020 18:29:18 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [patch 1/2] mm, shmem: add thp fault alloc and fallback stats
In-Reply-To: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2002181828070.108053@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thp_fault_alloc and thp_fault_fallback vmstats are incremented when a
hugepage is successfully or unsuccessfully allocated, respectively, during
a page fault for anonymous memory.

Extend this to shmem as well.  Note that care is taken to increment
thp_fault_alloc only when the fault succeeds; this is the same behavior as
anonymous thp.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/shmem.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1502,9 +1502,8 @@ static struct page *shmem_alloc_page(gfp_t gfp,
 	return page;
 }
 
-static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
-		struct inode *inode,
-		pgoff_t index, bool huge)
+static struct page *shmem_alloc_and_acct_page(gfp_t gfp, struct inode *inode,
+		pgoff_t index, bool fault, bool huge)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct page *page;
@@ -1518,9 +1517,11 @@ static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
 	if (!shmem_inode_acct_block(inode, nr))
 		goto failed;
 
-	if (huge)
+	if (huge) {
 		page = shmem_alloc_hugepage(gfp, info, index);
-	else
+		if (!page && fault)
+			count_vm_event(THP_FAULT_FALLBACK);
+	} else
 		page = shmem_alloc_page(gfp, info, index);
 	if (page) {
 		__SetPageLocked(page);
@@ -1832,11 +1833,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	}
 
 alloc_huge:
-	page = shmem_alloc_and_acct_page(gfp, inode, index, true);
+	page = shmem_alloc_and_acct_page(gfp, inode, index, vmf, true);
 	if (IS_ERR(page)) {
 alloc_nohuge:
-		page = shmem_alloc_and_acct_page(gfp, inode,
-						 index, false);
+		page = shmem_alloc_and_acct_page(gfp, inode, index, vmf, false);
 	}
 	if (IS_ERR(page)) {
 		int retry = 5;
@@ -1871,8 +1871,11 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 
 	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
 					    PageTransHuge(page));
-	if (error)
+	if (error) {
+		if (vmf && PageTransHuge(page))
+			count_vm_event(THP_FAULT_FALLBACK);
 		goto unacct;
+	}
 	error = shmem_add_to_page_cache(page, mapping, hindex,
 					NULL, gfp & GFP_RECLAIM_MASK);
 	if (error) {
@@ -1883,6 +1886,8 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	mem_cgroup_commit_charge(page, memcg, false,
 				 PageTransHuge(page));
 	lru_cache_add_anon(page);
+	if (vmf && PageTransHuge(page))
+		count_vm_event(THP_FAULT_ALLOC);
 
 	spin_lock_irq(&info->lock);
 	info->alloced += compound_nr(page);
