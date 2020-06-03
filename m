Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C477C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F530206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="MA3GSCsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgFCBNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgFCBNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:13:39 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4183FC08C5C3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 18:13:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f3so401255pfd.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 18:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+59owfc1kfwUQmXrWsFZ88Gj/vvbkDCiHlNMmcCSSdQ=;
        b=MA3GSCswyu++/KSXfQucWqe3bPqVm8H1OFBAVHdQh7mSpdt2pIR9Y+zSy8rF4+NbtM
         67cgLBLE1vYftoxcOJnOyO/mveyZq3yilJEQDJyKcLozP7t80+XbN1tCQj6x6pQLt25P
         PzSIMc529vLERmNd52ke0S4GvnPPkytABZ5SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+59owfc1kfwUQmXrWsFZ88Gj/vvbkDCiHlNMmcCSSdQ=;
        b=KYZ6F9aQnRukpZcT2uUzKUA1dypo9rFygl2B0b9VIg+Eg1zD30NNKLetpKm7ojUSPs
         WiLH0lKvwatqjsSwCGFhhTAYLbb7c/+vByQXVEjAwklKOWUEYYlFmW85yp2XcayaITIZ
         AXXB99jcoPAytLX03sqbAeuVJBLrkEyApSxmAMdUCK5XKz0FCv6lB0AEPxbl6ad6KqpE
         r6qWxlgYbVj9OzNTpgoOt6WRZwoq+GW/3z5HH9I5z4r2rIN0XYStk/pANZvc0Rnxw/q5
         mdCTtkxJ+A66KsAjwkzEYWankPEgD7W1BRao03VHRRGEkExCvWLpUNUQLqYL5VasSzkP
         7Ayw==
X-Gm-Message-State: AOAM532AoNbgPZYgfbgD3jVchFAxz8lQ4oJuPR9p1j5rZg2d+DSGJGNH
        U4J7c6lgOcr7rPeVW4hYAZ1dWg==
X-Google-Smtp-Source: ABdhPJwckHAc8V9MBQtC6yo7HcEMaJ9lBJTETreQJvAVJAA4IqhSbgVvN3lZo1k6FmnbUjDCAirO5Q==
X-Received: by 2002:a17:90a:b949:: with SMTP id f9mr2185235pjw.79.1591146817924;
        Tue, 02 Jun 2020 18:13:37 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id a12sm263222pjw.35.2020.06.02.18.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 18:13:37 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>,
        "David S . Miller" <davem@davemloft.net>,
        John Fastabend <john.r.fastabend@intel.com>,
        Tejun Heo <tj@kernel.org>, stable@vger.kernel.org,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/4] fs, net: Standardize on file_receive helper to move fds across processes
Date:   Tue,  2 Jun 2020 18:10:41 -0700
Message-Id: <20200603011044.7972-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011044.7972-1-sargun@sargun.me>
References: <20200603011044.7972-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously there were two chunks of code where the logic to receive file
descriptors was duplicated in net. The compat version of copying
file descriptors via SCM_RIGHTS did not have logic to update cgroups.
Logic to change the cgroup data was added in:
commit 48a87cc26c13 ("net: netprio: fd passed in SCM_RIGHTS datagram not set correctly")
commit d84295067fc7 ("net: net_cls: fd passed in SCM_RIGHTS datagram not set correctly")

This was not copied to the compat path. This commit fixes that, and thus
should be cherry-picked into stable.

This introduces a helper (file_receive) which encapsulates the logic for
handling calling security hooks as well as manipulating cgroup information.
This helper can then be used other places in the kernel where file
descriptors are copied between processes

I tested cgroup classid setting on both the compat (x32) path, and the
native path to ensure that when moving the file descriptor the classid
is set.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Suggested-by: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jann Horn <jannh@google.com>,
Cc: John Fastabend <john.r.fastabend@intel.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Tycho Andersen <tycho@tycho.ws>
Cc: stable@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/file.c            | 35 +++++++++++++++++++++++++++++++++++
 include/linux/file.h |  1 +
 net/compat.c         | 10 +++++-----
 net/core/scm.c       | 14 ++++----------
 4 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index abb8b7081d7a..5afd76fca8c2 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -18,6 +18,9 @@
 #include <linux/bitops.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
+#include <net/sock.h>
+#include <net/netprio_cgroup.h>
+#include <net/cls_cgroup.h>
 
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
 unsigned int sysctl_nr_open_min = BITS_PER_LONG;
@@ -931,6 +934,38 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	return err;
 }
 
+/*
+ * File Receive - Receive a file from another process
+ *
+ * This function is designed to receive files from other tasks. It encapsulates
+ * logic around security and cgroups. The file descriptor provided must be a
+ * freshly allocated (unused) file descriptor.
+ *
+ * This helper does not consume a reference to the file, so the caller must put
+ * their reference.
+ *
+ * Returns 0 upon success.
+ */
+int file_receive(int fd, struct file *file)
+{
+	struct socket *sock;
+	int err;
+
+	err = security_file_receive(file);
+	if (err)
+		return err;
+
+	fd_install(fd, get_file(file));
+
+	sock = sock_from_file(file, &err);
+	if (sock) {
+		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
+		sock_update_classid(&sock->sk->sk_cgrp_data);
+	}
+
+	return 0;
+}
+
 static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
diff --git a/include/linux/file.h b/include/linux/file.h
index 142d102f285e..7b56dc23e560 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -94,4 +94,5 @@ extern void fd_install(unsigned int fd, struct file *file);
 extern void flush_delayed_fput(void);
 extern void __fput_sync(struct file *);
 
+extern int file_receive(int fd, struct file *file);
 #endif /* __LINUX_FILE_H */
diff --git a/net/compat.c b/net/compat.c
index 4bed96e84d9a..8ac0e7e09208 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -293,9 +293,6 @@ void scm_detach_fds_compat(struct msghdr *kmsg, struct scm_cookie *scm)
 
 	for (i = 0, cmfptr = (int __user *) CMSG_COMPAT_DATA(cm); i < fdmax; i++, cmfptr++) {
 		int new_fd;
-		err = security_file_receive(fp[i]);
-		if (err)
-			break;
 		err = get_unused_fd_flags(MSG_CMSG_CLOEXEC & kmsg->msg_flags
 					  ? O_CLOEXEC : 0);
 		if (err < 0)
@@ -306,8 +303,11 @@ void scm_detach_fds_compat(struct msghdr *kmsg, struct scm_cookie *scm)
 			put_unused_fd(new_fd);
 			break;
 		}
-		/* Bump the usage count and install the file. */
-		fd_install(new_fd, get_file(fp[i]));
+		err = file_receive(new_fd, fp[i]);
+		if (err) {
+			put_unused_fd(new_fd);
+			break;
+		}
 	}
 
 	if (i > 0) {
diff --git a/net/core/scm.c b/net/core/scm.c
index dc6fed1f221c..ba93abf2881b 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -303,11 +303,7 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
 	for (i=0, cmfptr=(__force int __user *)CMSG_DATA(cm); i<fdmax;
 	     i++, cmfptr++)
 	{
-		struct socket *sock;
 		int new_fd;
-		err = security_file_receive(fp[i]);
-		if (err)
-			break;
 		err = get_unused_fd_flags(MSG_CMSG_CLOEXEC & msg->msg_flags
 					  ? O_CLOEXEC : 0);
 		if (err < 0)
@@ -318,13 +314,11 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
 			put_unused_fd(new_fd);
 			break;
 		}
-		/* Bump the usage count and install the file. */
-		sock = sock_from_file(fp[i], &err);
-		if (sock) {
-			sock_update_netprioidx(&sock->sk->sk_cgrp_data);
-			sock_update_classid(&sock->sk->sk_cgrp_data);
+		err = file_receive(new_fd, fp[i]);
+		if (err) {
+			put_unused_fd(new_fd);
+			break;
 		}
-		fd_install(new_fd, get_file(fp[i]));
 	}
 
 	if (i > 0)
-- 
2.25.1

