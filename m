Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B56C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145A52166E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="If3FdC3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392126AbgFSQHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:07:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45871 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405537AbgFSQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYKuiXa6JqSlFakb02F9N/z/khfKW7nv0ZKU3o10xCg=;
        b=If3FdC3pC2JY56xaHH+XCevdoh7aOir+1448pNF6p4RfwgXYf7BhzkNC/xKyozzSEwbh14
        UY6IlWT6O8MosJYg5LJzQjbrET3U+XK+uVSbtpGp6T1LoYCyvlbvJVHqbJGtu+RaudH/N5
        ocnxaWg9OzocXsff7Uq4FQWDwlpZQpQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-W9KU2JuPP1u_V_3sPe3wkQ-1; Fri, 19 Jun 2020 12:05:52 -0400
X-MC-Unique: W9KU2JuPP1u_V_3sPe3wkQ-1
Received: by mail-qv1-f70.google.com with SMTP id a4so7013124qvl.18
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYKuiXa6JqSlFakb02F9N/z/khfKW7nv0ZKU3o10xCg=;
        b=h/lE6EsVciTVjzO8QiLTX7Yh+kWmvQijDrW5t5vl9Jfv3kacy5B3r6yKFCZOw/GtDp
         gcBa7yFlfWDQDiCk2phnalX3CZ9w02xgo7oaTxAtgx3Z7DmQ4AS232t2PMdckLOnquU6
         pq+WvlLIqbc1+Su53Sp6Il+i8aS24ExKdWWwSyxoLKdRSjUam34iQn0x+XFYKqR7wd0Y
         14GhKznv3bj72XfI/VDJHfUjvF/BaHeaKdopp72p+M8mNUhkrAh1Xm/2KELvDpck2S12
         2s1rlxSegEFE9hmUWmjRSKVzZJAJYM5bXe6VXrA2gVfteFFKLaCH2LoTxZtiFHpSTrDn
         AR/Q==
X-Gm-Message-State: AOAM533ladMPCKAkiTfP6plig65q/sFxnZY511hYgamtPaQCoi9rOFOQ
        I/lYosIAaXS+5Bqk3wztamYNh2QrEfWlf0Gojvq0a96W8gnUbIiHeryjKMaQMlq2UY5BTXUOlCo
        QU1FVftytdCamejGPNyw6aCEq
X-Received: by 2002:a05:620a:3cc:: with SMTP id r12mr4302275qkm.44.1592582751524;
        Fri, 19 Jun 2020 09:05:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySAqeFc3bvWBPkc6npddWja9I+KCezM5DnLrSAgO76qm+hQxaisHscRU59a9ognA5IwopVqQ==
X-Received: by 2002:a05:620a:3cc:: with SMTP id r12mr4302251qkm.44.1592582751313;
        Fri, 19 Jun 2020 09:05:51 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g11sm6412604qkk.123.2020.06.19.09.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:05:50 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH 06/26] mm/csky: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:05:18 -0400
Message-Id: <20200619160538.8641-7-peterx@redhat.com>
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

CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/csky/mm/fault.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index b14f97d3cb15..a3e0aa3ebb79 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -151,7 +151,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0,
-				NULL);
+				regs);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -161,16 +161,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 			goto bad_area;
 		BUG();
 	}
-	if (fault & VM_FAULT_MAJOR) {
-		tsk->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
-			      address);
-	} else {
-		tsk->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
-			      address);
-	}
-
 	up_read(&mm->mmap_sem);
 	return;
 
-- 
2.26.2

