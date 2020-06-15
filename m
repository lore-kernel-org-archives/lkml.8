Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A13C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 704C620739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wvd/mX45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgFOWRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:17:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39291 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgFOWQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PRPudttfpR19+A+wbv6ggjFdv06B9VcI4/AzH9oClaw=;
        b=Wvd/mX45PJJArLTdtyBO+DkH/besEMr2i8QkkCKwKZC44t3du5FVqXKUcVLXFfejIALP+0
        i+VprsV058lo9n8N/IaQzbI27yk1n5eWGzSMsSeq92S9xM2OApx6aZFU32qWD0uqfevrxR
        DLLpeufQ/1CsgW6oMC0FenB5H9XPwSU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-XAtM-Sc3OfidzYxQnHyX0g-1; Mon, 15 Jun 2020 18:16:24 -0400
X-MC-Unique: XAtM-Sc3OfidzYxQnHyX0g-1
Received: by mail-qt1-f197.google.com with SMTP id p9so15215630qtn.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRPudttfpR19+A+wbv6ggjFdv06B9VcI4/AzH9oClaw=;
        b=nwiO579pbnLKT1RxbZ/i2AlbUv0ZSZ2xQzF8CaAIXf2qRERXQunlcOL/SkWuBKK0K4
         QhSMV8mFgiGei/GEGKffXaqfJFrrINom04R9p+HAnsS/EZ3VIqkIRcqgOvWD8CyPuDn8
         LtBgqLo2H3ZOwL9WWx+NjZk6SdDY6Q6PLM7l9vcsWi1YorgTN7XiZ/oMXrkho/JMP2om
         gFS02/tzUwmGyOd4WvAqBRXYoOmUaXgRS1Fhb/LwOQS63gSuLrNDHo/+K3ZU7zpU5Zm+
         iuwCZ6gML54ZEsCJLdlNCs5g8mBI2K3IK7ahTzRWoW8nZCSA+mp7lKYmTUkY4owU0kg/
         3RcQ==
X-Gm-Message-State: AOAM533RDpmN//y/HqXO4/aeSxZfAoF1Qj13qR4niuF0pQLbv3+lDPc6
        2YKZtWqMdvx3+ByRS2GM9xdcf5A9NtTYk5KyXNQ4RaBXH0x3cIXoJUtHj+S4h7m2qnNLrVthqf4
        3aQ3zpMp+sxdpsEGDJzSUEqvg
X-Received: by 2002:a37:aa87:: with SMTP id t129mr17645644qke.197.1592259383816;
        Mon, 15 Jun 2020 15:16:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVn9dsXg/pspHC4rWZesPTS5jGhgSsBUQJJibM3Od7vDH/8Bw78Arhr5f7epMon+09gUzkdw==
X-Received: by 2002:a37:aa87:: with SMTP id t129mr17645627qke.197.1592259383603;
        Mon, 15 Jun 2020 15:16:23 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:22 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org
Subject: [PATCH 08/25] mm/hexagon: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:50 -0400
Message-Id: <20200615221607.7764-9-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new mm_fault_accounting() helper for page fault accounting.

The perf event accounting will be included too if possible.  Also, do the
accounting after releasing the mmap_sem.

CC: Brian Cain <bcain@codeaurora.org>
CC: linux-hexagon@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/hexagon/mm/vm_fault.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index 72334b26317a..5fbccfce6083 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -39,7 +39,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	struct mm_struct *mm = current->mm;
 	int si_signo;
 	int si_code = SEGV_MAPERR;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	const struct exception_table_entry *fixup;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
@@ -90,6 +90,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	}
 
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -97,17 +98,13 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	/* The most common case -- we are done. */
 	if (likely(!(fault & VM_FAULT_ERROR))) {
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			if (fault & VM_FAULT_MAJOR)
-				current->maj_flt++;
-			else
-				current->min_flt++;
 			if (fault & VM_FAULT_RETRY) {
 				flags |= FAULT_FLAG_TRIED;
 				goto retry;
 			}
 		}
-
 		up_read(&mm->mmap_sem);
+		mm_fault_accounting(current, regs, address, major);
 		return;
 	}
 
-- 
2.26.2

