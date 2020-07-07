Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEEEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8584220771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHURBdyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgGGWur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:50:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59665 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729630AbgGGWup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DEmzww7H5zywGqZA9zT7LUnhxIyJ8MI0ZWzVs6Wigj0=;
        b=UHURBdyQ9bESfAP3XXMr3LZP4Ie9a56H8fsPOH6RgBRy4Lv6wdXUll933CUxmZoWGqKIsl
        MG4ajYfIhQwoIamLNkDeNu2U7q2FvFFCyekCDDDNxwCma6Pn66tK7uuz4IWkLqJXXPEv+v
        3no4XXvqPflNNzDiW2MbsFjmeU/Ps3k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-sTYjVG2mOW-vPq2-g64G6g-1; Tue, 07 Jul 2020 18:50:43 -0400
X-MC-Unique: sTYjVG2mOW-vPq2-g64G6g-1
Received: by mail-qt1-f199.google.com with SMTP id h24so16155661qtk.18
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DEmzww7H5zywGqZA9zT7LUnhxIyJ8MI0ZWzVs6Wigj0=;
        b=dR/vNr+EqmwJfcOUb3HHRKN1PX4KqTwpDb7l0JUGpQFMPzCbPia+TpzQftEo8Jn5cD
         hPVT5MCkUj12DCDoectyXVpn98auliRQ60XHxaiAjk2TB5iZzdDqamIW2ze6x2a82Zhl
         497EBN05VEQQbvm/mxlu/pTlRWRZhUpIRm55fyoG98tx10A6iBKa/Wh0W4pXdB4sqYLi
         WUr7Mf5tp9u9XlgfKtVAbEfinAL2eBqbJ3s/t1PzbAwLEV2EmSdzPcwCgUzGEC0IX4Z2
         YhFvK5EYTjO8isHem3fHOadC4oDN7xbebSi1FxknXT5rQ5xpL2GORhB7kp6zxASMw4ht
         7aKg==
X-Gm-Message-State: AOAM5339UmVbCiTkOZFw2a4ZqN6STknf93XaVnePL7ZJsrWBGt/oeuNv
        WPAcRUGhmWWTsOtDdUUKUQ5vuHmi9gjO8E/v4QJpd9aeXg4co9OslAU2xTrn0o5Tj9nM0dgAdZ6
        sW6nYb1dEIkcxIW2/2IXAwQaA
X-Received: by 2002:a05:620a:6c9:: with SMTP id 9mr52692043qky.271.1594162242431;
        Tue, 07 Jul 2020 15:50:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1qTJEBcfEtMVTs2oSUGxcvlRB7kFM/hzR/mKCkF4/EjMMmKG7vtyho7cDDf2sOJlHl1+CRg==
X-Received: by 2002:a05:620a:6c9:: with SMTP id 9mr52692017qky.271.1594162242180;
        Tue, 07 Jul 2020 15:50:42 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:41 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH v5 11/25] mm/mips: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:07 -0400
Message-Id: <20200707225021.200906-12-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707225021.200906-1-peterx@redhat.com>
References: <20200707225021.200906-1-peterx@redhat.com>
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

CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC: linux-mips@vger.kernel.org
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/mips/mm/fault.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index b1db39784db9..7c871b14e74a 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -96,6 +96,8 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	mmap_read_lock(mm);
 	vma = find_vma(mm, address);
@@ -152,12 +154,11 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
 
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -168,15 +169,6 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 		BUG();
 	}
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-						  regs, address);
-			tsk->maj_flt++;
-		} else {
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-						  regs, address);
-			tsk->min_flt++;
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

