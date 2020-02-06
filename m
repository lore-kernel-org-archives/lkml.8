Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAFDC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776CE21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="fuFeVnZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBFQug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:50:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43799 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgBFQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:50:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id u131so3013261pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 08:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BTslkJ1WbON33pGmdcwslSFQo5hXkHAsY1mvL9U4jzg=;
        b=fuFeVnZ03NYX6utKFJzeS6K0ZOTDmf+kBK1gyNBUAMEI81FTYZqMq7luf2Md4PcG0w
         HMJ8DQUR70GhfXfi16P/opDnJtK9JEGVgKfW/iUe7ON1+kTXrXuvum8wQobHTNbJpZpg
         3f6o1GN/BASsQXd60C/9WFtuzoUxovtc4PsTE8CevO9C2DRu59Y+945vyUh0NVUps2VO
         HSGtvPuqtNSGjR/Cwya0+0hCmCgkgAp3r6Hf2k5hUvc3x4LqA4kWlpThKlt1ZQSkOlFl
         7n9Hgop/9lps1PeAFAdpgRGLaZzWWT/L5Rg7TmjdD33OspjjT4Sd6jW7F5e5g0nbFSfR
         cd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BTslkJ1WbON33pGmdcwslSFQo5hXkHAsY1mvL9U4jzg=;
        b=j6wCfWNJrwR5FES1+JZg9yL/iwlevN6ofS/h5SyvaGPKXbp177WkT/+FmEErGOayUn
         SLZAG5QOw7eHMCpMtnFRBcqJxNV3X3KDjb10tknBfCp6+lqImQl9OWbH/iiBkE0I8ktl
         +SYR1yB4nuG+kgvlnuCWELjWximT0iN+bOkFxdBr/LACzu0RqBCOpimn5Hz5Ovr6b1GL
         jnJ19wSlMX2g1KIM7I40eIcCLRDSsUsh8//u4mSdh3ZuJ5klUaZ1jZNBIl70qIjI5MY6
         fD+JZskMULF/MPvOADoKlb3LoCIxjwosfMBgcPxSFUejO61CBwDGsu3lw8JwzToMBGJM
         62Fw==
X-Gm-Message-State: APjAAAUClOxQPYMrO+gKw/7F2lfHQmeiNCeyvVbg4MZGnFMCUT4NdKUA
        5T4ij4tSeE9Pyqk8FvKi9Iicvg==
X-Google-Smtp-Source: APXvYqyN6gEhmH+yU6Tr2TFk6HyR9YxWg3Vi66sRL6YkSo44q/t7g3Lyice0mA+7orG4XreylTBY8g==
X-Received: by 2002:aa7:9829:: with SMTP id q9mr4937411pfl.31.1581007834593;
        Thu, 06 Feb 2020 08:50:34 -0800 (PST)
Received: from cisco.hsd1.co.comcast.net ([2001:420:c0c8:1001::4bd])
        by smtp.gmail.com with ESMTPSA id l69sm4140569pgd.1.2020.02.06.08.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 08:50:33 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Matthew Denton <mpdenton@google.com>
Subject: [PATCH] seccomp: allow TSYNC and USER_NOTIF together
Date:   Thu,  6 Feb 2020 09:50:27 -0700
Message-Id: <20200206165027.18415-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The restriction introduced in 7a0df7fbc145 ("seccomp: Make NEW_LISTENER and
TSYNC flags exclusive") is mostly artificial: there is enough information
in a seccomp user notification to tell which thread triggered a
notification. The reason it was introduced is because TSYNC makes the
syscall return a thread-id on failure, and NEW_LISTENER returns an fd, and
there's no way to distinguish between these two cases (well, I suppose the
caller could check all fds it has, then do the syscall, and if the return
value was an fd that already existed, then it must be a thread id, but
bleh).

Matthew would like to use these two flags together in the Chrome sandbox
which wants to use TSYNC for video drivers and NEW_LISTENER to proxy
syscalls.

So, let's fix this ugliness by adding another flag, NO_TID_ON_TSYNC_ERR,
which tells the kernel to just return -EAGAIN on a TSYNC error. This way,
NEW_LISTENER (and any subsequent seccomp() commands that want to return
positive values) don't conflict with each other.

Suggested-by: Matthew Denton <mpdenton@google.com>
Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 include/linux/seccomp.h                       |  3 +-
 include/uapi/linux/seccomp.h                  |  1 +
 kernel/seccomp.c                              | 14 +++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 74 ++++++++++++++++++-
 4 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 03583b6d1416..e0560a941ed1 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -7,7 +7,8 @@
 #define SECCOMP_FILTER_FLAG_MASK	(SECCOMP_FILTER_FLAG_TSYNC | \
 					 SECCOMP_FILTER_FLAG_LOG | \
 					 SECCOMP_FILTER_FLAG_SPEC_ALLOW | \
-					 SECCOMP_FILTER_FLAG_NEW_LISTENER)
+					 SECCOMP_FILTER_FLAG_NEW_LISTENER | \
+					 SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR)
 
 #ifdef CONFIG_SECCOMP
 
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index be84d87f1f46..64678cc20e18 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -22,6 +22,7 @@
 #define SECCOMP_FILTER_FLAG_LOG			(1UL << 1)
 #define SECCOMP_FILTER_FLAG_SPEC_ALLOW		(1UL << 2)
 #define SECCOMP_FILTER_FLAG_NEW_LISTENER	(1UL << 3)
+#define SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR	(1UL << 4)
 
 /*
  * All BPF programs must return a 32-bit value.
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index b6ea3dcb57bf..fa01ec085d60 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -528,8 +528,12 @@ static long seccomp_attach_filter(unsigned int flags,
 		int ret;
 
 		ret = seccomp_can_sync_threads();
-		if (ret)
-			return ret;
+		if (ret) {
+			if (flags & SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR)
+				return -EAGAIN;
+			else
+				return ret;
+		}
 	}
 
 	/* Set log flag, if present. */
@@ -1288,10 +1292,12 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	 * In the successful case, NEW_LISTENER returns the new listener fd.
 	 * But in the failure case, TSYNC returns the thread that died. If you
 	 * combine these two flags, there's no way to tell whether something
-	 * succeeded or failed. So, let's disallow this combination.
+	 * succeeded or failed. So, let's disallow this combination if the user
+	 * has not explicitly requested no errors from TSYNC.
 	 */
 	if ((flags & SECCOMP_FILTER_FLAG_TSYNC) &&
-	    (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER))
+	    (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) &&
+	    ((flags & SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR) == 0))
 		return -EINVAL;
 
 	/* Prepare the new filter before holding any locks. */
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index ee1b727ede04..b7ec8655dd1c 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -212,6 +212,10 @@ struct seccomp_notif_sizes {
 #define SECCOMP_USER_NOTIF_FLAG_CONTINUE 0x00000001
 #endif
 
+#ifndef SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR
+#define SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR (1UL << 4)
+#endif
+
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
@@ -2187,7 +2191,8 @@ TEST(detect_seccomp_filter_flags)
 	unsigned int flags[] = { SECCOMP_FILTER_FLAG_TSYNC,
 				 SECCOMP_FILTER_FLAG_LOG,
 				 SECCOMP_FILTER_FLAG_SPEC_ALLOW,
-				 SECCOMP_FILTER_FLAG_NEW_LISTENER };
+				 SECCOMP_FILTER_FLAG_NEW_LISTENER,
+				 SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR };
 	unsigned int exclusive[] = {
 				SECCOMP_FILTER_FLAG_TSYNC,
 				SECCOMP_FILTER_FLAG_NEW_LISTENER };
@@ -2645,6 +2650,55 @@ TEST_F(TSYNC, two_siblings_with_one_divergence)
 	EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
 }
 
+TEST_F(TSYNC, two_siblings_with_one_divergence_no_tid_in_err)
+{
+	long ret, flags;
+	void *status;
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, 0, &self->root_prog);
+	ASSERT_NE(ENOSYS, errno) {
+		TH_LOG("Kernel does not support seccomp syscall!");
+	}
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support SECCOMP_SET_MODE_FILTER!");
+	}
+	self->sibling[0].diverge = 1;
+	tsync_start_sibling(&self->sibling[0]);
+	tsync_start_sibling(&self->sibling[1]);
+
+	while (self->sibling_count < TSYNC_SIBLINGS) {
+		sem_wait(&self->started);
+		self->sibling_count++;
+	}
+
+	flags = SECCOMP_FILTER_FLAG_TSYNC | \
+		SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &self->apply_prog);
+	ASSERT_EQ(EAGAIN, errno) {
+		TH_LOG("Did not return EAGAIN for diverged sibling.");
+	}
+	ASSERT_EQ(-1, ret) {
+		TH_LOG("Did not fail on diverged sibling.");
+	}
+
+	/* Wake the threads */
+	pthread_mutex_lock(&self->mutex);
+	ASSERT_EQ(0, pthread_cond_broadcast(&self->cond)) {
+		TH_LOG("cond broadcast non-zero");
+	}
+	pthread_mutex_unlock(&self->mutex);
+
+	/* Ensure they are both unkilled. */
+	PTHREAD_JOIN(self->sibling[0].tid, &status);
+	EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
+	PTHREAD_JOIN(self->sibling[1].tid, &status);
+	EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
+}
+
 TEST_F(TSYNC, two_siblings_not_under_filter)
 {
 	long ret, sib;
@@ -3196,6 +3250,24 @@ TEST(user_notification_basic)
 	EXPECT_EQ(0, WEXITSTATUS(status));
 }
 
+TEST(user_notification_with_tsync)
+{
+	int ret;
+	unsigned int flags;
+
+	/* these were exclusive */
+	flags = SECCOMP_FILTER_FLAG_NEW_LISTENER |
+		SECCOMP_FILTER_FLAG_TSYNC;
+	ASSERT_EQ(-1, user_trap_syscall(__NR_getppid, flags));
+	ASSERT_EQ(EINVAL, errno);
+
+	/* but now they're not */
+	flags |= SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR;
+	ret = user_trap_syscall(__NR_getppid, flags);
+	close(ret);
+	ASSERT_LE(0, ret);
+}
+
 TEST(user_notification_kill_in_middle)
 {
 	pid_t pid;
-- 
2.20.1

