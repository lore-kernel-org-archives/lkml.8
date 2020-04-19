Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C8AC38A2F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66A222209
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587261508;
	bh=ENuIonxA9t7MXcbRtsH6Z/8DcbDtTbt/JJI0qGNDi04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pG4IafWfMGDcKZlDhImrHAEQuZRfvQVDkJnmBvQ5B2wPtYo3YPYhTmYOdfSrFoo4F
	 Jq/ZOJbvnqB95pASo3WXzFVtGcNlJdH0txWlPYFevmv4DEogU7t4ZqN+HSKv0JBpKz
	 itnt06mAQwkNENXCBsx/pu7NCbig71JOU1fIso+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgDSB60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 21:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgDSB6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:58:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D7DC21D93;
        Sun, 19 Apr 2020 01:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261492;
        bh=ENuIonxA9t7MXcbRtsH6Z/8DcbDtTbt/JJI0qGNDi04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tpe20nnE/NiMKGg2lId1m4HZ8gWOgYPg/k9BbCxQdqWLw94TKl/qKXMIhSZXHdfCV
         RN8Jyw/WhyfoQL2yMBuIuPoJh3dnVd71vPzD7WynNfK59J0/w2HOmZyQz+jLF157tP
         hE4YJvj0qE5eS3hILLbKlIJhGmx6UFrzagWi+r04=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 11/12] tools/lib/lockdep: call lockdep_init_task on init
Date:   Sat, 18 Apr 2020 21:57:53 -0400
Message-Id: <20200419015754.24456-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
References: <20200419015754.24456-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have to explicitly call lockdep_init_task() when starting up.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/lockdep/preload.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/lockdep/preload.c b/tools/lib/lockdep/preload.c
index 8f1adbe887b2f..578fdeda9422c 100644
--- a/tools/lib/lockdep/preload.c
+++ b/tools/lib/lockdep/preload.c
@@ -9,6 +9,8 @@
 #include "include/liblockdep/mutex.h"
 #include "../../include/linux/rbtree.h"
 
+extern struct task_struct *__curr(void);
+
 /**
  * struct lock_lookup - liblockdep's view of a single unique lock
  * @orig: pointer to the original pthread lock, used for lookups
@@ -421,6 +423,8 @@ __attribute__((constructor)) static void init_preload(void)
 	if (__init_state == done)
 		return;
 
+	lockdep_init_task(__curr());
+
 #ifndef __GLIBC__
 	__init_state = prepare;
 
-- 
2.20.1

