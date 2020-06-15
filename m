Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD434C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5B220739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKkrtoN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgFOWRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:17:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41398 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726557AbgFOWQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29rQjHHfMz5TTodTKxetqtsoGSdJNiNA7+d/ohNymv4=;
        b=eKkrtoN4Zj2wzsYIIAk4bLMurq0Dw/AuduZLBcZHhZzuU73EUnYE9kkk4pj7Ix35dZ03dc
        qW90A991GXRarX4p+gaw+Nq6xD6kW7l/TtdtFHbMX0LHaFPUkQJKARief4Adpv21gxPjkb
        ktpt1G0ZfJP/zA5Vm8EMgrQKjEDisB0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-mjJlVfqzOlaXaGQ6QhFTnw-1; Mon, 15 Jun 2020 18:16:30 -0400
X-MC-Unique: mjJlVfqzOlaXaGQ6QhFTnw-1
Received: by mail-qk1-f197.google.com with SMTP id t18so15365639qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29rQjHHfMz5TTodTKxetqtsoGSdJNiNA7+d/ohNymv4=;
        b=OmuGrj5rTGf8Ecc2VxhtBT4zc/ajImvAAGQ5h65/PAe1jff8KpkjwzDNbi1VvVKqjG
         dB673TUrwkx22tWf9SV+WnyKeG+T21kjvE/L7ppZziGU0iVIbhT9rp9xee9wemXIgLn2
         xHBmqZyMkCVlKhwepkvecF9rvSVYa9x1fkXfsJwUqvBL0VXlONjb8tp+SGb/sms0eQsl
         wX0u9jywC7eX0ZSpXdxYnhIJutD2qzvhwP3mPTG1T8FFZw1S4J32h35GCHIojR47mYJh
         32zHxv7TJvwuJU5HJYX6snQGZ7pk03zknZrNwxk2DHrk1Qsq+qJ5+WpzjjtUWXryPNI7
         xoVQ==
X-Gm-Message-State: AOAM532W8bq8EPZRUF6i7mBQCiYpDygPK5Vf/seSKVkfo1rGt70O1u2T
        PZTsgEkh953PWqHO5q9IOEBckFH1/330uKM7BTK+s8XE8unABr9lfhnBOzoKekSvosyNg45sePQ
        Bw3epEmCLvMt3L3jiO3iwOKn1
X-Received: by 2002:ad4:4851:: with SMTP id t17mr27470147qvy.160.1592259389072;
        Mon, 15 Jun 2020 15:16:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxX1MqaPv7JHSCx9w4Ao2KOIVPGXfmmyP4DtsWYycMl8Wjz5YM0+uul3halOZlyfdhk/5f6mw==
X-Received: by 2002:ad4:4851:: with SMTP id t17mr27470128qvy.160.1592259388816;
        Mon, 15 Jun 2020 15:16:28 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:28 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH 11/25] mm/microblaze: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:53 -0400
Message-Id: <20200615221607.7764-12-peterx@redhat.com>
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

CC: Michal Simek <monstr@monstr.eu>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/microblaze/mm/fault.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 3248141f8ed5..db0f3b71c3fe 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -90,7 +90,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	struct mm_struct *mm = current->mm;
 	int code = SEGV_MAPERR;
 	int is_write = error_code & ESR_S;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	regs->ear = address;
@@ -216,6 +216,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -231,10 +232,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (unlikely(fault & VM_FAULT_MAJOR))
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
@@ -249,6 +246,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	up_read(&mm->mmap_sem);
+	mm_fault_accounting(current, regs, address, major);
 
 	/*
 	 * keep track of tlb+htab misses that are good addrs but
-- 
2.26.2

