Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235ACC11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF582208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFWGax5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgBTPIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:08:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20450 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728264AbgBTPIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582211331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/w+hkaHbcwTCv2DnISajtPMXZj1KshVLgpzoXr7emTA=;
        b=HFWGax5nxv/yvggwzGDhtq+l74OHf1B6lQfDg4J0vy+Zt8pMkQYx6o4DhwyK2Cfsa5LywA
        HEtL7jmjZUlyHbO1Uhhz3FPU0T/Qvd3MavA79pcwyVsWpRrCmY2XOVUC+Uuk9XQNsjjhrz
        fODgiArI9BjbOaqSv0bJ+nVi4VJGn6A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-9nFBFoHMMECwrHEYwMKs_Q-1; Thu, 20 Feb 2020 10:08:43 -0500
X-MC-Unique: 9nFBFoHMMECwrHEYwMKs_Q-1
Received: by mail-qv1-f70.google.com with SMTP id p3so2739085qvt.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:08:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/w+hkaHbcwTCv2DnISajtPMXZj1KshVLgpzoXr7emTA=;
        b=kVxTEzr3C1xb9beZw74M9kcy/k6UQjAbZRyb5LGRPoAC9mR0g//ydrs0rco8rwZ5cw
         PXpEOKC/AeOYH8tADGzCY264TcysjRAmJeYMxTGSKE7a/+lGfcNpmUB+BF/Gr022pEpq
         QFc8tDaHYJNJXStS0REtCzy4hp0cTOt1V/SObYW2LlVbiTr0gYCoHh7wontJqiZHkb7R
         WpLCmyQhfsm+7DCIjJSpq0LQqVuu5dSGNfPxtw8+a+4uWjLMd0Rafw+JqTC0G7ov57/z
         g5w9XRnxugh2cUOB5i2W38y7U0n3LTVgIHiZYIJbDUqFt/e/6rG0SDXoMLhwvf+3rvSX
         p3FA==
X-Gm-Message-State: APjAAAXke024WNvCZg4jG2SOOlmJ86lYY5Yl0mgUehS+PEt7FVTDlF2Z
        Nb5guH9FQB/T3rGxouYuF0I35r6VfdsaSdC19g6PAPVG7528N9r9MPmSoFMmthOx7K5aox2/4Qc
        mivkWpBnE6nq7LOjdvFlK6nzZ
X-Received: by 2002:ad4:446b:: with SMTP id s11mr25652898qvt.148.1582211323386;
        Thu, 20 Feb 2020 07:08:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxugRDscVk/FXRr8dZM9uPwzbNZ2wMdRN4ctRZZIDdXWnit5dMgCM4q9KKtRycvuX+yljAtAA==
X-Received: by 2002:ad4:446b:: with SMTP id s11mr25652871qvt.148.1582211323163;
        Thu, 20 Feb 2020 07:08:43 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id i28sm2038234qtc.57.2020.02.20.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:08:42 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Martin Cracauer <cracauer@cons.org>,
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
Subject: [PATCH v6 05/16] arc/mm: Use helper fault_signal_pending()
Date:   Thu, 20 Feb 2020 10:08:40 -0500
Message-Id: <20200220150840.6023-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220145432.4561-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let ARC to use the new helper fault_signal_pending() by moving the
signal check out of the retry logic as standalone.  This should also
helps to simplify the code a bit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arc/mm/fault.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index fb86bc3e9b35..6eb821a59b49 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -133,29 +133,21 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 
 	fault = handle_mm_fault(vma, address, flags);
 
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
+		return;
+	}
+
 	/*
-	 * Fault retry nuances
+	 * Fault retry nuances, mmap_sem already relinquished by core mm
 	 */
-	if (unlikely(fault & VM_FAULT_RETRY)) {
-
-		/*
-		 * If fault needs to be retried, handle any pending signals
-		 * first (by returning to user mode).
-		 * mmap_sem already relinquished by core mm for RETRY case
-		 */
-		if (fatal_signal_pending(current)) {
-			if (!user_mode(regs))
-				goto no_context;
-			return;
-		}
-		/*
-		 * retry state machine
-		 */
-		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
-			flags |= FAULT_FLAG_TRIED;
-			goto retry;
-		}
+	if (unlikely((fault & VM_FAULT_RETRY) &&
+		     (flags & FAULT_FLAG_ALLOW_RETRY))) {
+		flags &= ~FAULT_FLAG_ALLOW_RETRY;
+		flags |= FAULT_FLAG_TRIED;
+		goto retry;
 	}
 
 bad_area:
-- 
2.24.1

