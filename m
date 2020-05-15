Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C371BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 23:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1F42078C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 23:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="qVHejHX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgEOXkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 19:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726223AbgEOXkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 19:40:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F33BC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 16:40:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z26so1615858pfk.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 16:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJzFvwUo6iwn8/DhNKCJMUEDGhhpSA9N+Qu+KJbXwr8=;
        b=qVHejHX0vz/9v+B4nZFIfZakrLDKIV9dHq+Own9O52KzZBA6raffF1PWe0K7xm7t8/
         DoTt32O7hItE3VUMFDIU7ZCEo0FOR+235oUGGtNZeCten6HNw9qw6heNeGMeWHv20iG/
         1d9tYLqDdjGo4H7TkWoE6HgQQVuwXuzQxpBQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJzFvwUo6iwn8/DhNKCJMUEDGhhpSA9N+Qu+KJbXwr8=;
        b=QYGtM5YZFmuQg2RjZ8QwIyFZsaivYXhCfi7dIx2IPpyfduy7QixoNiqZtrfPGZf4tK
         EjZjZkZWCJJ0ryP6ZkAUr66B1SDxWX//Jlod2Hhh4YmXmZbwpxmjef5qm+Iz4xEhg3li
         mKhk1+x68zHplpGYnYp/p8ooICqNGYOWMzUNZTZorD5fZ/U2B5t8T+BUVUryxiijuFbN
         NFfvdTOfgtjgV3WTlTg0IDWieIIWlMlyT8TjKZ0mByGmdABL+z/3kQ1Sl77gRb8zem8I
         Mqm2Lb2jbt0dSk2VBAx5f01hB9KsGTGFC1ytrNXK1oWXvhek3vqnPyYbGSBSc3IXMOn8
         +bQw==
X-Gm-Message-State: AOAM533Z+3vJUugfYVPDiYRmNh2rgNwI+AfL9BNOakWHCfpJTJm3w6E+
        g56ZfPhL5IzK2l+O6I7uPnaqO6uFHjibMA==
X-Google-Smtp-Source: ABdhPJyDbT/37zGxxJ04QtTD4suKPeXcd688xN9h0qJJSHQhZSh5RAyLeHbzDChQBhC95TREq+CLWQ==
X-Received: by 2002:aa7:9302:: with SMTP id 2mr6304335pfj.256.1589586029248;
        Fri, 15 May 2020 16:40:29 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id x20sm1264990pfc.211.2020.05.15.16.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 16:40:28 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        tycho@tycho.ws, keescook@chromium.org, cyphar@cyphar.com
Subject: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Date:   Fri, 15 May 2020 16:40:05 -0700
Message-Id: <20200515234005.32370-1-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This includes the thread group leader ID in the seccomp_notif. This is
immediately useful for opening up a pidfd for the group leader, as
pidfds only work on group leaders.

Previously, it was considered to include an actual pidfd in the
seccomp_notif structure[1], but it was suggested to avoid proliferating
mechanisms to create pidfds[2].

[1]: https://lkml.org/lkml/2020/1/24/133
[2]: https://lkml.org/lkml/2020/5/15/481

Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/uapi/linux/seccomp.h                  |  2 +
 kernel/seccomp.c                              |  1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 50 +++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index c1735455bc53..f0c272ef0f1e 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -75,6 +75,8 @@ struct seccomp_notif {
 	__u32 pid;
 	__u32 flags;
 	struct seccomp_data data;
+	__u32 tgid;
+	__u8 pad0[4];
 };
 
 /*
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 55a6184f5990..538bcbbcf4da 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1061,6 +1061,7 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 
 	unotif.id = knotif->id;
 	unotif.pid = task_pid_vnr(knotif->task);
+	unotif.tgid = task_tgid_vnr(knotif->task);
 	unotif.data = *(knotif->data);
 
 	knotif->state = SECCOMP_NOTIFY_SENT;
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index c0aa46ce14f6..5658c6e95461 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -187,6 +187,8 @@ struct seccomp_notif {
 	__u32 pid;
 	__u32 flags;
 	struct seccomp_data data;
+	__u32 tgid;
+	__u8 pad0[4];
 };
 
 struct seccomp_notif_resp {
@@ -3226,6 +3228,8 @@ TEST(user_notification_basic)
 		req.pid = 0;
 		EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 	}
+	EXPECT_EQ(pid, req.pid);
+	EXPECT_EQ(pid, req.tgid);
 
 	pollfd.fd = listener;
 	pollfd.events = POLLIN | POLLOUT;
@@ -3453,6 +3457,7 @@ TEST(user_notification_child_pid_ns)
 
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 	EXPECT_EQ(req.pid, pid);
+	EXPECT_EQ(req.tgid, pid);
 
 	resp.id = req.id;
 	resp.error = 0;
@@ -3686,6 +3691,51 @@ TEST(user_notification_continue)
 	}
 }
 
+void *getppid_thread(void *arg)
+{
+	int *tid = arg;
+
+	*tid = syscall(__NR_gettid);
+	if (*tid <= 0)
+		return (void *)(long)errno;
+	return NULL;
+}
+
+TEST(user_notification_groupleader)
+{
+	struct seccomp_notif_resp resp = {};
+	struct seccomp_notif req = {};
+	int ret, listener, tid, pid;
+	pthread_t thread;
+	void *status;
+
+	pid = getpid();
+	ASSERT_GT(pid, 0);
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_trap_syscall(__NR_gettid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	ASSERT_EQ(0, pthread_create(&thread, NULL, getppid_thread, &tid));
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	resp.id = req.id;
+	resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	ASSERT_EQ(0, pthread_join(thread, &status));
+	ASSERT_EQ(0, status);
+
+	EXPECT_EQ(tid, req.pid);
+	EXPECT_EQ(pid, req.tgid);
+}
+
+
 /*
  * TODO:
  * - add microbenchmarks
-- 
2.20.1

