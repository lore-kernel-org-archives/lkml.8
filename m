Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B114FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72EC820B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CraDAXTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgFZWg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:36:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39721 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbgFZWgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEacpwhabx4oqP5P1sDsSQYEJDVmYeAmQf6kbwzkxic=;
        b=CraDAXTseT6JIbfqvGu2kxok264u2Vs8iotTnsGt8lvyqUWtCRHWA7HiZc9ERy7yKhvHIb
        ftKGA9IHpq7xNb35/r4CnUd7F3SskOYvmkv3rRHFHKVYa+ykTRbOWPiIg9gsKkYfAwdtJS
        UHUdfMqJpCZ7OPcL30yqA/7sxq6SZXU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-PO7r-DB8POqWPPOc2MnHsg-1; Fri, 26 Jun 2020 18:36:20 -0400
X-MC-Unique: PO7r-DB8POqWPPOc2MnHsg-1
Received: by mail-qt1-f200.google.com with SMTP id y5so7513201qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEacpwhabx4oqP5P1sDsSQYEJDVmYeAmQf6kbwzkxic=;
        b=etjoj6XCHw41wtYs3HIm3NMC20h6NhgZXX6k+2Ri/oRu5Hm+trYp/pSDvT5k5p9es3
         tn2RHjE24ttbtWlf4UGENsvBtu76a+P05ufD9nO7eT9UlFNtwWv53/TNCpJKc7tmDQqH
         lEAbX1i2J6g7kVVi2vuiE6rQPxBxyVBgyliMWc7LtVODaEcfdAEdpwMYFMP4qZyo0PTo
         FOHmqbUbzotZ6cv5RMIeEd3iXdP76pxYmvRhdIBc5qLU7/FQU0UAy4+LUs1SebKWDOz5
         V4+iPoryvM/6QuIchx8MfEiraoQtqZ7jKSb034cUxkpXR8XCXsKZIzdjqTCNBTDspXRh
         Opgg==
X-Gm-Message-State: AOAM5338i1Wv94VR+pdycIyjePNKZNJISmRdJxvIwc8EDBChqR8SIetU
        EViVjuV61zK4tobcakgOSDTdWX23YpuyIg2/xtDZE/RgHw91OQLg6xQVmjcB71p++YGHKFjjyIe
        pUQERewYNMb0K77hx+0yQdnuv
X-Received: by 2002:a0c:da04:: with SMTP id x4mr5373446qvj.71.1593210979793;
        Fri, 26 Jun 2020 15:36:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBZJGvl8YZD3UD74l3WAMRy83bIKViLR3O57/9pXVwl73+z2DH1H0MK6MkNpbyIvHsKU6sUg==
X-Received: by 2002:a0c:da04:: with SMTP id x4mr5373440qvj.71.1593210979588;
        Fri, 26 Jun 2020 15:36:19 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id x26sm9633604qtr.4.2020.06.26.15.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:18 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH 14/26] mm/openrisc: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:36:17 -0400
Message-Id: <20200626223617.199669-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

Add the missing PERF_COUNT_SW_PAGE_FAULTS perf events too.  Note, the other two
perf events (PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]) were done in handle_mm_fault().

CC: Jonas Bonn <jonas@southpole.se>
CC: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
CC: Stafford Horne <shorne@gmail.com>
CC: openrisc@lists.librecores.org
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/openrisc/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 45aedc572361..5255d73ce180 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/extable.h>
 #include <linux/sched/signal.h>
+#include <linux/perf_event.h>
 
 #include <linux/uaccess.h>
 #include <asm/siginfo.h>
@@ -103,6 +104,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (in_interrupt() || !mm)
 		goto no_context;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
 retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
@@ -159,7 +162,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -176,10 +179,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
 		/*RGD modeled on Cris */
-		if (fault & VM_FAULT_MAJOR)
-			tsk->maj_flt++;
-		else
-			tsk->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

