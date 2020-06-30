Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EC8C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF58420772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYvKyLAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgF3Upr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:45:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36235 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730209AbgF3Upj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/WN5suCL4vjaI1eJdzhaIBmykla0j2zqu4dhyFqEqPg=;
        b=gYvKyLAy9dwjdxKRxMWnFTFyz3O57KW4iPVSwYrq6dhx3Xk10PtNitnbuS620dIRZs/9BV
        WgOoJWjhH/Mgb1SLTZM53mvd7BkLITdEa2V3uVQOYirJDT0c96UmbeHvZzQgT6wVH7mDi7
        Jh3H22zcc3HxSVjmO3SNACwXSlKiwlU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-QmogM6A_P_u1PaEI8_YbXw-1; Tue, 30 Jun 2020 16:45:37 -0400
X-MC-Unique: QmogM6A_P_u1PaEI8_YbXw-1
Received: by mail-qk1-f200.google.com with SMTP id 16so15463421qka.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WN5suCL4vjaI1eJdzhaIBmykla0j2zqu4dhyFqEqPg=;
        b=mhSW28Z/J7jfK4NkBvue00Z/8U1leW9RGA3p4Ev0e4N0UK799L5TGPTAI9nZS7INpn
         B7pi4duh/AWruj5wweXe+3dmxQZHXpZPiPvkyREezRX47ZLIY+9iv5XScN7jabVpefC5
         aR/GT95IncVClN1eZ12xrwm42Tla+W8N1HtU4G0gQx/h4Wr7q6AaZ6sAKo02Q1RVj/Vg
         yjFZDLtElmTu/mnPXYVudRmmGYIvaX+LZtzxa/h0fQXlWikdZWNRTIkxprKjbdTzzALI
         X6s9dDpmRwErE0QLApq2awnOl/8USk6t6NAWwzhjiumczwgGD+u02XfZG30aOspHCp5G
         dpDg==
X-Gm-Message-State: AOAM532f9j2mlHqwtOgpaIAzk9Y6JMCYTWHW8lsFCViKLpH5A3YPyBOP
        x7vjG2Mowk0MTA6icI/HOBr+OdMFPQ2SEsnv/XBJ+a++9tXIjX/9EORkdPz7drDMnVjq7uSjevp
        FssZeKFvRxVjzqM0wbS6kbLhR
X-Received: by 2002:a37:9384:: with SMTP id v126mr21406133qkd.279.1593549935998;
        Tue, 30 Jun 2020 13:45:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyl0r385bL1CCQ43sCi04YewH2j6MjNKst8FXnzcKtfYGfPRrvD9MYri9EdNQZ89OEEZX5aig==
X-Received: by 2002:a37:9384:: with SMTP id v126mr21406084qkd.279.1593549935438;
        Tue, 30 Jun 2020 13:45:35 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id u6sm4405162qtk.9.2020.06.30.13.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH v4 12/26] mm/nds32: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:33 -0400
Message-Id: <20200630204533.39053-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
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
Acked-by: Greentime Hu <green.hu@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/nds32/mm/fault.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index d0ecc8fb5b23..f02524eb6d56 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -121,6 +121,8 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	if (unlikely(faulthandler_disabled() || !mm))
 		goto no_context;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
+
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -206,7 +208,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, addr, flags, NULL);
+	fault = handle_mm_fault(vma, addr, flags, regs);
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
@@ -228,22 +230,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
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

