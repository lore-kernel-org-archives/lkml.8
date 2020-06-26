Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C08C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA7520C09
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jx1fABtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgFZWgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:36:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22672 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbgFZWgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHOoOMvKCdAD0ZPNXEYJ7zwb9/Vhd5GoKeFrCVrHadg=;
        b=Jx1fABtDUpXzqAgcRu5sxlyEU9/mw5tlFOeevU7166+A/SuhPZWFE0woR+BL5JEjTpOY1c
        UyRcvmyVuftUb14MXKSLP1Hyc1zogKH/bs0rN1yotNIjjnYeqXBwaZ/zWZnagWuX/h1a/L
        Wuqkgf92LFsQ6IgFrz6qk3go+GP9RwI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-jduNkqRwO86YeZ5welTGTg-1; Fri, 26 Jun 2020 18:36:38 -0400
X-MC-Unique: jduNkqRwO86YeZ5welTGTg-1
Received: by mail-qk1-f199.google.com with SMTP id t22so7708615qkg.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hHOoOMvKCdAD0ZPNXEYJ7zwb9/Vhd5GoKeFrCVrHadg=;
        b=qLOg2ARZtM/NIxna6i8pG5hS+CfAhKcy+hCP0A0w3OftlABdA9rpj9HU9wKmmsfK9g
         FEHm0Bi63l4h0PICQwYyV+s/HL45u713AE7H442U9wUz+pqFJ6HVW/uYG4Z2y5WgYNo5
         omsEJQdmf8/IJ4nZv9zGRCjt4+oG3LpTjozYQZlrA/LhObR9TgCRrm+5VjieJQFl7qG8
         cG5GVMS6rhMA4noM0oX+MauavHc7+ykccatTRuFFCT5wA9dPpchPWAOal4qw2Nwus+wR
         19wLmk1Dga12X6OtHOu6zMty4XDO9blSA0m4lBtc6R40UMDY+prpDFA26r+hyllLEK0F
         ZshA==
X-Gm-Message-State: AOAM532OmRT2iMDNU+hOXsPm1nNdR0lXoIgvC2TmxU577iVUBComekTt
        gyiZ0SIgTc5PAZJ336U42qSQNpuDMgny5NuCufBF4976h6zuM/J/pvAJb9by8n+egVJXh6X0rgb
        sycfJpeYJDTh+qVePg0MbXN4k
X-Received: by 2002:ad4:57c4:: with SMTP id y4mr5199980qvx.230.1593210997679;
        Fri, 26 Jun 2020 15:36:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/5lWOLerE4xAFoxX4WH4c6jdmotNqRUcy+IApq6fCmSyWwwC40kou+k60M+HXuwatmhRgOA==
X-Received: by 2002:ad4:57c4:: with SMTP id y4mr5199965qvx.230.1593210997481;
        Fri, 26 Jun 2020 15:36:37 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id c27sm9546702qka.23.2020.06.26.15.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:36 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: [PATCH 21/26] mm/sparc64: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:36:35 -0400
Message-Id: <20200626223635.200006-1-peterx@redhat.com>
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

CC: David S. Miller <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sparc/mm/fault_64.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 6b702a0a8155..fe8854d447ed 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -423,7 +423,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 			goto bad_area;
 	}
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		goto exit_exception;
@@ -439,15 +439,6 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
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

