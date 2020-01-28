Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C774C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281712467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFhtOIbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgA1Stu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:49:50 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:43491 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgA1Str (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:49:47 -0500
Received: by mail-qv1-f73.google.com with SMTP id z9so9258831qvo.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 10:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FRYMM1qoPJhfGiG5OWEbx13i+2jzqMbf4H5LKO69CQU=;
        b=bFhtOIbcQrF6W7S50FwloXQv+gTL5Dc0/6XP56oKBenHYm98Yng2U+I5p+qfHPMNP7
         mXKjOy2wZeSKsZJWMowesjW4wlTddLLx2SWrJGP1ociyoc0epkZJ195SG9At2F1opp+V
         URf8CAqfz0aQ5kqzv3bn8idQIQzoYDL09b3SPw8hvTei18qiFg8BWL2mg+W23NxWD4Dn
         BM/ESuqDVdaUzuu5N78ZRANcwg3lkwkudz/DtF5we2gTsj2TLlVF6wIGzuFOmBhEVKFz
         OYg50S5qLuXvI5upqlHvIYXnxRCpTwSCa4SRI1VNfKjWKA80nVrA1G8NvIVhrLHLfAOP
         y+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FRYMM1qoPJhfGiG5OWEbx13i+2jzqMbf4H5LKO69CQU=;
        b=Vq6Sim0sZvr1Syx5RxqcMZKUIo906lQ5dQ+PDkiW7A2cGnL99q0gP6anvr86jmuV2K
         EuT5pelWPM+DN849OSGVFQMf4PUAVZzpo3cZDUVbdKHbenrizQUAK+ivx2kmH+zZeQXt
         w5klUYFjKcYgwkhqkkMCLxCA5PNkiuE/ECW+MhwIVQXxiiSzP3wi2kHneiMiUpMPk2Zi
         fAgnSlYkN3PnmccXJypu7GX0kpG8CuVODQow+qmP4JM6TV2VYxJyQVuh+D5GP4UT4LQ0
         8eYMNFL6kisCqgi8UDBh1lZhlktZ/HGWWNWsz5JniuENf8yg5pMPV4B5cvLS369WqToN
         0Dvg==
X-Gm-Message-State: APjAAAWT2rldfhRFzDSg8NxogPcueqZvlNX5UUuNlXhECxxDpRw8IJhU
        VQ5jS72xJ0kRLnjyi5PTbNsJoQKvRiIsf9uwGzc=
X-Google-Smtp-Source: APXvYqyk3gN+DHe7EMl7P65uc0diXH3phSSCxxDmawR0hdhYLtL89vUyklWkmNMJY3GUoAEL69pRLvjhdLmm1fCjGgg=
X-Received: by 2002:a0c:fac1:: with SMTP id p1mr24192377qvo.231.1580237386265;
 Tue, 28 Jan 2020 10:49:46 -0800 (PST)
Date:   Tue, 28 Jan 2020 10:49:26 -0800
In-Reply-To: <20200128184934.77625-1-samitolvanen@google.com>
Message-Id: <20200128184934.77625-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200128184934.77625-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v7 03/11] scs: add support for stack usage debugging
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks. When enabled,
also prints out the highest shadow stack usage per process.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/scs.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/scs.c b/kernel/scs.c
index 5245e992c692..ad74d13f2c0f 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -184,6 +184,44 @@ int scs_prepare(struct task_struct *tsk, int node)
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_STACK_USAGE
+static inline unsigned long scs_used(struct task_struct *tsk)
+{
+	unsigned long *p = __scs_base(tsk);
+	unsigned long *end = scs_magic(p);
+	unsigned long s = (unsigned long)p;
+
+	while (p < end && READ_ONCE_NOCHECK(*p))
+		p++;
+
+	return (unsigned long)p - s;
+}
+
+static void scs_check_usage(struct task_struct *tsk)
+{
+	static DEFINE_SPINLOCK(lock);
+	static unsigned long highest;
+	unsigned long used = scs_used(tsk);
+
+	if (used <= highest)
+		return;
+
+	spin_lock(&lock);
+
+	if (used > highest) {
+		pr_info("%s (%d): highest shadow stack usage: %lu bytes\n",
+			tsk->comm, task_pid_nr(tsk), used);
+		highest = used;
+	}
+
+	spin_unlock(&lock);
+}
+#else
+static inline void scs_check_usage(struct task_struct *tsk)
+{
+}
+#endif
+
 bool scs_corrupted(struct task_struct *tsk)
 {
 	unsigned long *magic = scs_magic(__scs_base(tsk));
@@ -200,6 +238,7 @@ void scs_release(struct task_struct *tsk)
 		return;
 
 	WARN_ON(scs_corrupted(tsk));
+	scs_check_usage(tsk);
 
 	scs_account(tsk, -1);
 	task_set_scs(tsk, NULL);
-- 
2.25.0.341.g760bfbb309-goog

