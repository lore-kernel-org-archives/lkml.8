Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891D1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6612E20C09
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQRSQ9uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgFZWgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:36:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27884 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbgFZWga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8WnWhn2O9ddpmgT5q7yGLFrwE17K5+WMrtUB+3cLWEw=;
        b=cQRSQ9uzfvZ50GPk9fHVJQL02EHHobJc9iJYimpUDngl15EEbQO5fvsCOsO+KeBKkVmcUy
        lIXAdOtY8v5utsLsz0KvW3Y1WDFIcKLWWw1oTNGIMSMUQi76AB4EmbBjR86UINSmND75sL
        XBENpRVI/CQ4/OsGnVt8Sx8XVS5bCXE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-S64NJxkDMQWxLEzfhIGuLA-1; Fri, 26 Jun 2020 18:36:28 -0400
X-MC-Unique: S64NJxkDMQWxLEzfhIGuLA-1
Received: by mail-qv1-f72.google.com with SMTP id da10so7406281qvb.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8WnWhn2O9ddpmgT5q7yGLFrwE17K5+WMrtUB+3cLWEw=;
        b=pqD+9WDyu9FtPR6Tkz2uhxV3IpDURrjh7sCYuKwBEULAGZ5ed6pxdIx17Mw71tU/91
         aWSBZCAE4cqR9H5iTQCStlNLWnbbVNZ2EKoEHLObjdtKOjgiLG1wvcUe40CAzbX0u6Hk
         ll5XXspS+wS1sdp67yBxAwV3zu+qLR9JAiRadSieE0dADhQU2jQh6w9knLZwjXZvHvHY
         UkcATlI9HwC5+K9hWutFwwvkukTE6vxE84dVk73hOTPSwaJOlrjjVVV5Gs0lBKx19+xg
         RV69w7P0tlbdbF8NpmP3WuBL5zqmwbzix6kjczhBCCnsaEb/1V0oHNBUqRzajP9zGxM8
         NlEA==
X-Gm-Message-State: AOAM532KfwRvdUEQdfGE8xCwOT8Ig62DsVjHmSB14MqJdAeRJ/aKTLoX
        ORfIGzAKtfmGkvBXW2G+lphjkbxKZOH81JibZljdyv5J7myZ/yyyti8T0kC7EeIH44ojTGZ429w
        6/b7SWJNDlQXCmUR+kJYNQ83f
X-Received: by 2002:a05:620a:994:: with SMTP id x20mr2758441qkx.367.1593210987669;
        Fri, 26 Jun 2020 15:36:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF7mXzjX2GYCldg8rpVKH+R/6CyjRUZNLT2pL9QW2hEVm9X8g93t+Jx2O/OTIhETTp/0bRvw==
X-Received: by 2002:a05:620a:994:: with SMTP id x20mr2758423qkx.367.1593210987471;
        Fri, 26 Jun 2020 15:36:27 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id t9sm9463853qke.68.2020.06.26.15.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:26 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 17/26] mm/riscv: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:36:25 -0400
Message-Id: <20200626223625.199813-1-peterx@redhat.com>
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

CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: linux-riscv@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/riscv/mm/fault.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 677ee1bb11ac..e796ba02b572 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -110,7 +110,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, addr, flags, NULL);
+	fault = handle_mm_fault(vma, addr, flags, regs);
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
@@ -128,21 +128,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		BUG();
 	}
 
-	/*
-	 * Major/minor page fault accounting is only done on the
-	 * initial attempt. If we go through a retry, it is extremely
-	 * likely that the page will be found in page cache at that point.
-	 */
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

