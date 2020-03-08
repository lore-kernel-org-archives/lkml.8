Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74721C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 17:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B81208C3
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 17:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgCHRKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 13:10:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56421 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgCHRKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 13:10:16 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jAzRN-0007Bs-6v; Sun, 08 Mar 2020 17:10:13 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     cminyard@mvista.com
Cc:     0x7f454c46@gmail.com, areber@redhat.com, avagin@gmail.com,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org,
        minyard@acm.org, oleg@redhat.com
Subject: [PATCH] pid: make ENOMEM return value more obvious
Date:   Sun,  8 Mar 2020 18:10:07 +0100
Message-Id: <20200308171007.3155138-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200307131136.GD2847@minyard.net>
References: <20200307131136.GD2847@minyard.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alloc_pid() codepath used to be simpler. With the introducation of the
ability to choose specific pids in 49cb2fc42ce4 ("fork: extend clone3() to
support setting a PID") it got more complex. It hasn't been super obvious
that ENOMEM is returned when the pid namespace init process/child subreaper
of the pid namespace has died. As can be seen from multiple attempts to
improve this see e.g. [1] and most recently [2].
We regressed returning ENOMEM in [3] and [2] restored it. Let's add a
comment on top explaining that this is historic and documented behavior and
cannot easily be changed.
The unconditional initialization of retval when declaring it can be removed
since it is initialized on ever failure path in the loop and unconditionaly
set to ENOMEM right after it.

[1]: 35f71bc0a09a ("fork: report pid reservation failure properly")
[2]: b26ebfe12f34 ("pid: Fix error return value in some cases")
[3]: 49cb2fc42ce4 ("fork: extend clone3() to support setting a PID")
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/pid.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 19645b25b77c..be43122eb876 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -165,7 +165,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	int i, nr;
 	struct pid_namespace *tmp;
 	struct upid *upid;
-	int retval = -ENOMEM;
+	int retval;
 
 	/*
 	 * set_tid_size contains the size of the set_tid array. Starting at
@@ -247,6 +247,14 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 		tmp = tmp->parent;
 	}
 
+	/*
+	 * ENOMEM is not the most obvious choice especially for the case
+	 * where the child subreaper has already exited and the pid
+	 * namespace denies the creation of any new processes. But ENOMEM
+	 * is what we have exposed to userspace for a long time and it is
+	 * documented behavior for pid namespaces. So we can't easily
+	 * change it even if there were an error code better suited.
+	 */
 	retval = -ENOMEM;
 
 	if (unlikely(is_child_reaper(pid))) {

base-commit: b26ebfe12f34f372cf041c6f801fa49c3fb382c5
-- 
2.25.1

