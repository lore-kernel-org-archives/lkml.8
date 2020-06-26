Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B42C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7280B20FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPDl/wjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgFZWb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:31:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23056 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbgFZWbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JN+es+8H1l3agmqz1OlDugYxis3rubXdkuh1XRgK5Rw=;
        b=PPDl/wjks9Az84w2Bt3KmP++g3W7aTBXuBNnbM3ggUkD0E7eMFBteVMJz3wJ9VuK5lQRPf
        4++PvNbxHmZFHDnwZXL6BLCBN+TIoIsPVttBLQvv7rhiWdLTDMDtakUUhTb5WJtuf07qd/
        rRx0zVLuC3x4XuZGhWYIVSRHwQhbcfw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-yhTzxEI7PQOJCWdtsNbrUQ-1; Fri, 26 Jun 2020 18:31:52 -0400
X-MC-Unique: yhTzxEI7PQOJCWdtsNbrUQ-1
Received: by mail-qk1-f198.google.com with SMTP id i6so7640805qkn.22
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JN+es+8H1l3agmqz1OlDugYxis3rubXdkuh1XRgK5Rw=;
        b=quKpx+wx3Xll5H5oSo/id4Qf4qNIO/0dQf6Vtpunle8FbrbCJtfmh4OWcCRRMraPkz
         Dh3PYLxtQHA4siUizKqEYBF/6rZh/zGrJNho+TQxyASFfD0jpEZpMvPWt/g2dowaAJy1
         /cr8NBQdUQ3X985bAG8L6XvERiF3FJfCEkE2a+BKPZnuCuhUPxf1ZtJEFg9jtaQVSyYU
         XCtTjt/ntlxpdkvPxVLrFw+Fey4SwT5QTT74NF7oHcCTCH762mWTqtW0m2h+dyqzq2po
         ciT444/RZyiXnGPyIompfpA6JE5IeMzvXcqJsLJkb2Ufo0FB0FCvlvm6b/+e73IV2zUv
         8upA==
X-Gm-Message-State: AOAM5328FL/JwS65HhYoZbgrSL5BXsrcgHvDfio8ScYVMFB/2SkDgLm+
        jaH9W1yPGbk5FvLeBvoCGZtEcmBSSI9rkeIjLpodkJ475ewqUWTfG2ibOxZpKdxUB2IcCzigVC1
        I4kFvFcjZaeOE05MXBEcef5qD
X-Received: by 2002:ac8:674c:: with SMTP id n12mr1721359qtp.312.1593210711921;
        Fri, 26 Jun 2020 15:31:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcYijJTVlPSIFEtT8ShfjkY00t4KQvgkEFr4fOdkWNwDI2R4lPmULH0n33oNjlV6dOmHz7zw==
X-Received: by 2002:ac8:674c:: with SMTP id n12mr1721343qtp.312.1593210711649;
        Fri, 26 Jun 2020 15:31:51 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:51 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH 12/26] mm/nds32: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:31:16 -0400
Message-Id: <20200626223130.199227-13-peterx@redhat.com>
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

Fix PERF_COUNT_SW_PAGE_FAULTS perf event manually for page fault retries, by
moving it before taking mmap_sem.

CC: Nick Hu <nickhu@andestech.com>
CC: Greentime Hu <green.hu@gmail.com>
CC: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/nds32/mm/fault.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 22527129025c..e7344440623c 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -122,6 +122,8 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	if (unlikely(faulthandler_disabled() || !mm))
 		goto no_context;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
+
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -207,7 +209,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, addr, flags, NULL);
+	fault = handle_mm_fault(vma, addr, flags, regs);
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
@@ -229,22 +231,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
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
 
-- 
2.26.2

