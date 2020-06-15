Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B69C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C47520739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5T69xCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgFOWRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:17:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58016 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726551AbgFOWQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKXlC2Ik8MurO5EQW9zZhxy63+C0QjUDgELZmh6OLDU=;
        b=K5T69xCLmOIVtLy3t0jibT5bKtaRF6fc/j85VklcBGRaPcrib1uJwAjnU4zDfKwe6VTgz2
        tZMzQpkVLAuN1Mtw6dgX8NWY2tR49fmUZweYV8y9NMSqkeUR3dGiPB4eACkO/e92B2hPM0
        cGz/+XfKWpemFJJUUmBIddH176Z4g14=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-A5K3sqIGMGWfVV2hfhWpAA-1; Mon, 15 Jun 2020 18:16:19 -0400
X-MC-Unique: A5K3sqIGMGWfVV2hfhWpAA-1
Received: by mail-qt1-f199.google.com with SMTP id x21so15141961qtp.16
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKXlC2Ik8MurO5EQW9zZhxy63+C0QjUDgELZmh6OLDU=;
        b=ljEib3IjsUxrjjloUf3W2t5A17hcJcCZcPqYRZpm5AiMraSE3kzza8nUPk7jqTuvnY
         2XIQYprQKqQlG/Ghl01BPJPsW+4uhTtDFIpoOGOfZjUshGecg0NEMQifSSxMCCuz1W68
         JtQ4SMwnxvdqYCawdoCLSwCxv2H+xbH9jswhFSWZbC5ehU5pRbVMn9Zo4z56xB6o8G+g
         piHZne1pT+OeVP3w9FkMp6HKkzcTY1vibzk6n14fVt8B9yzmISEsyU/3+9vEKCatORMJ
         GHW++jcAVqcC8AlwDvRVH6n7MVQKWkej3LcnGE12n/+WOKEvL6lzyg3tfEa5h15gusqz
         qBEw==
X-Gm-Message-State: AOAM531xLnD41dr0MdjmBNAXlvgQvK0n0v6bghiyzSm56Vd5LlFOVmJs
        q/XpIUTzY3BIsTar3DyBKUUi0fNFZ9tlQNM2ZJ2brYom7L9GLGTK97oX1k+mqqGhhwPPZtA9ClC
        L45t0+iXJ1OY/yiJXbcbxTMV7
X-Received: by 2002:a05:6214:17cb:: with SMTP id cu11mr26619257qvb.202.1592259378652;
        Mon, 15 Jun 2020 15:16:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYdEz/PXgGWV8lG2AkZeCE0DWjNT0NnU9fGbVJx/ytdFI4o+mld4AJShPV7+8taxw+Ukt3hQ==
X-Received: by 2002:a05:6214:17cb:: with SMTP id cu11mr26619231qvb.202.1592259378438;
        Mon, 15 Jun 2020 15:16:18 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:17 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/25] mm/arm: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:47 -0400
Message-Id: <20200615221607.7764-6-peterx@redhat.com>
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
Meanwhile, take the page fault as a major fault as long as any of the retried
page fault is a major fault.

CC: Russell King <linux@armlinux.org.uk>
CC: Will Deacon <will@kernel.org>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm/mm/fault.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2dd5c41cbb8d..92d4436e74da 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -240,7 +240,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	int sig, code;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	if (kprobe_page_fault(regs, fsr))
@@ -290,6 +290,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	}
 
 	fault = __do_page_fault(mm, addr, fsr, flags, tsk);
+	major |= fault & VM_FAULT_MAJOR;
 
 	/* If we need to retry but a fatal signal is pending, handle the
 	 * signal first. We do not need to release the mmap_sem because
@@ -301,23 +302,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		return 0;
 	}
 
-	/*
-	 * Major/minor page fault accounting is only done on the
-	 * initial attempt. If we go through a retry, it is extremely
-	 * likely that the page will be found in page cache at that point.
-	 */
-
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 	if (!(fault & VM_FAULT_ERROR) && flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-					regs, addr);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-					regs, addr);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 			goto retry;
@@ -326,6 +311,8 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	up_read(&mm->mmap_sem);
 
+	mm_fault_accounting(tsk, regs, addr, major);
+
 	/*
 	 * Handle the "normal" case first - VM_FAULT_MAJOR
 	 */
-- 
2.26.2

