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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25443C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006C220657
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AVULz8Yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgGJXBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgGJXBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:01:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A3AC08E806
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:01:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k5so2829608plk.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plPGzTPn8qeDi7iOgwL0mp+ouaTZyfAGNQFOzP+7U8Y=;
        b=AVULz8YcPhjFqumFxyE6EiQFOzyKP8WlXfdL8dzQANxCxMos6i3W1g9dfcVE2XpITO
         EmnvAfNht4K5U63zDffx2pmWCMA8kTSCUTCxYzKVJhlKI6JOMmmk5sXZsTLA1TPAtdfz
         pF+uQrs0ajxDHBOA39ovBlWQX/K2UsWE52Q5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plPGzTPn8qeDi7iOgwL0mp+ouaTZyfAGNQFOzP+7U8Y=;
        b=lfX2nfkb9wWJN/XFNn9lRkxM9DOPKVR8cAQN9Wp63Y+W4C6oP/pLNRTmXxwYNJTuoC
         +Q16rnsyqxEfGuur7N6pBJ37mY4CGPux5fKyW4zZeuZzqBjETCcEM0435lo6zykCzVNs
         VD0Ob0G+2481/V2AY7LTBm+/SRs+ez4JlZlYsTzO9BgS4iJRai7ffZVs93ceTpBxL3Wf
         bGe/cOiUQQoVjuiHA80jns0P0LFTb665JKx2zCXAC3pnvqMww9GV2COQMLIBdbzm/AQJ
         dqVxB2cxr5mUeyXZeqxT7iy+66vkdMkveq+xLPeGj/gViuOlRt9bpB/8mOJgtwmOlwmB
         H46A==
X-Gm-Message-State: AOAM532t1wjvC+oWYU4epM2Uta51k+El5ZX3+n6wwuOlM1FhaIxO8Pcy
        SwCUuFrYcStBHxwzAGPNJKBq2A==
X-Google-Smtp-Source: ABdhPJxJ3IvgLCB287FazX3iXVmDYo+c5ory2weCQWET53H5hMwkWX4TueUomo9YQx2XmgcY8Z6egg==
X-Received: by 2002:a17:90b:34d:: with SMTP id fh13mr7286518pjb.99.1594422071364;
        Fri, 10 Jul 2020 16:01:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b21sm6946553pfp.172.2020.07.10.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:01:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-next/seccomp v2 2/2] selftests/seccomp: Set NNP for TSYNC ESRCH flag test
Date:   Fri, 10 Jul 2020 16:01:07 -0700
Message-Id: <20200710230107.2528890-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710230107.2528890-1-keescook@chromium.org>
References: <20200710230107.2528890-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSYNC ESRCH flag test will fail for regular users because NNP was
not set yet. Add NNP setting.

Fixes: 51891498f2da ("seccomp: allow TSYNC and USER_NOTIF together")
Cc: stable@vger.kernel.org
Reviewed-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 14b038361549..0d29114123fa 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3257,6 +3257,11 @@ TEST(user_notification_with_tsync)
 	int ret;
 	unsigned int flags;
 
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	/* these were exclusive */
 	flags = SECCOMP_FILTER_FLAG_NEW_LISTENER |
 		SECCOMP_FILTER_FLAG_TSYNC;
-- 
2.25.1

