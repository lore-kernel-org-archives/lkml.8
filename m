Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D346C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF9220675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="oSQ4BQep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgGCGOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCGOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:14:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F97C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 23:14:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q17so13551245pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4EZwpgmE4SueL7e7tjK8HJwbAvV8gZoeqD/srGZ37yk=;
        b=oSQ4BQepwwyKGLVXlKk03nr1hWc+SmjA2W/HfDTlNPSxskF4OqVSmq0RMfGPlr/07R
         jUStXAHktVZXZG0cPzgnjsKTVf+I0J4y3B5qwWKX/h6HWRuy5Sn4M6T1/rvgXFnTntqB
         QmV1YtU8u0/ouw6WR6qHgg60SwBEFbm1OOAdHCY83r+SuuM/40DPg1FpAvx8IVedaQco
         XjQ7JBAPt4NROlIEax0eclbVYoQIuyl8KwdxZBsw6zsVkBdNzgqM4YGmeYEEU/iSEiKP
         0ISl6rX9NzISWAMIexq81r5lXa/MVr6J9dqm2GWZ+b4m7ILLaBLmu17+cEQik0P3B1lv
         5WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4EZwpgmE4SueL7e7tjK8HJwbAvV8gZoeqD/srGZ37yk=;
        b=ZPP1xZgeO+wX+AkwzBtHvrodim7us4cmlaCvlyzOh0s5rVsmZPTjAa0GEGBTcr2qln
         QbxqLeJAF9WrtJhFWRAdlKE8It7tRljqAjovivUtYtuVwgfE6ONY+BO7RzL3IX6ps1ps
         yTz0FWlKp538ZB0PZKg8zp4aR2PMbQg3K3SH8rwgQMiO4Z49yYq0Luxx3VzQrWQtRtee
         GOmT8S1E9L8+tOKq8HT3TJbQhHsVpCqURgNlz9u3+85QDrUaTjplpwR2S1Jj6VUFqujf
         kPRg5jqYFLtpJgvsWvZddY1bDObPqL5ZquE+zwxhwcw6HUS96Bq8LSVuVpStblMboj5a
         UvEw==
X-Gm-Message-State: AOAM530KU73Dy0jsoiVjkdjTI2Jz9YVQC+UDz17tnJw4jZ9SuakqjcJa
        TUWgU7p25qhjWuY8JWTVGS/ucQ==
X-Google-Smtp-Source: ABdhPJxCmD4c8IFGSzGHPg50n9TH1o+RaiKai1/irHgNYxcYmZIzLRcPtjtjRFKBn/GHQ0WBvLeYOg==
X-Received: by 2002:a63:1c23:: with SMTP id c35mr26767213pgc.91.1593756840219;
        Thu, 02 Jul 2020 23:14:00 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.68])
        by smtp.gmail.com with ESMTPSA id y7sm8642784pjp.47.2020.07.02.23.13.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 23:13:59 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RESEND] mm/page_alloc: skip setting nodemask when we are in interrupt
Date:   Fri,  3 Jul 2020 14:13:50 +0800
Message-Id: <20200703061350.94474-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we are in the interrupt context, it is irrelevant to the
current task context. If we use current task's mems_allowed, we
can fair to alloc pages in the fast path and fall back to slow
path memory allocation when the current node(which is the current
task mems_allowed) does not have enough memory to allocate. In
this case, it slows down the memory allocation speed of interrupt
context. So we can skip setting the nodemask to allow any node
to allocate memory, so that fast path allocation can success.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/page_alloc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b48336e20bdcd..a6c36cd557d1d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4726,10 +4726,12 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 
 	if (cpusets_enabled()) {
 		*alloc_mask |= __GFP_HARDWALL;
-		if (!ac->nodemask)
-			ac->nodemask = &cpuset_current_mems_allowed;
-		else
+		if (!ac->nodemask) {
+			if (!in_interrupt())
+				ac->nodemask = &cpuset_current_mems_allowed;
+		} else {
 			*alloc_flags |= ALLOC_CPUSET;
+		}
 	}
 
 	fs_reclaim_acquire(gfp_mask);
-- 
2.11.0

