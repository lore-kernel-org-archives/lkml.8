Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F586C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655432075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSUvcfv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgGGWvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:51:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21635 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729738AbgGGWvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPMcfxrEZ236mfezmh1VLu12AnYLZCZwUp1nicTiMR4=;
        b=HSUvcfv6T2cBFFhmD0yOPrN5UjvO/MgDCrpnCvGVM5mbNdQIXUT3KjPoGLjMm5g17HB7nw
        bhEK6hhhZ296hluNczHMjL5RnNxFC+O5VRJqvtehPNmmf6VKyVikpfR7BKvtAIoYGMmbIo
        lcVl5nIZ7rGk9O+JmRjO2mpEAf6hcxQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-SsiS5YcVNMWQEoxx1zEr3Q-1; Tue, 07 Jul 2020 18:50:59 -0400
X-MC-Unique: SsiS5YcVNMWQEoxx1zEr3Q-1
Received: by mail-qk1-f197.google.com with SMTP id z2so14072228qkb.17
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPMcfxrEZ236mfezmh1VLu12AnYLZCZwUp1nicTiMR4=;
        b=eIgl8j1NZ5Xx2G/3SlRsY3RixksQZXW3KMveD8N6GU/+mGwaTLD6+FZc9SQmsJNPIQ
         /Z889WFULCZx/n6a6QzX4JKIbV6Yi16sQ6+beMu6qiDIA9+P8Pr2fyrFtEvvVEHpQi9P
         Btmu/KF9CgwBylqg9QtpRaICeDWPJvpX5RoUqCKq/+3PcCy+nHBx2z1uM5XjqByVwsl6
         +KemCdDnh0SPsF6BDz9jY/kx6MAFkrdDnlMi5fm+Aq7Wb+P27fUvvY1CqtWJSpgxUvrg
         JH4BubUeChgNK4qtz4hpBY/iLDgRNBT8/pOxc9T2ZfcUobivtzH8emxgIITihHPJZq6h
         hnCg==
X-Gm-Message-State: AOAM531kBsCJOqlskIBP5PTlFMxiH8zrrCHZaREmB8BSKC+XdjwG+/7i
        CkkI4ulTOw0BwmESOyMgii/NYiz5u34+eFbhCeYSU8/RgDUNA+CXIS75abRV+gUGl9cesqpQKNu
        JsL/WSbU4RIYjReeUu2ctKJma
X-Received: by 2002:a05:620a:b1a:: with SMTP id t26mr55133336qkg.473.1594162258932;
        Tue, 07 Jul 2020 15:50:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2J0ngM7MXGA4Cel+DD1H81KUpKJX7/J++AxGaN1fxx6mcf6hQbpqhfEsYybz9zmsLxfBU8g==
X-Received: by 2002:a05:620a:b1a:: with SMTP id t26mr55133309qkg.473.1594162258730;
        Tue, 07 Jul 2020 15:50:58 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:58 -0700 (PDT)
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
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: [PATCH v5 21/25] mm/sparc64: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:17 -0400
Message-Id: <20200707225021.200906-22-peterx@redhat.com>
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

CC: David S. Miller <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sparc/mm/fault_64.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 9ebee14ee893..0a6bcc85fba7 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -422,7 +422,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 			goto bad_area;
 	}
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		goto exit_exception;
@@ -438,15 +438,6 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			current->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
-				      1, regs, address);
-		} else {
-			current->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
-				      1, regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

