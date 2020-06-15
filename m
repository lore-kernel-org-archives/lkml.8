Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29551C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0038B207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7ENQZe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgFOWXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:23:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26921 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726589AbgFOWXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFdmGMxgVY9SCrIC7JRov+UEIMXRQlq//9kYQVhiH/M=;
        b=e7ENQZe/nCMzz+YliuRem6FYXFPE990t7ltErPrPZpsxj8jBjtEY4J7KGJpO0HiO/Uqjcx
        a5Qp4b1ViXh16UrsBCK0G3Psz/FkCSzy3QyZwXsZu5X3mvXCDqtkMGDXIEZwUolaLvmSMt
        jbKhMesRI1bUqiPP7C5YnfNXPxau8iQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-L9kuBOrRMfOB9l5dA9-bZQ-1; Mon, 15 Jun 2020 18:23:30 -0400
X-MC-Unique: L9kuBOrRMfOB9l5dA9-bZQ-1
Received: by mail-qv1-f70.google.com with SMTP id f18so14096891qvr.22
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFdmGMxgVY9SCrIC7JRov+UEIMXRQlq//9kYQVhiH/M=;
        b=OZzVtBneVUwGEFmMlU0wL6R6Q+GdMCGM7JVnkf6XDJpvj57s9HmMSRVriUoefIkfWC
         W8jLes9MaEb/IBuhN3aU6b4aDgg+Xa8FkOy5hJq5MjJCGSIod1N9QMp/TeB2hSj3Tvih
         tNbTC1l3oWJ2WBA7mIetOPhvyS4JZTTgt3h43QQC/+VqovW1N6ocaBApi40u0PHO8vhW
         VrY+uSPdDDvMgkl4Gsh/fla8H7sX0lRWNYlV8RQrDcZbzUtmHL21kLYNXTTV2/zlT7hb
         JCa/AsiZzMIRPyNwgV5rRERQjROUIS/+cbIX572ye4ilayW1W//0/vIsjZWHSQEtNByX
         lCFw==
X-Gm-Message-State: AOAM5321OZFJooNh4g9WN1iQ2eFfCA1CTJPtzeGpqJnDsIneGvT9EDm2
        9J8lLxcTWQP/4eISMuqRav6ceuLSJVuKZXmwWKbBJVubvaozluuTHYGLI/WbDbTHu56DQiL7PgT
        7aeg9UqKFgc9H/3QydeU9wATj
X-Received: by 2002:ac8:6b85:: with SMTP id z5mr18085318qts.191.1592259809921;
        Mon, 15 Jun 2020 15:23:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCHSpItvnT+zujJi8Dw2Mt/hCs0Eyj0uPUFU6ftwD79VcDBySWQ3kGNSQx9oX0uN74D1xjYw==
X-Received: by 2002:ac8:6b85:: with SMTP id z5mr18085295qts.191.1592259809716;
        Mon, 15 Jun 2020 15:23:29 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id r14sm12370742qke.62.2020.06.15.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:23:29 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 25/25] mm/xtensa: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:23:28 -0400
Message-Id: <20200615222328.8745-1-peterx@redhat.com>
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

CC: Chris Zankel <chris@zankel.net>
CC: Max Filippov <jcmvbkbc@gmail.com>
CC: linux-xtensa@linux-xtensa.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/xtensa/mm/fault.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index e7172bd53ced..511a2c5f9857 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -42,7 +42,7 @@ void do_page_fault(struct pt_regs *regs)
 	int code;
 
 	int is_write, is_exec;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	code = SEGV_MAPERR;
@@ -109,6 +109,7 @@ void do_page_fault(struct pt_regs *regs)
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -123,10 +124,6 @@ void do_page_fault(struct pt_regs *regs)
 		BUG();
 	}
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
@@ -140,12 +137,7 @@ void do_page_fault(struct pt_regs *regs)
 	}
 
 	up_read(&mm->mmap_sem);
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-	if (flags & VM_FAULT_MAJOR)
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
-	else
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
-
+	mm_fault_accounting(current, regs, address, major);
 	return;
 
 	/* Something tried to access memory that isn't in our memory map..
-- 
2.26.2

