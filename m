Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCF7C7114D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 04:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3592C2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 04:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qASr64GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBOEZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 23:25:15 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37414 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgBOEZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 23:25:14 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so4811790pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 20:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4t7Xbaz1xoUTGAENQItzTjfc+1K4Tm8fLSipz2FNxHU=;
        b=qASr64GWv136MX7+vVotcycBPXMCpd18/mBO7Eq8wVaR5rpvWMVQ6MEHg5vjJuuAuy
         mA6BSb9oNtkc/h3V0GO2FxKqWbxcQe5AauX5PG/ixP9FJUR6NR/Y2LaCoMDwK2WD6PK/
         1/sJN3xzQxD+0bNO1w43IuSG1RvovsStyfCgSp65JqT05Ulsl8g/dhFwNfcwIYanuy8x
         0A9AJaHUXjHPUZjjFH9raF9KUSpJ3MyMBW819LQtFqAffYjLFrfYMG0XSw6IoawUJuek
         /MJ175Pk87yWZ5pWZLVZCmOOnCPaXrhVnbYz6t9QTUgr3YAZ4Pfebxf+kjOEmBkBIuhf
         CuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4t7Xbaz1xoUTGAENQItzTjfc+1K4Tm8fLSipz2FNxHU=;
        b=KxCQvcwksstqYHN58OKse/6zPJ1P6cBb9WxxHoOn+bRecCKjlwol9uPBai9o+eQx4J
         PBCC5PE0zSLbCncNQc4agBB3I9X6OI9b5+uWirMTr7Di/l0ax56o2zGoyoCZW2gnSICL
         E03/a6MNXtQmhXCIp1Ay9F/VNLH9nMSQh2I6SSHgurMDjcjiPPbdFyhrFtI0PhO182UB
         rT5dUoSKsaW81KuSqijI98TslX9oA/VgsHt94LnBn+J3AtoPQZChUUTDXuQjXxvUpCmM
         h+zFDKX21bAMPXhwGTJ4THnGarzBc+6VW4G2ybYo2NTX085D3OKFpdlkvVV5pQZbMENz
         pjHw==
X-Gm-Message-State: APjAAAVbtDCcBg9PULnYnsimjw4diyFpeYMt7oK6jaU1ek0j2SQAAe73
        b0ClSklFk3UyXLb3D59oKZM=
X-Google-Smtp-Source: APXvYqzqkSQHelx74Kk0mKgd0Ay4VEBD/Ex/3A4k7B5C2JE2hAx12PMVUcmtKI3+2yzYI7U3+OBqlA==
X-Received: by 2002:a17:902:103:: with SMTP id 3mr6518099plb.34.1581740714062;
        Fri, 14 Feb 2020 20:25:14 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 23sm8549509pfh.28.2020.02.14.20.25.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Feb 2020 20:25:13 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] locking/osq: use osq_wait_node_unqueue() for coding optimization
Date:   Sat, 15 Feb 2020 12:25:09 +0800
Message-Id: <1581740709-9013-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Define a separate function called osq_wait_node_unqueue() to
integrate the whole code of leaving a node apart from its queue.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 kernel/locking/osq_lock.c | 118 +++++++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 54 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 1f77349..6b1c6d2 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -87,10 +87,72 @@ static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
 	return next;
 }
 
+
+/*
+ * Tree steps to make sure the stability of leaving @node apart from its queue.
+ */
+static inline bool osq_wait_node_unqueue(struct optimistic_spin_queue *lock,
+		struct optimistic_spin_node *node,
+		struct optimistic_spin_node *prev)
+{
+	struct optimistic_spin_node *next;
+
+	/*
+	 * Step - A  -- stabilize @prev
+	 *
+	 * Undo our @prev->next assignment; this will make @prev's
+	 * unlock()/unqueue() wait for a next pointer since @lock points to us
+	 * (or later).
+	 */
+	for (;;) {
+		if (prev->next == node &&
+		    cmpxchg(&prev->next, node, NULL) == node)
+		    break;
+
+		/*
+		 * We can only fail the cmpxchg() racing against an unlock(),
+		 * in which case we should observe @node->locked to become
+		 * true.
+		 */
+		if (smp_load_acquire(&node->locked))
+			return true;
+
+		cpu_relax();
+
+		/*
+		 * Or we race against a concurrent unqueue()'s step-B, in which
+		 * case its step-C will write us a new @node->prev pointer.
+		 */
+		prev = READ_ONCE(node->prev);
+	}
+
+	/*
+	 * Step - B -- stabilize @next
+	 *
+	 * Similar to unlock(), wait for @node->next or move @lock from @node
+	 * back to @prev.
+	 */
+	next = osq_wait_next(lock, node, prev);
+	if (!next)
+		return false;
+
+	/*
+	 * Step - C -- unlink
+	 *
+	 * @prev is stable because its still waiting for a new @prev->next
+	 * pointer, @next is stable because our @node->next pointer is NULL and
+	 * it will wait in Step-A.
+	 */
+	WRITE_ONCE(next->prev, prev);
+	WRITE_ONCE(prev->next, next);
+
+	return false;
+}
+
 bool osq_lock(struct optimistic_spin_queue *lock)
 {
 	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
-	struct optimistic_spin_node *prev, *next;
+	struct optimistic_spin_node *prev;
 	int curr = encode_cpu(smp_processor_id());
 	int old;
 
@@ -145,59 +207,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 		return true;
 
 	/* unqueue */
-	/*
-	 * Step - A  -- stabilize @prev
-	 *
-	 * Undo our @prev->next assignment; this will make @prev's
-	 * unlock()/unqueue() wait for a next pointer since @lock points to us
-	 * (or later).
-	 */
-
-	for (;;) {
-		if (prev->next == node &&
-		    cmpxchg(&prev->next, node, NULL) == node)
-			break;
-
-		/*
-		 * We can only fail the cmpxchg() racing against an unlock(),
-		 * in which case we should observe @node->locked becomming
-		 * true.
-		 */
-		if (smp_load_acquire(&node->locked))
-			return true;
-
-		cpu_relax();
-
-		/*
-		 * Or we race against a concurrent unqueue()'s step-B, in which
-		 * case its step-C will write us a new @node->prev pointer.
-		 */
-		prev = READ_ONCE(node->prev);
-	}
-
-	/*
-	 * Step - B -- stabilize @next
-	 *
-	 * Similar to unlock(), wait for @node->next or move @lock from @node
-	 * back to @prev.
-	 */
-
-	next = osq_wait_next(lock, node, prev);
-	if (!next)
-		return false;
-
-	/*
-	 * Step - C -- unlink
-	 *
-	 * @prev is stable because its still waiting for a new @prev->next
-	 * pointer, @next is stable because our @node->next pointer is NULL and
-	 * it will wait in Step-A.
-	 */
-
-	WRITE_ONCE(next->prev, prev);
-	WRITE_ONCE(prev->next, next);
-
-	return false;
+	return osq_wait_node_unqueue(lock, node, prev);
 }
 
 void osq_unlock(struct optimistic_spin_queue *lock)
-- 
1.9.1

