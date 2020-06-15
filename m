Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDD5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951A820739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QImsPniw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgFOWQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:16:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39417 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726314AbgFOWQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNFwrYW4xLQEZWI+l4x2WwkQyryRByigJTo5AhzriWE=;
        b=QImsPniwGueddbc8YJXam9nS0uiwOTVMQ8lXnaFJ2FAk0npymgx9YCUM2qpMpKoikCHkgT
        yW7YsZgixusuMChSVEBwqWL8HQWRU6wASUKjS9mqoECrIxfj0qIyvz0KgFy3gR5998LEx1
        uR0TNlzAckE7nGgsrltmCBPHm0F8kNg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-G6XtsGnCMYOajpdrnYAAUA-1; Mon, 15 Jun 2020 18:16:13 -0400
X-MC-Unique: G6XtsGnCMYOajpdrnYAAUA-1
Received: by mail-qv1-f72.google.com with SMTP id r4so14080737qvh.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNFwrYW4xLQEZWI+l4x2WwkQyryRByigJTo5AhzriWE=;
        b=P0aBf5vQxKBadteD1WM4xUfXiT1w5cDpZZ5kI4xAKmt2s0Jht8wDGPsnbMx6qCPRUp
         yCmyKuSMYcz57/jZJPN/mSO1qX3hk5vqhwsqOGFKpkeNy0Uyc783yA5PwnS2bcA4/aC6
         lPXUVvfaZpLbnOjv/xOLOhAmtmRNA0hL+VNtAi1DAb285IaxXSir2RZOqdxlZifcyANr
         5/dsahr5bpNmWV7kD8oaRPYuNyxYQJofDpy+FhXnLFV4cHgmuhAfMKm6j/x7wO9b+Iz3
         xLavHEQ3y8/UdDBe6O0Dn82HoqBoGTrywzstUekxF5BZLfHbZG9MZcKb3KL7GwjD+iAp
         8Kag==
X-Gm-Message-State: AOAM533ysfCjZJG+Q1yYNZgPZZJbhkwRQDxDQK2ly44+GXfF/Ah05EaI
        BIPovLoa+3/EBy36yPdVYMBqLb0tqs8lpKB3SEp5VJyxyn40kcvbpLSXlyEGd8jCVk8sXX40vTs
        iVav4OwByT2L8+3IFjff9mi5w
X-Received: by 2002:ae9:dd02:: with SMTP id r2mr16438462qkf.179.1592259373035;
        Mon, 15 Jun 2020 15:16:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzByfKbHtfsqsB0mNSAna/23FngWrg/1qtQvHfSeQD/RQ6aXVpUU6Dja+Gbr4iYyBfEzDgr7g==
X-Received: by 2002:ae9:dd02:: with SMTP id r2mr16438446qkf.179.1592259372834;
        Mon, 15 Jun 2020 15:16:12 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:12 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH 02/25] mm: Introduce mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:44 -0400
Message-Id: <20200615221607.7764-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide this helper for doing memory page fault accounting across archs.  It
can be defined unconditionally because perf_sw_event() is always defined, and
perf_sw_event() will be a no-op if !CONFIG_PERF_EVENTS.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f3fe7371855c..b96db64125be 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1649,6 +1649,8 @@ void truncate_pagecache_range(struct inode *inode, loff_t offset, loff_t end);
 int truncate_inode_page(struct address_space *mapping, struct page *page);
 int generic_error_remove_page(struct address_space *mapping, struct page *page);
 int invalidate_inode_page(struct page *page);
+void mm_fault_accounting(struct task_struct *task, struct pt_regs *regs,
+			 unsigned long address, bool major);
 
 #ifdef CONFIG_MMU
 extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
diff --git a/mm/memory.c b/mm/memory.c
index f703fe8c8346..c4f8319f0ed8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -71,6 +71,8 @@
 #include <linux/dax.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/perf_event.h>
+#include <linux/ptrace.h>
 
 #include <trace/events/kmem.h>
 
@@ -4397,6 +4399,22 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL_GPL(handle_mm_fault);
 
+void mm_fault_accounting(struct task_struct *task, struct pt_regs *regs,
+			 unsigned long address, bool major)
+{
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+	if (major) {
+		task->maj_flt++;
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
+			      regs, address);
+	} else {
+		task->min_flt++;
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
+			      regs, address);
+	}
+}
+EXPORT_SYMBOL_GPL(mm_fault_accounting);
+
 #ifndef __PAGETABLE_P4D_FOLDED
 /*
  * Allocate p4d page table.
-- 
2.26.2

