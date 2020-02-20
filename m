Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0C5C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F8C208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzeeKWgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgBTPC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:02:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33731 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727298AbgBTPC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582210946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cu+nCrF0vUC0DWPMISJ46Dyo+A/qgWPAj0jcXPlop0=;
        b=FzeeKWgyFIXoyAhCl3K/oRe2B6yuiXF3AZOR63EyJmrPZqaqKL0XT9SEv6jqxpvkTYfFtD
        jgEybqQvTK75X7GbHpF6xTwacDL7KPY4+bjvqAESywkh0kbAADUEupN4OO4L+eZuLI5gQn
        bGkBJuz76p1cBbgBr7zHg6cX/hodtaM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-hh9EangBNNafis37K764gA-1; Thu, 20 Feb 2020 10:02:25 -0500
X-MC-Unique: hh9EangBNNafis37K764gA-1
Received: by mail-qk1-f200.google.com with SMTP id k133so2885104qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cu+nCrF0vUC0DWPMISJ46Dyo+A/qgWPAj0jcXPlop0=;
        b=lMgbHUfryJHNOV7UOe0FK2C7WtbV8JUIdY/Yj4tN6/HbM7Y4ca8jhNkgohvhIrU80x
         8u2hS4PmvHqUbfcsOujxSdFH9nX2Cx0coey05PcOM0Jh1RmckQ11S3jl334V88Lh4Cme
         sapl6oWtOCHJVTihb9RBPiAZ6Rz7pnmE1LOp2Spa045F4EHOXwqFtTKR3gcujfTX5UTw
         T0zhE5Qtce95At8Z4RiXiu6bJZy6gvPi/Hiw/xV8h7gaw+GbttwxHIR9pOumG8zdHOfk
         SFbDcpRysrdAHBkvLLgUbSvpFhRgETpz+c3VmuQerC+Jfpj85kTYBbA2GGkdrT06ssiG
         BmzA==
X-Gm-Message-State: APjAAAU9FVZdr+x1beUAvBwegRuqhIH/0kH2aobPxYf7z+7f7y6EzB46
        DL6P78VECrkxr/3erVOndBBizRDo/J1Fmx2uvw3ffcCbRhUMSmSsiTYPaCP49ysWYBntVYU3omH
        gYoM5Yl7OFg0PsVcVU60s+J1U
X-Received: by 2002:aed:2266:: with SMTP id o35mr27096991qtc.392.1582210944725;
        Thu, 20 Feb 2020 07:02:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqwGhja4fszCZ8iNXLMYYaAL97h6qyMi5Falkk5Bxp02RABcQA3JMqlc0eVFMPDvI16Q+varXQ==
X-Received: by 2002:aed:2266:: with SMTP id o35mr27095812qtc.392.1582210931370;
        Thu, 20 Feb 2020 07:02:11 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id g11sm1956437qtc.48.2020.02.20.07.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:02:10 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Martin Cracauer <cracauer@cons.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Brian Geffon <bgeffon@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH v6 04/16] x86/mm: Use helper fault_signal_pending()
Date:   Thu, 20 Feb 2020 10:02:08 -0500
Message-Id: <20200220150208.5159-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220145432.4561-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move the fatal signal check even earlier so that we can directly
use the new fault_signal_pending() in x86 mm code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/fault.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fa4ea09593ab..6a00bc8d047f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1442,27 +1442,25 @@ void do_user_addr_fault(struct pt_regs *regs,
 	fault = handle_mm_fault(vma, address, flags);
 	major |= fault & VM_FAULT_MAJOR;
 
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			no_context(regs, hw_error_code, address, SIGBUS,
+				   BUS_ADRERR);
+		return;
+	}
+
 	/*
 	 * If we need to retry the mmap_sem has already been released,
 	 * and if there is a fatal signal pending there is no guarantee
 	 * that we made any progress. Handle this case first.
 	 */
-	if (unlikely(fault & VM_FAULT_RETRY)) {
+	if (unlikely((fault & VM_FAULT_RETRY) &&
+		     (flags & FAULT_FLAG_ALLOW_RETRY))) {
 		/* Retry at most once */
-		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
-			flags |= FAULT_FLAG_TRIED;
-			if (!fatal_signal_pending(tsk))
-				goto retry;
-		}
-
-		/* User mode? Just return to handle the fatal exception */
-		if (flags & FAULT_FLAG_USER)
-			return;
-
-		/* Not returning to user mode? Handle exceptions or die: */
-		no_context(regs, hw_error_code, address, SIGBUS, BUS_ADRERR);
-		return;
+		flags &= ~FAULT_FLAG_ALLOW_RETRY;
+		flags |= FAULT_FLAG_TRIED;
+		goto retry;
 	}
 
 	up_read(&mm->mmap_sem);
-- 
2.24.1

