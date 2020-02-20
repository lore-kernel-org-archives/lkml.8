Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32770C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079F6206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIpVD7yD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgBTPBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:01:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58773 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728133AbgBTPBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582210878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cu+nCrF0vUC0DWPMISJ46Dyo+A/qgWPAj0jcXPlop0=;
        b=jIpVD7yDzPArBpmNA9pVWXG+fHyz+z5yapxCqgLJ1N18pROHBI0i0dDhm1YU3VeW84cMz+
        TKZYC7Ftz68wwPYKgE4jZk9zER6Og23uSgNb7367JJpkbVwEJNzdhO8JlWuBoj0D7rBupC
        Pwjm+yLbmVRKdDbnf1cn8LFJDXvAa+g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-WGM2PYZaN-iSSeJQorZHrQ-1; Thu, 20 Feb 2020 10:01:17 -0500
X-MC-Unique: WGM2PYZaN-iSSeJQorZHrQ-1
Received: by mail-qt1-f198.google.com with SMTP id p12so2742591qtu.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cu+nCrF0vUC0DWPMISJ46Dyo+A/qgWPAj0jcXPlop0=;
        b=DlaO0iPl7PkN+x0/11HArbxj9tRXJ4DkoDaihqNpgnzzXEEjJk8C6hilQNXDm7B5tM
         xuoL8qYig20stv3eXlWDv3wGlDBRH77pHqIIUp4a53B0MwfW+f5/v86n7NDAqxbTtE9H
         P6j9/XzeGeV/8BEvdxdxpE4NGlRFtH49by/AqAqaf4WP3uGjnsUZnCi/mhpeDiBuhi79
         0vSms0RkaQgcKlHAOk3YbSG8uboZwj0UAEJgbPmVaZz/UT2UNSvim3PBi0i66MoFF98p
         nzVNnnDjcz+qoxkwcN0pyo3ISktAlVrG/Ajs6eQfq2thI5CqLfbICcquTU0W2y/uahlk
         zwmw==
X-Gm-Message-State: APjAAAVFTivB6CqALKf0OoHPIUUXyU5zoMY++JwnhmERFhBuwJSYRn8r
        ECRySyIDI/MhOr6q3BLkoA9PEJCbe7YbDyPr+pqz1QpWh5IluAf7NkcikAxtYxYtZbyxgrgOCqL
        WR7JbEIqFEHNSuvy9qPdUPp/V
X-Received: by 2002:ac8:4085:: with SMTP id p5mr26819749qtl.132.1582210876703;
        Thu, 20 Feb 2020 07:01:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3QTVRkqA3yCavJV1bZCFrD3Tv4+JyoN+xrMyrd+Av7qoa1Y1pRsiT3dE9WPHn/5LgDfZBFw==
X-Received: by 2002:ac8:4085:: with SMTP id p5mr26819716qtl.132.1582210876390;
        Thu, 20 Feb 2020 07:01:16 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id m23sm1844583qtp.6.2020.02.20.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:01:15 -0800 (PST)
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
Date:   Thu, 20 Feb 2020 10:01:13 -0500
Message-Id: <20200220150113.5068-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220145432.4561-1-peterx@redhat.com
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

