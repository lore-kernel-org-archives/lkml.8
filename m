Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C056C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393C620FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOzZOnHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgFZWcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:32:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35563 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726096AbgFZWbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYKuiXa6JqSlFakb02F9N/z/khfKW7nv0ZKU3o10xCg=;
        b=VOzZOnHp2nPWjUd3Eo2pMB9Ik1hmsYbd2QkM815w8cOjmVAzZXg6k3mrRvfpp9djiiLsNM
        Vcv+ZKq1DIiL7G7b09JKE5YpFl28ZRcc0A+M097oqIpEkQJ12Z10lCTDlm1+jOS1jQTTpo
        tp8GYYAZjos7UAgD/7qLxj4Hwn9gu6U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-iYlsP3pVMSqUtvHmzHEGbg-1; Fri, 26 Jun 2020 18:31:44 -0400
X-MC-Unique: iYlsP3pVMSqUtvHmzHEGbg-1
Received: by mail-qk1-f200.google.com with SMTP id j79so7687747qke.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYKuiXa6JqSlFakb02F9N/z/khfKW7nv0ZKU3o10xCg=;
        b=VGNIpXM+KbST9ELRhq8FvUcbcKF0Y5Izb30s0uYgM1ChjiLx+I1W6fi91VuOcMxN9t
         VpeAXoVCXLbuuJbEKQxI3hJylBFMN/ir5Y01/UD9Uh0f1CaaaIQvaRQIgH6xTEL11vJp
         6uaP0YvmHgr0ExHCyFhyP7AbILl0ogB7Z67RZ4NAdsBbW3fTV5V5xf3SnYBACIXkrMEI
         qilIDjxAA7LkHW96Px/5dz5ed7goG9oeSuIXEdQCD5htc/N8wJmK9QCIoj6tdlTo6U9m
         cUaVJtIe2YaHfEXBY3BGJSsYmIFGylNSQrMzFKEbdkLmaF22C7uvyxNlTxqHBReLoA6a
         rSnw==
X-Gm-Message-State: AOAM532N4JyW97y0eBYWHADK7IQWsvFVwSpCwRn2hSHvA+JvrbPCTIX3
        a+FtNo7o5s4B0yD7gdarsG/rzWI/2ayB9u8tcw9bPPgnLROq1wd4gTfOvlRJQls2zRFUwQLvb+I
        T8U0rkX2BvX3Itg03HSkNkuEF
X-Received: by 2002:ac8:27bd:: with SMTP id w58mr5311358qtw.348.1593210701798;
        Fri, 26 Jun 2020 15:31:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSMdcnN8S0Vm53+A1zYZUxGb86xhlZEgD0Ug2gSVVAidxyTpcuF0guaWkh6epy+fd5/SNVlw==
X-Received: by 2002:ac8:27bd:: with SMTP id w58mr5311342qtw.348.1593210701587;
        Fri, 26 Jun 2020 15:31:41 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:40 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH 06/26] mm/csky: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:31:10 -0400
Message-Id: <20200626223130.199227-7-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/csky/mm/fault.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index b14f97d3cb15..a3e0aa3ebb79 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -151,7 +151,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0,
-				NULL);
+				regs);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -161,16 +161,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 			goto bad_area;
 		BUG();
 	}
-	if (fault & VM_FAULT_MAJOR) {
-		tsk->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
-			      address);
-	} else {
-		tsk->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
-			      address);
-	}
-
 	up_read(&mm->mmap_sem);
 	return;
 
-- 
2.26.2

