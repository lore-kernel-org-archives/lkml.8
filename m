Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB224C11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D51A20658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBHRR66n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgBTQCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:02:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59190 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728620AbgBTQCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582214563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mmxs1xZU/E+YLRZuVpERmcrfUBlYfy8dMItOYHlmr9U=;
        b=bBHRR66nxw4SuwWOFVefEVbksmaxCgsw9vGQr+YoCGicHrVwjb5NfpyWaerk2hgFYXU5RE
        tb2NlVPIPSq/4xz9Wi55qS+31G2e4ySGopjUxA25k3w043Y62TrVYTiAjOXLLf9KkA4jvW
        SfIuGpGcD2E6U85jrGS4DFOYg+/h/lc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-Wz-b9dzRPOKntn67EQ0sSw-1; Thu, 20 Feb 2020 11:02:38 -0500
X-MC-Unique: Wz-b9dzRPOKntn67EQ0sSw-1
Received: by mail-qt1-f200.google.com with SMTP id n4so2899404qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mmxs1xZU/E+YLRZuVpERmcrfUBlYfy8dMItOYHlmr9U=;
        b=UCvGIu4zZQyrWTKb+3EE0HDhx8CgxSggNJPBztq19t49ttH6Br85T4G8m/eVRLmO3D
         TiO++Yf8ks+ET9bk96H/ujfAtb7fWYwRqP26M0X0LVa1FdEKqG/5UqmeKUYca0vPD74Q
         JBfL47cd2SoefibIzaEXBRBM1dsCwuN7NlEGieKjTjuPnll4lxZJtqEv3GCs3J47NoCw
         Sb8yRbZajspPgOcEig9nAaR+5k4fpS1G3OoKr+ZJ0q4XNqS6X2+EDCBwSL3M2BbkqAd1
         uEyhlYgFWj42E5Kgb7uPG7nilj3kVM298KC3ANxM2kXVAMyirrqwOVl2G1qDkg+IXsrO
         Gs8A==
X-Gm-Message-State: APjAAAXjoQDlshB9uY13ivitfBT22XeI7CBG8RhC7FWHe8B0Ic+XUqJO
        nPej6PcmgHuHZfR1CR/KyOm1zVabiiPAvzl0D8xwBYluMnoigRr8bhcRi7BuXwdR5aKSGDYsoQ3
        KVZ/zAGw+5luU16QLY4bHfn8Z
X-Received: by 2002:ac8:74c:: with SMTP id k12mr27355002qth.185.1582214557401;
        Thu, 20 Feb 2020 08:02:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbR/o5dZzJVwqozB6pVsi0h53nUmmL1eNtnvEIEnyfDfc3KEByAnUqiFKZnf2XeJuMIgqoAg==
X-Received: by 2002:ac8:74c:: with SMTP id k12mr27354978qth.185.1582214557140;
        Thu, 20 Feb 2020 08:02:37 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id v10sm2032884qtj.26.2020.02.20.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:02:36 -0800 (PST)
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
Subject: [PATCH RESEND v6 10/16] userfaultfd: Don't retake mmap_sem to emulate NOPAGE
Date:   Thu, 20 Feb 2020 11:02:34 -0500
Message-Id: <20200220160234.9646-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the risk path in handle_userfault() then we will be
sure that the callers of handle_mm_fault() will know that the VMAs
might have changed.  Meanwhile with previous patch we don't lose
responsiveness as well since the core mm code now can handle the
nonfatal userspace signals even if we return VM_FAULT_RETRY.

Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 37df7c9eedb1..888272621f38 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -524,30 +524,6 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	__set_current_state(TASK_RUNNING);
 
-	if (return_to_userland) {
-		if (signal_pending(current) &&
-		    !fatal_signal_pending(current)) {
-			/*
-			 * If we got a SIGSTOP or SIGCONT and this is
-			 * a normal userland page fault, just let
-			 * userland return so the signal will be
-			 * handled and gdb debugging works.  The page
-			 * fault code immediately after we return from
-			 * this function is going to release the
-			 * mmap_sem and it's not depending on it
-			 * (unlike gup would if we were not to return
-			 * VM_FAULT_RETRY).
-			 *
-			 * If a fatal signal is pending we still take
-			 * the streamlined VM_FAULT_RETRY failure path
-			 * and there's no need to retake the mmap_sem
-			 * in such case.
-			 */
-			down_read(&mm->mmap_sem);
-			ret = VM_FAULT_NOPAGE;
-		}
-	}
-
 	/*
 	 * Here we race with the list_del; list_add in
 	 * userfaultfd_ctx_read(), however because we don't ever run
-- 
2.24.1

