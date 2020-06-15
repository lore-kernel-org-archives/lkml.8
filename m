Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD907C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F0820739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxB9mp2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgFOWRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:17:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24317 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbgFOWQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nTgxHzg3sUm7azIu/IGyb2/pAj1EtKc4utkvCx/xjo=;
        b=IxB9mp2Np4m1TFoJEFWencVCXJs59jBw1JkdtAbT8ITtyg/eJUekqQ2ru6yNpTuQAAgL8v
        5XbZqSFxCh4ttVZAGK+/ZuaRW+e0GLx4ae80Rm0qNaxBJ8vmhovW3bSFcTVE/e7ZGjbiLv
        hUpMohs2V4UmEJZlgAc+FEyjlRj7UkI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-yuTXEYOQPcOYxxdaXHLnZA-1; Mon, 15 Jun 2020 18:16:28 -0400
X-MC-Unique: yuTXEYOQPcOYxxdaXHLnZA-1
Received: by mail-qt1-f199.google.com with SMTP id n37so15146283qtf.18
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nTgxHzg3sUm7azIu/IGyb2/pAj1EtKc4utkvCx/xjo=;
        b=tIGoZ0nSNynR6fnGHaF36cJexB1Vmd7hwACDI798xZkvUkJRj8+lGI0u4M8OkpsbAr
         BILmyAG8BFC37JUFjAPDqO33YQZO6VRfqSClE6hOd557WJXJHuCfAqgpNWF3ZPEUKlQR
         OzrGygadWZdbNjendM8WrqIgM6y+risRxnABG9uU9yUa0CqwMSyux38Jr7jp7kQyj3XG
         lhsvieOKW5ZhPfC3uvf+rcuFqXgWWnxj+GvOHPjzPA+7h1J8UJQV7L0WLK13AFmKhOj0
         MMrUFfhz2/7n5+adoyV2KIBBP+YT96lE/WNpw9j3b9kGyhdTndIotQgiIhmpiUUIX5GX
         852Q==
X-Gm-Message-State: AOAM5316qwxfn3hUAobK4Uek6BvqNmd955H3SeYpPzE6bMwpz9ErflxX
        M9pThefQABG6jffyJ1tq9NiIPcckmlOjIXnbq8/y5Bxbfv95mWncchUMelWSAvtMWNPmdAwO4tY
        gkiqyNGrs0qTS4NdhKu5yz7Et
X-Received: by 2002:ac8:7c8e:: with SMTP id y14mr18606165qtv.112.1592259387374;
        Mon, 15 Jun 2020 15:16:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaZOEBtd/scoU4DOdAOopbdMF0V2JY6TKjzvEn2SFwwxD8thna1PZbGyLvOB4sG9vd+sh+ZQ==
X-Received: by 2002:ac8:7c8e:: with SMTP id y14mr18606143qtv.112.1592259387156;
        Mon, 15 Jun 2020 15:16:27 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:26 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 10/25] mm/m68k: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:52 -0400
Message-Id: <20200615221607.7764-11-peterx@redhat.com>
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
CONFIG_PERF_EVENTS defined.  Do the accounting without mmap_sem.

CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linux-m68k@lists.linux-m68k.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/m68k/mm/fault.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 3bfb5c8ac3c7..6c6d6d77a1be 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -70,7 +70,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct * vma;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	pr_debug("do page fault:\nregs->sr=%#x, regs->pc=%#lx, address=%#lx, %ld, %p\n",
@@ -136,6 +136,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 */
 
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 	pr_debug("handle_mm_fault returns %x\n", fault);
 
 	if (fault_signal_pending(fault, regs))
@@ -151,16 +152,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		BUG();
 	}
 
-	/*
-	 * Major/minor page fault accounting is only done on the
-	 * initial attempt. If we go through a retry, it is extremely
-	 * likely that the page will be found in page cache at that point.
-	 */
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
@@ -175,6 +167,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	up_read(&mm->mmap_sem);
+	mm_fault_accounting(current, regs, address, major);
 	return 0;
 
 /*
-- 
2.26.2

