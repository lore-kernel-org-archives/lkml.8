Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17348C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B9A2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTtoM1Ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFOWXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:23:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30050 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725843AbgFOWXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iJ7T2WCuS9j4a5Opdda9lcC0DUIC1agfdOIfVBRkmk=;
        b=HTtoM1KeSswjw8jBzcTNyOQEECAhgrN/bGmpfGzzNQwEQBTByWUeYp+KDQufmrVK3vLOsc
        eE0uxPxgJdKXDDVp8oeBjB3oTOBeEuXsdUUNVMthE1NI27lHyah4OabzLtXJCFPEVEthtk
        ssBac/Cz4V8PsAcnqeywfo99zgLluec=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-zROIL_wiMVekPfGvajAInA-1; Mon, 15 Jun 2020 18:23:05 -0400
X-MC-Unique: zROIL_wiMVekPfGvajAInA-1
Received: by mail-qv1-f70.google.com with SMTP id ba13so14113948qvb.15
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iJ7T2WCuS9j4a5Opdda9lcC0DUIC1agfdOIfVBRkmk=;
        b=S0bEUjRY7jMYi1i4G6PL6Y/tAPzsHlDGpgg80DIFF4MqtQjVti3vHI+RZWZNqGGsti
         smto0Ye5o8OPAr7/ZpwG8u6F6olWEhfXkTeJ5cnMYsK8MEATCtyqvUsF1sMmaK6JOvzK
         3y/Tu/w5aJp5Y/nNF4zXqQYmdOYnbypF2OOvvw+p1/BC7kGGXaCvv0xHix5eKV6IpqdJ
         3fmI4cTh4qOuL6HihZg+AQSEJB2VWJ1uoZ67JBuPym8j+8fiiVar25PxtgSMaOq6oecx
         QonVlRCHnzxHaj3ft/ThzAxNU/wdzSTF3V1k4nQ05WL1MblU9jJNNZ2gBo/PPHJNhV03
         Zm1g==
X-Gm-Message-State: AOAM531K0Xi4lxGmwl7NaOO7Kh1jph2mS/9gy9wUVBnAOFUhZdbmv1Ju
        u9AqmPqQTBiVmwAsv3J1LbjUWwAG5E+dSP09Yo3dyFXzSGX0bDVWqcsWNr5shevtj5UWaCwAP51
        zN0ZYLkiD2oIQY2RWe6Qc1MCR
X-Received: by 2002:ac8:4f46:: with SMTP id i6mr17839223qtw.317.1592259784901;
        Mon, 15 Jun 2020 15:23:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsVEBhvqnlL41B27HM9K7iSgiXjn7WNVAulmZ9FZltbdlG0mU9CjIqjx17dmiutbX9UExfzg==
X-Received: by 2002:ac8:4f46:: with SMTP id i6mr17839209qtw.317.1592259784704;
        Mon, 15 Jun 2020 15:23:04 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id d17sm12237625qke.101.2020.06.15.15.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:23:04 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 19/25] mm/s390: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:23:02 -0400
Message-Id: <20200615222302.8452-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new mm_fault_accounting() helper for page fault accounting.

Avoid doing page fault accounting multiple times if the page fault is retried.

CC: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Vasily Gorbik <gor@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: linux-s390@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/fault.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index dedc28be27ab..8ca207635b59 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -392,7 +392,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	unsigned long trans_exc_code;
 	unsigned long address;
 	unsigned int flags;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 
 	tsk = current;
 	/*
@@ -428,7 +428,6 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	}
 
 	address = trans_exc_code & __FAIL_ADDR_MASK;
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	flags = FAULT_FLAG_DEFAULT;
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
@@ -480,6 +479,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
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
@@ -519,6 +505,9 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 			goto retry;
 		}
 	}
+
+	mm_fault_accounting(tsk, regs, address, major);
+
 	if (IS_ENABLED(CONFIG_PGSTE) && gmap) {
 		address =  __gmap_link(gmap, current->thread.gmap_addr,
 				       address);
-- 
2.26.2

