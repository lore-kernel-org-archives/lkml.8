Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2564FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC1F620FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+F/iBJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgFZWcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:32:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31097 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbgFZWbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lYOPBG0iFD9F9VjgENlAdm0PiHZqNHDJn1sXF2V/+vk=;
        b=d+F/iBJuZqoXV/ProgAHjvABCqDRSWsoTJvEhW+ORcx56BPTpp/Ph+lFHccid6sDjdJfnu
        L36Ii5f4Vfp/fe4p8oghQYJq4yMnON2r2m6gtSva/St9Zr7q2wqQHS7Ly7RsIMSlwPbP2R
        uwrl3cB+hF6bTLbZOYYqSSahUFQX/oA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-6bHg1Xj1MtKlast6Xl0qWg-1; Fri, 26 Jun 2020 18:31:47 -0400
X-MC-Unique: 6bHg1Xj1MtKlast6Xl0qWg-1
Received: by mail-qv1-f71.google.com with SMTP id g13so7386095qvp.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lYOPBG0iFD9F9VjgENlAdm0PiHZqNHDJn1sXF2V/+vk=;
        b=WgGH7VZE4iH3dy+dz/uqiI9hzmnuydYvAZFZswx+7c9ru4b/gm2viq2wgXozbwrVGt
         jNkEZzphp3j6Gl/mMgArO3Qa+YBhnGLwM7EmCOoJf87PwBAusK0OkoSdjxc+3R7uHMM4
         O2tfPkf4vtvIpynMCAPkPWlboJI82Wcq3JOqV+y/hSB1iNm7HySyvboe9C2Q/jbdA6GK
         yg0bJletnytsA/WOaLrOzdsAtZdRFD4/Qv4ADbH0IsE0kvRE4QGYVK/XhG6EFJzzAGI8
         WEgvvSl4XUgRkwLGphlCTOcVU4YlwDyxPuscWiTDvsP2ICWz6gnxNlhOtZyxuq6su+c+
         aq3A==
X-Gm-Message-State: AOAM5329k0L4kCP7HEaCsbNfEWcbtToWAF559m5Vtn5HdpxY2yOBQzgQ
        k8eh05XbTkl6FSK2Zcf/ucu3O51ESh6dxIQQL9HNU2vOplqWewP88bv9FlSDbAhVguicbU+UFcn
        BylbgKhcL5I+DGmCCSfvLmqM5
X-Received: by 2002:ac8:34b1:: with SMTP id w46mr5148293qtb.175.1593210706889;
        Fri, 26 Jun 2020 15:31:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEsH9GTqG0Uyirbf2HfHCLkouB6MqgMm+luFGWqRBdr7XED0i0wltil1GoCMm1tUaTEq60hA==
X-Received: by 2002:ac8:34b1:: with SMTP id w46mr5148270qtb.175.1593210706647;
        Fri, 26 Jun 2020 15:31:46 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:46 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 09/26] mm/m68k: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:31:13 -0400
Message-Id: <20200626223130.199227-10-peterx@redhat.com>
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

Add the missing PERF_COUNT_SW_PAGE_FAULTS perf events too.  Note, the other two
perf events (PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]) were done in handle_mm_fault().

CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linux-m68k@lists.linux-m68k.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/m68k/mm/fault.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 2db38dfbc00c..983054d209bc 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 
 #include <asm/setup.h>
 #include <asm/traps.h>
@@ -85,6 +86,8 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	down_read(&mm->mmap_sem);
 
@@ -135,7 +138,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 	pr_debug("handle_mm_fault returns %x\n", fault);
 
 	if (fault_signal_pending(fault, regs))
@@ -151,16 +154,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
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
 
-- 
2.26.2

