Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A213EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2E62075A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LdiOo35Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgFHAmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgFHAmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 20:42:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D31C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 17:42:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k186so19325602ybc.19
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 17:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=R/WAosFhbNpsRWMToZp58lnog9BqD/v/8CzzxwISND0=;
        b=LdiOo35YxRIRIs6AkhF7gd2MD5UqfGvjmmW2Ypa0bR56W80JvmWuMjq81Qo65lBrnk
         9lQ3Fdq7J2Zuh4uzNST28UmvdVpks6/O91f/wn3R9ia/NsiaiLW/nZTu1FVmMQgubQLK
         2xPMpgfOvdz1HU2pl02Ne3RKUoN/BkfUvMD3kWACB1q1qQr7zAap3NweKtF0DkFngdMF
         L+yz5IjfbwYAklkEI4l5exA7h3sEz5Uhn89GznVjr+4KO1N1NywBFiTo3OW4Wn8vBy7F
         di/xXi//ccq9CUmVV4I12cX5gTyyZP/RlpvNC3d9Nk2jmJqXP9/Guwg3+KGQqcOt0FMI
         Fgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R/WAosFhbNpsRWMToZp58lnog9BqD/v/8CzzxwISND0=;
        b=iAr7zGOqhFmOJ5NQHMlJ3RQnv4tSKwskrCHBJDEFPSj/Rh2eFFfOX6N7/i+u5/VyLW
         +iQhNUF9ekz4eY5GpKmKILcT35ow5D2ZArE64Wttf8ujmZyr6LZ/spzKXyGmhm23+HW9
         ugBLDyXFhi7LVhbono/hjyIAJsIDeranrLKSYE7l1i/ivnfu6J7nQJCnxleKqU7J/qWh
         GKvL0N1k0HVXmuHnogJ9Y7qttaf2jt4wE7jtpiFLLEUZlleS+871Hu18/q5AMWXK27zy
         ypqvJM2hrMA7RNJ2yV0F7auz/lpUCdUfGdn70o7dnk7pUwTKiJfnU4/RLMIPwufRbZna
         To2g==
X-Gm-Message-State: AOAM533bDL1xzSufoYMmmvmFiOgTdyfE8woM8QZTh7m/Sw5JC7QEqBrs
        cUqg4ydwg+TlhPXaSeLMlYZOBDDh9BGLGXwI
X-Google-Smtp-Source: ABdhPJwFMrumkHVFDTPTUg7mt2z9sUVrELoIw4bTlRKa9uLJQUYUsTRAlUGzUJgtUp7lvuNh/VJL6AWaaipSJBs8
X-Received: by 2002:a05:6902:4a2:: with SMTP id r2mr9439390ybs.176.1591576921786;
 Sun, 07 Jun 2020 17:42:01 -0700 (PDT)
Date:   Mon,  8 Jun 2020 02:41:53 +0200
Message-Id: <fcd1cd16eac1d2c01a66befd8ea4afc6f8d09833.1591576806.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH] kcov: check kcov_softirq in kcov_remote_stop()
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kcov_remote_stop() should check that the corresponding kcov_remote_start()
actually found the specified remote handle and started collecting
coverage. This is done by checking the per thread kcov_softirq flag.

A particular failure scenario where this was observed involved a softirq
with a remote coverage collection section coming between check_kcov_mode()
and the access to t->kcov_area in __sanitizer_cov_trace_pc(). In that
softirq kcov_remote_start() bailed out after kcov_remote_find() check, but
the matching kcov_remote_stop() didn't check if kcov_remote_start()
succeeded, and overwrote per thread kcov parameters with invalid (zero)
values.

Fixes: 5ff3b30ab57d ("kcov: collect coverage from interrupts")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/kcov.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 55c5d883a93e..6afae0bcbac4 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -427,7 +427,8 @@ void kcov_task_exit(struct task_struct *t)
 	 *        WARN_ON(!kcov->remote && kcov->t != t);
 	 *
 	 * For KCOV_REMOTE_ENABLE devices, the exiting task is either:
-	 * 2. A remote task between kcov_remote_start() and kcov_remote_stop().
+	 *
+	 * 1. A remote task between kcov_remote_start() and kcov_remote_stop().
 	 *    In this case we should print a warning right away, since a task
 	 *    shouldn't be exiting when it's in a kcov coverage collection
 	 *    section. Here t points to the task that is collecting remote
@@ -437,7 +438,7 @@ void kcov_task_exit(struct task_struct *t)
 	 *        WARN_ON(kcov->remote && kcov->t != t);
 	 *
 	 * 2. The task that created kcov exiting without calling KCOV_DISABLE,
-	 *    and then again we can make sure that t->kcov->t == t:
+	 *    and then again we make sure that t->kcov->t == t:
 	 *        WARN_ON(kcov->remote && kcov->t != t);
 	 *
 	 * By combining all three checks into one we get:
@@ -764,7 +765,7 @@ static const struct file_operations kcov_fops = {
  * Internally, kcov_remote_start() looks up the kcov device associated with the
  * provided handle, allocates an area for coverage collection, and saves the
  * pointers to kcov and area into the current task_struct to allow coverage to
- * be collected via __sanitizer_cov_trace_pc()
+ * be collected via __sanitizer_cov_trace_pc().
  * In turns kcov_remote_stop() clears those pointers from task_struct to stop
  * collecting coverage and copies all collected coverage into the kcov area.
  */
@@ -972,16 +973,25 @@ void kcov_remote_stop(void)
 		local_irq_restore(flags);
 		return;
 	}
-	kcov = t->kcov;
-	area = t->kcov_area;
-	size = t->kcov_size;
-	sequence = t->kcov_sequence;
-
+	/*
+	 * When in softirq, check if the corresponding kcov_remote_start()
+	 * actually found the remote handle and started collecting coverage.
+	 */
+	if (in_serving_softirq() && !t->kcov_softirq) {
+		local_irq_restore(flags);
+		return;
+	}
+	/* Make sure that kcov_softirq is only set when in softirq. */
 	if (WARN_ON(!in_serving_softirq() && t->kcov_softirq)) {
 		local_irq_restore(flags);
 		return;
 	}
 
+	kcov = t->kcov;
+	area = t->kcov_area;
+	size = t->kcov_size;
+	sequence = t->kcov_sequence;
+
 	kcov_stop(t);
 	if (in_serving_softirq()) {
 		t->kcov_softirq = 0;
-- 
2.27.0.278.ge193c7cf3a9-goog

