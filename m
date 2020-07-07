Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD1EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D68520720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcrQ4Z+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgGGWue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:50:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729147AbgGGWub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zINhPgn0dLU827u0kCMWiXWqm1EOoX2bkCYV8BQtz4=;
        b=LcrQ4Z+uJIfH9VCDMtz9bTeplV61PoTx4n+LHZSvLg5tRFLgLyvDzjh9pJ9OUzshe+wEMV
        dDijhBkrxgdaw29MxBErm5iQ8JaG5ptYwfDryLYb8FkNLcfX/xcDyZdKlHiuCGLusitUBl
        zjAJ6VGnm0nRL3uwDfVmV9MY8wFTmZg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-id0o3hLWN5qmdC5_UYMgOw-1; Tue, 07 Jul 2020 18:50:28 -0400
X-MC-Unique: id0o3hLWN5qmdC5_UYMgOw-1
Received: by mail-qv1-f71.google.com with SMTP id ee9so25649109qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9zINhPgn0dLU827u0kCMWiXWqm1EOoX2bkCYV8BQtz4=;
        b=iek38ybpb/GJRdGRfAxzesNPGkTQLKg+z77cb6guuBjDPCddK4A91xt8orMHWJqB3d
         SGq3skX9V9dbuFwLn3Gh3nb0MPg4vT7VlBcXmX2bfO3+tBE4jOx/4JfEXxGLLLewBZki
         31xstJlgFfQmfxiyaKlCIzL5EQk0I4ditGMPL0seNbrnSXItCPE20HM8hMdjE/rZ+sR8
         4VFbF7S48pXZimv50Fxz6AUblUsPWUtsh0FXH+Syq0M8koAX7hsvxKpesyUx9K7gN9hT
         a1OpVjo5U/ruiXEHOEKQAerFcJa2Gru2yT5lL7CT8/j/vF0V06esqkm5pworXnarZlBj
         vlwA==
X-Gm-Message-State: AOAM530nVfAx5j663NRkZffv2LAMJN4HtTwz8eQT1KNhb672xPVzg6vI
        7ROVo2/42/Z7VaXCj4h3isnpiEJg4xUhlofrJHyINkYGXtyyjn2+08vJX86f/OCZM364BrMQfm+
        99ezVEbEIXWUuUDUihUpurdrR
X-Received: by 2002:ac8:7b57:: with SMTP id m23mr36398736qtu.379.1594162227887;
        Tue, 07 Jul 2020 15:50:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjtNA8lnpn1m/KE5+eQlmjotnypaLOF4WLVE5X368ySfVMh096MOzRrWMEJA23JXXqHHd3XA==
X-Received: by 2002:ac8:7b57:: with SMTP id m23mr36398711qtu.379.1594162227647;
        Tue, 07 Jul 2020 15:50:27 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:27 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH v5 02/25] mm/alpha: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:49:58 -0400
Message-Id: <20200707225021.200906-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707225021.200906-1-peterx@redhat.com>
References: <20200707225021.200906-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().

Add the missing PERF_COUNT_SW_PAGE_FAULTS perf events too.  Note, the other two
perf events (PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]) were done in handle_mm_fault().

CC: Richard Henderson <rth@twiddle.net>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Matt Turner <mattst88@gmail.com>
CC: linux-alpha@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/alpha/mm/fault.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 1983e43a5e2f..09172f017efc 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/extable.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 
 extern void die_if_kernel(char *,struct pt_regs *,long, unsigned long *);
 
@@ -116,6 +117,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 #endif
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	mmap_read_lock(mm);
 	vma = find_vma(mm, address);
@@ -148,7 +150,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	/* If for any reason at all we couldn't handle the fault,
 	   make sure we exit gracefully rather than endlessly redo
 	   the fault.  */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -164,10 +166,6 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

