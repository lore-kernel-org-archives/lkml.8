Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86638C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D67206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYt+qxj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgGGWvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:51:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34096 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729707AbgGGWu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3XIq9qb2B089LN9k3kMf47vSw7aFkV5Znk8amd1bbo=;
        b=iYt+qxj0EepIfd94l1adZFwCkHRtj6Ff6QQZ2A2IK8Rgege3z3hGy2ElD9EtZoQr0av7EP
        frCE+RTH+YJOUGIPV2dJvN7Tdj8CUP/WiOq2aMvdMbRD3gkRc1CvawVuOttd6/t9HNBkxQ
        uDgrIh0vmZ8aHQjcw6toLRtke+SLqLc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-r2PdbDqvMA2KbrOZkTkLYQ-1; Tue, 07 Jul 2020 18:50:54 -0400
X-MC-Unique: r2PdbDqvMA2KbrOZkTkLYQ-1
Received: by mail-qv1-f69.google.com with SMTP id v20so28075557qvt.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3XIq9qb2B089LN9k3kMf47vSw7aFkV5Znk8amd1bbo=;
        b=lXgYYH8bzp0L3e84Wamm+g+snUWYk12WJvLaWLnkHMPluIVklEMn+HIz8pox6XjrJt
         /qnGgO9b97613m55B+4lRtaVuTrxKdfkkEaQJz8Hvd7K6r+ulpAF2MGpiKBo2uC1ziKT
         /uZ2UKlRFcn+lQwjq6B+W9OJNcv8b/92I26sU1WJ4cAYw34PhZlY693aq+8d1vaY2xl4
         hISEab4qsFdJk4lmY2pfsDKdfQ5FAh7YrqrQ/vSJSAvKBl1SjROqxFYsNPMX9+J207xP
         aBR9f5Og+qa4yt8X7T5sWNCFioruZfaibjAGFBhaI6XiVldlz5HKOEsy8zzNb8BRv4gI
         NuzQ==
X-Gm-Message-State: AOAM530NdPqHb1mAiU+hjlGW0DfdBOuM1O5zGl3wLcA5m1FClNgdqJaI
        FTt5sA9T3GNTDk2MQixAd3B80cfU/y0dIPDk3H5b4ZlA6WC5/wGBnW7kmY66XMa6eeV/+YyXij9
        o8rgC3zi+kuI/Fgl7IFQZSwJU
X-Received: by 2002:a37:aa05:: with SMTP id t5mr54060142qke.451.1594162254234;
        Tue, 07 Jul 2020 15:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeE2qM5GM19ugpdoKdIt+ai6du4xQwHKQ/Rb9KnI/4dISGj30ouoU1oW9Iw8yZXJini/8w8g==
X-Received: by 2002:a37:aa05:: with SMTP id t5mr54060118qke.451.1594162254014;
        Tue, 07 Jul 2020 15:50:54 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:53 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v5 18/25] mm/s390: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:14 -0400
Message-Id: <20200707225021.200906-19-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707225021.200906-1-peterx@redhat.com>
References: <20200707225021.200906-1-peterx@redhat.com>
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
Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/fault.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index fc14df0b4d6e..9aa201df2e94 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -478,7 +478,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
@@ -488,21 +488,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
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

