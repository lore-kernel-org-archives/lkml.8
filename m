Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88517C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E2B20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hU4i1neP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgFOWQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:16:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49633 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726537AbgFOWQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KFBAGoH4m4vLgkLo1O4lKDrZPfxmEHOi/brzsSjZMGQ=;
        b=hU4i1nePOwFBStQUl8UPBSFYz244BjLzX1JV390hJ/h9pz0DpN+iYQxkwWH8B96U82wjXc
        0yf/nfd3m0MlBvb5VyIP8WNv9M7mKADblcaRS5OUDXqJ5bQgq364lN93dT2awcYU2oz3yw
        1cYnZOeFN0mSDtHaGUj0IOHwwC7YNUY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-xG3mpiPyPo2qU21_R91hMQ-1; Mon, 15 Jun 2020 18:16:22 -0400
X-MC-Unique: xG3mpiPyPo2qU21_R91hMQ-1
Received: by mail-qk1-f199.google.com with SMTP id t18so15365387qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFBAGoH4m4vLgkLo1O4lKDrZPfxmEHOi/brzsSjZMGQ=;
        b=q/Fm5pZCKYvlFA4FAd+IMgMpzX28MuFBvH90qqJLlVBZGoNqcLKK3av/vuQBhELQGq
         gwv6KeeNyItt+v3liyb2IchxxhDo8Aud6XVhaDyg/pr+QtPKQjR4A3SapoQt8390dXxJ
         ZnUDWsPbVlqQBcYPj52bbzb/6KDJTcNDZtVnNlQy5rUqEQTgqhuGrIbR4o6dFpvZTPr1
         PobBKDN6zXsiPYJeOk6aoBWJfuOM1SDqaY7BEio28dE88sNnves3PcVxKF9FX2vxgG/j
         FrsvlQI+vqY4B2NKJuxAzM3Wjwlxovb/lxgnyBuznmopv/H+F66ittVmKa/zqNzzfV2/
         BLug==
X-Gm-Message-State: AOAM530NYH+LXtQW8lz1sGhpus1W9UEFpFsSPcj/vYmgM3ABh3TRNCXe
        PtDtsyDy46ND7WjFxCu+9aVaIPuybdSQfvqA9JyOf/7r7bWvz8qOgcBv6Pqi9unrO14ybpmKVE8
        k0iFHt6HX0MWu7VcgJ4x8XcDY
X-Received: by 2002:ac8:768b:: with SMTP id g11mr18907575qtr.249.1592259381884;
        Mon, 15 Jun 2020 15:16:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyj2u8zUEq1AVaqIVlLmmoPxXksMKXvCW3j5Sj2WjcowIx7CNdGCFxksv3E2wEYY6My624aug==
X-Received: by 2002:ac8:768b:: with SMTP id g11mr18907553qtr.249.1592259381676;
        Mon, 15 Jun 2020 15:16:21 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:49 -0400
Message-Id: <20200615221607.7764-8-peterx@redhat.com>
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
Also, move the accounting to be after release of mmap_sem.

CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/csky/mm/fault.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 4e6dc68f3258..8f8d34d27eca 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -111,8 +111,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 		return;
 	}
 #endif
-
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
@@ -160,17 +158,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 			goto bad_area;
 		BUG();
 	}
-	if (fault & VM_FAULT_MAJOR) {
-		tsk->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
-			      address);
-	} else {
-		tsk->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
-			      address);
-	}
-
 	up_read(&mm->mmap_sem);
+	mm_fault_accounting(tsk, regs, address, fault & VM_FAULT_MAJOR);
 	return;
 
 	/*
-- 
2.26.2

