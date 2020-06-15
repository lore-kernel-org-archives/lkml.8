Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13E7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82BFA207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiuL+G5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgFOWXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:23:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43335 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbgFOWXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWAHEvELG7PCXiHldR7PdlXbQKIkg3HJngutFs9FQdI=;
        b=LiuL+G5PRpvHXqyEnZHBShVsSfHxZ+C9ExOAtt8DgJHK8bvimxEns1tnodOjCPpaOqy3Vl
        Dp70aIH5RubYG4QntPYpLY50Slek689rXzw91zvmAEitjrvmyxsTrVsyhS/0e9BCOt0XX/
        JwAhsBvc2kCiuV9LsmlQxhQXMn6HSc8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-gWqiYIhtO6O2UTi8_SSFUg-1; Mon, 15 Jun 2020 18:23:09 -0400
X-MC-Unique: gWqiYIhtO6O2UTi8_SSFUg-1
Received: by mail-qv1-f72.google.com with SMTP id t20so14080448qvy.16
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWAHEvELG7PCXiHldR7PdlXbQKIkg3HJngutFs9FQdI=;
        b=Kxa6ge80l3dJb78vrkAtlQREjJySZTTig8ZXleUYnxsqzDbmAGJeQIo11/W1Ryg6WV
         RynMQVoIolmmf0IPwnFc42871M+hv+VRn5wcxpBfmlZ8mMbTemaTGDJgaLtgwGwcMva+
         FtsBtaE+i3wJt0eFADiD58CchgxR2uvDvJ0jlwgBfnBEQ8UYV+Q9vQTO8YkapEG9RYkb
         ewJWBljS979SLKaXdimF3mS6RBgW5JLteMBWX3pLypAWNY/9bJVWjW+DxKNrRjih67RG
         P9bGNqxrWxcE8qKqa4r1wuNIFCw0f74hU6rJRILq4esaI923xKMWluHmMC7FSyoh9LA+
         ozlQ==
X-Gm-Message-State: AOAM533KDyya3wDlSZ8ASO8XrCsYCzi7OKvw+gMW49FI+Ja6Jql4Ze5w
        mojvhCL/wRumopCvZmd9axh7QlvWiWnbret/A+b4J3xC6JtNB8stE1/6bsX9vOthrTdOcq+Wvyf
        sfoaNLLHFZ/5Yt7lwlAtIoUk1
X-Received: by 2002:a0c:f84c:: with SMTP id g12mr26695599qvo.31.1592259788750;
        Mon, 15 Jun 2020 15:23:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyBZmVWyEmv0sPI1YBaFXr2Se+d7tyy64EI3sFlERYrvc/tp+2ai4tWd5V/XX5SRT29OLZxQ==
X-Received: by 2002:a0c:f84c:: with SMTP id g12mr26695582qvo.31.1592259788510;
        Mon, 15 Jun 2020 15:23:08 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id q38sm14019321qtb.74.2020.06.15.15.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:23:07 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH 20/25] mm/sh: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:23:06 -0400
Message-Id: <20200615222306.8502-1-peterx@redhat.com>
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

Avoid doing page fault accounting multiple times if the page fault is retried.

CC: Yoshinori Sato <ysato@users.sourceforge.jp>
CC: Rich Felker <dalias@libc.org>
CC: linux-sh@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sh/mm/fault.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 5f23d7907597..06b232973488 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -379,7 +379,7 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	struct vm_area_struct * vma;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
@@ -412,8 +412,6 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	if ((regs->sr & SR_IMASK) != SR_IMASK)
 		local_irq_enable();
 
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-
 	/*
 	 * If we're in an interrupt, have no user context or are running
 	 * with pagefaults disabled then we must not take the fault:
@@ -465,21 +463,13 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (unlikely(fault & (VM_FAULT_RETRY | VM_FAULT_ERROR)))
 		if (mm_fault_error(regs, error_code, address, fault))
 			return;
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
@@ -493,4 +483,5 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	}
 
 	up_read(&mm->mmap_sem);
+	mm_fault_accounting(tsk, regs, address, major);
 }
-- 
2.26.2

