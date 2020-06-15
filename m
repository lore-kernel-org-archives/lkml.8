Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6B0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B35D20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLUlysi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgFOWQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:16:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24563 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726614AbgFOWQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RqJKKw8a1NKRln+8zArdPqt59N0jqlX/yu/HW/s9kC4=;
        b=RLUlysi/KLIyFM757BgJM53Q5bDKA8+90Yvf13v87FqQTRF0g0URn8h5J1usqIGUdjMVLz
        kCQ2zhk7k3hl9CmDyrkqMoXj6LlwwenkpFMpQVY+LL1RjvWwzPO6vQ8plqW9WZzztH0Bx5
        Qzivv+P+ilF13TCINXMWyEDJom6RPPw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-fB5hmzITPTiN6_JNcxjuSw-1; Mon, 15 Jun 2020 18:16:38 -0400
X-MC-Unique: fB5hmzITPTiN6_JNcxjuSw-1
Received: by mail-qv1-f69.google.com with SMTP id t20so14068489qvy.16
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqJKKw8a1NKRln+8zArdPqt59N0jqlX/yu/HW/s9kC4=;
        b=DIKySVuAih00xH6ZBII8XowkiOCfB1Z5KyRza15Sg267N9gk/N6hpi8dutpVsf9T4K
         VSQg760Ls8q9ZYwPJHGwN+SXbQKadmemR8jZy6jQ0Rkj8aqgYviupVoT5O+OgPbRVb/v
         ImVkirBp70fOwWsf0bAm5WRiCC6o6TU0zSqsmKOus+zFw3APPkTgJVUxY3/yhtgRMesJ
         TBzGroXyTp1oWAsuyFrYOg7DHdXEBcZ0Lt9iPdCHPLEqoKxZ1wEtq4q2jQN3n9mwqJrP
         2xHEejW/imTgWebWuXcMSklAadHOZzWCOGhj/GvcuJzqKcvFsVIOhu6Btp16n/6WnOqa
         qfAg==
X-Gm-Message-State: AOAM531oNzyANVo4zh3bSRCI7G1O9q9ixS4p3Jm1EfQVCCOiNmucMzAp
        jolD4hsZgpIkwLMkVW6T2IBqrrVlAVgEkXXCQcpEqByCoH6mzD8P4g/RoQjCMfIsRMMI9BrXyMG
        crkYoRLfoM7RI1MfzIBF5a9B7
X-Received: by 2002:ac8:2b98:: with SMTP id m24mr18160589qtm.7.1592259397576;
        Mon, 15 Jun 2020 15:16:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym0dTv1jCtl4PPadaK3FtEqrEEdDfUimjvunbZFPifhmsxPtnWv/2yi5DBIOU+dU1tzU/YzA==
X-Received: by 2002:ac8:2b98:: with SMTP id m24mr18160561qtm.7.1592259397379;
        Mon, 15 Jun 2020 15:16:37 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:36 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH 16/25] mm/parisc: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:58 -0400
Message-Id: <20200615221607.7764-17-peterx@redhat.com>
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
Also, the perf events for page faults will be accounted too when the config has
CONFIG_PERF_EVENTS defined.

CC: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
CC: Helge Deller <deller@gmx.de>
CC: linux-parisc@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/parisc/mm/fault.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 86e8c848f3d7..eab1ee8d18c6 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -263,7 +263,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	unsigned long acc_type;
-	vm_fault_t fault = 0;
+	vm_fault_t fault = 0, major = 0;
 	unsigned int flags;
 
 	if (faulthandler_disabled())
@@ -303,6 +303,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	 */
 
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -323,10 +324,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 		BUG();
 	}
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			/*
 			 * No need to up_read(&mm->mmap_sem) as we would
@@ -338,6 +335,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 		}
 	}
 	up_read(&mm->mmap_sem);
+	mm_fault_accounting(current, regs, address, major);
 	return;
 
 check_expansion:
-- 
2.26.2

