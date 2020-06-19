Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD19C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB31217A0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g31txkb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394400AbgFSQNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:13:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31384 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2394391AbgFSQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHCFBr0H2Wj98J64LoxM3OjPsGeWNQz7WDWbAHsmGis=;
        b=g31txkb7064DGT16E5DNXqbhZ4Y2JfKNHoTv8e5LP6DGROyASe4p36hcbBr61Z/ebRAtxd
        b9JzAoXeSPHc6yz/HPoeKp1iVs6/iauucMIgl3T4vrlMg0OdHNmHI4PjWfkHQoiOPXqT2g
        eLe2u030MckT4351jIiYiP2C8NSpepM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-E9kaMyFTOaGPtJFBTrYhzQ-1; Fri, 19 Jun 2020 12:13:38 -0400
X-MC-Unique: E9kaMyFTOaGPtJFBTrYhzQ-1
Received: by mail-qk1-f197.google.com with SMTP id u186so1036998qka.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHCFBr0H2Wj98J64LoxM3OjPsGeWNQz7WDWbAHsmGis=;
        b=cf2iOT0ncrgFFW7rt2y9izCyoK0qGXHNIkj1f1VJ18f7Kz5xhCJUCM+DfNgfyNfAKh
         wHl3fOmm1LZ9TDUT00ubSC5GQTAcW0G3aAJKhae2BAjIlAvZ1CcWAZCAAY7cXxHxMjVB
         AT/4TEHe/h4pN3tJFX5e40JXFPNwulHeqPynYtTm3KltFkIklaSz6e6Kc1aRFUlmoZ89
         g6hJdJSXGjZwbh3+RJba68hxzbtAx7aUD3g2Nnm4jJ7gWcl6aoXC/H/IqbVOf1h8g6i5
         0ZQR+Q5bWkF9VW5mYrtgpMaRYdgQFLcB5Od28hXwn9Ndv5cw4Rq01VbgMKhY2F8IGZ8I
         zs2Q==
X-Gm-Message-State: AOAM530cV01q+rISaJvJU0r+YkZ87wy+nBIkaqFxl+LwKy3y5BsX1jWY
        BFAXJtqq51rSY897ygxnDsZybfSH2fqxvvKtxjJvAnDE5lHKY3r6OQw/GTY972QnF3lfkz8MTiX
        JxO1qn4stMd2CxDDOPXlC1KRg
X-Received: by 2002:ac8:4746:: with SMTP id k6mr4197647qtp.234.1592583217569;
        Fri, 19 Jun 2020 09:13:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8FxSE1nBWsTRVRNtg8kxaR64T2HjUjPlWnGOgZGa7/UjveZ5zpprBuiIcJe4cj3bpOnvD0g==
X-Received: by 2002:ac8:4746:: with SMTP id k6mr4197618qtp.234.1592583217335;
        Fri, 19 Jun 2020 09:13:37 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id r76sm6090318qka.30.2020.06.19.09.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:13:36 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 18/26] mm/s390: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:13:35 -0400
Message-Id: <20200619161335.9664-1-peterx@redhat.com>
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

