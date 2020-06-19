Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13603C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EBA204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJ5DK1Iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394112AbgFSQGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:06:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2394156AbgFSQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JN+es+8H1l3agmqz1OlDugYxis3rubXdkuh1XRgK5Rw=;
        b=UJ5DK1Iv8v7Fz5GkYCuFpQYCsvqo6aL/Cn8Lq1jGTv70BqD6Xr8RGF57ayoUaZOTNZ2gN6
        Rm6WqxMRpDQupABLnyngpoGGDuvx0vC5dvu4k9VSA2Ceuw2BZ3ALpi6HW8lZ2ojiG1wSLr
        lyPcYmvftE/QQzGl5VHNA0f375DuUsA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-rvWOMuuCNf-6Vr3FZusMNw-1; Fri, 19 Jun 2020 12:06:06 -0400
X-MC-Unique: rvWOMuuCNf-6Vr3FZusMNw-1
Received: by mail-qk1-f197.google.com with SMTP id n185so5527418qkc.21
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JN+es+8H1l3agmqz1OlDugYxis3rubXdkuh1XRgK5Rw=;
        b=TXOtkV2H3abf92B4WSBAkQQEovjHbkG9aC/BUPdKTcSyb0YJ9k274/MqkupzdRIx1U
         hf6NM1mDI6twCW7no24ZJR2ruzAgqzw8CHDkUUnBS70iy02IK/kmqvgC1nAqpTg9muoV
         3HXgkFYdJ8FWHtyPS5IW205ZXjxaO0ovPq8MgVUNGiHjfZGVS9NduO3a/SAaGLZSqYHm
         DzxuzcZYxImAllvWl/01hZuZNSGEMGJqYHMzE1VQLEXccGJYK0kwyj4R3DVi6xbo4Ym3
         amc3R3QqJXVHp6uAi+pk1MXt4FLxadkAR6r/938cJfhFQxzfNZpRURQm+ATcpchC02rA
         J6mQ==
X-Gm-Message-State: AOAM53185gZzAwUs/71PFANL0nZDUoNAi3b6TaiAkFPnAzsL8ib4hdSL
        dY+MES93eRKdL/3Q9N0s3OWr5yRRyME0RAfV3qwlMkun1tKL2rMLTDyCdkt5dOiRuXLvS1C9Le8
        Jbe7K42M7VVHohnKQYT8nfS1s
X-Received: by 2002:a05:620a:810:: with SMTP id s16mr4133124qks.360.1592582763542;
        Fri, 19 Jun 2020 09:06:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykH0gVLj5//M8Cz8/QdCcP1QeRwcUw6yJV2iyuWBKSIFyWPnkNb4597nojKp96iqgMHS74AQ==
X-Received: by 2002:a05:620a:810:: with SMTP id s16mr4133016qks.360.1592582762503;
        Fri, 19 Jun 2020 09:06:02 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g11sm6412604qkk.123.2020.06.19.09.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:06:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH 12/26] mm/nds32: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:05:24 -0400
Message-Id: <20200619160538.8641-13-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619160538.8641-1-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

Fix PERF_COUNT_SW_PAGE_FAULTS perf event manually for page fault retries, by
moving it before taking mmap_sem.

CC: Nick Hu <nickhu@andestech.com>
CC: Greentime Hu <green.hu@gmail.com>
CC: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/nds32/mm/fault.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 22527129025c..e7344440623c 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -122,6 +122,8 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	if (unlikely(faulthandler_disabled() || !mm))
 		goto no_context;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
+
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -207,7 +209,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, addr, flags, NULL);
+	fault = handle_mm_fault(vma, addr, flags, regs);
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
@@ -229,22 +231,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 			goto bad_area;
 	}
 
-	/*
-	 * Major/minor page fault accounting is only done on the initial
-	 * attempt. If we go through a retry, it is extremely likely that the
-	 * page will be found in page cache at that point.
-	 */
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
-				      1, regs, addr);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
-				      1, regs, addr);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

