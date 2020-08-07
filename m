Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98BFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB8B214F1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfqzL8BW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHGTRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:16:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B09C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:16:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d188so1546137pfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nAulkNxU9Nrr0r2Q+/oP/y0eVROiBvJb3wM5+KKQ5eM=;
        b=UfqzL8BWBezA23AIgV8lJCXtRB83oKAQHXP40B+Y2CnU/8eLW4EQ9ejYtDvdiiOwkX
         wPAh+O40EoFMjNWCqsOUF2+EgSRDJJc/yKiqVbZw9quOyfJORy+b50B+akPFnX0HOhB3
         DiyIeKi/H2h6tE15XOQCKjLWwxbUJud4qH6DhM08w8eT8SAS7MhF817/+Pw+FmpcNEal
         H5rfjlUhG9/hN1zcuAVwlkShWvvz8JlViKfMuoRFl+On6EY6qgEmUYNx/pfem7r27wBe
         ByRK5gJcCGeh9i9K8yPg8qUz5tUIWXHdMo7iOLl1waPAe6AugLjFtlXRW57QHcwrDchK
         Y4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nAulkNxU9Nrr0r2Q+/oP/y0eVROiBvJb3wM5+KKQ5eM=;
        b=i3Q1Jupqgo0inegFmg0+EEHv7C2gcVtZseHBhlCuXbCL+jkW6objr1yQ9jK4VP5YhU
         011wAtlfKwUmrgdQxvNsghjARP/nf4qHunrM9f2NnXo//z8dJb69cB6lczLEt4uoeZNb
         Lyjm7y0dIAK+evO8Nu8nYOTs+QwKarIaW75coBJv7TLERgNJOjjEkFIa2dra1GlpXvIJ
         St1KZv34ykUlPKMeVZ/HEW0pEi7juM9X+rfQktVx43mLDkoLW6oVLeSUPoWLjhAw+dNE
         2t2h9go6vLf3ehVYX7EAlilNlg7yOPZY6FO2gqs3glYQlYYvM3DB5l/WTxSU5eGuEfUW
         bFFA==
X-Gm-Message-State: AOAM531zDfKgJFhMA6XLlOyIL9UN2ZX7ARjiZBdeETLqhxz2SnHR/akq
        pJjxZvu96LgtaNEhwyi61qM=
X-Google-Smtp-Source: ABdhPJxlcMhidUm9kO+7tjlgQ6RAcIOD9PZs5RerRs47ASqhXiA2lHjyeI0ftKa71wrIekEwLEHYzA==
X-Received: by 2002:a65:63c8:: with SMTP id n8mr12757511pgv.232.1596827818163;
        Fri, 07 Aug 2020 12:16:58 -0700 (PDT)
Received: from sultan-box.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id y4sm13432665pff.44.2020.08.07.12.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 12:16:57 -0700 (PDT)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH 2/2] locking/rwsem: Don't hog RCU read lock while optimistically spinning
Date:   Fri,  7 Aug 2020 12:16:36 -0700
Message-Id: <20200807191636.75045-2-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807191636.75045-1-sultan@kerneltoast.com>
References: <20200807191636.75045-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

There's no reason to hold an RCU read lock the entire time while
optimistically spinning for a rwsem. This can needlessly lengthen RCU
grace periods and slow down synchronize_rcu() when it doesn't brute
force the RCU grace period via rcupdate.rcu_expedited=1.

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 kernel/locking/rwsem.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index f11b9bd3431d..a1e3ceb254d1 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -723,8 +723,10 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 	if (state != OWNER_WRITER)
 		return state;
 
-	rcu_read_lock();
 	for (;;) {
+		bool same_owner;
+
+		rcu_read_lock();
 		/*
 		 * When a waiting writer set the handoff flag, it may spin
 		 * on the owner as well. Once that writer acquires the lock,
@@ -732,27 +734,32 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 		 * handoff bit is set.
 		 */
 		new = rwsem_owner_flags(sem, &new_flags);
-		if ((new != owner) || (new_flags != flags)) {
-			state = rwsem_owner_state(new, new_flags, nonspinnable);
-			break;
-		}
 
 		/*
-		 * Ensure we emit the owner->on_cpu, dereference _after_
-		 * checking sem->owner still matches owner, if that fails,
+		 * Ensure sem->owner still matches owner. If that fails,
 		 * owner might point to free()d memory, if it still matches,
 		 * the rcu_read_lock() ensures the memory stays valid.
 		 */
-		barrier();
+		same_owner = new == owner && new_flags == flags;
+		if (same_owner && !owner_on_cpu(owner))
+			state = OWNER_NONSPINNABLE;
+		rcu_read_unlock();
 
-		if (need_resched() || !owner_on_cpu(owner)) {
+		if (!same_owner) {
+			state = rwsem_owner_state(new, new_flags, nonspinnable);
+			break;
+		}
+
+		if (state == OWNER_NONSPINNABLE)
+			break;
+
+		if (need_resched()) {
 			state = OWNER_NONSPINNABLE;
 			break;
 		}
 
 		cpu_relax();
 	}
-	rcu_read_unlock();
 
 	return state;
 }
-- 
2.28.0

