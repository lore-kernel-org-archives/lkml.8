Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDEEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF222076A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IlQ4B4jG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgFJEws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 00:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgFJEw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 00:52:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F90C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 21:52:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d66so565647pfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 21:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkHFge5iGK3mXqFQgWET256fV3n4uLgYr5BgBuJjdss=;
        b=IlQ4B4jGpjVFzCfBAY1AhKLFFo7mRBGt6zmf8hjNQZEYkpLOR23fIxG7ZEtmNrekBj
         JA2hXD3nOqt1gbawN3hC+RLfEgXW4vBqnoN6O7hdNd7g04N953l3sGGZGdNw8o4I3fXb
         n8V1qyNZiLQ0SeYG9gtTyHO/79Vdo63tOZguw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkHFge5iGK3mXqFQgWET256fV3n4uLgYr5BgBuJjdss=;
        b=m2sgtxmAp96d0A4HuKZia/MnA6SfOahVwHKPUU+YFhbdYgNi8+1LGNxWhXbs664Wmv
         pkorbRgGM8ug/SqVB+KSaxTj+FY5p3jkIZwXm6SMSvSVh+n5YrZE7wW6vp165y3FuVg4
         NGl18dWlAf/mph7puNHFKMRw75V/h7H2fOSmZiM2zh9sEcXj2xY8tV9ucbIF/srVkKig
         Hz3vDjLntQDXaSe2EeGllRtlgb7wacQ0fJx+HKsmRnRkTcJwQ/j9M9ne3ljRd1uva0qZ
         WXh2IOsGPbtWKfxarq77QzGMp90Wfga7UD2sMY9t05lR7vvjzbuOEB4AtlQtAgSgQMNi
         Y/oQ==
X-Gm-Message-State: AOAM532DbBFoSBzyudrUZg9j7sZtp9wr1UYHf6pK5nzIb8a7IVLMgwCi
        +cCXH/OLnNd/joJxHoidsPAX9w==
X-Google-Smtp-Source: ABdhPJxu2hX4QwQz9hGpKtTPg7w3unlEM3xCOJBsWcwHUi5rdHBDHfh9fqkc15w5Lq2xF2OvyzVb2Q==
X-Received: by 2002:aa7:8f1c:: with SMTP id x28mr1120001pfr.19.1591764746755;
        Tue, 09 Jun 2020 21:52:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j17sm9837217pgk.66.2020.06.09.21.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 21:52:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pidfd: Replace open-coded partial __scm_install_fd()
Date:   Tue,  9 Jun 2020 21:52:14 -0700
Message-Id: <20200610045214.1175600-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610045214.1175600-1-keescook@chromium.org>
References: <20200610045214.1175600-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sock counting (sock_update_netprioidx() and sock_update_classid())
was missing from this implementation of fd installation, compared to
SCM_RIGHTS. Use the new scm helper to get the work done, after adjusting
it to return the installed fd and accept a NULL user pointer.

Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
AFAICT, the following patches are needed for back-porting this to stable:

0462b6bdb644 ("net: add a CMSG_USER_DATA macro")
2618d530dd8b ("net/scm: cleanup scm_detach_fds")
1f466e1f15cf ("net: cleanly handle kernel vs user buffers for ->msg_control")
6e8a4f9dda38 ("net: ignore sock_from_file errors in __scm_install_fd")
---
 kernel/pid.c   | 12 ++----------
 net/compat.c   |  2 +-
 net/core/scm.c | 27 ++++++++++++++++++++-------
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index f1496b757162..a7ce4ba898d3 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -42,6 +42,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/idr.h>
+#include <net/scm.h>
 
 struct pid init_struct_pid = {
 	.count		= REFCOUNT_INIT(1),
@@ -635,18 +636,9 @@ static int pidfd_getfd(struct pid *pid, int fd)
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = security_file_receive(file);
-	if (ret) {
-		fput(file);
-		return ret;
-	}
-
-	ret = get_unused_fd_flags(O_CLOEXEC);
+	ret = __scm_install_fd(file, NULL, O_CLOEXEC);
 	if (ret < 0)
 		fput(file);
-	else
-		fd_install(ret, file);
-
 	return ret;
 }
 
diff --git a/net/compat.c b/net/compat.c
index 117f1869bf3b..f8575555b6d7 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -299,7 +299,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
 
 	for (i = 0; i < fdmax; i++) {
 		err = __scm_install_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
-		if (err)
+		if (err < 0)
 			break;
 	}
 
diff --git a/net/core/scm.c b/net/core/scm.c
index 86d96152646f..e80648fb4da7 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -280,6 +280,14 @@ void put_cmsg_scm_timestamping(struct msghdr *msg, struct scm_timestamping_inter
 }
 EXPORT_SYMBOL(put_cmsg_scm_timestamping);
 
+/**
+ * __scm_install_fd() - Install received file into file descriptor table
+ *
+ * Installs a received file into the file descriptor table, with appropriate
+ * checks and count updates.
+ *
+ * Returns fd installed or -ve on error.
+ */
 int __scm_install_fd(struct file *file, int __user *ufd, int o_flags)
 {
 	struct socket *sock;
@@ -294,20 +302,25 @@ int __scm_install_fd(struct file *file, int __user *ufd, int o_flags)
 	if (new_fd < 0)
 		return new_fd;
 
-	error = put_user(new_fd, ufd);
-	if (error) {
-		put_unused_fd(new_fd);
-		return error;
+	if (ufd) {
+		error = put_user(new_fd, ufd);
+		if (error) {
+			put_unused_fd(new_fd);
+			return error;
+		}
 	}
 
-	/* Bump the usage count and install the file. */
+	/* Bump the usage count and install the file. The resulting value of
+	 * "error" is ignored here since we only need to take action when
+	 * the file is a socket and testing "sock" for NULL is sufficient.
+	 */
 	sock = sock_from_file(file, &error);
 	if (sock) {
 		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
 		sock_update_classid(&sock->sk->sk_cgrp_data);
 	}
 	fd_install(new_fd, get_file(file));
-	return 0;
+	return new_fd;
 }
 
 static int scm_max_fds(struct msghdr *msg)
@@ -337,7 +350,7 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
 
 	for (i = 0; i < fdmax; i++) {
 		err = __scm_install_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
-		if (err)
+		if (err < 0)
 			break;
 	}
 
-- 
2.25.1

