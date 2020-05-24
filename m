Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7421C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A573D20885
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="B/rL+GXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbgEXXkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 19:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388641AbgEXXj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:39:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEACC05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:39:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu7so7802064pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TkFh/ltuSCZKIpIsO7Tn/NDZKFXDGHYiyontlywtpfI=;
        b=B/rL+GXXoD44Y6uC2o+7L7Oll3ncoP77DkflU7CuMOMuhPAZaZciH9ThUWMLEvGGBG
         x4ETO+xogPGVns5rOqi3OHrxKqd38kf21jjmtBh6zLTkl2r4PFT3l1IXWk2LKVFC0z/s
         H7UPaMvZIqV81Wc9A9E3woy/X5pPxB5bGHHSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkFh/ltuSCZKIpIsO7Tn/NDZKFXDGHYiyontlywtpfI=;
        b=l21JvknmXXTecp2rNUQs6tJ/B3Z8WUfgyuIrUj+v8gyX5w9WLhH+W5v5vCSX4H1+kn
         rfWNvb0oioAl8/cKjkq8jDO06UXI56oRVZxIT8oN6RVn8QZB+DroFzgCCczIV6BMoGsy
         ozQ5TzkvT+FDFZZKk/kKk1kTwXzZVoWO94dxCuEOvgcZmbOoJT+Cg0+74C+u8CA5643q
         0WTx+CYdnwd+6oMeDw92q54oCtkFLvH2deRHxtbUVQZvaDULMj33LBs5TIYxc9N4onNb
         +CAjzTWzexWWZXezAh9wD6/Q6p+Mg6ZIvBThAOtb4iz9diaoNyN7DEBcKeAAUhJmGfsX
         WSLw==
X-Gm-Message-State: AOAM531Fk94aaIq7S3BAoJ6KbHymSZ7Srl1sFJEd8R4s1n4EEsw9/dwb
        Qi85CE1IAesNFAzsJm0ZZkC93B3b/TwZ8af8
X-Google-Smtp-Source: ABdhPJwBufPMMSq2FzfVicuZKcyjLpKWsnUxla7t5SgLM6ZIGnT0jxlSJEN6fWz3vHMbU2n/z5+rnw==
X-Received: by 2002:a17:902:c3ca:: with SMTP id j10mr25898350plj.242.1590363598683;
        Sun, 24 May 2020 16:39:58 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b16sm11633177pfi.74.2020.05.24.16.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:39:58 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        tycho@tycho.ws, keescook@chromium.org, cyphar@cyphar.com,
        Jeffrey Vander Stoep <jeffv@google.com>, jannh@google.com,
        rsesek@google.com, palmer@google.com,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: [PATCH 5/5] selftests/seccomp: Add test for addfd move semantics
Date:   Sun, 24 May 2020 16:39:42 -0700
Message-Id: <20200524233942.8702-6-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524233942.8702-1-sargun@sargun.me>
References: <20200524233942.8702-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces another call to addfd, in which the move flag is set. It
may make sense to setup a cgroup v1 hierarchy, and check that the
netprioidx is changed.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Matt Denton <mpdenton@google.com>
Cc: Kees Cook <keescook@google.com>,
Cc: Jann Horn <jannh@google.com>,
Cc: Robert Sesek <rsesek@google.com>,
Cc: Chris Palmer <palmer@google.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Tycho Andersen <tycho@tycho.ws>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 1ec43fef2b93..f4b50cbbde42 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -188,6 +188,8 @@ struct seccomp_metadata {
 
 /* valid flags for seccomp_notif_addfd */
 #define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
+#define SECCOMP_ADDFD_FLAG_MOVE		(1UL << 1)
+
 
 struct seccomp_notif {
 	__u64 id;
@@ -3756,6 +3758,12 @@ TEST(user_notification_sendfd)
 	EXPECT_GE(ret, 0);
 	EXPECT_EQ(filecmp(getpid(), pid, memfd, ret), 0);
 
+	/* Move the FD */
+	addfd.flags = SECCOMP_ADDFD_FLAG_MOVE;
+	ret = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
+	EXPECT_GE(ret, 0);
+	EXPECT_EQ(filecmp(getpid(), pid, memfd, ret), 0);
+
 	/* Verify we can set a specific remote fd */
 	addfd.remote_fd = 42;
 	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD;
-- 
2.25.1

