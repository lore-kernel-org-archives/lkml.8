Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF6AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898BD207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyhjC2Z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgFOWQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:16:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49143 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726514AbgFOWQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slspSoLdiR900Rcpj54eQasJib7kVBgImwvKNWrvX4Y=;
        b=KyhjC2Z9g+NHXPshVXpZ4W2fmMnQuvc/DGP7Ea3h7zG/oPNZsr14XPRNd0X3qjVWzF9qQ0
        BYY8DtSBJ07EOk7LV3cNVhyvMqMPy9S+OksB97TSE7XBMSoaIWeh3sfCeF9vRrm7E2/if8
        XJR+Z/LG/a69oVALfHf4g7GMe1AhSSs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-h2-2FvhDMm2vQVKXa3jP4A-1; Mon, 15 Jun 2020 18:16:17 -0400
X-MC-Unique: h2-2FvhDMm2vQVKXa3jP4A-1
Received: by mail-qk1-f198.google.com with SMTP id g72so15360440qke.18
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slspSoLdiR900Rcpj54eQasJib7kVBgImwvKNWrvX4Y=;
        b=VfA0OEXlNfND2b75CUzIBHNsFL80/wXyFE9UP76itdPKeVRhFlC7HiRuR62R8RJS2w
         lI9n8ii9Iba0AZ6u051v2OapzszQaOcTQ4WkebB3Ne5YN0G4BHs3stZvOOTGGRHLIlfw
         ab205WlcV6TsSYmpCNdi/B2bCgdiArLoecwcmvIvpHQHg2K5tT+rIamezw6RX3BQwRq9
         mZwCEWdOEbmsV8TkprxJAQKml3E/u5aTXWhh7wuq7YEuL8mGfK7WX9MG3kyTu1YN7ial
         HlRbCzkBbjQPK7mOcwxVmIVGdG564Co2/R8HMYI21Os/T/xKtUvKoOFRlbqGG5LqQk4L
         We3A==
X-Gm-Message-State: AOAM530o9Tqi5RtTBLLSvqvHacFnrhEpYetRXy1VWlme9j+76REhyEIh
        92x+L1aBOct+cCZM2cqs6vAv12nqd7Ab/0k/1OUuwN3twZkhlHwS0EsMYZE4zBF0eIioLgxczS2
        O4gnTajt4lVqzTB6NnPD/vyns
X-Received: by 2002:a37:a309:: with SMTP id m9mr15509582qke.284.1592259376816;
        Mon, 15 Jun 2020 15:16:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+A/A772mmUrx3v5zJ9Ls6uRTYu52DgBbd6x8UepXb3ELKtULjF8DxCU4UWD4kQeUDJPTJ9w==
X-Received: by 2002:a37:a309:: with SMTP id m9mr15509556qke.284.1592259376517;
        Mon, 15 Jun 2020 15:16:16 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:15 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH 04/25] mm/arc: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:46 -0400
Message-Id: <20200615221607.7764-5-peterx@redhat.com>
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

The functional change here is that now we take the whole page fault as a major
fault as long as any of the retried page fault is a major fault.  Previously we
only considered the last fault.

CC: Vineet Gupta <vgupta@synopsys.com>
CC: linux-snps-arc@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arc/mm/fault.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 92b339c7adba..bc89d4b9c59d 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -72,6 +72,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	int sig, si_code = SEGV_MAPERR;
 	unsigned int write = 0, exec = 0, mask;
 	vm_fault_t fault = VM_FAULT_SIGSEGV;	/* handle_mm_fault() output */
+	vm_fault_t major = 0;
 	unsigned int flags;			/* handle_mm_fault() input */
 
 	/*
@@ -132,6 +133,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	}
 
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
@@ -156,20 +158,9 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	 * Major/minor page fault accounting
 	 * (in case of retry we only land here once)
 	 */
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-
 	if (likely(!(fault & VM_FAULT_ERROR))) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
-
 		/* Normal return path: fault Handled Gracefully */
+		mm_fault_accounting(tsk, regs, address, major);
 		return;
 	}
 
-- 
2.26.2

