Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC25AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFCD207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsxScn4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgFOWX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:23:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45132 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726541AbgFOWX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b9bROlH2F8PfVi4T8WvjvG0pZzLEw9QLjZ1QLi35C9o=;
        b=EsxScn4Pe1mfQQYc/5GN/22UoP303CODcD61F+kK1SAD3aSnwXD8IO8hsOIwteCqqTW19a
        DRm6fNwYeeYv5WD7qaGaFeSWA+CcTKKJRi0+53f7M0k5Z6DSXwfGX+fuTCz+mmHbHpwWDc
        R8hTHacsuzwwRTC7a/9GxenevuLPArk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-ZPcD8ov5PB6jIKFHQfWy7A-1; Mon, 15 Jun 2020 18:23:24 -0400
X-MC-Unique: ZPcD8ov5PB6jIKFHQfWy7A-1
Received: by mail-qk1-f198.google.com with SMTP id 140so15354976qko.23
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9bROlH2F8PfVi4T8WvjvG0pZzLEw9QLjZ1QLi35C9o=;
        b=BtHjQOnf077qOEEA4/DYlqAeV4IOMiQoXra1lyL8KaVo9/4CeQ6VxFUFueyuVoN7Dp
         w9Yqo3uA3wAImc7EzmfOym5wle4Y6QyRi3W8oCg6AgVdkb1lb3wudXZw5aBrXWJua6Hk
         P8bB/ttqensPRsKIJ+1/dMIzMhnCQd5q2xlLlcOaEAbPeUU4oXnDqI5ZcCuSBM9wzasx
         zwFo1oKRFAovQOyZvZGDtnIadIoC+S5wkL07oFZ08EQ3y7c52+D67APlrMDMsLROm4yk
         WuhHGPRW98gdhiEno7W02pn1635ROHGun/TnsE6RJpf212UftVaEkJpNFL1IvNfvXkU+
         0FeA==
X-Gm-Message-State: AOAM5326aTGMbSbFQQTCVui1pRM+D+c/xy891bYOFLTsrJ3gtoDBveUW
        OGPAou4ElaLGAFUwcYVaZtOQEZqtx0Bunnjuc+j8BcpFiC6AvjG88nqXqQD3tbPvxgvR1k8Qf57
        jThhtfZHIUHDlv66w+milDBK9
X-Received: by 2002:a0c:ef47:: with SMTP id t7mr27416215qvs.1.1592259803771;
        Mon, 15 Jun 2020 15:23:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/iYFazPhmYPvsAn6LM+V6qyEOfAv6yCYLB0wuYYugcePCm50XqcfS3MFbM9nVdTGvZTGnjg==
X-Received: by 2002:a0c:ef47:: with SMTP id t7mr27416198qvs.1.1592259803528;
        Mon, 15 Jun 2020 15:23:23 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 4sm10816747qkn.84.2020.06.15.15.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:23:22 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH 23/25] mm/unicore32: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:23:21 -0400
Message-Id: <20200615222321.8649-1-peterx@redhat.com>
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

CC: Guan Xuetao <gxt@pku.edu.cn>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/unicore32/mm/fault.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 3022104aa613..240b38e81ed6 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -201,7 +201,7 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	int sig, code;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
@@ -245,6 +245,7 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	}
 
 	fault = __do_pf(mm, addr, fsr, flags, tsk);
+	major |= fault & VM_FAULT_MAJOR;
 
 	/* If we need to retry but a fatal signal is pending, handle the
 	 * signal first. We do not need to release the mmap_sem because
@@ -254,10 +255,6 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		return 0;
 
 	if (!(fault & VM_FAULT_ERROR) && (flags & FAULT_FLAG_ALLOW_RETRY)) {
-		if (fault & VM_FAULT_MAJOR)
-			tsk->maj_flt++;
-		else
-			tsk->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 			goto retry;
@@ -267,11 +264,13 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	up_read(&mm->mmap_sem);
 
 	/*
-	 * Handle the "normal" case first - VM_FAULT_MAJOR
+	 * Handle the "normal" case first
 	 */
-	if (likely(!(fault &
-	       (VM_FAULT_ERROR | VM_FAULT_BADMAP | VM_FAULT_BADACCESS))))
+	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP |
+			      VM_FAULT_BADACCESS)))) {
+		mm_fault_accounting(tsk, regs, addr, major);
 		return 0;
+	}
 
 	/*
 	 * If we are in kernel mode at this point, we
-- 
2.26.2

