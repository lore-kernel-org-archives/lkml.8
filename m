Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A623BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8207320772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AryvP7vH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgF3UpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:45:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40512 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730025AbgF3UpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9zINhPgn0dLU827u0kCMWiXWqm1EOoX2bkCYV8BQtz4=;
        b=AryvP7vHoLSZVgmMUhbFtJJFmn7jmJq319KWAiUcqzYb7pMG1dyJChcO2R2FRBGRcgX23S
        GblMgows6rjjFEemdKJe/rwgxaOftgH4l4WLDIYictAuRE0PiCiyrXCgKgi4Yf6kxQShAq
        xYn5xTQCMfZ+GLD4r107T1SOoXwWDaA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-gHsTL13TMkSuNS4JZ_23mA-1; Tue, 30 Jun 2020 16:45:12 -0400
X-MC-Unique: gHsTL13TMkSuNS4JZ_23mA-1
Received: by mail-qt1-f199.google.com with SMTP id c22so15313604qtp.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9zINhPgn0dLU827u0kCMWiXWqm1EOoX2bkCYV8BQtz4=;
        b=h0/Gfm0il4xJg03wHuWtYrH1lDXIapdNR3xSKTReKaocMbUdFrgQ0QfLIR7wBVmyCC
         pWQV1W5AERnIHWi9b17fLq9K0DNwkyyMZc4CB6E+8L9O06yhHCMYYImLYdYX4+YKH3OR
         60EagxvHH48OmEoSxIviKg6bmbduUYwxiRhrd+bOyf4LJux1JYoLXs09cczDofCUA281
         Mvd0EBfnNYQuT32g1tHLZp9Jp9Q7OI7rPtqUf2nRy7EBm7fGlWs09z7e5ACbu1PmGAs6
         M35LhFa3OZyXpaZKfkFjnhtpxOeUZOGYqWES7Q3kLovwvh2wA0j5sbAJ2/dg4Pg0ZRmS
         3Brg==
X-Gm-Message-State: AOAM533lcFd/0y3nHobCEMoyFlT8G0hDlvXkuVf7JJ2AVJ6MExr/SbO+
        bKOx1dnnU4gTk79XiwV2/FD5FVnX5C+kZ1utkbz0MNvhAEkWHZ3JrlcNtX8qedMo79bmFI2/GDu
        e9LAMmNvk4Z2w7+e9lL0B/MWQ
X-Received: by 2002:ac8:100b:: with SMTP id z11mr23499522qti.157.1593549911381;
        Tue, 30 Jun 2020 13:45:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0yAgQnRD/5TZveHkpZPXLU358GLo0DpfJwL9wdYY6bw9cMFV6GaGklDvsflsay5ajX+3TFA==
X-Received: by 2002:ac8:100b:: with SMTP id z11mr23499328qti.157.1593549908970;
        Tue, 30 Jun 2020 13:45:08 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id o145sm3987048qke.2.2020.06.30.13.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:08 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH v4 02/26] mm/alpha: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:06 -0400
Message-Id: <20200630204506.38567-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
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

