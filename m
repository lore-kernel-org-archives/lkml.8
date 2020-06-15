Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB25C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6E52100A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dm0lQgSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgFOWRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:17:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41750 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726556AbgFOWQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h74RJN7UDBQOUJjRh7O1oAW1FMKjRAJ0Jb9rKyi/N44=;
        b=dm0lQgSFJTOveOi4NTwfaCqIaqUSQfZNQzMxw3mq7KnKa2Cr64Slui7RTGIUkK4r7tEXqG
        lZIqi3XJxTA+3ZnxY22Ni8DCZw4pRTSSex5u+/s52LKGK4J8b9dMhIyRQJryFXAK1THp2/
        uYpzWUNoq1LvV3lzxgqn9DHPkx2hi/Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-ccVynl2-N4uaQkK4BzVSCA-1; Mon, 15 Jun 2020 18:16:26 -0400
X-MC-Unique: ccVynl2-N4uaQkK4BzVSCA-1
Received: by mail-qt1-f198.google.com with SMTP id t24so15171606qtj.15
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h74RJN7UDBQOUJjRh7O1oAW1FMKjRAJ0Jb9rKyi/N44=;
        b=Ah9ZcRjJY2KbnjRe9YmMuYqvc7ich7ttm3NoKPhgVCWOCqnAvDU3gXiP5n4wDqsw+O
         P+251B5bHha4RZY/zIeFr0Gs4Lxynsf6vk0XuIOoyNELzSWve4y8DK43PpWp3EtIEYJ7
         mtIYhOboBKKj8qgvraM113ccTnlsJX24hotqXa33Z/k9Pam+Re9UcxxwneP+Zp42pBUO
         Ppr2GmG0OpoTtLV2ZhSANiRHdK3rc1nidV64ETtODxP/38dcdRlzDxKHWp7hlwuxKg7o
         q2D6dQ6WIiYNPAj4Q5ZVsqf6OXWWptz2fVLnOMTatG35ShLICWckBRREWz4Sh2tTHnvi
         ZTTw==
X-Gm-Message-State: AOAM530WvgUTOjqvAO0UcU1bNmAIT2v/fBKrqbo9cstTm2e3g/5N7930
        8aEgP5zOmL58g10R/iSUhfUFl123WDC7Vfi5oz3lmeo0D6H2KiKVa0lnII6JcBQ2LgoZgmkT6fA
        XL+9h6hMshNeWZHftzSOPyXSY
X-Received: by 2002:ac8:4742:: with SMTP id k2mr18392752qtp.304.1592259385577;
        Mon, 15 Jun 2020 15:16:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOjS+jsdBuTUAPJy9u5matyM4fxEFGFtpaEFFyzlXjLC7diZVNDckMW6sOXtLiBCkpzKC9sA==
X-Received: by 2002:ac8:4742:: with SMTP id k2mr18392723qtp.304.1592259385315;
        Mon, 15 Jun 2020 15:16:25 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:24 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH 09/25] mm/ia64: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:51 -0400
Message-Id: <20200615221607.7764-10-peterx@redhat.com>
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
CONFIG_PERF_EVENTS defined.  Do the accouting without mmap_sem.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/ia64/mm/fault.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 30d0c1fca99e..1b7c1a537865 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -64,7 +64,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	struct vm_area_struct *vma, *prev_vma;
 	struct mm_struct *mm = current->mm;
 	unsigned long mask;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	mask = ((((isr >> IA64_ISR_X_BIT) & 1UL) << VM_EXEC_BIT)
@@ -140,6 +140,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	 * fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -162,10 +163,6 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
@@ -179,6 +176,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	}
 
 	up_read(&mm->mmap_sem);
+	mm_fault_accounting(current, regs, address, major);
 	return;
 
   check_expansion:
-- 
2.26.2

