Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA282C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8968F21707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLEZhxQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405586AbgFSQOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:14:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59066 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394387AbgFSQNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+T4PahBLwp+qMqIXI+a8sKJL/5YpPnDyt5GJ45wieOk=;
        b=ZLEZhxQjyhdyv2ydo0hQqKOJSBFOiE3UI++1ZNHnlv+0GZocK2lbSo8EikGb4ms7GD9dIW
        vO/jahuqQspheRue9u7hYUYW+Xqs3cr7Jjwqc7KJ2aXMN413fBlEnQz7QGGYxeYSxLXR3R
        eqTNgpvfpZvEE0YOgHfovXa6m8f8aFM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-4vX0biJMPI6U8HjMZAgInw-1; Fri, 19 Jun 2020 12:13:44 -0400
X-MC-Unique: 4vX0biJMPI6U8HjMZAgInw-1
Received: by mail-qt1-f200.google.com with SMTP id z26so1327099qto.15
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+T4PahBLwp+qMqIXI+a8sKJL/5YpPnDyt5GJ45wieOk=;
        b=o2cV7izhM3WcD/rW+w6tccHCBICsIh4WP8kBiFN5aaHhF3GAxhAYrNciJ79p4E3FyR
         S9KzhIb3HUdsFnbhps7tWWehGXxwzQH3wjyF8XUoHKOOeKyiJbJ8JIqHF4bpMVvjbNAi
         xh2w9Bzn6YVVxIDyHOgCq54fyowek9+YRvjn4pjO+mqz6sGWJvxifjqP/VVxljHSyYoa
         /nQOp/JLgXiqleBEbfKTThy1WdRHFrpbFuBDsLbGTjnbW6JWFY5zFdAw11fvBipwsbEr
         /Yz7RoXd+8HxNa4VPRAuux76QOVcXmppdnTsih6eEM7eBnHfbjZ2hTkQc4CFUikH0IHM
         d+qw==
X-Gm-Message-State: AOAM532SZMT+o/f+lo2nmW5ch9GcIaiWCBwkmsRd9LlQO9OLgG7JJvZW
        aUzhFCyQnmHIZsO2nWUQloU4IetUg4a1F06ahMpkAG3WVDIPqlM97ZRd5jKkpugdGossci3vGp7
        i08HHVQNHYO7Xi6VPAae+oHb2
X-Received: by 2002:a37:4ac6:: with SMTP id x189mr4077372qka.323.1592583223459;
        Fri, 19 Jun 2020 09:13:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6soZaP4dnoM13q0hEmGSoc9m+CP9QFqBJTTn4uB3sxC+M1N2RbKnkZrYMa4KMFGRLAMCg6A==
X-Received: by 2002:a37:4ac6:: with SMTP id x189mr4077348qka.323.1592583223233;
        Fri, 19 Jun 2020 09:13:43 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id k26sm7453496qtk.55.2020.06.19.09.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:13:42 -0700 (PDT)
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
Subject: [PATCH 20/26] mm/sparc32: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:13:41 -0400
Message-Id: <20200619161341.9762-1-peterx@redhat.com>
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
 arch/sparc/mm/fault_32.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 61524d284706..542bf034962f 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -235,7 +235,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -251,15 +251,6 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
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

