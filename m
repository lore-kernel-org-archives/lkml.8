Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E44C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B18C24658
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="LsM24t+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgCDSFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:05:32 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34029 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDSFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:05:32 -0500
Received: by mail-io1-f68.google.com with SMTP id z190so3441508iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 10:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sz+O6Lps0umEnNJFXdC0/3SyI4P+h3cIR2fD8N7Z8Oc=;
        b=LsM24t+U3SbW8TYzGQtgi6Xdmy3odzfnzALIsAN+k8UnUlOsLUmvk8gj/Y5BtVjGBV
         WHAB3wC5ENz09O/oE9tIZJK5RTBtdNMxLfzdmuqTwC/5UzPmHl982t2/KrFBkW791xSe
         38/X1RhMzJAcTqoWs98wXfkhp6JHCaU5kjfFpMeyBA5f3PADOCy8iQp53Lh2Wd025D7n
         5wBIzSI/QRnrrRXRTFmYudYeYcQV5sS0UOhlpbBtUCdN2QR2exkeZ0QiplFXXMM/a8F/
         2jiYHWEIu3Ejr+2sRX+/6+aXtQiQih/y0Lomw1gdttcO3p0zEVhy5lIVVwPUF/lQCmH1
         8iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sz+O6Lps0umEnNJFXdC0/3SyI4P+h3cIR2fD8N7Z8Oc=;
        b=DmOqjFusJRhri/Jm8qSxpRV1eNPJd0tB4Ce/zycCHV3XS5AelWzgYKlAh87oZ79x8G
         EG+qBD1gJ6Xh7dbT6inJ7yUxfVBPJVLZ24XoNX6i9r2s9RSEXFiZgxAJKLnmqPzhzmSN
         yPScnLzD6cg64Kii8Zs+emstVQcaAhMAJ8Xij55zt17GPieHTo9HnJZkRBU4hU/096+j
         YgEj1JH50YX2WN9yOhBcyCzVvJzwtm6JP1IctkNN4OZdS8QQ7JXFWAdPTmXP0fAP8KX/
         wA3BFC2Qg6JFvXIsmfYmGlfgFeQ5c/QwYID+rQXls6pEuAka1JPJaYzm4jUa+m2JxYvK
         T55w==
X-Gm-Message-State: ANhLgQ0xTBv0fpNqVLe7R3hxA11txX8qvV2crzp3M7+29CKBq7o7xBjH
        aKgBpLN6dib285TqzH9pnVOyWw==
X-Google-Smtp-Source: ADFU+vuP5V/jMKApNiDG6nnsRKd+fZMLFHBOZpM3cZAQGnCTZJuzRjpNjxI5dNzT/tehFDwXHoldOg==
X-Received: by 2002:a02:240c:: with SMTP id f12mr3824740jaa.65.1583345130996;
        Wed, 04 Mar 2020 10:05:30 -0800 (PST)
Received: from cisco.hsd1.co.comcast.net ([2601:282:902:b340:1002:9a44:e2a2:4464])
        by smtp.gmail.com with ESMTPSA id h8sm6826360iof.18.2020.03.04.10.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:05:29 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Matthew Denton <mpdenton@google.com>
Subject: [PATCH v2] seccomp: allow TSYNC and USER_NOTIF together
Date:   Wed,  4 Mar 2020 11:05:17 -0700
Message-Id: <20200304180517.23867-1-tycho@tycho.ws>
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

So, let's fix this ugliness by adding another flag, TSYNC_ESRCH, which
tells the kernel to just return -ESRCH on a TSYNC error. This way,
NEW_LISTENER (and any subsequent seccomp() commands that want to return
positive values) don't conflict with each other.

Suggested-by: Matthew Denton <mpdenton@google.com>
Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
v2: s/NO_TID_ON_TSYNC_ERR/TSYNC_ESRCH/g, s/EAGAIN/ESRCH/g from Kees
---
 include/linux/seccomp.h                       |  3 +-
 include/uapi/linux/seccomp.h                  |  1 +
 kernel/seccomp.c                              | 14 +++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 74 ++++++++++++++++++-
 4 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 03583b6d1416..4192369b8418 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -7,7 +7,8 @@
 #define SECCOMP_FILTER_FLAG_MASK	(SECCOMP_FILTER_FLAG_TSYNC | \
 					 SECCOMP_FILTER_FLAG_LOG | \
 					 SECCOMP_FILTER_FLAG_SPEC_ALLOW | \
-					 SECCOMP_FILTER_FLAG_NEW_LISTENER)
+					 SECCOMP_FILTER_FLAG_NEW_LISTENER | \
+					 SECCOMP_FILTER_FLAG_TSYNC_ESRCH)
 
 #ifdef CONFIG_SECCOMP
 
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index be84d87f1f46..c1735455bc53 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -22,6 +22,7 @@
 #define SECCOMP_FILTER_FLAG_LOG			(1UL << 1)
 #define SECCOMP_FILTER_FLAG_SPEC_ALLOW		(1UL << 2)
 #define SECCOMP_FILTER_FLAG_NEW_LISTENER	(1UL << 3)
+#define SECCOMP_FILTER_FLAG_TSYNC_ESRCH		(1UL << 4)
 
 /*
  * All BPF programs must return a 32-bit value.
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index b6ea3dcb57bf..29022c1bbe18 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -528,8 +528,12 @@ static long seccomp_attach_filter(unsigned int flags,
 		int ret;
 
 		ret = seccomp_can_sync_threads();
-		if (ret)
-			return ret;
+		if (ret) {
+			if (flags & SECCOMP_FILTER_FLAG_TSYNC_ESRCH)
+				return -ESRCH;
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
+	    ((flags & SECCOMP_FILTER_FLAG_TSYNC_ESRCH) == 0))
 		return -EINVAL;
 
 	/* Prepare the new filter before holding any locks. */
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index ee1b727ede04..a9ad3bd8b2ad 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -212,6 +212,10 @@ struct seccomp_notif_sizes {
 #define SECCOMP_USER_NOTIF_FLAG_CONTINUE 0x00000001
 #endif
 
+#ifndef SECCOMP_FILTER_FLAG_TSYNC_ESRCH
+#define SECCOMP_FILTER_FLAG_TSYNC_ESRCH (1UL << 4)
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
+				 SECCOMP_FILTER_FLAG_TSYNC_ESRCH };
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
+		SECCOMP_FILTER_FLAG_TSYNC_ESRCH;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &self->apply_prog);
+	ASSERT_EQ(ESRCH, errno) {
+		TH_LOG("Did not return ESRCH for diverged sibling.");
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
+	flags |= SECCOMP_FILTER_FLAG_TSYNC_ESRCH;
+	ret = user_trap_syscall(__NR_getppid, flags);
+	close(ret);
+	ASSERT_LE(0, ret);
+}
+
 TEST(user_notification_kill_in_middle)
 {
 	pid_t pid;

base-commit: 98d54f81e36ba3bf92172791eba5ca5bd813989b
-- 
2.20.1

