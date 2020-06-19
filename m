Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BE3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFEB22168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyhSPCHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394412AbgFSQN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:13:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39858 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394396AbgFSQNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHOoOMvKCdAD0ZPNXEYJ7zwb9/Vhd5GoKeFrCVrHadg=;
        b=CyhSPCHVt54UtnD/QX/a2wH3eCSwijFSoQodKQPrPn9SwhEZZF7L1mgUX4ftMQi6Ib1ppV
        e+qHpBZuj3gAQWvzIX5TeJirOgG1A/rJLjj3MBO6MdJAfXw7ufLjCv8DMOB9Qb0PR/ToOY
        2tiXvpS+t7e0bzfpIZilWdNCeudK+Q4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-js1oea8UPd6f8vmG9DKwng-1; Fri, 19 Jun 2020 12:13:51 -0400
X-MC-Unique: js1oea8UPd6f8vmG9DKwng-1
Received: by mail-qt1-f197.google.com with SMTP id l1so7474161qtv.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hHOoOMvKCdAD0ZPNXEYJ7zwb9/Vhd5GoKeFrCVrHadg=;
        b=Z6XMp+JcoK7kkCpGsaWKpCFthRKZ3df8e9cgJz3tVnon2R7q6CdQ4KoxVqc3S1S3xo
         UanryYJ6PLfBVrQPthTBsmAyTbNeVInEhsRVgBs15mye3J7oiK0Q4pvYeqBc1gD3wJzm
         Z5cEIEtusNRc8qTSXy54hDWt0lOI5nvhplIcZ8zXaDOKEuy7F15TQZoMin6BIWoMMN+j
         QNl9egU2Sj60Bnz7XhZO5/JfTEuiTc4sAa+u0N/mJn7dCAfPULBfyStWYfZPtFxuHAUq
         GxtqvLvuTTndQwAn5JgNv/yIcMP8j5A6VAyeemWe5xSpEXV7Q5P+8UrrYLNut9HvJRAH
         Kx/Q==
X-Gm-Message-State: AOAM530ydXz4sz7tf4mWsp7ztByzh971aNkO7u0TkuIjHpZEe1eQ3vHs
        e+YPtci9wJLksT2+B85CckfLD2/qN98cfFCVwXppw3m0TCPyWfsVnVSwz86IwTCudjkT+L5bQLp
        fvg54u+ZJmxqTeZL8qJwHbmJN
X-Received: by 2002:a37:9cb:: with SMTP id 194mr4168766qkj.456.1592583230422;
        Fri, 19 Jun 2020 09:13:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlsFSGYwLSHrNQCrtseIMJR1uot4X4VtcHhU1f6HFiKSJmKiiV4hUEBJBylfQ6YO+vR6eJOw==
X-Received: by 2002:a37:9cb:: with SMTP id 194mr4168749qkj.456.1592583230187;
        Fri, 19 Jun 2020 09:13:50 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id v184sm1283720qki.12.2020.06.19.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:13:49 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: [PATCH 21/26] mm/sparc64: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:13:48 -0400
Message-Id: <20200619161348.9811-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619160538.8641-1-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
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

