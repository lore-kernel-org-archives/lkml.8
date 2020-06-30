Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1AFC433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796B42081A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erfTgZ0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgF3UqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:46:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44831 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730375AbgF3UqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xKTka6Ypb97PfFs9wakfoxiGbE9LtmEFf0rRmXaAIMo=;
        b=erfTgZ0iJYorOXc8khF2E4aqs6OuyOzJU6T8080PamhNWLnnBsUgMJCcTUGKUS/ENkcvhP
        FMlifzvUnKuoj+I8sWD3Z/LdmGvVsjM5/T7hZ1D/Qik6naPey/AZ3GwHXDkBuIvWDExzKk
        3vK5tvL/SpGCQRCOJNJP02WzBINUTjs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-N4BTsH2kNUOt1nZUftY9Uw-1; Tue, 30 Jun 2020 16:46:05 -0400
X-MC-Unique: N4BTsH2kNUOt1nZUftY9Uw-1
Received: by mail-qv1-f70.google.com with SMTP id b5so8588216qvi.19
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKTka6Ypb97PfFs9wakfoxiGbE9LtmEFf0rRmXaAIMo=;
        b=HYt29b06jgZceyFX7k2tTgWzszwjpUusuz5ww90VtfD1r+d3ImWIlBz3Ow1Gyb1ADA
         efMBMTqYQg8qZXp+2Qaw1dDv9pr1aZhWOjnuGwwz4n9+/nYAFA1ipV5ag6qFThxxyFDa
         uu0pcZOv1RSI+2oltGVIeJDtc/KO/9eVd0nDpwATCjcfZvlznb5SHW5cP6IMlPRN/l4q
         NIyMWg2+xPJZCeauI/0WbFzsSGNmbkCDEMqxEsgcBaFl0oDC7yKWl4S3yat4aEG8kG/5
         M8angMus2ukIGeH9zOJPDFUG02QvS4H9VynI7dY/1P8VllKTDPu5ti7H1NpNfBqa0ZKK
         EBhw==
X-Gm-Message-State: AOAM530qwADjLVLqENondBAEjEdpDy0t+jLzSYrvwXnFeaXI3Ih/halV
        MDUw3VN8BksYC6nBrvvGdnV+PUfZ2wGqFjAWrei+GPLOwItPmcOWh4/qX+lPl2CZEQT0OGy+6ep
        1xoWw3+G/qhpED45/NmXNsZU2
X-Received: by 2002:aed:2b04:: with SMTP id p4mr22839480qtd.158.1593549964732;
        Tue, 30 Jun 2020 13:46:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZVq5ZLv/tiefIstP8J/VIwICsvgCu20sWu/3kRcEuyQrKCd+/O7fDLZCFxom05nNc25pjGA==
X-Received: by 2002:aed:2b04:: with SMTP id p4mr22839427qtd.158.1593549964186;
        Tue, 30 Jun 2020 13:46:04 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id u58sm4071887qth.77.2020.06.30.13.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:46:03 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 23/26] mm/x86: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:46:01 -0400
Message-Id: <20200630204601.39591-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().

CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: x86@kernel.org
CC: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/fault.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fe3ca00eb121..9ac80bb87781 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1140,7 +1140,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	vm_fault_t fault, major = 0;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
@@ -1292,8 +1292,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * userland). The return to userland is identified whenever
 	 * FAULT_FLAG_USER|FAULT_FLAG_KILLABLE are both set in flags.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
-	major |= fault & VM_FAULT_MAJOR;
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
@@ -1320,18 +1319,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 	}
 
-	/*
-	 * Major/minor page fault accounting. If any of the events
-	 * returned VM_FAULT_MAJOR, we account it as a major fault.
-	 */
-	if (major) {
-		tsk->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
-	} else {
-		tsk->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
-	}
-
 	check_v8086_mode(regs, address, tsk);
 }
 NOKPROBE_SYMBOL(do_user_addr_fault);
-- 
2.26.2

