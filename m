Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001E0C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1F824656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cu/THgoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBSAIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:08:38 -0500
Received: from mail-qv1-f74.google.com ([209.85.219.74]:43835 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgBSAIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:08:37 -0500
Received: by mail-qv1-f74.google.com with SMTP id z9so13488318qvo.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 16:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0f/RzoyEatytyatThC+F3eOfN2v+QCCQ4NfkPjtyieo=;
        b=cu/THgoI4tMw6Hv/cnWQTiNWXWXUr6AKTVvfgPfzSMLj0kWYcpifZKdSq6w1+DteE0
         kXx8mLdQVe2X1IQWWOSR6Mh+Qa+NPbQfhsSgJqX39vvszx480CLksDEmmIFQd2vxoqY3
         1dP0HJ2lDnH66hEZo0ZFi1oE3hkU0IZ8oCsB7mmk/3IFcSboHkCVWkxpT1HW+h7VC1n7
         yOmJd+ZtmnwfszU5a6Kt86Lcv2GGAwqezGTfzkaF0JiBJgiasqm6vEx4C8j7oNaglBnU
         JfJ9UsRRTrbO7JD+RSG6YqwZQYiUQK+KI9Aw/1esMS/y9pSezRReN3CDnTr6Mdf4Z3gi
         lu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0f/RzoyEatytyatThC+F3eOfN2v+QCCQ4NfkPjtyieo=;
        b=iw8tXt2eENStRnai0dhBC3O7oWIJy9Cjea69NiZx8sKPXgw1ptY1IgR/zezc9EWYy5
         qLGCewqRBt4Mpi9utdBbFYNhpDSheZ+suEPBoFr12yWH22EGC0llEuqrAjkNoRrEoMva
         xTJXNM86+CSxiigpQveIbj6Gqi3xEBw44fy9iK3u8g74+z/+cH7exHCySNHpt7aszeyE
         nDXwZVjkbMk41vlY9k0QkfbbdsT8GIo5ohFZccQCx2Cbu1SIsdHEOVXL4SgmWgllrUIl
         XgLwJ0S36l6bPezj/SQkjxduRguKoJQS24WmHjw5pY/e08UZ213OX3UYN1Pz7zbSLJUn
         z7uA==
X-Gm-Message-State: APjAAAVO31rnC9iz7Uaa5hco7qG6Oib6k4Do4XJOu+UjBZLdZ4GAQ7+e
        dIDrWWzEtodBVGR1jZpMsusrRzSBuGV47O/5dFE=
X-Google-Smtp-Source: APXvYqw4ER8WovKBYQVVrHd0oyLZvkEq3WR7WVWTpyENeUeptJ25rnbegEbU6hsEORKa9iiI1OoS973GsI/tCw23qS4=
X-Received: by 2002:a37:4e89:: with SMTP id c131mr22333834qkb.5.1582070915273;
 Tue, 18 Feb 2020 16:08:35 -0800 (PST)
Date:   Tue, 18 Feb 2020 16:08:08 -0800
In-Reply-To: <20200219000817.195049-1-samitolvanen@google.com>
Message-Id: <20200219000817.195049-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200219000817.195049-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 03/12] scs: add support for stack usage debugging
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
2.25.0.265.gbab2e86ba0-goog

