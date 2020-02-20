Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D23C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4992465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awDq0oJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgBTQCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:02:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41966 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728644AbgBTQCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582214551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gswwep3mXTBLLb6Vi32okBT2PfDu/kHkaO+Nde6OuPk=;
        b=awDq0oJHOyaMqOynjpx5exnDobC/emSja4lz/9H0caWoZFyGLwyW6y2XtKOIyCf+J4LE4a
        LkXDWH2LiVsDJUOzg7Jia2xKkfPg0vKYZ+64qHDvFQ3MXz7MPKD1PPQM/ITIm7LelBOU5p
        ihnUg9FOdN9HVLwDIFo0+4/BC/feuwM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-lsHksNMyNQq3iOt2ip7N1A-1; Thu, 20 Feb 2020 11:02:30 -0500
X-MC-Unique: lsHksNMyNQq3iOt2ip7N1A-1
Received: by mail-qt1-f200.google.com with SMTP id y3so2892879qti.15
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gswwep3mXTBLLb6Vi32okBT2PfDu/kHkaO+Nde6OuPk=;
        b=JbiRIY75EATG5WGhqp0ypJLDqRm8gUiH0MHYFkoiNPVJ1vHEnI4uLNMl68Z+kQ2q2d
         Z2k5vV/JbZB96KEG767Mb/6n2Oe9LxTrD0JsiAnnRv5SGDEpC6UumLZw2qgbOaA/mdOg
         pXRC5cR/cpde4N+DlPXgjVmj9gjSh93iVYABZ6tEkGcP1fgBuVLkifOvk+uHkzQTDKsI
         F+uFACaDSvHeo1zn3SLO51GhsZx1swxDJjmnPi8Iw+in6rYjsiwGo3TIREVRR7eSS1nY
         exHHA32St6G+d3hIw82tFJ0F65BNkCm+cgFQc6dUqolaC3+qIli8uZxk9JK8TCWlZTFi
         BUYg==
X-Gm-Message-State: APjAAAVJTLf4KqX0T1jKNRpeYY1xgQfh4Nfaup9HNSquyN+LJ2bjkjpX
        RWvxe/x6+gvzZ0rszVPK8RPKmRNE3wPeMrrpTBuhSR4sIowp8TE7BBKobS+7pW09MZ2rZF4UbnS
        EM3tL3db5zOX6ItAeAiKWXvEi
X-Received: by 2002:a05:620a:20c1:: with SMTP id f1mr8514889qka.229.1582214549958;
        Thu, 20 Feb 2020 08:02:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7hBw2gg2WOpOLEqAOvRZ+ql2BYdirmepbIVkV4khoEHxFeBq3KgVo+cKJ5pK2t7V8VjEMIw==
X-Received: by 2002:a05:620a:20c1:: with SMTP id f1mr8514853qka.229.1582214549733;
        Thu, 20 Feb 2020 08:02:29 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id 89sm1957073qth.3.2020.02.20.08.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:02:28 -0800 (PST)
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
Subject: [PATCH RESEND v6 08/16] sh/mm: Use helper fault_signal_pending()
Date:   Thu, 20 Feb 2020 11:02:26 -0500
Message-Id: <20200220160226.9550-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let SH to use the new fault_signal_pending() helper.  Here we'll need
to move the up_read() out because that's actually needed as long as
!RETRY cases.  At the meantime we can drop all the rest of up_read()s
now (which seems to be cleaner).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sh/mm/fault.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 5f51456f4fc7..eb4048ad0b38 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -302,25 +302,25 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 	 * Pagefault was interrupted by SIGKILL. We have no reason to
 	 * continue pagefault.
 	 */
-	if (fatal_signal_pending(current)) {
-		if (!(fault & VM_FAULT_RETRY))
-			up_read(&current->mm->mmap_sem);
+	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			no_context(regs, error_code, address);
 		return 1;
 	}
 
+	/* Release mmap_sem first if necessary */
+	if (!(fault & VM_FAULT_RETRY))
+		up_read(&current->mm->mmap_sem);
+
 	if (!(fault & VM_FAULT_ERROR))
 		return 0;
 
 	if (fault & VM_FAULT_OOM) {
 		/* Kernel mode? Handle exceptions or die: */
 		if (!user_mode(regs)) {
-			up_read(&current->mm->mmap_sem);
 			no_context(regs, error_code, address);
 			return 1;
 		}
-		up_read(&current->mm->mmap_sem);
 
 		/*
 		 * We ran out of memory, call the OOM killer, and return the
-- 
2.24.1

