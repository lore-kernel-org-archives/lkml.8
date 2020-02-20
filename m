Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08546C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51DE20659
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqKRoyR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgBTP6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:58:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34333 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728305AbgBTP6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582214328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/w+hkaHbcwTCv2DnISajtPMXZj1KshVLgpzoXr7emTA=;
        b=EqKRoyR4RiAoga+1bW3ixAJ6x6ll7z9Bh/ZzD3GGnVSpQv9hdIuUpBjG100Y62Kjp0jfxf
        16MHZgpc6odZwEsK6A67xsulF6hW3ZeZ6gZtZ8tt+SYNRlsLqyJP9yJdHQrkfbnopSBokv
        YD+mlVW+yVJeZORcAVLY/CY5PCknS9w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-e5J0E5AoNOaHZkcUGv93lQ-1; Thu, 20 Feb 2020 10:58:46 -0500
X-MC-Unique: e5J0E5AoNOaHZkcUGv93lQ-1
Received: by mail-qk1-f197.google.com with SMTP id b23so3016378qkg.17
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/w+hkaHbcwTCv2DnISajtPMXZj1KshVLgpzoXr7emTA=;
        b=A2RMcginOnOnhbybO92T4poOhkMtqZmCU1tBs0TzkHvYkGYgnwJNvRD0HaGIbV0QwL
         dQl/33xklJe3mqpLIJhQP/3/AcFvcznk+m00Emc93lufPx+CcnP0IJVKtzVdahh0dLW3
         Mx8YqVsP0Co1LMsswlSgP3w8j0NbessKrW+I6Dzde9uqiizqscrvJkGjulgi8fyIwcJ7
         /7bm3BOhkKQu0GIPpfOQzmKqRRyM6V5c4esD85kcPPwZIXVbASAm1LHGpOpuSrLiwxVU
         FX7Ygihqb+SUTvW66KNPB/rS/b37jtkrDPWjW1LigZuu5vb743qZxgJwEy9uaC5D9tmG
         2ZNA==
X-Gm-Message-State: APjAAAVt+nSoddBA0cCor8yoJyFzsPWIJKlvL6LQ7doXe/PeWOD1EbQ9
        iHD1cLaMYKeoHtQ8+89cUqLMx8akf5eXUg8H4UqEiEOOlUfWrAbjp5ySND6rQX30Dayvt7N6hG1
        wIRDjAgZ2Tjz9/S/lmTVafpTh
X-Received: by 2002:a37:6393:: with SMTP id x141mr25710893qkb.134.1582214326041;
        Thu, 20 Feb 2020 07:58:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqwyG1X8cdmqasz0CGKVZZ1M2qefquTjA2lb+tjrK7SYG+1zTn4dHbhNdwOWnjgE3sv3Ui8bww==
X-Received: by 2002:a37:6393:: with SMTP id x141mr25710854qkb.134.1582214325797;
        Thu, 20 Feb 2020 07:58:45 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id e3sm1965255qtb.65.2020.02.20.07.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:58:45 -0800 (PST)
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
Subject: [PATCH RESEND v6 05/16] arc/mm: Use helper fault_signal_pending()
Date:   Thu, 20 Feb 2020 10:58:43 -0500
Message-Id: <20200220155843.9172-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
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

