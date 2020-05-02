Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FDCC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C633F208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBTP92mI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEBAfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 20:35:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51018 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726352AbgEBAfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588379730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ujwsyw/O/+AeBjWrVJ65oHPAkvklfR2fQlh0BfXvrl8=;
        b=ZBTP92mIRRydB5tWbYn4+BYzcU5GpxAbkeCFx62DxaoijGCiD2UuyQJJyO8SlyW1Dic+Nx
        6Cspe7o6Ecy8GJTg6vF56U1UbvMmkBaw9xsfR5aE1sBGmWw2dfldCyF2NTOUrnhOBEWwQp
        MeggRtiFSQGQr0nScidNp7DjNhuYs7g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-9zCLmeDGOR2A_AFPmm_4Ew-1; Fri, 01 May 2020 20:35:27 -0400
X-MC-Unique: 9zCLmeDGOR2A_AFPmm_4Ew-1
Received: by mail-qk1-f198.google.com with SMTP id h186so11931690qkc.22
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 17:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ujwsyw/O/+AeBjWrVJ65oHPAkvklfR2fQlh0BfXvrl8=;
        b=SakNbwwGtm4Zvv4RyOIxdZcd/hQeGg7h0O5jA5AiRUaW+e7tAZHdEnkIhSl+PVz3cy
         NWIkYs0eZ8OQ5j6zgfOvZuFkYwcXbz3cbFcPObED6/+VcpYy22Kx3mCkf5Akxs9mbbqK
         NRBnq3FZ0+/LHYExZcClrhf16IKPxWH/ncuszIL0aO0HDW+PsJiQP6s2yZJUC0CxQrqf
         C+DigCFwL05VzlkJ87+WdObufUQEhsa3l++imquDaYbaABPVkFEi++yz4vOHuMM5js7k
         nTr2hSV54uMjZpWay+cplXpOx7ee+wtbQ2Cxw9MKF83U0GpT0JPgGVY1xi6po1AFgOBG
         DBRA==
X-Gm-Message-State: AGi0PuYNt/Ru0+UwexixbUfMr7LE+L0W3o87dRATuccLwASWPy6Kf7di
        yMxut/yM9tUePlcUSZFae5ZLmZq5VhIxJYPaaK2fsdPcJn7LTtrj9SFHpWfaQBCjL23deVevWW8
        7G1q3hLIdFkRJLEsLyZazn43Q
X-Received: by 2002:a0c:e305:: with SMTP id s5mr6695560qvl.234.1588379726269;
        Fri, 01 May 2020 17:35:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypIKjxGjbQD1Flb1NGYaaAesLEVchYYS9XDerFgmnbjkuTL/GCEnpwLpmoav+xBLnP8sNFxrUw==
X-Received: by 2002:a0c:e305:: with SMTP id s5mr6695538qvl.234.1588379725927;
        Fri, 01 May 2020 17:35:25 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g123sm4044892qkd.95.2020.05.01.17.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 17:35:24 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/gup: Fix fixup_user_fault() on multiple retries
Date:   Fri,  1 May 2020 20:35:23 -0400
Message-Id: <20200502003523.8204-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This part is overlooked when reworking the gup code on multiple retries.  When
we get the 2nd+ retry, we'll be with TRIED flag set.  Current code will bail
out on the 2nd retry because the !TRIED check will fail so the retry logic will
be skipped.  What's worse is that, it will also return zero which errornously
hints the caller that the page is faulted in while it's not.

The !TRIED flag check seems to not be needed even before the mutliple retries
change because if we get a VM_FAULT_RETRY, it must be the 1st retry, and we
should not have TRIED set for that.

Fix it by removing the !TRIED check, at the meantime check against fatal
signals properly before the page fault so we can still properly respond to the
user killing the process during retries.

CC: Alex Williamson <alex.williamson@redhat.com>
Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
Signed-off-by: Peter Xu <peterx@redhat.com>
---

I don't have a case to trigger the problem, so I only smoke tested the patch.
However I think this should be the right thing to do...  Please have a look,
thanks.
---
 mm/gup.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 50681f0286de..87a6a59fe667 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1218,6 +1218,10 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	if (!vma_permits_fault(vma, fault_flags))
 		return -EFAULT;
 
+	if ((fault_flags & FAULT_FLAG_KILLABLE) &&
+	    fatal_signal_pending(current))
+		return -EINTR;
+
 	ret = handle_mm_fault(vma, address, fault_flags);
 	major |= ret & VM_FAULT_MAJOR;
 	if (ret & VM_FAULT_ERROR) {
@@ -1230,11 +1234,9 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 
 	if (ret & VM_FAULT_RETRY) {
 		down_read(&mm->mmap_sem);
-		if (!(fault_flags & FAULT_FLAG_TRIED)) {
-			*unlocked = true;
-			fault_flags |= FAULT_FLAG_TRIED;
-			goto retry;
-		}
+		*unlocked = true;
+		fault_flags |= FAULT_FLAG_TRIED;
+		goto retry;
 	}
 
 	if (tsk) {
-- 
2.26.2

