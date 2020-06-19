Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC6BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398C121707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frKOBChS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405572AbgFSQNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:13:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40882 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391492AbgFSQM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEacpwhabx4oqP5P1sDsSQYEJDVmYeAmQf6kbwzkxic=;
        b=frKOBChSZDWBGKLQJ1TuBeb5kPREAwqVXmitxX63uiUURXTeo+nnDHlvek/pdS46tgOGnO
        /ujhgEx10ImwW+XXcGB6+uYiaca1amL8qD8kd/DmhhA7E9DNPZF6LUeXN8myN0XHmav7E+
        lT/c5g8bTQzXBbKrCrHaIq/Oys0N/ns=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-hHKGNuUzO3CeLDiLUrre2A-1; Fri, 19 Jun 2020 12:12:54 -0400
X-MC-Unique: hHKGNuUzO3CeLDiLUrre2A-1
Received: by mail-qk1-f199.google.com with SMTP id a6so7517633qka.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEacpwhabx4oqP5P1sDsSQYEJDVmYeAmQf6kbwzkxic=;
        b=G/dwcBfiU6neU0yE7tBrLyp1Dw25oSFuE6K3v5cHqu13vfh2yLmcu9YpXPEbxaQgQX
         fm3q8+POTJmCbK59bT1J4KdOgXNiKxQ4tFlAFxCKYy1FISJcDKRllkl1jqXd61zB9797
         HtqZ+ED/0fc1vvGgpxLNiM8dmEPHZgUpUxzcfskMD769rnKvNFzsm5X/6IurmDIVMdWG
         yRxzr5VLQoottm1xJ/dP5JJzTNC+XySiONh3VrcMgdzqSj9HFwQ2PG5TiKGs+sekdYiB
         RUywNRJ7Vb723095WW6EMHj/Bi312fd3/c8pWN+783VMQrKzznLj9QQXxa4daSa+JFEC
         23AA==
X-Gm-Message-State: AOAM530+Emmbqb81GR499l7qWmPSGkcb2f8vyIl/DncYIu06jtyyKUvK
        gmVXnwykX9tB6PpILqR1LMffx3E8CR3AIqnGGzCnJ3UoUF+CnCo3Rj89EJIc85Q/wPzMKcPrqOE
        AVnUKay0+GzbXPO2nwA3RH5Sm
X-Received: by 2002:a0c:ea4a:: with SMTP id u10mr9341636qvp.225.1592583173006;
        Fri, 19 Jun 2020 09:12:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/KbzvQf8GbrVk0E0Lv5jPmHcSh5JxBeheLHw2C8ZFelbbsjI3LhaiwkF4VxKMOl5dF8XE/g==
X-Received: by 2002:a0c:ea4a:: with SMTP id u10mr9341584qvp.225.1592583172386;
        Fri, 19 Jun 2020 09:12:52 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm499961qke.135.2020.06.19.09.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:12:51 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH 14/26] mm/openrisc: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:12:50 -0400
Message-Id: <20200619161250.9443-1-peterx@redhat.com>
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

