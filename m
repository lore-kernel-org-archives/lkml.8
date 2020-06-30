Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C9DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4EE2077D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5ltbR96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgF3UqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:46:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50391 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbgF3UqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nRL7j1WwZNqVLuKE8r33la3T5z/V/hLFvWs36l0m98c=;
        b=e5ltbR964Sgw6f1CmZBHWIx9cv5ff+Up9WQnfVxASv22V231o5cOo/gaqtCXJSE8Tm+5MQ
        FJQowzGlVPBwj7KCoFCcfutohV8+vDMbCpiZcIlmtFz0t9RrGJ7VFvbG8EIzMxZwyjsRUK
        bshufPe9YVkZCusl2IdUVLLDKjyWZrI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-j_-v3lPcOrCERMPP0tfX1A-1; Tue, 30 Jun 2020 16:46:04 -0400
X-MC-Unique: j_-v3lPcOrCERMPP0tfX1A-1
Received: by mail-qv1-f70.google.com with SMTP id r19so14511369qvz.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nRL7j1WwZNqVLuKE8r33la3T5z/V/hLFvWs36l0m98c=;
        b=fh12lXPN03oEMaGPXihr/he7SFXsR40Qhtm9BB1pwitXQ/LhTjl4LXSRcPXVHB51T+
         ZWV4qQg6qFpM1NFQWpBR0xF5Ubqv+oNT5A7btwu9bAkg3WEYh5j44gpPFBuhLwSx/gaK
         kX5iiQnYc5+QkHTEZXFeNPaJkPeDBzt9x6rD0DxYxVUrnN/soEMjZQqPNhrG288gyfj9
         1IsxesebFd3AFoLpJH2HJpeGr3RgbRxfg77ef45iq0lfpb1+eCJ9SOwE3o1ETmxTrM5X
         /sewXSQeSEm8C4T4pKI2/aEkeh6ePxxNI06X2b8oKDNb8UUsFbiJ3Cl6KBPFKZn27Lxz
         /pJg==
X-Gm-Message-State: AOAM531WBZYkIStmeMXKeQJz9TCcUrhPHIEIl7S5DSeGs7WWJmaOOlGW
        FA8AcyO2HAeelF02THRvBGIBhM1utZ8/VW8zy26fc3x17liz6sHJ7HkVvAPjdvAeqeqYDUiw8qO
        oGUbyV/ZHUgMvzkXiYhTWufbU
X-Received: by 2002:a05:620a:635:: with SMTP id 21mr22244592qkv.491.1593549961986;
        Tue, 30 Jun 2020 13:46:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlUPsr/W+WeZFM6KWdqEHBVB5RxdLgehVJ6NhUZN7D0mYiZYTZhpM7moIljz6u9XaYXW1fJQ==
X-Received: by 2002:a05:620a:635:: with SMTP id 21mr22244374qkv.491.1593549958835;
        Tue, 30 Jun 2020 13:45:58 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f18sm4467263qtc.28.2020.06.30.13.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:58 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: [PATCH v4 21/26] mm/sparc64: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:56 -0400
Message-Id: <20200630204556.39491-1-peterx@redhat.com>
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

CC: David S. Miller <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
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

