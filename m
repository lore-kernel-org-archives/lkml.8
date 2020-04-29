Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B903C83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FA820730
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROkfloZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgD2CnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 22:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2CnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:43:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7121DC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 19:43:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g17so1611616ybk.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 19:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1e2NH77BUHybTGxugnpz/lVzLlT/U4RLm6UsbwYLr4A=;
        b=ROkfloZnyw0Pn1nyVT+OhQYVEitYDmQNg/ttq24vcCWR+BHyf7R5m6JtVusJMfAa03
         47BpzL8fznqfqMHWLbLBMSKa2qLXXg8L+ttcFF+MJgcx/EImPs0b4Mw3zR6f4KXi7aki
         /wR8lwRjt60fjkH/xi4LSFwStbw1RT/c4p4FPEkdCcCUHUxJyPPapXi2ArDxTlBBYbcI
         dnMGNlgFvq5d4/VH/pirmr9Y6hfZgQ8p2ROTNI08TLuMWLj7iVbdkcbcDKZWlaZGzvWZ
         PP1oKRK+a8UophdnKWCC3UeIBIkuPpCLn4P6rHmlbEpJCHxmyCWvYWfrx0mGnDKSvmOL
         yzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1e2NH77BUHybTGxugnpz/lVzLlT/U4RLm6UsbwYLr4A=;
        b=ahMmnN0MQkJaDdVmXJn1ExxuSa1Y527Rd/CYzLZfrbgYjxZ2ewO2pclxRa1AjAkxm9
         KGWJCfOkXtdBXmpeRwn5RNqLS7ynqfsstAf38Wby3lhEg46LfWUoZMVe+jq2P/+mVHM2
         SfAvhRb36/elYAH55C1g8ozdz6HIjQ7Zf2hAnMYC3deXU1iOaxO6AIJnMssZDggIZybG
         nozOc5xyowCp08dBzwV7y9wxwX3vNe064Gbt2aoBojVLMneozRrK/1StlXbiSGUWu5yo
         BnDHnSTe9lWXpf2WKQ/9tgE5kCRk0SNiqJTtw/UT9XvXJj+X86DtfaZBNiWUx+3K5Mzc
         qygQ==
X-Gm-Message-State: AGi0PuZ7R5icja6LrGvyAAMDXHUaFQGmqy5mW4LW/1yNYwCmfTCqp8NC
        ousuhqky8WJnRk+dIVfydIdeayIVeA==
X-Google-Smtp-Source: APiQypKHXS545Ck07m0eyuMmqQZYShUs9n7ii7OW5TQ6sdLH5iCKxNW0TYL3M7PWRW7MQca6L3ZJ6PRRrA==
X-Received: by 2002:a25:cc48:: with SMTP id l69mr48912932ybf.459.1588128180667;
 Tue, 28 Apr 2020 19:43:00 -0700 (PDT)
Date:   Wed, 29 Apr 2020 04:42:26 +0200
Message-Id: <20200429024226.135830-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH] epoll: Move helper functions from UAPI header into eventpoll.c
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        NeilBrown <neilb@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ep_take_care_of_epollwakeup() is a kernel-internal function (it calls
capable()) and therefore does not belong in a UAPI header.

Since nothing outside fs/eventpoll.c uses it, move it over there.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/eventpoll.c                 | 13 +++++++++++++
 include/uapi/linux/eventpoll.h | 12 ------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8c596641a72b0..7365ccba90973 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2102,6 +2102,19 @@ static inline int epoll_mutex_lock(struct mutex *mutex, int depth,
 	return -EAGAIN;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
+{
+	if ((epev->events & EPOLLWAKEUP) && !capable(CAP_BLOCK_SUSPEND))
+		epev->events &= ~EPOLLWAKEUP;
+}
+#else
+static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
+{
+	epev->events &= ~EPOLLWAKEUP;
+}
+#endif
+
 int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 		 bool nonblock)
 {
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index 8a3432d0f0dcb..39dfc29f0f529 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -79,16 +79,4 @@ struct epoll_event {
 	__u64 data;
 } EPOLL_PACKED;
 
-#ifdef CONFIG_PM_SLEEP
-static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
-{
-	if ((epev->events & EPOLLWAKEUP) && !capable(CAP_BLOCK_SUSPEND))
-		epev->events &= ~EPOLLWAKEUP;
-}
-#else
-static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
-{
-	epev->events &= ~EPOLLWAKEUP;
-}
-#endif
 #endif /* _UAPI_LINUX_EVENTPOLL_H */

base-commit: 96c9a7802af7d500a582d89a8b864584fe878c1b
-- 
2.26.2.303.gf8c07b1a785-goog

