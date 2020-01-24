Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0572CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E922075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="oZTfK+0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgAXJSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:18:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32976 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730472AbgAXJSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:18:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so531501plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 01:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TDhZOynphy0Xvg7HBFwMit+7T95Klu1aHNq+emyqScw=;
        b=oZTfK+0R9osykxEjXoqEbNQUJ5lcI2m5Dxd353uZ6PMoi0srFVVHS4xlpewzOZBlCd
         h2OeSekdmtI79yAesYPvDV1obfIocx6fvTkDvTxADV0Kx8CmqZOREgDK9wCWMWRQbpfV
         p3BD0HIdAxfbmwdD+t59IlHxBxxwPFJ/bou/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDhZOynphy0Xvg7HBFwMit+7T95Klu1aHNq+emyqScw=;
        b=L1EfQ8HocAq5qyMPs25r209yWLjnMZQ+rk4eKTnA7iqjhcfxwrIP/WteIZmBQHaQV0
         4GWBOp4BOuerefzhd1Iutn/BIBAifH8ZXI3lE0atOdFxsuYPGNYQJioHW67+748o9q1C
         TyC0Uufq/U12NrE+Rq+u3nzIHiydGVZl8pgqwNfeN/vAEixzSKi5H98wap1xKnRDPale
         zaS3JpA1tVcuWXcIbm+ottBuOhUpuwahqJvZIWvG7EthFxM/mn5YBBYYUqEEI1ieoFdU
         EMjKElIQdATbAkvEVWoCV5xHR7l3XZ6YxDMw6w3JK9IygUFZfocbj70NCeRjf4KKChAe
         nPeA==
X-Gm-Message-State: APjAAAW4pqbVfxX1+EVDgIDiFRNtaQ6p7QG8Qfyuand6hGRKxyF5foas
        Uc9bHg6c5hvkkaq2/Uigj3yT4Sg8xJtd0A==
X-Google-Smtp-Source: APXvYqwmQP77Au3LiyBaC3XXFTOjaXFNgQqwJ1tgJrZlb420ZkuKKggGBamaR8yBl67yfH6RdBOOZg==
X-Received: by 2002:a17:90a:7f86:: with SMTP id m6mr2180124pjl.143.1579857482208;
        Fri, 24 Jan 2020 01:18:02 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id y14sm5459507pfe.147.2020.01.24.01.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 01:18:01 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        christian.brauner@ubuntu.com
Subject: [PATCH 3/4] seccomp: Add SECCOMP_USER_NOTIF_FLAG_PIDFD to get pidfd on listener trap
Date:   Fri, 24 Jan 2020 01:17:42 -0800
Message-Id: <20200124091743.3357-4-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124091743.3357-1-sargun@sargun.me>
References: <20200124091743.3357-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces the capability for users of seccomp's listener behaviour
to be able to receive the pidfd of the process that triggered the event.
Currently, this just opens the group leader of the thread that triggere
the event, as pidfds (currently) are limited to group leaders.

For actions which do not act on the process outside of the pidfd, there
is then no need to check the cookie to ensure validity of the request
throughout the listener's handling of it.

This can be extended later on as well when pidfd capabilities are added
to be able to have the listener imbue the pidfd with certain capabilities
when it is delivered to userspace.

It is the responsibility of the user to close the pidfd.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/uapi/linux/seccomp.h |  4 +++
 kernel/seccomp.c             | 68 ++++++++++++++++++++++++++++++++----
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index be84d87f1f46..64f6fc5c95f1 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -69,11 +69,15 @@ struct seccomp_notif_sizes {
 	__u16 seccomp_data;
 };
 
+/* Valid flags for struct seccomp_notif */
+#define SECCOMP_USER_NOTIF_FLAG_PIDFD	(1UL << 0) /* populate pidfd */
+
 struct seccomp_notif {
 	__u64 id;
 	__u32 pid;
 	__u32 flags;
 	struct seccomp_data data;
+	__u32 pidfd;
 };
 
 /*
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index b6ea3dcb57bf..93f9cf45ce07 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1019,21 +1019,61 @@ static int seccomp_notify_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+
+static long __seccomp_notify_recv_pidfd(void __user *buf,
+					struct seccomp_notif *unotif,
+					struct task_struct *group_leader)
+{
+	struct file *pidfd_file;
+	struct pid *pid;
+	int fd;
+
+	pid = get_task_pid(group_leader, PIDTYPE_PID);
+	pidfd_file = pidfd_create_file(pid);
+	put_pid(pid);
+	if (IS_ERR(pidfd_file))
+		return PTR_ERR(pidfd_file);
+
+	fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		fput(pidfd_file);
+		return fd;
+	}
+
+	unotif->pidfd = fd;
+
+	if (copy_to_user(buf, unotif, sizeof(*unotif))) {
+		put_unused_fd(fd);
+		fput(pidfd_file);
+		return -EFAULT;
+	}
+
+	fd_install(fd, pidfd_file);
+
+	return 0;
+}
+
 static long seccomp_notify_recv(struct seccomp_filter *filter,
 				void __user *buf)
 {
 	struct seccomp_knotif *knotif = NULL, *cur;
 	struct seccomp_notif unotif;
+	struct task_struct *group_leader;
+	bool send_pidfd;
 	ssize_t ret;
 
+	if (copy_from_user(&unotif, buf, sizeof(unotif)))
+		return -EFAULT;
 	/* Verify that we're not given garbage to keep struct extensible. */
-	ret = check_zeroed_user(buf, sizeof(unotif));
-	if (ret < 0)
-		return ret;
-	if (!ret)
+	if (unotif.id ||
+	    unotif.pid ||
+	    memchr_inv(&unotif.data, 0, sizeof(unotif.data)) ||
+	    unotif.pidfd)
+		return -EINVAL;
+	if (unotif.flags & ~(SECCOMP_USER_NOTIF_FLAG_PIDFD))
 		return -EINVAL;
 
-	memset(&unotif, 0, sizeof(unotif));
+	send_pidfd = unotif.flags & SECCOMP_USER_NOTIF_FLAG_PIDFD;
 
 	ret = down_interruptible(&filter->notif->request);
 	if (ret < 0)
@@ -1057,9 +1097,13 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 		goto out;
 	}
 
+	memset(&unotif, 0, sizeof(unotif));
+
 	unotif.id = knotif->id;
 	unotif.pid = task_pid_vnr(knotif->task);
 	unotif.data = *(knotif->data);
+	if (send_pidfd)
+		group_leader = get_task_struct(knotif->task->group_leader);
 
 	knotif->state = SECCOMP_NOTIFY_SENT;
 	wake_up_poll(&filter->notif->wqh, EPOLLOUT | EPOLLWRNORM);
@@ -1067,9 +1111,21 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 out:
 	mutex_unlock(&filter->notify_lock);
 
-	if (ret == 0 && copy_to_user(buf, &unotif, sizeof(unotif))) {
+	if (ret)
+		return ret;
+
+	/*
+	 * We've successfully received a notification, let's try to copy it to
+	 * userspace.
+	 */
+	if (send_pidfd) {
+		ret = __seccomp_notify_recv_pidfd(buf, &unotif, group_leader);
+		put_task_struct(group_leader);
+	} else if (copy_to_user(buf, &unotif, sizeof(unotif))) {
 		ret = -EFAULT;
+	}
 
+	if (ret) {
 		/*
 		 * Userspace screwed up. To make sure that we keep this
 		 * notification alive, let's reset it back to INIT. It
-- 
2.20.1

