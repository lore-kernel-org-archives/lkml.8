Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F395C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D59F2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMZPGV52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgHGTQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:16:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1D9C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:16:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so1543066pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w22kZ75JGy2Gq3VBIM8FU26Q5gzXZnTUB6P6tGV9wvg=;
        b=JMZPGV5288yNzNSZLFUUBb7mZFPgCSl5mnv697xqrIBXcY8ugFSQka2Zh0+vjQEgpm
         lO6Mbw3xxCinANX8wLhGsraz6RRAblUf2S7Y8W6V8tuQMQbPW+whev6SFJRZdmGzHUVa
         krp1dZdF6qo/IZW4q7fHQT5hXRAeX5zR6hMmCLkJrwblkhL1zHCyCFHD4uFRCIZmYPog
         9CEwpGiOZ7DcKdQvs0VMHVRQ71978e4L6k50kIe6zdC16HiYmUAnaVkgY+DxEzTsZae+
         4NvBbaK5NFIgKMIIyeziQbYk5VU0cVssPyWApBV+9Z61bSp8rRulKx1VElmVtyAdLZz0
         M4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=w22kZ75JGy2Gq3VBIM8FU26Q5gzXZnTUB6P6tGV9wvg=;
        b=VCmhwHT1a1sNlswlL36rQ72KnZp/esnvR+rF/RIKJEXQAI7//hWIWygg13MXwifxS8
         LNEArMn3Tp4xEj0JsMnR+16paaOu1e0rAsHdoEk3R3TyrBQ7vYQv60330xz/2hOs1tFX
         LEeKruyGzfaU4g6eqPjHjWnOvsu0HQ6FCNBhWMN/F0oZgKk9VVLTfSHZlFZbUJO+s3cG
         K6HDVfsczm6WEKXi/du6wTocMEqC5mgj02t1LX8pyzRshzyfJzAvJX0GAhlohbJPnpBu
         PMUtJ2fb0jKIB/5fPSjiX+c8bfg4SyepgQ5XvAiTZgUTaehhM9Qkszvkq6WKYjxV57r8
         X+og==
X-Gm-Message-State: AOAM533oNUtY5V1mUjaVqupgFQQico+kLZfGwpFQknraWupI58eS5Fcb
        MNXxgO/p5id/Zk9E2/p8jHc=
X-Google-Smtp-Source: ABdhPJzNaHW9b/WV22yrUOMtl5VaKywUnvhHra6uE+kbUBYVVWq4PMHXmvH+PSmd0u5U+6hMMQhPyQ==
X-Received: by 2002:a17:902:d341:: with SMTP id l1mr13667172plk.134.1596827816932;
        Fri, 07 Aug 2020 12:16:56 -0700 (PDT)
Received: from sultan-box.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id y4sm13432665pff.44.2020.08.07.12.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 12:16:56 -0700 (PDT)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH 1/2] locking/mutex: Don't hog RCU read lock while optimistically spinning
Date:   Fri,  7 Aug 2020 12:16:35 -0700
Message-Id: <20200807191636.75045-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

There's no reason to hold an RCU read lock the entire time while
optimistically spinning for a mutex lock. This can needlessly lengthen
RCU grace periods and slow down synchronize_rcu() when it doesn't brute
force the RCU grace period via rcupdate.rcu_expedited=1.

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 kernel/locking/mutex.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5352ce50a97e..cc5676712458 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -552,21 +552,31 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 {
 	bool ret = true;
 
-	rcu_read_lock();
-	while (__mutex_owner(lock) == owner) {
+	for (;;) {
+		unsigned int cpu;
+		bool same_owner;
+
 		/*
-		 * Ensure we emit the owner->on_cpu, dereference _after_
-		 * checking lock->owner still matches owner. If that fails,
+		 * Ensure lock->owner still matches owner. If that fails,
 		 * owner might point to freed memory. If it still matches,
 		 * the rcu_read_lock() ensures the memory stays valid.
 		 */
-		barrier();
+		rcu_read_lock();
+		same_owner = __mutex_owner(lock) == owner;
+		if (same_owner) {
+			ret = owner->on_cpu;
+			if (ret)
+				cpu = task_cpu(owner);
+		}
+		rcu_read_unlock();
+
+		if (!ret || !same_owner)
+			break;
 
 		/*
 		 * Use vcpu_is_preempted to detect lock holder preemption issue.
 		 */
-		if (!owner->on_cpu || need_resched() ||
-				vcpu_is_preempted(task_cpu(owner))) {
+		if (need_resched() || vcpu_is_preempted(cpu)) {
 			ret = false;
 			break;
 		}
@@ -578,7 +588,6 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 
 		cpu_relax();
 	}
-	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.28.0

