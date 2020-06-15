Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BFBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B37A20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGzLdqI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgFOWRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:17:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37847 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726583AbgFOWQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDWjhdWziQChPCdE8p/meiUBb0nH7AmWdbFRAx8v9tM=;
        b=DGzLdqI9gmVq5x52dZRPCNpub8k2dx9WQLDynCx86qdJH8ObpksVBk7N+DgOAtcYV84YqJ
        7Qb5keBHRLVswT6dufWwIRXob6wpqqWT2YrF/s1xTIKilJypUTDC5zmZ5wuLAxiz2kuM1B
        ykh3b0r9h2CqRJ2gWuVOAzMD30AHOho=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-IlqbZ1aGPMijFWouvHfqow-1; Mon, 15 Jun 2020 18:16:33 -0400
X-MC-Unique: IlqbZ1aGPMijFWouvHfqow-1
Received: by mail-qk1-f197.google.com with SMTP id l184so15422884qkb.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDWjhdWziQChPCdE8p/meiUBb0nH7AmWdbFRAx8v9tM=;
        b=h8GR+wWiATDQebiuHsmammuCO8zrz2Xz2hvN1laVxoew9DMtXEmPZb/RX3AgErWA/b
         MvJM7S6FHymCXirZwjDXH9LQd/5g00Zkaeu8okfcPlqidceIAaoCZbMWwBvAQ4devQWZ
         RYY78U+q1LZp3+/3ihjxU7IKeky1xvCXkLakntYo0CigxooEjVcQHATg7YL84EWcJUBA
         y8LOrmyT1ha5hDq/MGntbipA1enMY2VoxzF6huwapuLYF/wv5Uqc1PWe8w6IauD9TVEe
         vQ2cUAA37n6WagPnk5uGegD9+7lRY7PyymeBRW9V2rgEXGrAus+ApvoL4lLeNQK+wH7m
         Wt0Q==
X-Gm-Message-State: AOAM532mjRHLF65Bp4JzqQIwnpN9j+ccLnrTqLtO/yMknqi9l0sgC9Gb
        dl10oN1/TNe/g+Wi2MGcMTzFU+APx15kEKR4htm3VdzLeycwG5GdohmN6BlReGfEeYc8eR+dOoT
        qlCBO1fPjzKR1vS0DLMRSu/lB
X-Received: by 2002:a05:620a:131b:: with SMTP id o27mr17190796qkj.239.1592259392674;
        Mon, 15 Jun 2020 15:16:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuxS6dZZ8g64vcB57pOOwBAPdQdn82RbHtFFseWRM6CLiBPa78iQx2G1Suy8CNtlwHN7HaBg==
X-Received: by 2002:a05:620a:131b:: with SMTP id o27mr17190782qkj.239.1592259392481;
        Mon, 15 Jun 2020 15:16:32 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:31 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH 13/25] mm/nds32: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:55 -0400
Message-Id: <20200615221607.7764-14-peterx@redhat.com>
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
Since at it, move the accounting after releasing mmap_sem.

CC: Nick Hu <nickhu@andestech.com>
CC: Greentime Hu <green.hu@gmail.com>
CC: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/nds32/mm/fault.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index f331e533edc2..11537c03ab1d 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -78,7 +78,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int si_code;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned int mask = VM_ACCESS_FLAGS;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
@@ -208,6 +208,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	 */
 
 	fault = handle_mm_fault(vma, addr, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
@@ -229,22 +230,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 			goto bad_area;
 	}
 
-	/*
-	 * Major/minor page fault accounting is only done on the initial
-	 * attempt. If we go through a retry, it is extremely likely that the
-	 * page will be found in page cache at that point.
-	 */
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
-				      1, regs, addr);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
-				      1, regs, addr);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
@@ -257,6 +243,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	}
 
 	up_read(&mm->mmap_sem);
+	mm_fault_accounting(tsk, regs, addr, major);
 	return;
 
 	/*
-- 
2.26.2

