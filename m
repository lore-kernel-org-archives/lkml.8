Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFF8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB43F20657
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F0pFYG7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGJXBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGJXBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:01:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE480C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:01:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so3159277pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJc4QERnOgktMF7NqBZjFQHDM5ibkAymhVFvz1eDOmI=;
        b=F0pFYG7+McnKe83941AK8NN4lM4MoyXsDbWy65c09PV1lBw7xVYl0AMgw5QSkOnrJe
         Nwrwtsqvg08baI19s2fDAGmvtoL1rXIyVgD9PID1HW49OQGuQkuUJpQbd9SQQ4MzHVzw
         m7c2lLHklIqQTAETql0ByTPy9X928C9v8zpp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJc4QERnOgktMF7NqBZjFQHDM5ibkAymhVFvz1eDOmI=;
        b=e0XjRw7gwca9nz1NAqxf/5eWvL+dwzaUP3czN3MRyuNsysz+6RJdHfnDh5vgJW3SrV
         P08SEZ4+RBoeav2Al2XCW8vC7mEp7E7+drZ3zQ6hnyX5GgFwz7ZAQ0C+WW5h6INy2kw7
         8oSpXKPyjLdOiMSkQwRMD/ZEv4KP0H0x65OghZRGqunmDUs4DNmPjxFqPwnKLTQJq7fN
         MSmEf21AJZo47ljDySIistcV0j60r/SIQy6jPpOL3DNqAD3fPboxN6AC6oQRuGYL4QUX
         63HGgfaHwm3EIjSaO19pNUWmH1QPcxVPWZuKfPrjJIEkakXmHY0ZOFIjlw9/L8K8imO8
         1agQ==
X-Gm-Message-State: AOAM532CWvHRYDqbMG4xmedpw6mAXJqEsDuE//4vUkWa7zK8M2NJLuYb
        giLs2dCDhKptKcsppDxKNujqzw==
X-Google-Smtp-Source: ABdhPJy3YT7KkX4oNIVxegNkh5Z8UYtYGphPRPSA5jmBHeGfmGico3ihLD+kNSyKs3e9ilotKrp3Ig==
X-Received: by 2002:a62:ab17:: with SMTP id p23mr48997593pff.177.1594422072450;
        Fri, 10 Jul 2020 16:01:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e5sm6568941pjv.18.2020.07.10.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:01:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Tycho Andersen <tycho@tycho.ws>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-next/seccomp v2 1/2] selftests/seccomp: Add SKIPs for failed unshare()
Date:   Fri, 10 Jul 2020 16:01:06 -0700
Message-Id: <20200710230107.2528890-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710230107.2528890-1-keescook@chromium.org>
References: <20200710230107.2528890-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running the seccomp tests as a regular user shouldn't just fail tests
that require CAP_SYS_ADMIN (for getting a PID namespace). Instead,
detect those cases and SKIP them. Additionally, gracefully SKIP missing
CONFIG_USER_NS (and add to "config" since we'd prefer to actually test
this case).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/config        |  1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/config b/tools/testing/selftests/seccomp/config
index db1e11b08c8a..64c19d8eba79 100644
--- a/tools/testing/selftests/seccomp/config
+++ b/tools/testing/selftests/seccomp/config
@@ -1,2 +1,3 @@
 CONFIG_SECCOMP=y
 CONFIG_SECCOMP_FILTER=y
+CONFIG_USER_NS=y
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index c0aa46ce14f6..14b038361549 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3439,7 +3439,10 @@ TEST(user_notification_child_pid_ns)
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
 
-	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0);
+	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0) {
+		if (errno == EINVAL)
+			SKIP(return, "kernel missing CLONE_NEWUSER support");
+	};
 
 	listener = user_trap_syscall(__NR_getppid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
@@ -3504,7 +3507,10 @@ TEST(user_notification_sibling_pid_ns)
 	}
 
 	/* Create the sibling ns, and sibling in it. */
-	ASSERT_EQ(unshare(CLONE_NEWPID), 0);
+	ASSERT_EQ(unshare(CLONE_NEWPID), 0) {
+		if (errno == EPERM)
+			SKIP(return, "CLONE_NEWPID requires CAP_SYS_ADMIN");
+	}
 	ASSERT_EQ(errno, 0);
 
 	pid2 = fork();
-- 
2.25.1

