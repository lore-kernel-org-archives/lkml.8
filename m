Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE0DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA15206E9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtubiScP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHBTM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 15:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgHBTM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 15:12:59 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FB0C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 12:12:58 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id b2so5862963qvp.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=XRgkO+pWg9WMheb+JuYC1vAI+vcvMh8iE4b2S931akA=;
        b=jtubiScPdbrW2+U7U+6jrzTShJ5Sg9yHdKlHM1Y9mq8Amalzwv74e6GjZougu1lAPc
         9jt9PbyLvszkkyA/zS4V6TxdEyB7CRSqfWRdTy5+0/FDOSu2M+Eg65uPiICpGw66FFT/
         wdG04xdsqcxbo/7I8N6ygrqr7/9x7bfS37nqSdZjOPHFLiVulebhs1apxLRFxD7nhaGN
         ErihAFyp0ylMXsZ8MGiWjvAsp3xJhmkQZ1bgcdhqfY/irbBnFXyH3UD5caeLp6s073gl
         TaFut4XXDirwV1fq1Zlg2fYrCQLtRjK5WoJWJsU6Vj/e9/tIQQCiIyC1t/G9IlJ+XHeZ
         rbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=XRgkO+pWg9WMheb+JuYC1vAI+vcvMh8iE4b2S931akA=;
        b=UkUwBtHdui9aeLnvEHnG8kYCBW/J6KyPbLtegpt7zD8OMnj5n43GwBKj9Nf8BAcUkZ
         m3cJyiM7veEOtPu015HPXysSFc9Wzs/fyK64LEH+SU0O7zJSOTkOARZxNvcn881w4Klx
         uwT2oOw9Pj+KwITSHQomjQXuXL9EMaGIh57AetU/ggs8RAOK7jFGCKRzktdHv+6YeN+E
         OwEohVyUr9ao4iw3JlmTl4RLRdo80wRQD5qyUqgmtT7McPZeGhXiTIGv237CxKi/1py+
         vbCxla4CqBoL5WwFRW/Y3X8plEaTFiuxOtSM1UgVsEEDKG8n90QLPTIpQUP2qJMuw6cK
         pn+A==
X-Gm-Message-State: AOAM531Fn9QWE/OAHFH06d1Q+vtI1f5hi4kkyMtrCa8ifPbNX5aaiEr7
        1LndpzEfxXpqYeWyqlpFm9mptlivcCM=
X-Google-Smtp-Source: ABdhPJx3nuFaSj5OTZQhiVFDS8UmH+7MuU+YZgjvS3G55rBmDRWqt8Q81TxAunQoMIQS7xaozuHgbw==
X-Received: by 2002:ad4:41c9:: with SMTP id a9mr13360158qvq.171.1596395576614;
        Sun, 02 Aug 2020 12:12:56 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g21sm18668943qts.18.2020.08.02.12.12.54
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 02 Aug 2020 12:12:55 -0700 (PDT)
Date:   Sun, 2 Aug 2020 12:12:42 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] khugepaged: collapse_pte_mapped_thp() flush the right
 range
Message-ID: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmdp_collapse_flush() should be given the start address at which the huge
page is mapped, haddr: it was given addr, which at that point has been
used as a local variable, incremented to the end address of the extent.

Found by source inspection while chasing a hugepage locking bug, which
I then could not explain by this. At first I thought this was very bad;
then saw that all of the page translations that were not flushed would
actually still point to the right pages afterwards, so harmless; then
realized that I know nothing of how different architectures and models
cache intermediate paging structures, so maybe it matters after all -
particularly since the page table concerned is immediately freed.

Much easier to fix than to think about.

Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org # v5.4+
---

 mm/khugepaged.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 5.8-rc7/mm/khugepaged.c	2020-07-26 16:58:02.189038680 -0700
+++ linux/mm/khugepaged.c	2020-08-02 10:48:59.890925896 -0700
@@ -1502,7 +1502,7 @@ void collapse_pte_mapped_thp(struct mm_s
 
 	/* step 4: collapse pmd */
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	_pmd = pmdp_collapse_flush(vma, addr, pmd);
+	_pmd = pmdp_collapse_flush(vma, haddr, pmd);
 	spin_unlock(ptl);
 	mm_dec_nr_ptes(mm);
 	pte_free(mm, pmd_pgtable(_pmd));
