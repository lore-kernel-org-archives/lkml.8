Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F389BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C444620B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fjk35Qof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgFZWbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:31:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31142 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgFZWbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SagB2x6xDXMHuNfH0nszNoiVH7/+fXWLgMfhv8WOo7E=;
        b=Fjk35QofIx1SjehB0vXC5bIw9wjV6nZtvKEosTSOAxSwtmXah6BsP5NRQHyKTXA5BqLOLg
        qcJh82Hm/PZvM/B0yp1w+dsh/QTY+9+odDSr63jOTSQFx7NSsEgaQAYAf+X1QFVLUlgsrz
        1MucACDUGpwYxPT9/gmwjs0VztHL5p8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-4pN4RQ0GNOSPSROHpMN5Yw-1; Fri, 26 Jun 2020 18:31:45 -0400
X-MC-Unique: 4pN4RQ0GNOSPSROHpMN5Yw-1
Received: by mail-qt1-f197.google.com with SMTP id k15so4922017qti.22
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SagB2x6xDXMHuNfH0nszNoiVH7/+fXWLgMfhv8WOo7E=;
        b=CYYonVslLSTRXrjPXxbb/kzHOo1+w5FrKpDN/h7m87inI2ZNCnUfET5jTotPVV7Lmg
         FWpfzSjAi75Hevp8Ms2Nst0yPFVAYv6ULa+Fk+IE2ft0wrU7AsmtK3lCOfBcEIuEunzH
         EjtQi1uyfwuFzYtAjCpCEVQ0CPGNS6ztMxsRGn1GCOLVLpVGVqMU1FudoEHPP6eRc+v0
         y7sSf4sIl/9vq8Sm34Y9XMX+aHbkhVi+KPU4U5pbfzZkotJ235w8ybSo54sZsgEedGUh
         XWlppvsJ/4EpjlW0LoTygKyamDgsqhzBtQboBswk17sblTykbvd98QAie3/EeRJKnpMW
         Gt3w==
X-Gm-Message-State: AOAM533dpnT24EVEkt06boPbUyAnzroxhErEONI6YUwzwzyFEgWvIaT8
        CKlDGNiBIN4jIz63Q0L530BTZY8CloH4Xr/2B+PUKrwe8d3FD8LqVZdHcQ0iIAPtHtwJjnJQHNj
        HT4v5lEt/Lt/M051IufV03Wg9
X-Received: by 2002:ac8:382b:: with SMTP id q40mr5158475qtb.11.1593210703554;
        Fri, 26 Jun 2020 15:31:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+3FP1V/Ad++bjiADIsOLnYLtWDzv+gtA2qG8ikbYulDNDze8olEwJ20DxbWqD1R+2IL+N9g==
X-Received: by 2002:ac8:382b:: with SMTP id q40mr5158456qtb.11.1593210703343;
        Fri, 26 Jun 2020 15:31:43 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org
Subject: [PATCH 07/26] mm/hexagon: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:31:11 -0400
Message-Id: <20200626223130.199227-8-peterx@redhat.com>
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

CC: Brian Cain <bcain@codeaurora.org>
CC: linux-hexagon@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/hexagon/mm/vm_fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index f04cd0a6d905..1b1802f30862 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -19,6 +19,7 @@
 #include <linux/signal.h>
 #include <linux/extable.h>
 #include <linux/hardirq.h>
+#include <linux/perf_event.h>
 
 /*
  * Decode of hardware exception sends us to one of several
@@ -54,6 +55,8 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
@@ -89,7 +92,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 		break;
 	}
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -97,10 +100,6 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	/* The most common case -- we are done. */
 	if (likely(!(fault & VM_FAULT_ERROR))) {
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			if (fault & VM_FAULT_MAJOR)
-				current->maj_flt++;
-			else
-				current->min_flt++;
 			if (fault & VM_FAULT_RETRY) {
 				flags |= FAULT_FLAG_TRIED;
 				goto retry;
-- 
2.26.2

