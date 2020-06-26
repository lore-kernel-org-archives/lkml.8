Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEFAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DA020C09
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5yfzOfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgFZWhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:37:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36807 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726125AbgFZWge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHCFBr0H2Wj98J64LoxM3OjPsGeWNQz7WDWbAHsmGis=;
        b=R5yfzOfw/PV9JKqBWdCUcsneH01bWix262il1741Kj1OJ69IAXHjGvEFMQT1ObrLRN/3WZ
        A7pj8arAS5sHFNBT1tuKmhSIx8mj+C1vN/5FhgwBIDKykzBoVKZPk6sgkWgiSng6ctd05w
        7ZXtLkpTInn6VBJf8VYIgGdjNB9cC88=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-Mdmc3-niP3eP8-_0JdA7iA-1; Fri, 26 Jun 2020 18:36:31 -0400
X-MC-Unique: Mdmc3-niP3eP8-_0JdA7iA-1
Received: by mail-qt1-f197.google.com with SMTP id p9so7555077qtn.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHCFBr0H2Wj98J64LoxM3OjPsGeWNQz7WDWbAHsmGis=;
        b=rXyx8+qlH5LJ2KF0OLJxcIFcUR0DcencgHm3i1mbeZFEeW7xjTrLiZRLHEWwFJSHsd
         6lgqofirvgv6l3f2sJqO89vT1HmM0dhiAKq+Tlj3glktG4b40JnLDi0qnt298CWpsA/2
         F03PCW5gRGj4vRIPl5OjHZL+2IyTJGm9kXp2zQw0HPC9YotOLvTJ3TzyjhGBEmCiOKKT
         5JFx4/M6GpN4Gdw90hALmLobSX3yq9o/1OIKgOfJ01a9TnzJhFcM4wqJpxGCSjXl0T3r
         TvmAyrnsDeOQ7olgDBo14A7c+nHjMVj/adyAPWwQyRv1Y+5qWamjs+RW9AxQ1yjz9ejh
         xt/w==
X-Gm-Message-State: AOAM533MS/MCanDKC8BGRBl27xlRYHQGb0/lRAs5FkWHTavdARf5iXXc
        pf7/rCkGPy5GKwYY3An1gxVRnxFRfIh/BBnQ+Cn/9GyKhQ0NkA3OAebsUHekWGcHGxwXtQMzGlt
        kq4MHiHRfFSs9OYNf40728McJ
X-Received: by 2002:a05:620a:7ea:: with SMTP id k10mr4985245qkk.418.1593210990396;
        Fri, 26 Jun 2020 15:36:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLYGq3uXNWtPIgvnBvBRj+uEHvatOJbgH7Twl/utY0PoQ7HyXhGFahIL8nucdp7+auhoYPqQ==
X-Received: by 2002:a05:620a:7ea:: with SMTP id k10mr4985234qkk.418.1593210990186;
        Fri, 26 Jun 2020 15:36:30 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id k45sm3109699qtc.62.2020.06.26.15.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:29 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 18/26] mm/s390: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:36:27 -0400
Message-Id: <20200626223627.199861-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Vasily Gorbik <gor@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: linux-s390@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/fault.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index ab6d7eedcfab..4d62ca7d3e09 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -479,7 +479,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
@@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	if (unlikely(fault & VM_FAULT_ERROR))
 		goto out_up;
 
-	/*
-	 * Major/minor page fault accounting is only done on the
-	 * initial attempt. If we go through a retry, it is extremely
-	 * likely that the page will be found in page cache at that point.
-	 */
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
 			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {
-- 
2.26.2

