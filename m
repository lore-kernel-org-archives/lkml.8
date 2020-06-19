Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D2AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9422168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emmP1d4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405573AbgFSQNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:13:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23919 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394396AbgFSQNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sy544NXeYcNhbxOT1ou9Gq9AWlj9fShUn5juJrQIV8c=;
        b=emmP1d4glvVLK0yWhQKf8tVZuNKcRSLE796ZU2zvrllH12Q3wXQtwkJVumeOXBWbuMBLTx
        Lc83AwHmimsVttNdiiY79Ymlk/CSZP6rJryPO9Kv29sm+s/jWZqKg+C88K3VIC3SIsKSfU
        02+bwse8sQMqQZ1znwBKQvwFDe248ew=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-T_hJnIWOOTqIXzPiml-IgQ-1; Fri, 19 Jun 2020 12:13:41 -0400
X-MC-Unique: T_hJnIWOOTqIXzPiml-IgQ-1
Received: by mail-qk1-f199.google.com with SMTP id t22so6834792qkg.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sy544NXeYcNhbxOT1ou9Gq9AWlj9fShUn5juJrQIV8c=;
        b=mQeyfjcPISU1M65MKBSv6W0I6opieF7p/ScrX2ubfnMfflR/Z/onyOj7ECXBTOBldC
         PT8tkphODqi23CTwlKWpgScdng+XLq/iBP5mF+pbfUuZyQ/+xDXf3TKebvvoAYXou2pB
         wnhnuPTkleUVXk4hN5nz2OjJdAEyGAc3mUaQVRlcsm7WHSytB8mxbFGZEioqicXbVwgn
         WXYWcdPiN01Hh8YTGBGzFjEOE+Evn8ym42XjXcITBsQw+q/qHKFN9DxPbD+0GzHki1Ec
         9HMnQQqG9GCDrEyrm7wwZJ7QWaSqrUdxdKO4tETu+l+uj5xxxTwOX84Fanup4Mg7obnM
         9Y7w==
X-Gm-Message-State: AOAM530JGmfTVSiImNnvkdMYuzBh3w8sw9ISJ5/1NKBfYndjRyov1YAs
        mFDx5x12YuQyI6AUM1n4kqz2nnBjgcyUaKDJz8WUvZH0QZQHtpeYZDkpigXVdel+Noae/XNpgyf
        eBiL0ALcc7dJeS7FdhtFoUqBw
X-Received: by 2002:a05:6214:134f:: with SMTP id b15mr9246751qvw.208.1592583220598;
        Fri, 19 Jun 2020 09:13:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYciDEcz+6ytfRwjREBcuIkBV9R3diCFzYltXp0h47AZIc6TyB3mcZDytKnQbnKaSsy8vd+w==
X-Received: by 2002:a05:6214:134f:: with SMTP id b15mr9246728qvw.208.1592583220420;
        Fri, 19 Jun 2020 09:13:40 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm502143qke.135.2020.06.19.09.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:13:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH 19/26] mm/sh: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:13:38 -0400
Message-Id: <20200619161338.9714-1-peterx@redhat.com>
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

CC: Yoshinori Sato <ysato@users.sourceforge.jp>
CC: Rich Felker <dalias@libc.org>
CC: linux-sh@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sh/mm/fault.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index a4e670a9c9b3..ba6f7ed570e5 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -464,22 +464,13 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (unlikely(fault & (VM_FAULT_RETRY | VM_FAULT_ERROR)))
 		if (mm_fault_error(regs, error_code, address, fault))
 			return;
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

