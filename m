Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37BBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985CD208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6/H5JPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgFRV3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:29:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44380 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730486AbgFRV3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592515791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=pSeBMkGoiWF7Uqz9mv4RyLPu5DAlwZeP6Lwc6V30QlY=;
        b=T6/H5JPI+RFtoTvNxwr0BDLvUXRnxlwfkjEK5QHFjYTJY6B7xxHiZ5UMP29L0zYumeLSMA
        j0Xf1bfgQpZNBCPdil1IksZfGR0PZS8hCZQ3BKYvY4gRXl7U3ZDkSFcNqUJhBbr2NFylDk
        z5c3Avcx0R/cfYnvogsO+5nU3C508vI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-_HwV8PBmPmiEXunbTnrkpA-1; Thu, 18 Jun 2020 17:29:49 -0400
X-MC-Unique: _HwV8PBmPmiEXunbTnrkpA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 971F78035DF;
        Thu, 18 Jun 2020 21:29:48 +0000 (UTC)
Received: from llong.com (ovpn-118-66.rdu2.redhat.com [10.10.118.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE709100238D;
        Thu, 18 Jun 2020 21:29:44 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michel Lespinasse <walken@google.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2] sched, mm: Optimize current_gfp_context()
Date:   Thu, 18 Jun 2020 17:29:36 -0400
Message-Id: <20200618212936.9776-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current_gfp_context() converts a number of PF_MEMALLOC_* per-process
flags into the corresponding GFP_* flags for memory allocation. In
that function, current->flags is accessed 3 times. That may lead to
duplicated access of the same memory location.

This is not usually a problem with minimal debug config options on as the
compiler can optimize away the duplicated memory accesses.  With most
of the debug config options on, however, that may not be the case.
For example, the x86-64 object size of the __need_fs_reclaim() in a
debug kernel that calls current_gfp_context() was 309 bytes. With this
patch applied, the object size is reduced to 202 bytes. This is a saving
of 107 bytes and will probably be slightly faster too.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched/mm.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 480a4d1b7dd8..ff37cd8bbd82 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -181,18 +181,20 @@ static inline bool in_vfork(struct task_struct *tsk)
  */
 static inline gfp_t current_gfp_context(gfp_t flags)
 {
-	if (unlikely(current->flags &
+	unsigned int pflags = READ_ONCE(current->flags);
+
+	if (unlikely(pflags &
 		     (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS | PF_MEMALLOC_NOCMA))) {
 		/*
 		 * NOIO implies both NOIO and NOFS and it is a weaker context
 		 * so always make sure it makes precedence
 		 */
-		if (current->flags & PF_MEMALLOC_NOIO)
+		if (pflags & PF_MEMALLOC_NOIO)
 			flags &= ~(__GFP_IO | __GFP_FS);
-		else if (current->flags & PF_MEMALLOC_NOFS)
+		else if (pflags & PF_MEMALLOC_NOFS)
 			flags &= ~__GFP_FS;
 #ifdef CONFIG_CMA
-		if (current->flags & PF_MEMALLOC_NOCMA)
+		if (pflags & PF_MEMALLOC_NOCMA)
 			flags &= ~__GFP_MOVABLE;
 #endif
 	}
-- 
2.18.1

